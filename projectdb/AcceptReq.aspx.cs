using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ProjectDB
{
    public partial class AcceptReq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AccReq(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String smuser = Convert.ToString(Session["user"]);
            String host = Host.Text;
            String guest = Guest.Text;
            String start = Start.Text;

            SqlCommand checkreq = new SqlCommand("CheckRequ", conn);
            checkreq.CommandType = CommandType.StoredProcedure;
            checkreq.Parameters.Add(new SqlParameter("@host", host));
            checkreq.Parameters.Add(new SqlParameter("@guest", guest));
            checkreq.Parameters.Add(new SqlParameter("@start", Convert.ToDateTime(start)));



            SqlParameter success = checkreq.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            checkreq.ExecuteNonQuery();
            conn.Close();

            SqlCommand checkreqa = new SqlCommand("CheckReqacc", conn);
            checkreqa.CommandType = CommandType.StoredProcedure;
            checkreqa.Parameters.Add(new SqlParameter("@host", host));
            checkreqa.Parameters.Add(new SqlParameter("@guest", guest));
            checkreqa.Parameters.Add(new SqlParameter("@start", Convert.ToDateTime(start)));



            SqlParameter success1 = checkreqa.Parameters.Add("@success", SqlDbType.Int);

            success1.Direction = ParameterDirection.Output;

            conn.Open();
            checkreqa.ExecuteNonQuery();
            conn.Close();

            if (String.IsNullOrEmpty(host) || String.IsNullOrEmpty(guest) || String.IsNullOrEmpty(start))
            {
                Response.Write("Please Enter All Information");
            }
            else if (success.Value.ToString() == "0")
            {
                Response.Write("Request Doesnt Exist");

            }
            else if (success.Value.ToString() == "1")
            {
                Response.Write("Request Already Accepted");

            }
            else
            {
                SqlCommand accreq = new SqlCommand("acceptRequest", conn);
                accreq.CommandType = CommandType.StoredProcedure;
                accreq.Parameters.Add(new SqlParameter("@username", smuser));
                accreq.Parameters.Add(new SqlParameter("@host", host));
                accreq.Parameters.Add(new SqlParameter("@guest", guest));
                accreq.Parameters.Add(new SqlParameter("@start", Convert.ToDateTime(start)));

                conn.Open();
                accreq.ExecuteNonQuery();
                conn.Close();
                Response.Write("Request Accepted Successfully");
            }
        }
    }
}