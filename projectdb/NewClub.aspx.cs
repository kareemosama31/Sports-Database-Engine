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
    public partial class NewClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddClub(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String Cname = ClubName.Text;
            String Cloc = ClubLocation.Text;
       

            String name = Request["ClubName"];
            String loc = Request["ClubLocation"];

           
           
            SqlCommand checkclub = new SqlCommand("CheckClub", conn);
            checkclub.CommandType = CommandType.StoredProcedure;
            checkclub.Parameters.Add(new SqlParameter("@cname", Cname));
            checkclub.Parameters.Add(new SqlParameter("@cloc", Cloc));



            SqlParameter success = checkclub.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            checkclub.ExecuteNonQuery();
            conn.Close();



            if (String.IsNullOrEmpty(Cname) || String.IsNullOrEmpty(Cloc))
            {
                Response.Write("Please Enter All Information");
            }
            else if (success.Value.ToString() == "1")
                {
                    Response.Write("Club Already Exists");
                }
            else
                {
                    SqlCommand addclub = new SqlCommand("addclub", conn);
                    addclub.CommandType = CommandType.StoredProcedure;
                    addclub.Parameters.Add(new SqlParameter("@cname", Cname));
                    addclub.Parameters.Add(new SqlParameter("@cloc", Cloc));
                    conn.Open();
                    addclub.ExecuteNonQuery();
                    conn.Close();
                    Response.Write("Club Added Successfully");
                }
            


        }
    }
}