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
    public partial class TwoNeverPlay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand matches = new SqlCommand("NeverMatched", conn);
            matches.CommandType = System.Data.CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = matches.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String club1 = rdr.GetString(rdr.GetOrdinal("Club1"));
                String club2= rdr.GetString(rdr.GetOrdinal("Club2"));
                ListBox lb = new ListBox();
                lb.Height = 100;
                lb.Width = 200;
                lb.BackColor = Color.Black;
                lb.ForeColor = Color.White;
                lb.Items.Add("Club1 Name:");
                lb.Items.Add(club1);
                lb.Items.Add("   ");
                lb.Items.Add("Club2 Name:");
                lb.Items.Add(club2);
                lb.Items.Add("   ");
                form1.Controls.Add(lb);
            }
        }
    }
}