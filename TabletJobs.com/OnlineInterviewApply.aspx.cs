using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com
{
    public partial class OnlineInterviewApply : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected int JobId
        {
            get { return ViewState["JobId"] == null ? 0 : Convert.ToInt32(ViewState["JobId"]); }
            set { ViewState["JobId"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["jobId"], out int jobId))
            {
                lblError.Text = "Invalid job id.";
                btnAttendOnline.Enabled = false;
                return;
            }

            JobId = jobId;

            if (!IsPostBack)
            {
                BindJob(jobId);
            }
        }

        private void BindJob(int jobId)
        {
            const string query = @"
                SELECT JobID, JTitle, hname, hcity, hstat, himages, Jposi, Jqual, Jexp, Jsal,
                       GenderRequirement, Representative,
                       InterviewDate, ISNULL(InterviewStartTime,'10:00 AM') AS InterviewStartTime
                FROM JobPostInternal
                WHERE JobID = @JobID";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblJobTitle.Text = Convert.ToString(reader["JTitle"]);
                        lblHospitalLocation.Text = string.Format("{0} | {1}, {2}", Convert.ToString(reader["hname"]), Convert.ToString(reader["hcity"]), Convert.ToString(reader["hstat"]));
                        imgHospitalImage.ImageUrl = GetHospitalImageDataUrl(reader["himages"]);                        lblVacancies.Text = Convert.ToString(reader["Jposi"]);
                        lblQualification.Text = Convert.ToString(reader["Jqual"]);
                        lblExperience.Text = Convert.ToString(reader["Jexp"]);
                        lblSalary.Text = Convert.ToString(reader["Jsal"]);
                        lblGenderRequired.Text = string.IsNullOrWhiteSpace(Convert.ToString(reader["GenderRequirement"])) ? "Both" : Convert.ToString(reader["GenderRequirement"]);

                        DateTime interviewDate;
                        if (DateTime.TryParse(Convert.ToString(reader["InterviewDate"]), out interviewDate))
                        {
                            lblInterviewDateTime.Text = interviewDate.ToString("dd MMMM") + " | " + Convert.ToString(reader["InterviewStartTime"]);
                        }
                        else
                        {
                            lblInterviewDateTime.Text = "TBD | " + Convert.ToString(reader["InterviewStartTime"]);
                        }

                        string representative = Convert.ToString(reader["Representative"]);
                        //lblInterviewerRequired.Text = representative.Contains("Female") ? "Female" : "As per hospital requirement";
                    }
                    else
                    {
                        lblError.Text = "Job not found.";
                        btnAttendOnline.Enabled = false;
                    }
                }
            }
        }


        private string GetHospitalImageDataUrl(object imageData)
        {
            if (imageData == null || imageData == DBNull.Value)
            {
                return ResolveUrl("~/Images/jpglogopng.png");
            }

            byte[] bytes = imageData as byte[];

            if (bytes == null || bytes.Length == 0)
            {
                return ResolveUrl("~/Images/jpglogopng.png");
            }

            string mimeType = GetImageMimeType(bytes);

            return "data:" + mimeType + ";base64," +
                   Convert.ToBase64String(bytes);
        }
        private string GetImageMimeType(byte[] bytes)
        {
            if (bytes.Length >= 8 &&
                bytes[0] == 0x89 &&
                bytes[1] == 0x50 &&
                bytes[2] == 0x4E &&
                bytes[3] == 0x47)
            {
                return "image/png";
            }

            if (bytes.Length >= 3 &&
                bytes[0] == 0xFF &&
                bytes[1] == 0xD8 &&
                bytes[2] == 0xFF)
            {
                return "image/jpeg";
            }

            if (bytes.Length >= 6 &&
                bytes[0] == 'G' &&
                bytes[1] == 'I' &&
                bytes[2] == 'F')
            {
                return "image/gif";
            }

            return "image/jpeg";
        }

        protected string GetShareApplyUrl(int jobId)
        {
            return "https://tabletjobs.com/OnlineInterviewApply.aspx?jobId=" + jobId;
        }

        protected string GetFacebookShareUrl(int jobId)
        {
            return "https://www.facebook.com/sharer/sharer.php?u=" + Uri.EscapeDataString(GetShareApplyUrl(jobId));
        }

        protected string GetWhatsAppShareUrl(int jobId)
        {
            string text = "Check out TabletJobs online interview job: " + GetShareApplyUrl(jobId);
            return "https://api.whatsapp.com/send?text=" + Uri.EscapeDataString(text);
        }

        protected string GetTelegramShareUrl(int jobId)
        {
            return "https://t.me/share/url?url=" + Uri.EscapeDataString(GetShareApplyUrl(jobId)) + "&text=" + Uri.EscapeDataString("Find hospital jobs faster on TabletJobs.com");
        }

        protected string GetTwitterShareUrl(int jobId)
        {
            return "https://twitter.com/intent/tweet?url=" + Uri.EscapeDataString(GetShareApplyUrl(jobId)) + "&text=" + Uri.EscapeDataString("Find Hospital Jobs Faster on TabletJobs");
        }

        protected string GetLinkedInShareUrl(int jobId)
        {
            return "https://www.linkedin.com/shareArticle?mini=true&url=" + Uri.EscapeDataString(GetShareApplyUrl(jobId)) + "&title=" + Uri.EscapeDataString("TabletJobs - Healthcare Job Portal");
        }
        protected void btnAttendOnline_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/OnlineInterviewPayment.aspx?jobId=" + JobId, false);
        }
    }
}




