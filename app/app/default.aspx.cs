﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace app
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string url = TextBox1.Text;
            RemoteFileExists(url);
            rb.Checked = true;
        }

        public bool RemoteFileExists(string fileUrl)
        {
            bool result = false;//下载结果

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
                    string html = streamReader.ReadToEnd();
                    //ychtml.InnerText = html;
                    string qz = "http://zqmhlc.apphb.com";
                    Uri un=new Uri(fileUrl);
                    string thurl = un.Scheme+"://"+un.Host;
                    html = html.Replace(qz, thurl);
                    html = html.Replace("href=\"/", "href=\""+thurl+"/");
                    html = html.Replace("href='/", "href='" + thurl + "/");
                    html = html.Replace("href=/", "href=" + thurl + "/");
                    //html = html.Replace("http://zqmhlc.apphb.com", fileUrl);//http://localhost:61496
                    html += "<script>$('a').click(function(){if(this.href.substring(0,1)=='/'){this.href='"+thurl+"'+this.href;}$('#TextBox1').val(this.href.replace('"+qz+"','" + thurl + "'));$('#Button1').click();return false;});</script>";  
                    divHtml.InnerHtml = html;
                    streamReader.Close();
                    sw.Close();
                }

            }
            catch (Exception ex)
            {
                result = false;
                divHtml.InnerText = ex.Message;
            }
            finally
            {
                if (response != null)
                {
                    response.Close();
                }
            }


            return result;
        }
    }
}