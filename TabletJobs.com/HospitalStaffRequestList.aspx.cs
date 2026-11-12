using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class HospitalStaffRequestList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        void BindData()
        {
            string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM HospitalStaffRequest,JobCategories where StaffRequired = CategoryID ORDER BY Id DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lvData.DataSource = dt;
                lvData.DataBind();
            }
        }

        protected void lvData_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

            if (e.CommandName == "DeleteItem")
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM HospitalStaffRequest WHERE Id=@Id", con);
                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                BindData();
            }

            if (e.CommandName == "EditItem")
            {
                Response.Redirect("HospitalStaffRequest.aspx?Id=" + id);
            }
        }
    }
}