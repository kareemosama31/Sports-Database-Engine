using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data.SqlTypes;

namespace ProjectDB
{
    public partial class UpcomingClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String username = Convert.ToString(Session["user"]);
            SqlCommand ClubsN = new SqlCommand("ClubName", conn);
            ClubsN.CommandType = System.Data.CommandType.StoredProcedure;
            ClubsN.Parameters.Add(new SqlParameter("@username", username));

            SqlParameter clubn = ClubsN.Parameters.Add("@clubname", SqlDbType.VarChar, 20);

            clubn.Direction = ParameterDirection.Output;

            conn.Open();
            ClubsN.ExecuteNonQuery();
            conn.Close();

            String clubnn = clubn.Value.ToString();


            SqlCommand up = new SqlCommand("upcoming", conn);
            up.CommandType = System.Data.CommandType.StoredProcedure;
            up.Parameters.Add(new SqlParameter("@cname", clubnn));

            conn.Open();
            SqlDataReader rdr = up.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String Host = rdr.GetString(rdr.GetOrdinal("host"));
                String Guest = rdr.GetString(rdr.GetOrdinal("guest"));
                DateTime start = rdr.GetDateTime(rdr.GetOrdinal("starttime"));
                DateTime end = rdr.GetDateTime(rdr.GetOrdinal("endtime"));
                String startt = Convert.ToString(start);
                String endt = Convert.ToString(end);
                String stad="";
                bool stadium = true;
                try
                {
                     stad = rdr.GetString(rdr.GetOrdinal("stad"));
                }
                catch (SqlNullValueException)
                {
                    stadium = false;
                }
                ListBox lb = new ListBox();
                lb.Height = 300;
                lb.Width = 150;
                lb.BackColor = Color.Black;
                lb.ForeColor = Color.White;
                lb.Items.Add("Host:");
                lb.Items.Add(Host);
                lb.Items.Add("   ");
                lb.Items.Add("Guest:");
                lb.Items.Add(Guest);
                lb.Items.Add("   ");
                lb.Items.Add("Start time:");
                lb.Items.Add(startt);
                lb.Items.Add("   ");
                lb.Items.Add("End time:");
                lb.Items.Add(endt);
                lb.Items.Add("   ");
                if (!stadium)
                {
                    lb.Items.Add("Stadium:");
                    lb.Items.Add("No Stadium Assigned Yet");
                    lb.Items.Add("   ");
                }
                else
                {
                    lb.Items.Add("Stadium:");
                    lb.Items.Add(stad);
                    lb.Items.Add("   ");
                }
                
                form1.Controls.Add(lb);
            }
        }
    }
}