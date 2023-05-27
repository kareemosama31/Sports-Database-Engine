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
    public partial class StadInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String username = Convert.ToString(Session["user"]);
            SqlCommand StadN = new SqlCommand("StadName", conn);
            StadN.CommandType = System.Data.CommandType.StoredProcedure;
            StadN.Parameters.Add(new SqlParameter("@username", username));

            SqlParameter clubn = StadN.Parameters.Add("@stadname", SqlDbType.VarChar, 20);

            clubn.Direction = ParameterDirection.Output;

            conn.Open();
            StadN.ExecuteNonQuery();
            conn.Close();

            String clubnn = clubn.Value.ToString();


            SqlCommand ClubsInfo = new SqlCommand("StadInfo", conn);
            ClubsInfo.CommandType = System.Data.CommandType.StoredProcedure;
            ClubsInfo.Parameters.Add(new SqlParameter("@sname", clubnn));

            conn.Open();
            SqlDataReader rdr = ClubsInfo.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String Name = rdr.GetString(rdr.GetOrdinal("sname"));
                String Location = rdr.GetString(rdr.GetOrdinal("slocation"));
                Int32 Capacity = rdr.GetInt32(2);
                String capa = Convert.ToString(Capacity);
                ListBox lb = new ListBox();
                lb.Height = 150;
                lb.Width = 150;
                lb.BackColor = Color.Black;
                lb.ForeColor = Color.White;
                lb.Items.Add("Stadium Name:");
                lb.Items.Add(Name);
                lb.Items.Add("   ");
                lb.Items.Add("Stadium Location:");
                lb.Items.Add(Location);
                lb.Items.Add("   ");
                lb.Items.Add("Stadium Capacity:");
                lb.Items.Add(capa);
                lb.Items.Add("   ");
                form1.Controls.Add(lb);
            }
        }
    }
}