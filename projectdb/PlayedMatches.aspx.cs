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
    public partial class PlayedMatches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand matches = new SqlCommand("PlayedMatches", conn);
            matches.CommandType = System.Data.CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = matches.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String hn = rdr.GetString(rdr.GetOrdinal("Host"));
                String gn = rdr.GetString(rdr.GetOrdinal("Guest"));
                DateTime start = rdr.GetDateTime(rdr.GetOrdinal("Starttime"));
                DateTime end = rdr.GetDateTime(rdr.GetOrdinal("Endtime"));
                String startt = Convert.ToString(start);
                String endt = Convert.ToString(end);
                ListBox lb = new ListBox();
                lb.Height = 220;
                lb.Width = 200;
                lb.BackColor = Color.Black;
                lb.ForeColor = Color.White;
                lb.Items.Add("Host Club Name:");
                lb.Items.Add(hn);
                lb.Items.Add("   ");
                lb.Items.Add("Guest Club Name:");
                lb.Items.Add(gn);
                lb.Items.Add("   ");
                lb.Items.Add("Start Time:");
                lb.Items.Add(startt);
                lb.Items.Add("   ");
                lb.Items.Add("End Time:");
                lb.Items.Add(endt);
                form1.Controls.Add(lb);
            }
        }
    }
}