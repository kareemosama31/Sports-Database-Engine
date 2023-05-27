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
    public partial class DeleteMatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DeleteMatchc(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String hname = HostName.Text;
            String gname = GuestName.Text;
            String starttime = Start.Text;
            String endtime = End.Text;

            if (String.IsNullOrEmpty(hname) || String.IsNullOrEmpty(gname) || String.IsNullOrEmpty(Start.Text) || String.IsNullOrEmpty(End.Text))
            {
                Response.Write("Please Enter All Information");
            }

            else
            {

                SqlCommand checkmatch = new SqlCommand("CheckMatch", conn);
                checkmatch.CommandType = CommandType.StoredProcedure;
                checkmatch.Parameters.Add(new SqlParameter("@hname", hname));
                checkmatch.Parameters.Add(new SqlParameter("@gname", gname));
                checkmatch.Parameters.Add(new SqlParameter("@start", Convert.ToDateTime(starttime)));
                checkmatch.Parameters.Add(new SqlParameter("@end", Convert.ToDateTime(endtime)));




                SqlParameter success = checkmatch.Parameters.Add("@success", SqlDbType.Int);

                success.Direction = ParameterDirection.Output;

                conn.Open();
                checkmatch.ExecuteNonQuery();
                conn.Close();




                if (success.Value.ToString() == "0")
                {
                    Response.Write("Match Doesn't Exist");
                }
                else
                {
                    SqlCommand deletematch = new SqlCommand("deleteMatch", conn);
                    deletematch.CommandType = CommandType.StoredProcedure;
                    deletematch.Parameters.Add(new SqlParameter("@host", hname));
                    deletematch.Parameters.Add(new SqlParameter("@guest", gname));
                    conn.Open();
                    deletematch.ExecuteNonQuery();
                    conn.Close();
                    Response.Write("Match Deleted Successfully");
                }
            }
        }

        }
}