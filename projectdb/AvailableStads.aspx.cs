using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Xml.Linq;

namespace ProjectDB
{
    public partial class AvailableStads : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ViewStad(object sender, EventArgs e)
        {
            
        }

        public string getAvailableStadiumsData()
        {
            string strs = "";
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand availableStadiums = new SqlCommand("SELECT * FROM viewAvailableStadiumsOn(@starttime)", conn);
            SqlParameter param = new SqlParameter();
            param.ParameterName = "@starttime";
            param.Value = datet.Text;
            availableStadiums.Parameters.Add(param);
            SqlDataReader rdrAvailableStadiums = availableStadiums.ExecuteReader();
            if (rdrAvailableStadiums.Read())
            {
                string name = rdrAvailableStadiums.GetString(0);
                string location = rdrAvailableStadiums.GetString(1);
                int capacity = rdrAvailableStadiums.GetInt32(2);
                

                strs += "<tr><td>" + name + "</td><td>" + location + "</td><td>" + capacity + "</td><td>" ;

                conn.Close();

            }
            return strs;


        }
    }
}