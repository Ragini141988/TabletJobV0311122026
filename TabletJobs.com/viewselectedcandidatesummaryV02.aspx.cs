using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class viewselectedcandidatesummaryV02 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGridView();
            }
        }

        private void LoadGridView()
        {
            string query = @"
        SELECT 
            ROW_NUMBER() OVER (ORDER BY MIN(SerialNo)) AS SerialNo,
            HospitalName, 
                City,
            InterviewDate, 
            COUNT(*) AS SelectedCount
        FROM dbo.InterviewResult
        GROUP BY HospitalName, InterviewDate,City
        ORDER BY InterviewDate DESC";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    ListView4.DataSource = dt;
                    ListView4.DataBind();
                }
            }
        }


        protected void gvCandidates_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnkSelectedCandidates = (LinkButton)e.Row.FindControl("lnkSelectedCandidates");
                DataRowView row = (DataRowView)e.Row.DataItem;

                int selectedCount = Convert.ToInt32(row["SelectedCount"]);
                string hospitalName = row["HospitalName"].ToString();
                string interviewDate = Convert.ToDateTime(row["InterviewDate"]).ToString("yyyy-MM-dd");

                // Set Hyperlink Text & URL
                lnkSelectedCandidates.Text = selectedCount.ToString();
                lnkSelectedCandidates.PostBackUrl = "SelectedCandidatesDetails.aspx?Hospital=" + hospitalName + "&Date=" + interviewDate;
            }
        }

        protected void ListView4_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                LinkButton lnkSelectedCandidates = (LinkButton)e.Item.FindControl("lnkSelectedCandidates");
                DataRowView row = (DataRowView)e.Item.DataItem;

                int selectedCount = Convert.ToInt32(row["SelectedCount"]);
                string hospitalName = row["HospitalName"].ToString();
                string interviewDate = Convert.ToDateTime(row["InterviewDate"]).ToString("yyyy-MM-dd");

                // Set Hyperlink Text & URL
                // lnkSelectedCandidates.Text = $"Selected Candidates: {selectedCount}";
                lnkSelectedCandidates.PostBackUrl = $"SelectedCandidatesDetails.aspx?Hospital={hospitalName}&Date={interviewDate}";
            }
        }


    }
}