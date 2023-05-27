using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectDB
{
    public partial class RequestStad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Req(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String user =Convert.ToString( Session["user"]);
            String stad=stadname.Text;
            String starts = start.Text;
            SqlCommand ClubsN = new SqlCommand("ClubName", conn);
            ClubsN.CommandType = System.Data.CommandType.StoredProcedure;
            ClubsN.Parameters.Add(new SqlParameter("@username", user));

            SqlParameter clubn = ClubsN.Parameters.Add("@clubname", SqlDbType.VarChar, 20);

            clubn.Direction = ParameterDirection.Output;

            conn.Open();
            ClubsN.ExecuteNonQuery();
            conn.Close();

            String clubnn = clubn.Value.ToString();
            SqlCommand request = new SqlCommand("addHostRequest", conn);
            request.CommandType = System.Data.CommandType.StoredProcedure;
            request.Parameters.Add(new SqlParameter("@cname", clubnn));
            request.Parameters.Add(new SqlParameter("@stadname", stad));
            request.Parameters.Add(new SqlParameter("@starttime", Convert.ToDateTime(starts)));

            SqlCommand check = new SqlCommand("CheckReq", conn);
            check.CommandType = System.Data.CommandType.StoredProcedure;
            check.Parameters.Add(new SqlParameter("@cname", clubnn));
            check.Parameters.Add(new SqlParameter("@stadname", stad));
            check.Parameters.Add(new SqlParameter("@starttime", Convert.ToDateTime(starts)));

            SqlParameter success = check.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            check.ExecuteNonQuery();
            conn.Close();

            if (String.IsNullOrEmpty(stad) || String.IsNullOrEmpty(starts))
            {
                Response.Write("Please Enter All Information");
            }
            if (success.Value.ToString() == "1")
            {
                Response.Write("Request Already Sent");
            }
            else 
            {

                conn.Open();
                request.ExecuteNonQuery();
                conn.Close();
                Response.Write("Request Sent");

            }

        }

    }
}