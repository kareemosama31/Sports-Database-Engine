using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectDB
{
    public partial class SportsAssociationManagerReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginclick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String samname = SAMname.Text;
            String samuser = SAMusername.Text;
            String sampass = Request["SAMpassword"];

            SqlCommand loginproc = new SqlCommand("CheckSAMu", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", samuser));
            

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            if (String.IsNullOrEmpty(samuser) || String.IsNullOrEmpty(sampass) || String.IsNullOrEmpty(samname))
            {
                Response.Write("Please Enter All Information");
            }
            else
            {
                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                SqlCommand addman = new SqlCommand("addAssociationManager", conn);
                addman.CommandType = CommandType.StoredProcedure;
                addman.Parameters.Add(new SqlParameter("@username", samuser));
                addman.Parameters.Add(new SqlParameter("@pass", sampass));
                addman.Parameters.Add(new SqlParameter("@name", samname));

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
                    Response.Redirect("SportsAssociationManagerLog.aspx", false);

                }
            }
        }
    }
}