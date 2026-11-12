using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class OnlineInterviewJobs : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFilters();
                BindJobs();
            }
        }

        private void BindFilters()
        {
            ddlLocation.Items.Clear();
            ddlLocation.Items.Add("All Locations");

            ddlJobCategory.Items.Clear();
            ddlJobCategory.Items.Add("All Jobs");

            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    con.Open();

                    //using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT hcity FROM JobPostInternal WHERE ISNULL(hcity,'')<>'' ORDER BY hcity", con))
                    using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT hcity FROM JobPostInternal WHERE hcity = 'Bangalore' ORDER BY hcity", con))
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            ddlLocation.Items.Add(Convert.ToString(dr["hcity"]));
                        }
                    }

                    using (SqlCommand cmd2 = new SqlCommand("SELECT CategoryName FROM JobCategoriesNew  where IsActive = 'Y'  ORDER BY ISNULL(ordercolumn, CategoryID)", con))
                    using (SqlDataReader dr2 = cmd2.ExecuteReader())
                    {
                        while (dr2.Read())
                        {
                            ddlJobCategory.Items.Add(Convert.ToString(dr2["CategoryName"]));
                        }
                    }
                }
            }
            catch
            {
                // Keep defaults if table is unavailable.
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindJobs();
        }
        private int PageSize = 10;

        private int CurrentPage
        {
            get
            {
                return ViewState["CurrentPage"] == null
                    ? 0
                    : (int)ViewState["CurrentPage"];
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }
        private void BindJobs()
        {
            const string sql = @"
        SELECT
            j.JobID,
            j.JTitle,
            j.hname,
            j.hcity,
            j.hstat, 
            j.Jposi,
            j.Jsal,
            GenderRequirement,
            j.Jexp,
            InterviewDate,
            InterviewEndTime,
            Jqual,
            ISNULL(j.InterviewStartTime, '10:00 AM') AS InterviewStartTime,
            CASE
                WHEN DATEDIFF(DAY, ISNULL(j.JPostdate, GETDATE()), GETDATE()) <= 2 THEN 'New'
                WHEN UPPER(ISNULL(j.Status,'')) = 'SCHEDULED' THEN 'Urgent'
                ELSE ''
            END AS BadgeText
        FROM JobPostInternal j
        LEFT JOIN JobCategoriesNew c ON c.CategoryID = j.CategoryID
        WHERE ISNULL(j.IsActive, 'Y') = 'Y'
            AND (@Search = '' 
                 OR j.JTitle LIKE '%' + @Search + '%'
                 OR j.hname LIKE '%' + @Search + '%'
                 OR j.hcity LIKE '%' + @Search + '%')
            AND (@City = '' OR j.hcity = @City)
            AND (@Category = '' OR c.CategoryName = @Category)
        ORDER BY ISNULL(j.JPostdate, GETDATE()) desc, j.JobID DESC";

            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    string search = (txtSearch.Text ?? string.Empty).Trim();

                    string city = ddlLocation.SelectedValue == "All Locations"
                        ? string.Empty
                        : ddlLocation.SelectedValue;

                    string category = ddlJobCategory.SelectedValue == "All Jobs"
                        ? string.Empty
                        : ddlJobCategory.SelectedValue;

                    cmd.Parameters.AddWithValue("@Search", search);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@Category", category);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // -------------------------------
                        // PAGING - 10 JOBS PER PAGE
                        // -------------------------------

                        PagedDataSource pds = new PagedDataSource();

                        pds.DataSource = dt.DefaultView;
                        pds.AllowPaging = true;
                        pds.PageSize = PageSize;
                        pds.CurrentPageIndex = CurrentPage;

                        rptJobs.DataSource = pds;
                        rptJobs.DataBind();

                        // -------------------------------
                        // NO JOBS
                        // -------------------------------

                        if (dt.Rows.Count == 0)
                        {
                            lblMessage.Text = "No jobs found for selected filters.";
                        }
                        else
                        {
                            lblMessage.Text = string.Empty;
                        }

                        // -------------------------------
                        // PAGING BUTTONS
                        // -------------------------------

                        btnPrevious.Enabled = !pds.IsFirstPage;
                        btnNext.Enabled = !pds.IsLastPage;

                        lblPageInfo.Text =
                            "Page " + (CurrentPage + 1) +
                            " of " + pds.PageCount;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Unable to load jobs. " + ex.Message;
            }
        }
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindJobs();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindJobs();
        }

        protected bool ShowBadge(object badgeObj)
        {
            string badge = Convert.ToString(badgeObj);
            return !string.IsNullOrWhiteSpace(badge);
        }

        protected string FormatHospital(object hospital, object city, object state)
        {
            return string.Format("{0} | {1}, {2}", Convert.ToString(hospital), Convert.ToString(city), Convert.ToString(state));
        }

        protected string FormatVacancies(object vacancies)
        {
            string value = Convert.ToString(vacancies);
            if (string.IsNullOrWhiteSpace(value))
            {
                return "Vacancies";
            }

            return value + " Vacancies";
        }

        protected string GetHospitalImageDataUrl(object imageData)
        {
            if (imageData == null || imageData == DBNull.Value)
            {
                return ResolveClientUrl("~/Images/jpglogopng.png");
            }

            byte[] bytes = imageData as byte[];
            if (bytes == null || bytes.Length == 0)
            {
                return ResolveClientUrl("~/Images/jpglogopng.png");
            }

            return "data:image/jpeg;base64," + Convert.ToBase64String(bytes);
        }


        protected string GetFacebookShareUrl(object jobIdObj)
        {
            string url = GetShareApplyUrl(jobIdObj);
            return "https://www.facebook.com/sharer/sharer.php?u=" + Uri.EscapeDataString(url);
        }

        protected string GetWhatsAppShareUrl(object jobIdObj)
        {
            string url = GetShareApplyUrl(jobIdObj);
            string text = "Check out TabletJobs online interview job: " + url;
            return "https://api.whatsapp.com/send?text=" + Uri.EscapeDataString(text);
        }

        protected string GetTelegramShareUrl(object jobIdObj)
        {
            string url = GetShareApplyUrl(jobIdObj);
            string text = "Find hospital jobs faster on TabletJobs.com";
            return "https://t.me/share/url?url=" + Uri.EscapeDataString(url) + "&text=" + Uri.EscapeDataString(text);
        }

        protected string GetTwitterShareUrl(object jobIdObj)
        {
            string url = GetShareApplyUrl(jobIdObj);
            string text = "Find Hospital Jobs Faster on TabletJobs";
            return "https://twitter.com/intent/tweet?url=" + Uri.EscapeDataString(url) + "&text=" + Uri.EscapeDataString(text);
        }

        protected string GetLinkedInShareUrl(object jobIdObj)
        {
            string url = GetShareApplyUrl(jobIdObj);
            string title = "TabletJobs - Healthcare Job Portal";
            return "https://www.linkedin.com/shareArticle?mini=true&url=" + Uri.EscapeDataString(url) + "&title=" + Uri.EscapeDataString(title);
        }
        protected string GetShareApplyUrl(object jobIdObj)
        {
            int jobId;
            if (!int.TryParse(Convert.ToString(jobIdObj), out jobId))
            {
                jobId = 9;
            }

            return "https://tabletjobs.com/OnlineInterviewApply.aspx?jobId=" + jobId;
        }
    }
}




