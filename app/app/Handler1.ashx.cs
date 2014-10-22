using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Reflection;

namespace app
{
    /// <summary>
    /// Handler1 的摘要说明
    /// </summary>
    public class Handler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string str_action = "";
            string p_ret = "";

            try
            {
                str_action = context.Request["a"].ToString();

                MethodInfo menthinfo = this.GetType().GetMethod(str_action, BindingFlags.Instance | BindingFlags.Public | BindingFlags.IgnoreCase);
                if (menthinfo != null)
                {
                    p_ret = (string)menthinfo.Invoke(this, new object[] { context });
                }
            }
            catch 
            {
                p_ret = "nosession-2";                
            }
            context.Response.Write(p_ret);
            context.Response.End();
        }        

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public string rfe(HttpContext context)
        {
            string fileUrl = context.Request["url"].ToString();
            bool result = false;//下载结果
            string html = string.Empty;

            System.Net.WebResponse response = null;
            try
            {
                if (!fileUrl.ToLower().StartsWith("http://") && !fileUrl.ToLower().StartsWith("https://"))
                {
                    fileUrl = "http://" + fileUrl;
                }
                System.Net.WebRequest req = System.Net.WebRequest.Create(fileUrl);
                req.Headers.Add("Accept-Language", "utf-8");

                response = req.GetResponse();
                System.Net.WebHeaderCollection headers = response.Headers;
                //遍历http头信息
                string bm = "";
                for (int i = 0; i < headers.Count; i++)
                {
                    string tempKey = headers.Keys[i];
                    if (tempKey == "Content-Type")
                    {
                        string tempHeadersValue = headers[i];
                        bm = System.Text.RegularExpressions.Regex.Match(headers[i], "charset=(.*)$").Groups[1].Value;
                    }
                }
                System.Text.Encoding enc;
                if (bm == "")
                    enc = System.Text.Encoding.Default;
                else
                    enc = System.Text.Encoding.GetEncoding(bm);

                result = response == null ? false : true;

                if (result)
                {
                    System.IO.Stream sw = response.GetResponseStream();
                    System.IO.StreamReader streamReader = new System.IO.StreamReader(sw, enc);
                    //将流转换为字符串
                    html = streamReader.ReadToEnd();
                    //ychtml.InnerText = html;
                    string qz = "http://zqmhlc.apphb.com";
                    Uri un = new Uri(fileUrl);
                    string thurl = un.Scheme + "://" + un.Host;
                    html = html.Replace(qz, thurl);
                    html = html.Replace("href=\"/", "href=\"" + thurl + "/");
                    html = html.Replace("href='/", "href='" + thurl + "/");
                    html = html.Replace("href=/", "href=" + thurl + "/");
                    //html = html.Replace("http://zqmhlc.apphb.com", fileUrl);//http://localhost:61496
                    html += "<script>$('a').click(function(){if(this.href.substring(0,1)=='/'){this.href='" + thurl + "'+this.href;}$('#txturl').val(this.href.replace('" + qz + "','" + thurl + "'));$('#btn').click();return false;});</script>";                    
                    streamReader.Close();
                    sw.Close();
                    sw.Dispose();
                }

            }
            catch (Exception ex)
            {
                result = false;
                //divHtml.InnerText = ex.Message;
            }
            finally
            {
                if (response != null)
                {
                    response.Close();                    
                }
            }


            return html;
        }
    }
}