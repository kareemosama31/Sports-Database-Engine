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

namespace ProjectDB
{
    public partial class RecievedReq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String username = Convert.ToString(Session["user"]);
            SqlCommand pend = new SqlCommand("Pending", conn);
            pend.CommandType = System.Data.CommandType.StoredProcedure;
            pend.Parameters.Add(new SqlParameter("@username", username));
            conn.Open();
            SqlDataReader rdr = pend.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String crname = rdr.GetString(rdr.GetOrdinal("CRName"));
                String host = rdr.GetString(rdr.GetOrdinal("Host"));
                String guest = rdr.GetString(rdr.GetOrdinal("Guest"));
                DateTime start = rdr.GetDateTime(rdr.GetOrdinal("Starttime"));
                DateTime end = rdr.GetDateTime(rdr.GetOrdinal("Endtime"));
                String stat = rdr.GetString(rdr.GetOrdinal("Stat"));
                String starts = Convert.ToString(start);
                String ends = Convert.ToString(end);
                ListBox lb = new ListBox();
                lb.Height = 300;
                lb.Width = 250;
                lb.BackColor = Color.Black;
                lb.ForeColor = Color.White;
                lb.Items.Add("Club Representative Name:");
                lb.Items.Add(crname);
                lb.Items.Add("   ");
                lb.Items.Add("Host Club Name:");
                lb.Items.Add(host);
                lb.Items.Add("   ");
                lb.Items.Add("Guest Club Name:");
                lb.Items.Add(guest);
                lb.Items.Add("   ");
                lb.Items.Add("Start Time:");
                lb.Items.Add(starts);
                lb.Items.Add("   ");
                lb.Items.Add("End Time:");
                lb.Items.Add(ends);
                lb.Items.Add("   ");
                lb.Items.Add("Request Status:");
                lb.Items.Add(stat);
                lb.Items.Add("   ");
                form1.Controls.Add(lb);
            }
        }
    }
}