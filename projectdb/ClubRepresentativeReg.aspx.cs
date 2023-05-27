using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Runtime.Remoting.Metadata.W3cXsd2001;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectDB
{
    public partial class ClubRepresentativeReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rclick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String crname = CRname.Text;
            String cruser = CRusername.Text;
            String crpass = Request["CRpassword"];
            String crclub = CRclub.Text;

            SqlCommand loginproc = new SqlCommand("CheckCRu", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", cruser));


            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            SqlCommand checkcr = new SqlCommand("CheckClubCR", conn);
            checkcr.CommandType = CommandType.StoredProcedure;
            checkcr.Parameters.Add(new SqlParameter("@cname", crclub));


            SqlParameter success2 = checkcr.Parameters.Add("@success", SqlDbType.Int);

            success2.Direction = ParameterDirection.Output;
            conn.Open();
            checkcr.ExecuteNonQuery();
            conn.Close();

            if (String.IsNullOrEmpty(cruser) || String.IsNullOrEmpty(crpass) || String.IsNullOrEmpty(crname) || String.IsNullOrEmpty(crclub))
            {
                Response.Write("Please Enter All Information");
            }
            else if (success2.Value.ToString() == "1")
            {
                Response.Write("Club Already Has Representative");
            }
            else
            {
                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                SqlCommand checkclub = new SqlCommand("CheckClubn", conn);
                checkclub.CommandType = CommandType.StoredProcedure;
                checkclub.Parameters.Add(new SqlParameter("@cname", crclub));


                SqlParameter success1 = checkclub.Parameters.Add("@success", SqlDbType.Int);

                success1.Direction = ParameterDirection.Output;

                conn.Open();
                checkclub.ExecuteNonQuery();
                conn.Close();

                if (success1.Value.ToString() == "1")
                {
                    SqlCommand addman = new SqlCommand("addRepresentative", conn);
                    addman.CommandType = CommandType.StoredProcedure;
                    addman.Parameters.Add(new SqlParameter("@name", crname));
                    addman.Parameters.Add(new SqlParameter("@password", crpass));
                    addman.Parameters.Add(new SqlParameter("@username", cruser));
                    addman.Parameters.Add(new SqlParameter("@cname", crclub));

                    if (success.Value.ToString() == "1")
                    {
                        Response.Write("This User Is Already In The System");
                    }
                    else
                    {
                        conn.Open();
                        addman.ExecuteNonQuery();
                        conn.Close();
                        Response.Write("User Added Successfully");
                        Response.Redirect("ClubRepresentativeLog.aspx", false);

                    }
                }
                else
                {
                    Response.Write("Please Enter An Available Club");
                }


            }
        }
    }
}