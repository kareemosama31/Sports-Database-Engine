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
    public partial class FanLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginclick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String users = user.Text;
            String passs = Request["pass"];

            SqlCommand loginproc = new SqlCommand("CheckF", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@username", users));
            loginproc.Parameters.Add(new SqlParameter("@password", passs));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["user"] = users;
                Response.Redirect("FanPage.aspx", false);
            }
            else
            {
                Response.Write("Username Or Password Is Incorrect");
            }
        }
    }
}