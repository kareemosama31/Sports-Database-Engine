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
    public partial class FanReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginclick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String fname = Fname.Text;
            String fuser = Fusername.Text;
            String fpass = Request["Fpassword"];
            String fid = Request["FID"];
            String fphone = Request["FPhone"];
            String fbd = Request["FBD"];
            String fadd = Request["FAddress"];


            SqlCommand loginproc = new SqlCommand("CheckFu", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", fuser));
            loginproc.Parameters.Add(new SqlParameter("@nationalid", fid));



            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            if (String.IsNullOrEmpty(fuser) || String.IsNullOrEmpty(fpass) || String.IsNullOrEmpty(fname) || String.IsNullOrEmpty(fid) || String.IsNullOrEmpty(fphone) || String.IsNullOrEmpty(fbd) || String.IsNullOrEmpty(fadd))
            {
                Response.Write("Please Enter All Information");
            }
            else
            {
                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                SqlCommand addman = new SqlCommand("addFan", conn);
                addman.CommandType = CommandType.StoredProcedure;
                addman.Parameters.Add(new SqlParameter("@name", fname));
                addman.Parameters.Add(new SqlParameter("@nationalid", fid));
                addman.Parameters.Add(new SqlParameter("@birth_date", fbd));
                addman.Parameters.Add(new SqlParameter("@address",fadd));
                addman.Parameters.Add(new SqlParameter("@phoneno", fphone));
                addman.Parameters.Add(new SqlParameter("@username", fuser));
                addman.Parameters.Add(new SqlParameter("@password", fpass));



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
                    Response.Redirect("FanLog.aspx", false);

                }
            }
        }
    }
}