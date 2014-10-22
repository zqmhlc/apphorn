using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace app
{
    public class webget
    {
        public static string getwebresponse(string url,System.Text.Encoding enc)
        {
            System.Net.WebRequest req = System.Net.WebRequest.Create(url);
            System.Net.WebResponse res = req.GetResponse();
            System.IO.Stream resStream = res.GetResponseStream();
            System.IO.StreamReader sr = new System.IO.StreamReader(resStream, enc);
            string x = sr.ReadToEnd();
            return x;
        }

        public static string consXml(string xml) {
            string html = "";
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xml);
            XmlElement root= doc.DocumentElement;
            XmlNodeList xnl= root.SelectNodes("channel/item");
            foreach (XmlNode node in xnl)
            {
                html += "<a href='" + node.SelectSingleNode("link").InnerText + "' target='_blank' >" + node.SelectSingleNode("title").InnerText + "</a><br/>";
                html += node.SelectSingleNode("description").InnerText + "<br/><br/>";
            }
            return html;
        }
    }
}