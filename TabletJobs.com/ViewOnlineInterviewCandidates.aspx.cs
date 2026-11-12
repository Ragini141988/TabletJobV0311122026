using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ViewOnlineInterviewCandidates : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadJobFilter();
                BindCandidates();
            }
        }
        private void BindCandidates()
            {
                string sql = @"
        SELECT 
            a.ApplicationID,
            a.CandidateName,
            a.Mobile,
            a.Email,

            j.hname AS HospitalName,
            j.hcity AS City,
            j.JTitle AS ApplyingFor,

            a.Qualification,
            a.Experience,
            a.ApplicationStatus,
            a.CreatedAt,

            ISNULL(p.PaymentStatus, 'NOT_PAID') AS PaymentStatus

        FROM OnlineInterviewApplications a

        INNER JOIN JobPostInternal j
            ON j.JobID = a.JobID

        OUTER APPLY
        (
            SELECT TOP 1
                Status AS PaymentStatus
            FROM OnlineInterviewPayments
            WHERE ApplicationID = a.ApplicationID
            ORDER BY CreatedAt DESC
        ) p

        WHERE 1 = 1
    ";

                if (!string.IsNullOrWhiteSpace(ddlJobFilter.SelectedValue))
                {
                    sql += " AND a.JobID = @JobID ";
                }

                if (!string.IsNullOrWhiteSpace(txtFromDate.Text))
                {
                    sql += " AND a.CreatedAt >= @FromDate ";
                }

                if (!string.IsNullOrWhiteSpace(txtToDate.Text))
                {
                    sql += " AND a.CreatedAt < DATEADD(DAY, 1, @ToDate) ";
                }

                sql += " ORDER BY a.CreatedAt DESC";


                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(sql, con))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    if (!string.IsNullOrWhiteSpace(ddlJobFilter.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue(
                            "@JobID",
                            Convert.ToInt32(ddlJobFilter.SelectedValue));
                    }

                    if (!string.IsNullOrWhiteSpace(txtFromDate.Text))
                    {
                        cmd.Parameters.AddWithValue(
                            "@FromDate",
                            DateTime.Parse(txtFromDate.Text));
                    }

                    if (!string.IsNullOrWhiteSpace(txtToDate.Text))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ToDate",
                            DateTime.Parse(txtToDate.Text));
                    }


                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    lvCandidates.DataSource = dt;
                    lvCandidates.DataBind();
                }
            }
            private void LoadJobFilter()
            {
                const string sql = @"
        SELECT JobID, JTitle
        FROM JobPostInternal
        ORDER BY JTitle";

                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(sql, con))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    ddlJobFilter.DataSource = dt;
                    ddlJobFilter.DataTextField = "JTitle";
                    ddlJobFilter.DataValueField = "JobID";
                    ddlJobFilter.DataBind();
                }

                ddlJobFilter.Items.Insert(
                    0,
                    new ListItem("-- All Jobs --", "")
                );
            }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindCandidates();
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlJobFilter.SelectedIndex = 0;

            txtFromDate.Text = "";
            txtToDate.Text = "";

            BindCandidates();
        }
        protected string GetCandidateCss(object paymentStatus)
        {
            string status = Convert.ToString(paymentStatus);

            if (status.Equals("SUCCESS", StringComparison.OrdinalIgnoreCase))
            {
                return "candidate-card candidate-paid";
            }

            return "candidate-card candidate-unpaid";
        }
        protected string GetPaymentStatusCss(object paymentStatus)
        {
            string status = Convert.ToString(paymentStatus);

            if (status.Equals("SUCCESS", StringComparison.OrdinalIgnoreCase))
            {
                return "payment-status paid-status";
            }

            return "payment-status unpaid-status";
        }
        protected string GetPaymentStatusText(object paymentStatus)
        {
            string status = Convert.ToString(paymentStatus);

            if (status.Equals("SUCCESS", StringComparison.OrdinalIgnoreCase))
            {
                return "Payment Done";
            }

            if (status.Equals("INITIATED", StringComparison.OrdinalIgnoreCase))
            {
                return "Payment Pending";
            }

            if (status.Equals("FAILED", StringComparison.OrdinalIgnoreCase))
            {
                return "Payment Failed";
            }

            return "Payment Not Done";
        }
    }
}
