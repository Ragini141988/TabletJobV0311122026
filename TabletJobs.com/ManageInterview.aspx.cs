using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TabletJobs.com
{
    public partial class ManageInterview : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        int PageSize = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData(1);
            }
        }

        private void BindData(int pageIndex)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("sp_GetJobsPaged", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@PageSize", PageSize);
                cmd.Parameters.AddWithValue("@Search", txtSearch.Text);
                cmd.Parameters.AddWithValue("@City", txtCity.Text);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lvJobs.DataSource = dt;
                lvJobs.DataBind();

                int totalRecords = Convert.ToInt32(dt.Rows[0]["TotalCount"]);
                BindPagination(totalRecords, pageIndex);
            }
        }

        private void BindPagination(int totalRecords, int currentPage)
        {
            int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);

            DataTable dt = new DataTable();
            dt.Columns.Add("PageIndex");
            dt.Columns.Add("Text");

            for (int i = 1; i <= totalPages; i++)
            {
                dt.Rows.Add(i, i.ToString());
            }

            rptPaging.DataSource = dt;
            rptPaging.DataBind();
        }

        protected void rptPaging_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int pageIndex = Convert.ToInt32(e.CommandArgument);
            BindData(pageIndex);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData(1);
        }

        protected void DeleteRecord(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM JobPostInternal WHERE JOBID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindData(1);
        }
    }
}