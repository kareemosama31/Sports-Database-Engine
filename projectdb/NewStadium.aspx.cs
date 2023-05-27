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
    public partial class NewStadium : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddStad(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String Sname = StadName.Text;
            String Sloc = StadLocation.Text;
            String Scap = StadCapacity.Text;



            SqlCommand checkstadium = new SqlCommand("CheckStadium", conn);
            checkstadium.CommandType = CommandType.StoredProcedure;
            checkstadium.Parameters.Add(new SqlParameter("@sname", Sname));
            checkstadium.Parameters.Add(new SqlParameter("@sloc", Sloc));
            checkstadium.Parameters.Add(new SqlParameter("@scap", Convert.ToInt64(Scap)));



            SqlParameter success = checkstadium.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            checkstadium.ExecuteNonQuery();
            conn.Close();



            if (String.IsNullOrEmpty(Sname) || String.IsNullOrEmpty(Sloc) || Convert.ToInt64(Scap) == 0)
            {
                Response.Write("Please Enter All Information");
            }
            else if (success.Value.ToString() == "1")
            {
                Response.Write("Stadium Already Exists");
            }
            else
            {
                SqlCommand addstad = new SqlCommand("addStadium", conn);
                addstad.CommandType = CommandType.StoredProcedure;
                addstad.Parameters.Add(new SqlParameter("@name", Sname));
                addstad.Parameters.Add(new SqlParameter("@location", Sloc));
                addstad.Parameters.Add(new SqlParameter("@capacity", Convert.ToInt64(Scap)));
                conn.Open();
                addstad.ExecuteNonQuery();
                conn.Close();
                Response.Write("Stadium Added Successfully");
            }

        }
    }
}