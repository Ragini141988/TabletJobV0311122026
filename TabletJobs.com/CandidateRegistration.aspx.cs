using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class CandidateRegistration : System.Web.UI.Page
    {
        string conStr = ConfigurationManager
            .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
            .ConnectionString;
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateCandidateCode();
                LoadStates();
                LoadCategories();
            }

            if (IsPostBack)
            {
                SaveTempFiles();
            }
        }
            private void SaveTempFiles()
            {
                if (fuResume.HasFile &&
                    string.IsNullOrEmpty(hfResume.Value))
                {
                    hfResume.Value =
                        UploadFile(fuResume, "Temp");
                }

                if (fuPhoto.HasFile &&
                    string.IsNullOrEmpty(hfPhoto.Value))
                {
                    hfPhoto.Value =
                        UploadFile(fuPhoto, "Temp");
                }

                if (fuCertificate.HasFile &&
                    string.IsNullOrEmpty(hfCertificate.Value))
                {
                    hfCertificate.Value =
                        UploadFile(fuCertificate, "Temp");
                }

                if (fuAadhaar.HasFile &&
                    string.IsNullOrEmpty(hfAadhaar.Value))
                {
                    hfAadhaar.Value =
                        UploadFile(fuAadhaar, "Temp");
                }
            }
        
        private void LoadStates()
        {
            List<string> states = new List<string>
            {
                "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Delhi",
                "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala",
                "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "NA", "Nagaland",
                "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
                "Uttar Pradesh", "Uttarakhand", "West Bengal"
            };

            ddlCurrentState.DataSource = states;
            ddlCurrentState.DataBind();
            ddlCurrentState.Items.Insert(0, new ListItem("Select a state", "Select a state"));
            ddlRegistrationState.DataSource = states;
            ddlRegistrationState.DataBind();
            ddlRegistrationState.Items.Insert(0, new ListItem("Select a state", "Select a state"));
            ddlNativeState.DataSource = states;
            ddlNativeState.DataBind();
            ddlNativeState.Items.Insert(0, new ListItem("Select a state", "Select a state"));


        }
        private void GenerateCandidateCode()
        {
            txtCandidateCode.Text =
                "CAN" + DateTime.Now.ToString("yyyyMMddHHmmss");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveTempFiles();
            if (!Page.IsValid)
                return;

            try
            {
                // Mobile Duplicate Check
                if (MobileExists(txtMobile.Text.Trim()))
                {
                    ShowMessage("Mobile Number already exists.");
                    return;
                }

                // Email Duplicate Check
                if (EmailExists(txtEmail.Text.Trim()))
                {
                    ShowMessage("Email already exists.");
                    return;
                }

                // DOB Validation
                DateTime dob;

                if (!DateTime.TryParse(txtDOB.Text, out dob))
                {
                    ShowMessage("Invalid DOB.");
                    return;
                }

                if (dob > DateTime.Now)
                {
                    ShowMessage("DOB cannot be future date.");
                    return;
                }

                // Upload Files
               
                string resumePath = hfResume.Value;
                string photoPath = hfPhoto.Value;
                string certificatePath = hfCertificate.Value;
                string aadhaarPath = hfAadhaar.Value;
               
               

                using (SqlConnection con = new SqlConnection(conStr))
                {

string sql = @"
INSERT INTO CandidateMaster
(
    CandidateCode,
    FullName,
    Gender,
    DateOfBirth,
    Age,

    MobileNumber,
    AlternateMobileNumber,
    WhatsAppNumber,
    Email,

    CurrentCity,
    CurrentState,
    NativePlace,
    NativeState,
    CurrentAddress,
    PermanentAddress,
    Pincode,

    CandidateCategory,
    Department,
    Designation,

    Qualification,
    Specialization,

    RegistrationState,
    RegistrationStatus,

    TotalExperienceYears,
    CurrentEmployer,

    CurrentSalary,
    ExpectedSalary,

    NoticePeriod,
    PreferredLocation,
    WillingToRelocate,
    FoodAccommodationRequired,

    ResumeFileUrl,
    PhotoFileUrl,
    CertificateFileUrl,
    AadhaarFileUrl,

    CandidateStatus,
    ProfileCompletionPercent,
    VerificationStatus,

    Source,
    AssignedRecruiter,

    LastContactedAt,
    NextFollowUpAt,
    InternalRemarks,

    CreatedAt,
    UpdatedAt,

    CreatedByUserId,
    UpdatedByUserId,

    IsActive
)
VALUES
(
    @CandidateCode,
    @FullName,
    @Gender,
    @DateOfBirth,
    @Age,

    @MobileNumber,
    @AlternateMobileNumber,
    @WhatsAppNumber,
    @Email,

    @CurrentCity,
    @CurrentState,
    @NativePlace,
    @NativeState,
    @CurrentAddress,
    @PermanentAddress,
    @Pincode,

    @CandidateCategory,
    @Department,
    @Designation,

    @Qualification,
    @Specialization,

    @RegistrationState,
    @RegistrationStatus,

    @TotalExperienceYears,
    @CurrentEmployer,

    @CurrentSalary,
    @ExpectedSalary,

    @NoticePeriod,
    @PreferredLocation,
    @WillingToRelocate,
    @FoodAccommodationRequired,

    @ResumeFileUrl,
    @PhotoFileUrl,
    @CertificateFileUrl,
    @AadhaarFileUrl,

    @CandidateStatus,
    @ProfileCompletionPercent,
    @VerificationStatus,

    @Source,
    @AssignedRecruiter,

    @LastContactedAt,
    @NextFollowUpAt,
    @InternalRemarks,

    GETDATE(),
    GETDATE(),

    @CreatedByUserId,
    @UpdatedByUserId,

    1
)";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@CandidateCode", txtCandidateCode.Text);
                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                    cmd.Parameters.AddWithValue("@DateOfBirth", dob);
                    

                    cmd.Parameters.AddWithValue("@Age", txtAge.Text.Trim());
                    cmd.Parameters.AddWithValue("@MobileNumber", txtMobile.Text);
                    cmd.Parameters.AddWithValue("@AlternateMobileNumber", txtAltMobile.Text);
                    cmd.Parameters.AddWithValue("@WhatsAppNumber", txtWhatsApp.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);

                    cmd.Parameters.AddWithValue("@CurrentCity", txtCurrentCity.Text);
                    cmd.Parameters.AddWithValue("@CurrentState", ddlCurrentState.SelectedValue);

                    cmd.Parameters.AddWithValue("@NativePlace", txtNativePlace.Text);
                    cmd.Parameters.AddWithValue("@NativeState", ddlNativeState.SelectedValue);

                    cmd.Parameters.AddWithValue("@CurrentAddress", txtCurrentAddress.Text);
                    cmd.Parameters.AddWithValue("@PermanentAddress", txtPermanentAddress.Text);

                    cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text);

                    cmd.Parameters.AddWithValue("@CandidateCategory",
                        ddlCandidateCategory.SelectedValue);

                    cmd.Parameters.AddWithValue("@Department",
                        ddlDepartment.SelectedValue);

                    cmd.Parameters.AddWithValue("@Designation",
                        txtDesignation.Text);

                    cmd.Parameters.AddWithValue("@Qualification",
                        ddlQualification.SelectedValue);

                    cmd.Parameters.AddWithValue("@ProfileCompletionPercent", CalculateProfileCompletion());

                    cmd.Parameters.AddWithValue("@TotalExperienceYears",
                     string.IsNullOrWhiteSpace(txtExperience.Text)
                     ? (object)0
                     : Convert.ToDecimal(txtExperience.Text));



                    cmd.Parameters.AddWithValue("@CurrentEmployer",
                        txtEmployer.Text);

                    cmd.Parameters.AddWithValue("@CurrentSalary",
 string.IsNullOrWhiteSpace(txtCurrentSalary.Text)
 ? (object)0
 : Convert.ToDecimal(txtCurrentSalary.Text));



                    cmd.Parameters.AddWithValue("@ExpectedSalary",
                   string.IsNullOrWhiteSpace(txtExpectedSalary.Text)
                   ? (object)0
                   : Convert.ToDecimal(txtExpectedSalary.Text));

                    cmd.Parameters.AddWithValue("@ResumeFileUrl", resumePath);
                    cmd.Parameters.AddWithValue("@PhotoFileUrl", photoPath);
                    cmd.Parameters.AddWithValue("@CertificateFileUrl", certificatePath);
                    cmd.Parameters.AddWithValue("@AadhaarFileUrl", aadhaarPath);
                    cmd.Parameters.AddWithValue("@Specialization",
txtSpecialization.Text);

                    cmd.Parameters.AddWithValue("@RegistrationState",
                    ddlRegistrationState.SelectedValue);

                    cmd.Parameters.AddWithValue("@RegistrationStatus",
                    ddlRegistrationStatus.SelectedValue);

                    cmd.Parameters.AddWithValue("@NoticePeriod",
                    ddlNoticePeriod.SelectedValue);

                    cmd.Parameters.AddWithValue("@PreferredLocation",
                    txtPreferredLocation.Text);

                    cmd.Parameters.AddWithValue("@WillingToRelocate",
                    chkRelocate.Checked);

                    cmd.Parameters.AddWithValue("@FoodAccommodationRequired",
                    chkFoodAccommodation.Checked);

                    cmd.Parameters.AddWithValue("@CandidateStatus",
                    ddlCandidateStatus.SelectedValue);

                    cmd.Parameters.AddWithValue("@VerificationStatus",
                    ddlVerificationStatus.SelectedValue);

                    cmd.Parameters.AddWithValue("@Source",
                    ddlSource.SelectedValue);

                    cmd.Parameters.AddWithValue("@AssignedRecruiter",
                    txtAssignedRecruiter.Text);

                    cmd.Parameters.AddWithValue("@LastContactedAt",
                    string.IsNullOrEmpty(txtLastContacted.Text)
                    ? (object)DBNull.Value
                    : Convert.ToDateTime(txtLastContacted.Text));

                    cmd.Parameters.AddWithValue("@NextFollowUpAt",
                    string.IsNullOrEmpty(txtNextFollowup.Text)
                    ? (object)DBNull.Value
                    : Convert.ToDateTime(txtNextFollowup.Text));

                    cmd.Parameters.AddWithValue("@InternalRemarks",
                    txtInternalRemarks.Text);

                    long userId =
     Session["useridforcandidateregistration"] == null
     ? 1
     : Convert.ToInt64(Session["useridforcandidateregistration"]);

                    cmd.Parameters.AddWithValue("@CreatedByUserId", userId);
                    cmd.Parameters.AddWithValue("@UpdatedByUserId", userId);
                   

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ShowMessage("Candidate Saved Successfully.");
                ClearForm();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message);
            }
        }

        private bool MobileExists(string mobile)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM CandidateMaster WHERE MobileNumber=@Mobile",
                    con);

                cmd.Parameters.AddWithValue("@Mobile", mobile);

                con.Open();

                int count = Convert.ToInt32(cmd.ExecuteScalar());

                return count > 0;
            }
        }

        private bool EmailExists(string email)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM CandidateMaster WHERE Email=@Email",
                    con);

                cmd.Parameters.AddWithValue("@Email", email);

                con.Open();

                int count = Convert.ToInt32(cmd.ExecuteScalar());

                return count > 0;
            }
        }

      

