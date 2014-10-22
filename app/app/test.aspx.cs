using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace app
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //addtable();
            //query();
            getssq();
            query();
        }

        public void addtable()
        {
            SqlConnection conn = new SqlConnection("Server=6a5d2ed7-67a7-40e5-a268-a377009e903b.sqlserver.sequelizer.com;Database=db6a5d2ed767a740e5a268a377009e903b;User ID=niysgikgzvkutqyp;Password=5LARCQL7xBqyXa2SBDkPtvrsjKbVdi2eZ8j7pigYPatTeaz56PtqArqHuhG2PY4o;");
            conn.Open();
            try
            {
                string cmdtext = @"create table ssq_data  
                                (  
                                 qh int primary key,  
                                 r1 int,  
                                 r2 int,  
                                 r3 int, 
                                 r4 int,  
                                 r5 int,  
                                 r6 int,
                                 b int,
                                 indate date
                                ) ";
                SqlCommand cmd = new SqlCommand(cmdtext, conn);
                int x = cmd.ExecuteNonQuery();
            }
            catch
            {
            }
            //SqlDataAdapter ada = new SqlDataAdapter(cmdtext, conn);
            //DataSet ds = new DataSet();
            //ada.Fill(ds);
            conn.Close();

        }

        public void query()
        {
            SqlConnection conn = new SqlConnection("Server=6a5d2ed7-67a7-40e5-a268-a377009e903b.sqlserver.sequelizer.com;Database=db6a5d2ed767a740e5a268a377009e903b;User ID=niysgikgzvkutqyp;Password=5LARCQL7xBqyXa2SBDkPtvrsjKbVdi2eZ8j7pigYPatTeaz56PtqArqHuhG2PY4o;");
            conn.Open();
            try
            {
                string cmdtext = @"select * from  ssq_data ";
                SqlDataAdapter ada = new SqlDataAdapter(cmdtext, conn);
                DataSet ds = new DataSet();
                ada.Fill(ds);

                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
            catch
            {
            }

            conn.Close();
        }

        public void getssq()
        {
            System.Net.WebRequest req = System.Net.WebRequest.Create("http://baidu.lecai.com/api/hao123/new_lottery_all.php");
            System.Net.WebResponse res = req.GetResponse();
            System.IO.Stream resStream = res.GetResponseStream();
            System.IO.StreamReader sr = new System.IO.StreamReader(resStream, System.Text.Encoding.Default);
            string x = sr.ReadToEnd();
            x = ConvertToGB(x);
            x = x.Substring(x.IndexOf("caipiao\":{\"50\":{\"name\":\"双色球\","), x.IndexOf(",\"bonus\":") - x.IndexOf("caipiao\":{\"50\":{\"name\":\"双色球\","));
            resStream.Close();
            sr.Close();
            x=x.Substring(x.IndexOf("phase\":\"")+8);
            string qh = x.Substring(0,x.IndexOf("\""));
            x = x.Substring(x.IndexOf("detail\":[\"")+10);
            string r1 = x.Substring(0, x.IndexOf("\""));
            x = x.Substring(x.IndexOf("\",\"")+3);
            string r2 = x.Substring(0,x.IndexOf("\""));
            x = x.Substring(x.IndexOf("\",\"") + 3);
            string r3 = x.Substring(0, x.IndexOf("\""));
            x = x.Substring(x.IndexOf("\",\"") + 3);
            string r4 = x.Substring(0, x.IndexOf("\""));
            x = x.Substring(x.IndexOf("\",\"") + 3);
            string r5 = x.Substring(0, x.IndexOf("\""));
            x = x.Substring(x.IndexOf("\",\"") + 3);
            string r6 = x.Substring(0, x.IndexOf("\""));
            x = x.Substring(x.IndexOf("\",\"") + 3);
            string b = x.Substring(0, x.IndexOf("\""));

            SqlConnection conn = new SqlConnection("Server=6a5d2ed7-67a7-40e5-a268-a377009e903b.sqlserver.sequelizer.com;Database=db6a5d2ed767a740e5a268a377009e903b;User ID=niysgikgzvkutqyp;Password=5LARCQL7xBqyXa2SBDkPtvrsjKbVdi2eZ8j7pigYPatTeaz56PtqArqHuhG2PY4o;");
            conn.Open();
            try
            {
                string cmdtext = string.Empty;
                SqlCommand cmd = new SqlCommand();
                cmdtext = "select count(1) from ssq_data where qh=" + qh;
                cmd.CommandText = cmdtext;
                cmd.Connection = conn;
                object obj=cmd.ExecuteScalar();
                if (obj != null && int.Parse(obj.ToString()) < 1)
                {
                    cmdtext = @"insert into ssq_data values(" + qh + "," + r1 + "," + r2 + "," + r3 + "," + r4 + "," + r5 + "," + r6 + "," + b + ",getdate())";
                    cmd.CommandText = cmdtext;
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
            }

            conn.Close();
            
        }

        /// <summary> 
        /// 把Unicode解码为普通文字 
        /// </summary> 
        /// <param name="unicodeString">要解码的Unicode字符集</param> 
        /// <returns>解码后的字符串</returns> 
        private string ConvertToGB(string unicodeString)
        {
            string[] strArray = unicodeString.Split(new string[] { @"\u" }, StringSplitOptions.None);
            string result = string.Empty;
            for (int i = 0; i < strArray.Length; i++)
            {
                if (strArray[i].Trim() == "" || strArray[i].Length < 2 || strArray.Length <= 1)
                {
                    result += i == 0 ? strArray[i] : @"\u" + strArray[i];
                    continue;
                }
                for (int j = strArray[i].Length > 4 ? 4 : strArray[i].Length; j >= 2; j--)
                {
                    try
                    {
                        result += char.ConvertFromUtf32(Convert.ToInt32(strArray[i].Substring(0, j), 16)) + strArray[i].Substring(j);
                        break;
                    }
                    catch
                    {
                        continue;
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// 把汉字字符转码为Unicode字符集 
        /// </summary> 
        /// <param name="strGB">要转码的字符</param> 
        /// <returns>转码后的字符</returns> 
        private string ConvertToUnicode(string strGB)
        {
            char[] chs = strGB.ToCharArray();
            string result = string.Empty;
            foreach (char c in chs)
            {
                result += @"\u" + char.ConvertToUtf32(c.ToString(), 0).ToString("x");
            }
            return result;
        }
    }
}