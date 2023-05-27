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
    public partial class UnblockFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Blockf(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["ProjectDB"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String fid = FanID.Text;



            SqlCommand checkfan = new SqlCommand("CheckFan", conn);
            checkfan.CommandType = CommandType.StoredProcedure;
            checkfan.Parameters.Add(new SqlParameter("@nationalid", fid));


            SqlParameter success = checkfan.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            checkfan.ExecuteNonQuery();
            conn.Close();

            SqlCommand blockfan = new SqlCommand("unblockFan", conn);
            blockfan.CommandType = CommandType.StoredProcedure;
            blockfan.Parameters.Add(new SqlParameter("@nationalid", fid));

            SqlCommand checkblock = new SqlCommand("CheckUnBlock", conn);
            checkblock.CommandType = CommandType.StoredProcedure;
            checkblock.Parameters.Add(new SqlParameter("@nationalid", fid));


            SqlParameter block = checkblock.Parameters.Add("@block", SqlDbType.Int);

            block.Direction = ParameterDirection.Output;

            if (String.IsNullOrEmpty(fid))
            {
                Response.Write("Please Enter All Information");
            }


            else if (success.Value.ToString() == "0")
            {
                Response.Write("Fan Doesn't Exist");
            }
            else
            {
                conn.Open();
                checkblock.ExecuteNonQuery();
                conn.Close();
                if (block.Value.ToString() == "1")
                {
                    Response.Write("Fan Is Already unblocked");
                }
                else
                {
                    conn.Open();
                    blockfan.ExecuteNonQuery();
                    conn.Close();
                    Response.Write("Fan UnBlocked Successfully");
                }
            }
        }
    }
}