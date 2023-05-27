using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectDB
{
    public partial class AvTickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string getAvMatch()
        {
            string strs = "";
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand availableStadiums = new SqlCommand("SELECT * FROM availableMatchesToAttend(@date)", conn);
            SqlParameter param = new SqlParameter();
            param.ParameterName = "@date";
            param.Value =TextBox1.Text;
            availableStadiums.Parameters.Add(param);
            SqlDataReader rdrAvailableStadiums = availableStadiums.ExecuteReader();

            if (rdrAvailableStadiums.Read())
            {
                string host = rdrAvailableStadiums.GetString(0);
                string guest = rdrAvailableStadiums.GetString(1);
                DateTime starttime = rdrAvailableStadiums.GetDateTime(2);
                String stad = rdrAvailableStadiums.GetString(3);


                strs += "<tr><td>" + host + "</td><td>" + guest + "</td><td>" + starttime + "</td><td>" + stad + "</td><td>";

                conn.Close();

            }
            return strs;


        }
    }
}