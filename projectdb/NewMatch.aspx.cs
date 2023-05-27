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
    public partial class NewMatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddMatch(object sender, EventArgs e)
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

                SqlCommand checkclubh = new SqlCommand("CheckClubn", conn);
                checkclubh.CommandType = CommandType.StoredProcedure;
                checkclubh.Parameters.Add(new SqlParameter("@cname", hname));

                SqlParameter successh = checkclubh.Parameters.Add("@success", SqlDbType.Int);

                successh.Direction = ParameterDirection.Output;
                conn.Open();
                checkclubh.ExecuteNonQuery();
                conn.Close();

                SqlCommand checkclubg = new SqlCommand("CheckClubn", conn);
                checkclubg.CommandType = CommandType.StoredProcedure;
                checkclubg.Parameters.Add(new SqlParameter("@cname", gname));


                SqlParameter successg = checkclubg.Parameters.Add("@success", SqlDbType.Int);

                successg.Direction = ParameterDirection.Output;
                conn.Open();
                checkclubg.ExecuteNonQuery();
                conn.Close();

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


                if (successh.Value.ToString() == "0" || successg.Value.ToString() == "0")
                {
                    Response.Write("Club Doesn't Exist");
                }

                else if (success.Value.ToString() == "1")
                {
                    Response.Write("Match Already Exists");
                }
                else
                {
                    SqlCommand addmatch = new SqlCommand("addNewMatch", conn);
                    addmatch.CommandType = CommandType.StoredProcedure;
                    addmatch.Parameters.Add(new SqlParameter("@host", hname));
                    addmatch.Parameters.Add(new SqlParameter("@guest", gname));
                    addmatch.Parameters.Add(new SqlParameter("@start", Convert.ToDateTime(starttime)));
                    addmatch.Parameters.Add(new SqlParameter("@end", Convert.ToDateTime(endtime)));
                    conn.Open();
                    addmatch.ExecuteNonQuery();
                    conn.Close();
                    Response.Write("Match Added Successfully");
                }
            }
        }
    }   }