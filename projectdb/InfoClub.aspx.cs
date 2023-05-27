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
using System.Text.RegularExpressions;
using System.Data.Common;

namespace ProjectDB
{
    public partial class InfoClub : System.Web.UI.Page
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
 

            SqlCommand ClubsInfo = new SqlCommand("ClubInfo", conn);
            ClubsInfo.CommandType = System.Data.CommandType.StoredProcedure;
            ClubsInfo.Parameters.Add(new SqlParameter("@cname", clubnn ));

            conn.Open();
            SqlDataReader rdr = ClubsInfo.ExecuteReader(CommandBehavior.CloseConnection); 
            while (rdr.Read())
            {
                String Name = rdr.GetString(rdr.GetOrdinal("cName"));
                String Location = rdr.GetString(rdr.GetOrdinal("cLocation"));
                ListBox lb = new ListBox();
                lb.Height = 150;
                lb.Width = 150;
                lb.BackColor = Color.Black;
                lb.ForeColor = Color.White;
                lb.Items.Add("Name:");
                lb.Items.Add(Name);
                lb.Items.Add("   ");
                lb.Items.Add("Location:");
                lb.Items.Add(Location);
                lb.Items.Add("   ");
                form1.Controls.Add(lb);
            }
        }
    }
}