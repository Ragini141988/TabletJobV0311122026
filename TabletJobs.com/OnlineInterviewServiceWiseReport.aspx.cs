using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class OnlineInterviewServiceWiseReport : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;
        private int PageSize = 10;
        private int CurrentPage
        {
            get { return ViewState["Page"] == null ? 1 : (int)ViewState["Page"]; }
            set { ViewState["Page"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindReport();
            }
        }
        protected void btnLoadMore_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindReport(true);
        }
        
        private void BindReport(bool isLoadMore = false)
        {
            string sql = @"
        SELECT
            a.ApplicationID,
            a.CandidateName,
            a.Mobile,
            a.Email,
            a.ServiceType,
            a.ApplicationStatus,
            ISNULL(a.MerchantTxnId, p.MerchantTxnId) AS MerchantTxnId,
            ISNULL(p.Status, 'NA') AS PaymentStatus,
            p.Amount,
            CONVERT(varchar(19), a.CreatedAt, 120) AS CreatedAtText
        FROM ServicePaymentApplications a
        LEFT JOIN ServicePayments p ON p.ApplicationID = a.ApplicationID
        ORDER BY a.ApplicationID DESC
        OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@Offset", (CurrentPage - 1) * PageSize);
                cmd.Parameters.AddWithValue("@PageSize", PageSize);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (isLoadMore && ViewState["Data"] != null)
                {
                    DataTable oldDt = (DataTable)ViewState["Data"];
                    oldDt.Merge(dt);
                    rptData.DataSource = oldDt;
                    rptData.DataBind();
                    ViewState["Data"] = oldDt;
                }
                else
                {
                    rptData.DataSource = dt;
                    rptData.DataBind();
                    ViewState["Data"] = dt;
                }

                btnLoadMore.Visible = dt.Rows.Count == PageSize;
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 1;
            BindReport();
        }


    }
}
