using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ProjectDB
{
    public partial class Buy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void buys(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String fuser = Convert.ToString(Session["user"]);
            String fhost = host.Text;
            String fguest = guest.Text;
            String fstart = start.Text;



            SqlCommand getnat = new SqlCommand("getnational", conn);
            getnat.CommandType = CommandType.StoredProcedure;
            getnat.Parameters.Add(new SqlParameter("@username", fuser));
            



            SqlParameter nationalid = getnat.Parameters.Add("@nationalid", SqlDbType.VarChar, 20);

            nationalid.Direction = ParameterDirection.Output;

            conn.Open();
            getnat.ExecuteNonQuery();
            conn.Close();

            String natid=nationalid.Value.ToString();

            if (String.IsNullOrEmpty(fhost) || String.IsNullOrEmpty(fguest) || String.IsNullOrEmpty(fstart))
            {
                Response.Write("Please Enter All Information");
            }
            else
            {
                SqlCommand check = new SqlCommand("CheckT", conn);
                check.CommandType = CommandType.StoredProcedure;
                check.Parameters.Add(new SqlParameter("@host", fhost));
                check.Parameters.Add(new SqlParameter("@guest", fguest));
                check.Parameters.Add(new SqlParameter("@start", Convert.ToDateTime(fstart)));
                SqlParameter success = check.Parameters.Add("@success", SqlDbType.Int);

                success.Direction = ParameterDirection.Output;
                conn.Open();
                check.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {

                    SqlCommand ticket = new SqlCommand("purchaseTicket", conn);
                    ticket.CommandType = CommandType.StoredProcedure;
                    ticket.Parameters.Add(new SqlParameter("@nationalid", natid));
                    ticket.Parameters.Add(new SqlParameter("@host", fhost));
                    ticket.Parameters.Add(new SqlParameter("@guest", fguest));
                    ticket.Parameters.Add(new SqlParameter("@starttime", Convert.ToDateTime(fstart)));
                    conn.Open();
                    ticket.ExecuteNonQuery();
                    conn.Close();
                    Response.Write("Ticket Bought Successfully");
                }
                else
                {
                    Response.Write("No Tickets Exist");

                }
            }

        }
    }
}