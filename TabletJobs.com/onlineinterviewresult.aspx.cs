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
    public partial class onlineinterviewresult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadGridView();
        }
        private void LoadGridView()
        {
            string connStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("GetTopInterviewSummary", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    listview_interviewresult.DataSource = dt;
                    listview_interviewresult.DataBind();
                }
            }
        }
        protected void listview_interviewresult_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var lnk = (HyperLink)e.Item.FindControl("lnkSelectedCandidates");
                var row = (DataRowView)e.Item.DataItem;

                int selectedCount = Convert.ToInt32(row["SelectedCount"]);
                string hospitalName = Server.UrlEncode(row["HospitalName"].ToString());
                string interviewDate = Convert.ToDateTime(row["InterviewDate"]).ToString("yyyy-MM-dd");

                lnk.NavigateUrl = $"SelectedCandidatesDetails.aspx?Hospital={hospitalName}&Date={interviewDate}";
                lnk.Text = selectedCount.ToString();
            }
        }

    }
}