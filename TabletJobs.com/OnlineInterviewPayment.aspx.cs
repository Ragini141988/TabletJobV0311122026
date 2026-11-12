using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class OnlineInterviewPayment : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected int JobId
        {
            get { return ViewState["JobId"] == null ? 0 : Convert.ToInt32(ViewState["JobId"]); }
            set { ViewState["JobId"] = value; }
        }

        private string JobCity
        {
            get { return Convert.ToString(ViewState["JobCity"]); }
            set { ViewState["JobCity"] = value; }
        }

        private string JobState
        {
            get { return Convert.ToString(ViewState["JobState"]); }
            set { ViewState["JobState"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["jobId"], out int jobId) || jobId <= 0)
            {
                lblMessage.Text = "Invalid job id.";
                btnNext.Enabled = false;
                return;
            }

            JobId = jobId;

            if (!IsPostBack)
            {
                BindJob(jobId);
                LoadCategories();
                PopulateExpDropdown();
                txtName.Text = Convert.ToString(Session["Username"]);
                txtEmail.Text = Convert.ToString(Session["Nmail"]);
                txtMobile.Text = Convert.ToString(Session["Mobile"]);
            }
        }

        private void LoadCategories()
        {
            ddlCategory.Items.Clear();
            ddlCategory.Items.Add(new ListItem("-- Select Category --", ""));

            const string query = "SELECT CategoryID, CategoryName FROM JobCategoriesNew ORDER BY ISNULL(ordercolumn, CategoryID)";
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlCategory.Items.Add(new ListItem(
                                Convert.ToString(reader["CategoryName"]),
                                Convert.ToString(reader["CategoryID"])));
                        }
                    }
                }
            }
            catch
            {
                ddlCategory.Items.Add(new ListItem("Nurse", "1"));
                ddlCategory.Items.Add(new ListItem("Doctor", "2"));
                ddlCategory.Items.Add(new ListItem("Technician", "3"));
                ddlCategory.Items.Add(new ListItem("Pharmacist", "4"));
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateQualifications();
        }

        private void PopulateQualifications()
        {
            string category = ddlCategory.SelectedItem == null ? "" : ddlCategory.SelectedItem.Text;
            Dropqual.Items.Clear();

            switch (category)
            {
                case "Staff Nurse":
                    AddQualifications("ANM", "GNM", "GNM / Bsc Nursing", "B.Sc Nursing", "Post B.Sc Nursing", "M.Sc Nursing", "MPHW", "MSc Nursing (Obg/Gynec)", "MSc Nursing (Pediatrics)", "MSc Nursing (Psychiatric)", "MSc Nursing (Medical & Surgical)", "MSc Nursing (Community Health)", "MSc Nursing (Critical Care)", "MSc Nursing (Oncology)", "Other");
                    break;
                default:
                    AddQualifications("10th Pass", "12th Pass", "Graduate", "Post Graduate", "Diploma", "ITI", "Other");
                    break;
            }

            Dropqual.Items.Insert(0, new ListItem("-- Select Qualification --", ""));
        }

        private void AddQualifications(params string[] items)
        {
            foreach (string item in items)
                Dropqual.Items.Add(new ListItem(item, item));
        }

        private void PopulateExpDropdown()
        {
            DrpExp.Items.Clear();
            AddItems(DrpExp,
                "Select Experience",
                "Fresher with no experience",
                "1-3 Years",
                "1-5 Years",
                "2-5 Years",
                "3-7 Years",
                "7-10 Years",
                "10+ Years",
                "Fresher waiting for exam results",
                "Fresher waiting for registration.Result passed",
                "Fresher with registration.No experience");
        }

        private static void AddItems(ListControl control, params string[] items)
        {
            foreach (string item in items)
                control.Items.Add(new ListItem(item, item));
        }

        private void BindJob(int jobId)
        {
            const string sql = @"
                SELECT JobID, JTitle, hname, hcity, hstat, himages,
                       Jexp, Jposi,
                       ISNULL(CONVERT(varchar(20), InterviewDate, 106), 'TBD') AS InterviewDateText,
                       ISNULL(InterviewStartTime,'10:00 AM') AS InterviewStartTime
                FROM JobPostInternal
                WHERE JobID = @JobID";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblJobTitle.Text = Convert.ToString(dr["JTitle"]);
                        lblHospitalLocation.Text = string.Format("{0} | {1}, {2}", Convert.ToString(dr["hname"]), Convert.ToString(dr["hcity"]), Convert.ToString(dr["hstat"]));
                        imgHospitalImage.ImageUrl = GetHospitalImageDataUrl(dr["himages"]);
                        lblInterviewDateTime.Text = Convert.ToString(dr["InterviewDateText"]) + ", " + Convert.ToString(dr["InterviewStartTime"]);
                        lblExperience.Text = Convert.ToString(dr["Jexp"]);
                        lblVacancies.Text = Convert.ToString(dr["Jposi"]);
                        JobCity = Convert.ToString(dr["hcity"]);
                        JobState = Convert.ToString(dr["hstat"]);
                    }
                    else
                    {
                        lblMessage.Text = "Job not found.";
                        btnNext.Enabled = false;
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

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (!Page.IsValid)
                return;

          

            if (string.IsNullOrWhiteSpace(DrpExp.SelectedValue))
            {
                lblMessage.Text = "Please select Experience.";
                return;
            }

            if (string.IsNullOrWhiteSpace(Dropqual.SelectedValue))
            {
                lblMessage.Text = "Please select Qualification.";
                return;
            }

            try
            {
                int applicationId = SaveApplication();
                Response.Redirect("OnlineInterviewPaymentProceed.aspx?applicationId=" + applicationId, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Unable to save your application: " + ex.Message;
            }
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
        private int SaveApplication()
        {
            const string sql = @"
                INSERT INTO OnlineInterviewApplications
                (JobID, CandidateName, Mobile, Email, Address, City, [State], Gender,
                 CategoryID, SubcategoryID, Qualification, Experience,
                 ApplicationStatus, CreatedAt, UpdatedAt)
                VALUES
                (@JobID, @CandidateName, @Mobile, @Email, @Address, @City, @State, @Gender,
                 @CategoryID, @SubcategoryID, @Qualification, @Experience,
                 'PENDING_PAYMENT', GETDATE(), GETDATE());
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@JobID", JobId);
                cmd.Parameters.AddWithValue("@CandidateName", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", "DOB: " + "01/01/1990");
                cmd.Parameters.AddWithValue("@City", string.IsNullOrWhiteSpace(JobCity) ? "NA" : JobCity);
                cmd.Parameters.AddWithValue("@State", string.IsNullOrWhiteSpace(JobState) ? "NA" : JobState);
                cmd.Parameters.AddWithValue("@Gender", ddlGenderReq.SelectedValue);
                cmd.Parameters.AddWithValue("@CategoryID", int.TryParse(ddlCategory.SelectedValue, out int catId) ? (object)catId : DBNull.Value);
                cmd.Parameters.AddWithValue("@SubcategoryID", DBNull.Value);
                cmd.Parameters.AddWithValue("@Qualification", Dropqual.SelectedValue);
                cmd.Parameters.AddWithValue("@Experience", DrpExp.SelectedValue);
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }
    }
}
