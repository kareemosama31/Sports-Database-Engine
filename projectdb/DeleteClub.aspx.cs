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
    public partial class DeleteClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Deletec(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String Cname = ClubName.Text;
            


            SqlCommand checkclubn = new SqlCommand("CheckClubn", conn);
            checkclubn.CommandType = CommandType.StoredProcedure;
            checkclubn.Parameters.Add(new SqlParameter("@cname", Cname));
            

            SqlParameter success = checkclubn.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            checkclubn.ExecuteNonQuery();
            conn.Close();

            SqlCommand deleteclub = new SqlCommand("deleteClub", conn);
            deleteclub.CommandType = CommandType.StoredProcedure;
            deleteclub.Parameters.Add(new SqlParameter("@cname", Cname));

            if (String.IsNullOrEmpty(Cname))
            {
                Response.Write("Please Enter All Information");
            }
            
            
            else if (success.Value.ToString() == "0")
            {
                Response.Write("Club Doesn't Exist");
            }
            else
            {
                conn.Open();
                deleteclub.ExecuteNonQuery();
                conn.Close();
                Response.Write("Club Deleted Successfully");
            }
        }
    }
}