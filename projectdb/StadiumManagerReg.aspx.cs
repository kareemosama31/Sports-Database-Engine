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
    public partial class StadiumManagerReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginclick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String smname = SMName.Text;
            String smuser = SMusername.Text;
            String smpass = Request["SMpassword"];
            String smstad = SMStad.Text;

            SqlCommand loginproc = new SqlCommand("CheckSMu", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", smuser));


            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            SqlCommand checksm = new SqlCommand("CheckStadSM", conn);
            checksm.CommandType = CommandType.StoredProcedure;
            checksm.Parameters.Add(new SqlParameter("@sname", smstad));


            SqlParameter success2 = checksm.Parameters.Add("@success", SqlDbType.Int);

            success2.Direction = ParameterDirection.Output;
            conn.Open();
            checksm.ExecuteNonQuery();
            conn.Close();


            if (String.IsNullOrEmpty(smuser) || String.IsNullOrEmpty(smpass) || String.IsNullOrEmpty(smname) || String.IsNullOrEmpty(smstad))
            {
                Response.Write("Please Enter All Information");
            }
            else if (success2.Value.ToString() == "1")
            {
                Response.Write("Stadium Already Has Representative");

            }

            else
            {
                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                SqlCommand checkstad = new SqlCommand("CheckStadn", conn);
                checkstad.CommandType = CommandType.StoredProcedure;
                checkstad.Parameters.Add(new SqlParameter("@sname", smstad));


                SqlParameter success1 = checkstad.Parameters.Add("@success", SqlDbType.Int);

                success1.Direction = ParameterDirection.Output;

                conn.Open();
                checkstad.ExecuteNonQuery();
                conn.Close();
                if (success1.Value.ToString() == "1")
                {

                    SqlCommand addman = new SqlCommand("addStadiumManager", conn);
                    addman.CommandType = CommandType.StoredProcedure;
                    addman.Parameters.Add(new SqlParameter("@username", smuser));
                    addman.Parameters.Add(new SqlParameter("@password", smpass));
                    addman.Parameters.Add(new SqlParameter("@name", smname));
                    addman.Parameters.Add(new SqlParameter("@stadname", smstad));

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
                        Response.Redirect("StadiumManagerLog.aspx", false);

                    }
                }
                else
                {
                    Response.Write("Please Enter An Available Stadium");

                }
            }
        }
    }
}