private string UploadFile(FileUpload fu, string folder)
    {
        if (!fu.HasFile)
            return "";

        string ext = Path.GetExtension(fu.FileName).ToLower();

        if (fu.PostedFile.ContentLength > 2097152)
        {
            throw new Exception("Maximum file size 2 MB.");
        }

        // Create folder if not exists
        string uploadFolder = Server.MapPath("~/Uploads/" + folder);

        if (!Directory.Exists(uploadFolder))
        {
            Directory.CreateDirectory(uploadFolder);
        }

        string fileName = Guid.NewGuid().ToString() + ext;

        string physicalPath = Path.Combine(uploadFolder, fileName);

        fu.SaveAs(physicalPath);

        return "~/Uploads/" + folder + "/" + fileName;
    }

    private void ShowMessage(string msg)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "msg",
                "alert('" + msg.Replace("'", "") + "');",
                true);
        }
       
private int CalculateProfileCompletion()
        {
            int percent = 0;

            if (!string.IsNullOrEmpty(txtFullName.Text)) percent += 10;
            if (!string.IsNullOrEmpty(txtMobile.Text)) percent += 10;
            if (!string.IsNullOrEmpty(txtEmail.Text)) percent += 10;
            if (!string.IsNullOrEmpty(txtCurrentAddress.Text)) percent += 10;
            if (ddlCandidateCategory.SelectedIndex > 0) percent += 10;
            if (ddlDepartment.SelectedIndex > 0) percent += 10;
            if (ddlQualification.SelectedIndex > 0) percent += 10;
            if (!string.IsNullOrEmpty(txtExperience.Text)) percent += 10;
            if (fuResume.HasFile) percent += 10;
            if (fuPhoto.HasFile) percent += 10;

            return percent;
        }

        private void LoadCategories()
        {
            ddlCandidateCategory.Items.Clear();
            ddlCandidateCategory.Items.Add(new ListItem("-- Select Category --", ""));

            const string query = "SELECT CategoryID, CategoryName FROM JobCategories ORDER BY ISNULL(ordercolumn, CategoryID)";
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
                            ddlCandidateCategory.Items.Add(new ListItem(
                                Convert.ToString(reader["CategoryName"]),
                                Convert.ToString(reader["CategoryID"])));
                        }
                    }
                }
            }
            catch
            {
                ddlCandidateCategory.Items.Add(new ListItem("Nurse", "1"));
                ddlCandidateCategory.Items.Add(new ListItem("Doctor", "2"));
                ddlCandidateCategory.Items.Add(new ListItem("Technician", "3"));
                ddlCandidateCategory.Items.Add(new ListItem("Pharmacist", "4"));
            }
        }

        protected void ddlCandidateCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add(new ListItem("-- Select Department --", ""));

            //if (string.IsNullOrWhiteSpace(ddlDepartment.SelectedValue))
            //{
            //    PopulateQualifications();
            //    return;
            //}

            const string query = "SELECT SubcategoryID, SubcategoryName FROM JobSubcategories WHERE CategoryID = @CategoryID ORDER BY SubcategoryName";

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CategoryID", ddlCandidateCategory.SelectedValue);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlDepartment.Items.Add(new ListItem(
                                Convert.ToString(reader["SubcategoryName"]),
                                Convert.ToString(reader["SubcategoryID"])));
                        }
                    }
                }
            }
            catch
            {
                // Keep default select item when table is not ready.
            }

           PopulateQualifications();
        }

        private void PopulateQualifications()
        {
            string category = ddlCandidateCategory.SelectedItem.Text;
            ddlQualification.Items.Clear();

            switch (category)
            {
                case "Nurse":
                    ddlQualification.Items.Add(new ListItem("Bsc Nursing"));
                    ddlQualification.Items.Add(new ListItem("Post Bsc Nursing"));
                    ddlQualification.Items.Add(new ListItem("Gnm"));
                    ddlQualification.Items.Add(new ListItem("GNM / Bsc Nursing"));
                    ddlQualification.Items.Add(new ListItem("ANM"));
                    ddlQualification.Items.Add(new ListItem("Msc Nursing"));
                    ddlQualification.Items.Add(new ListItem("MPHW"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Obg/Gynec)"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Pediatrics)"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Psychiatric)"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Medical & Surgical)"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Community Health)"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Critical Care)"));
                    ddlQualification.Items.Add(new ListItem("MSc Nursing (Oncology)"));
                    break;

                case "Doctor":
                    ddlQualification.Items.Add("MBBS");
                    ddlQualification.Items.Add("MD");
                    ddlQualification.Items.Add("MS");
                    ddlQualification.Items.Add("DM");
                    ddlQualification.Items.Add("MCH");
                    ddlQualification.Items.Add("DNB");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Technician":
                    ddlQualification.Items.Add("Diploma in Lab Technician");
                    ddlQualification.Items.Add("B.Sc MLT");
                    ddlQualification.Items.Add("X-Ray Technician");
                    ddlQualification.Items.Add("ECG Technician");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Pharmacist":
                    ddlQualification.Items.Add("D.Pharm");
                    ddlQualification.Items.Add("B.Pharm");
                    ddlQualification.Items.Add("M.Pharm");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Physiotherapist":
                    ddlQualification.Items.Add("BPT");
                    ddlQualification.Items.Add("MPT");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Physician Assistant":
                    ddlQualification.Items.Add("Bachelor in Physician Assistant");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Dietician / Nutritionist":
                    ddlQualification.Items.Add("B.Sc Nutrition");
                    ddlQualification.Items.Add("M.Sc Nutrition");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Clinical Psychologist":
                    ddlQualification.Items.Add("M.Phil Clinical Psychology");
                    ddlQualification.Items.Add("MA Psychology");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Speech Therapist":
                    ddlQualification.Items.Add("BASLP");
                    ddlQualification.Items.Add("MASLP");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Top Management / Leadership":
                    ddlQualification.Items.Add("MBA Hospital Management");
                    ddlQualification.Items.Add("MBA General");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Accounts Department":
                case "Finance Department":
                    ddlQualification.Items.Add("B.Com");
                    ddlQualification.Items.Add("M.Com");
                    ddlQualification.Items.Add("CA");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Billing Department":
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    ddlQualification.Items.Add("Graduate");
                    ddlQualification.Items.Add("Post Graduate");
                    ddlQualification.Items.Add("Hospital Billing Course");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Biomedical Technician / Engineer":
                    ddlQualification.Items.Add("Diploma Biomedical");
                    ddlQualification.Items.Add("B.E Biomedical");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Front Office Department":
                case "Receptionist":
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    ddlQualification.Items.Add("Graduate");
                    ddlQualification.Items.Add("Post Graduate");
                    ddlQualification.Items.Add("Hospital Front Office Training");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Hospital Admin Department":
                    ddlQualification.Items.Add("MBA Hospital Administration");
                    ddlQualification.Items.Add("BHA");
                    ddlQualification.Items.Add("BBA");
                    ddlQualification.Items.Add("MBA");
                    ddlQualification.Items.Add("Other");
                    break;

                case "HR Department":
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    ddlQualification.Items.Add("BBA");
                    ddlQualification.Items.Add("MBA");
                    ddlQualification.Items.Add("MBA HR");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Hostel Warden":
                case "Housekeeping Department":
                case "Laundry Staff":
                case "Security Department":
                case "Ward Attendant / Ward Boy":
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    break;

                case "Insurance Department":
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    ddlQualification.Items.Add("Other Degree");
                    ddlQualification.Items.Add("Insurance Processing Training");
                    break;

                case "IT Department":
                    ddlQualification.Items.Add("BCA");
                    ddlQualification.Items.Add("MCA");
                    ddlQualification.Items.Add("B.Tech CSE");
                    ddlQualification.Items.Add("M.Tech CSE");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Maintenance Department":
                    ddlQualification.Items.Add("Diploma Electrical");
                    ddlQualification.Items.Add("ITI Fitter");
                    ddlQualification.Items.Add("12th");
                    ddlQualification.Items.Add("Graduate");
                    ddlQualification.Items.Add("Post Graduate");
                    break;

                case "Marketing & Business Development":
                    ddlQualification.Items.Add("MBA Marketing");
                    ddlQualification.Items.Add("MBA");
                    ddlQualification.Items.Add("BBA");
                    ddlQualification.Items.Add("Other");
                    break;

                case "Medical Records (MRD) Department":
                    ddlQualification.Items.Add("MRD Technician Course");
                    ddlQualification.Items.Add("Other Degree");
                    break;

                case "Medical Social Worker":
                    ddlQualification.Items.Add("MSW");
                    ddlQualification.Items.Add("BSW");
                    ddlQualification.Items.Add("Graduate");
                    ddlQualification.Items.Add("Post Graduate");
                    break;

                case "Patient Care Department":
                    ddlQualification.Items.Add("Patient Care Assistant Course");
                    ddlQualification.Items.Add("Nursing Diploma");
                    break;

                case "Pharmacy Assistant":
                    ddlQualification.Items.Add("D.Pharm");
                    ddlQualification.Items.Add("B.Pharm");
                    ddlQualification.Items.Add("M.Pharm");
                    ddlQualification.Items.Add("Pharmacy Assistant Course");
                    break;

                case "Purchase Department":
                case "Supply Chain / Stores Department":
                    ddlQualification.Items.Add("Diploma in Logistics");
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    ddlQualification.Items.Add("Graduate");
                    ddlQualification.Items.Add("Post Graduate");
                    break;

                case "Transport / Logistics Dept":
                    ddlQualification.Items.Add("Valid Driving License");
                    ddlQualification.Items.Add("10th Pass");
                    ddlQualification.Items.Add("12th Pass");
                    ddlQualification.Items.Add("Graduate");
                    ddlQualification.Items.Add("Post Graduate");
                    break;

                default:
                    ddlQualification.Items.Add("Please select a qualification");
                    break;
            }

            ddlQualification.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Qualification --", ""));
        }

        private static void AddItems(ListControl control, params string[] items)
        {
            foreach (string item in items)
            {
                control.Items.Add(new ListItem(item, item));
            }
        }

       
        private void ClearForm()
        {
            txtFullName.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtCurrentCity.Text = "";
            txtEmployer.Text = "";
            txtAge.Text = "";
            txtAltMobile.Text = "";
            txtCurrentAddress.Text = "";
            txtCurrentCity.Text = "";
            txtCurrentSalary.Text = "";
            txtDesignation.Text = "";
            txtExperience.Text = "";
            txtInternalRemarks.Text = "";
            txtLastContacted.Text = "";
            txtNativePlace.Text = "";
            txtNextFollowup.Text = "";
            txtPermanentAddress.Text = "";
            txtPincode.Text = "";
            txtPreferredLocation.Text = "";
            txtSpecialization.Text = "";
            txtWhatsApp.Text = "";
            txtExpectedSalary.Text = "";
            txtDesignation.Text = "";
            txtAssignedRecruiter.Text = "";
            hfResume.Value = "";
            hfPhoto.Value = "";
            hfCertificate.Value = "";
            hfAadhaar.Value = "";
            ddlGender.SelectedIndex = 0;
            ddlCandidateCategory.SelectedIndex = 0;
            ddlDepartment.SelectedIndex = 0;
            ddlQualification.SelectedIndex = 0;
            GenerateCandidateCode();
            LoadStates();
            LoadCategories();
        }
    }
}
