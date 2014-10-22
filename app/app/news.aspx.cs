using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace app
{
    public partial class news : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string key= System.Web.HttpUtility.UrlEncode("强奸");
            string x = webget.getwebresponse("http://news.baidu.com/ns?word=" + key + "&tn=newsrss&sr=0&cl=2&rn=100&ct=0", System.Text.Encoding.GetEncoding("gb2312"));
            string html= webget.consXml(x);
            dnews.InnerHtml = html;
        }
    }
}