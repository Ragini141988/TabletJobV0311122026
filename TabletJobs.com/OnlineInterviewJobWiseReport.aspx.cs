using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class OnlineInterviewJobWiseReport : System.Web.UI.Page
    {
        private readonly string _connectionString =
            ConfigurationManager.ConnectionStrings[
                "hospi2yp_tabletjobssConnectionString_V02"
            ].ConnectionString;

        private const int PageSize = 30;

        private int CurrentPage
        {
            get
            {
                return ViewState["Page"] == null
                    ? 1
                    : Convert.ToInt32(ViewState["Page"]);
            }
            set
            {
                ViewState["Page"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 1;

                BindJobs();
                BindReport();
            }
        }

        private void BindJobs()
        {
            ddlJobs.Items.Clear();
            ddlJobs.Items.Add(
                new ListItem("-- All Jobs --", "")
            );

            const string sql = @"
                SELECT 
                    JobID, 
                    JTitle + ' | ' + hname AS DisplayText
                FROM JobPostInternal
                ORDER BY JobID DESC";

            try
            {
                using (SqlConnection con =
                    new SqlConnection(_connectionString))
                using (SqlCommand cmd =
                    new SqlCommand(sql, con))
                {
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            ddlJobs.Items.Add(
                                new ListItem(
                                    Convert.ToString(dr["DisplayText"]),
                                    Convert.ToString(dr["JobID"])
                                )
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Unable to load jobs. " + ex.Message;
            }
        }

        private void BindReport()
        {
            string sql = @"
                SELECT 
                    j.JobID, 
                    j.JTitle, 
                    j.hname AS Hospital, 
                    a.ApplicationID, 
                    a.CandidateName, 
                    a.Mobile, 
                    a.Email, 
                    a.ApplicationStatus, 
                    ISNULL(a.MerchantTxnId, p.MerchantTxnId) AS MerchantTxnId, 
                    ISNULL(p.Status, 'NA') AS PaymentStatus, 
                    CONVERT(varchar(19), a.CreatedAt, 120) AS CreatedAtText 

                FROM OnlineInterviewApplications a 

                INNER JOIN JobPostInternal j 
                    ON j.JobID = a.JobID 

                LEFT JOIN OnlineInterviewPayments p 
                    ON p.ApplicationID = a.ApplicationID 

                WHERE (@JobID IS NULL OR a.JobID = @JobID) 

                ORDER BY a.ApplicationID DESC 

                OFFSET @Offset ROWS 
                FETCH NEXT @PageSize ROWS ONLY";

            try
            {
                using (SqlConnection con =
                    new SqlConnection(_connectionString))
                using (SqlCommand cmd =
                    new SqlCommand(sql, con))
                {
                    // Job filter
                    int jobId;

                    if (int.TryParse(
                        ddlJobs.SelectedValue,
                        out jobId))
                    {
                        cmd.Parameters.Add(
                            "@JobID",
                            SqlDbType.Int
                        ).Value = jobId;
                    }
                    else
                    {
                        cmd.Parameters.Add(
                            "@JobID",
                            SqlDbType.Int
                        ).Value = DBNull.Value;
                    }

                    // Pagination
                    cmd.Parameters.Add(
                        "@Offset",
                        SqlDbType.Int
                    ).Value =
                        (CurrentPage - 1) * PageSize;

                    cmd.Parameters.Add(
                        "@PageSize",
                        SqlDbType.Int
                    ).Value = PageSize;

                    DataTable dt = new DataTable();

                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    rptData.DataSource = dt;
                    rptData.DataBind();

                    // Pagination buttons
                    btnPrevious.Enabled = CurrentPage > 1;

                    // If less than PageSize records are returned,
                    // we know this is the last page.
                    btnNext.Enabled = dt.Rows.Count == PageSize;

                    lblPageNumber.Text =
                        "Page " + CurrentPage;

                    // Optional message
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "No records found.";
                    }
                    else
                    {
                        lblMessage.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Unable to load report. " + ex.Message;
            }
        }

        protected void btnSearch_Click(
            object sender,
            EventArgs e)
        {
            // When changing job filter,
            // always start from page 1.
            CurrentPage = 1;

            BindReport();
        }

        protected void btnPrevious_Click(
            object sender,
            EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;

                BindReport();
            }
        }

        protected void btnNext_Click(
            object sender,
            EventArgs e)
        {
            CurrentPage++;

            BindReport();
        }
    }
}