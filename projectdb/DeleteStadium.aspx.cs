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
    public partial class DeleteStadium : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Deletes(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String Sname = StadName.Text;



            SqlCommand checkstadn = new SqlCommand("CheckStadn", conn);
            checkstadn.CommandType = CommandType.StoredProcedure;
            checkstadn.Parameters.Add(new SqlParameter("@sname", Sname));


            SqlParameter success = checkstadn.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            checkstadn.ExecuteNonQuery();
            conn.Close();

            SqlCommand deletestad = new SqlCommand("deleteStadium", conn);
            deletestad.CommandType = CommandType.StoredProcedure;
            deletestad.Parameters.Add(new SqlParameter("@sname", Sname));

            if (String.IsNullOrEmpty(Sname))
            {
                Response.Write("Please Enter All Information");

            }


            else if (success.Value.ToString() == "0")
            {
                Response.Write("Stadium Doesn't Exist");
            }
            else
            {
                conn.Open();
                deletestad.ExecuteNonQuery();
                conn.Close();
                Response.Write("Stadium Deleted Successfully");
            }
        }
    }
}