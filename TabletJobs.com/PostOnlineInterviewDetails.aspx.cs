using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class PostOnlineInterviewDetails : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;
        int editId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out editId);
            }

            if (!IsPostBack)
            {
                LoadRepresentatives();
                LoadCategories();
                PopulateStates();
                PopulateExpDropdown();

                if (editId > 0)
                {
                    LoadEditData(editId);
                    Button1.Text = "Update Interview";
                }
            }

            RestorePreviewImage(ImageData, Image1);
            RestorePreviewImage(ImageDataHospital, Image2);
            RestorePreviewImage(ImageData4, Image4);
        }
        private void RestorePreviewImage(HiddenField source, Image target)
        {
            if (!string.IsNullOrWhiteSpace(source.Value))
            {
                target.ImageUrl = "data:image/jpeg;base64," + source.Value;
                target.Style["display"] = "block";
            }
        }
        private void LoadEditData(int id)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM JobPostInternal WHERE JOBID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // BASIC
                    Txtnm.Text = dr["JTitle"].ToString();
                    Txtdesc.Text = dr["Jdesc"].ToString();
                    Txtrnm.Text = dr["Jrec"].ToString();
                    Txtcn.Text = dr["Jcont"].ToString();

                    // HOSPITAL
                    Txthnm.Text = dr["hname"].ToString();
                    Txtadd.Text = dr["haddress"].ToString();
                    Txtcity.Text = dr["hcity"].ToString();
                    txtwhatsapplink.Text = dr["WHATSAPPLINK"].ToString();
                    ddlStates.SelectedValue = dr["hstat"].ToString();
                    ddlCountry.SelectedValue = dr["hCountry"].ToString();

                    // CATEGORY
                    ddlCategory.SelectedValue = dr["CategoryID"].ToString();
                    ddlCategory_SelectedIndexChanged(null, null);
                   // ddlSubcategory.SelectedValue = dr["SubcategoryID"].ToString();

                    // JOB DETAILS
                    Dropqual.SelectedValue = dr["Jqual"].ToString();
                    DrpExp.SelectedValue = dr["Jexp"].ToString();
                    Drpsal.SelectedValue = dr["Jsal"].ToString();
                    Drppos.SelectedValue = dr["Jposi"].ToString();   // ✅ FIXED
                    DrpAccomo.SelectedValue = dr["accommodation"].ToString(); // ✅ FIXED
                    DrpJob.SelectedValue = dr["Jtype"].ToString();   // ✅ FIXED
                    Drptim.SelectedValue = dr["Jtimin"].ToString();  // ✅ FIXED
                    Drptiming.SelectedValue = dr["Schedule"].ToString(); // ✅ FIXED

                    // INTERVIEW
                    calInterviewDate.Text = Convert.ToDateTime(dr["InterviewDate"]).ToString("yyyy-MM-dd");

                    var startTime = dr["InterviewStartTime"].ToString();
                    if (ddlInterviewStartTime.Items.FindByText(startTime) != null)
                    {
                        ddlInterviewStartTime.ClearSelection();
                        ddlInterviewStartTime.Items.FindByText(startTime).Selected = true;
                    }
                    var endTime = dr["InterviewEndTime"].ToString();
                    if (ddlInterviewEndTime.Items.FindByText(endTime) != null)
                    {
                        ddlInterviewEndTime.ClearSelection();
                        ddlInterviewEndTime.Items.FindByText(endTime).Selected = true;
                    }
                    ddlFreq.SelectedValue = dr["InterviewFrequency"].ToString();
                    ddlStatus.SelectedValue = dr["Status"].ToString();

                    // EXTRA
                    TxtBenefits.Text = dr["Benefits"].ToString();
                    TxtAboutHospital.Text = dr["AboutHospital"].ToString();
                    ddlGenderReq.SelectedValue = dr["GenderRequirement"].ToString();

                    // HAS ACCOMMODATION
                    ddlAcco.SelectedValue = dr["HasAccommodation"].ToString();

                    // ✅ REPRESENTATIVE (IMPORTANT)
                    string reps = dr["Representative"].ToString();
                    if (!string.IsNullOrEmpty(reps))
                    {
                        foreach (ListItem item in cblJobRoles.Items)
                        {
                            if (reps.Contains(item.Text))
                                item.Selected = true;
                        }
                    }

                    // ✅ IMAGE LOAD (IMPORTANT)
                    if (dr["hlogo"] != DBNull.Value)
                    {
                        Image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])dr["hlogo"]);
                        Image1.Style["display"] = "block";
                    }

                    if (dr["himages"] != DBNull.Value)
                    {
                        Image2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])dr["himages"]);
                        Image2.Style["display"] = "block";
                    }

                    if (dr["QRCode"] != DBNull.Value)
                    {
                        Image4.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])dr["QRCode"]);
                        Image4.Style["display"] = "block";
                    }
                }
            }
        }
        private void LoadCategories()
        {
            ddlCategory.Items.Clear();
            ddlCategory.Items.Add(new ListItem("-- Select Category --", ""));

           // const string query = "SELECT CategoryID, CategoryName FROM JobCategories ORDER BY ISNULL(ordercolumn, CategoryID)";
            const string query =
    "SELECT CategoryID, CategoryName FROM JobCategoriesNew ORDER BY ISNULL(OrderColumn, CategoryID)";
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
           

            if (string.IsNullOrWhiteSpace(ddlCategory.SelectedValue))
            {
                PopulateQualifications();
                return;
            }

           
            PopulateQualifications();
        }

        private void PopulateQualifications()
        {
            string category = ddlCategory.SelectedItem.Text;
            Dropqual.Items.Clear();

            switch (category)
            {
                // =====================================================
                // ACCOUNTS
                // =====================================================
                case "Accounts Executive":
                    Dropqual.Items.Add("B.Com");
                    Dropqual.Items.Add("M.Com");
                    Dropqual.Items.Add("CA");
                    Dropqual.Items.Add("CMA");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA Finance");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // BACK OFFICE / DATA ENTRY
                // =====================================================
                case "Back Office Executive":
                case "Data Entry Operator":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BCA");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // BPO / CALL CENTRE / TELECALLER
                // =====================================================
                case "BPO / Call Centre Executive":
                case "Telecaller / Telesales Executive":
                case "International Voice Process Executive":
                case "Non-Voice / Chat Support Executive":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // BUSINESS DEVELOPMENT / SALES
                // =====================================================
                case "Business Development Executive":
                case "Field Sales Executive":
                case "Sales Executive":
                case "Retail Sales Executive":
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("MBA Marketing");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // COLLECTION
                // =====================================================
                case "Collection Executive / Telecollections":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("B.Com");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // CUSTOMER RELATIONSHIP / CUSTOMER SUCCESS
                // =====================================================
                case "Customer Relationship Executive":
                case "Customer Success Executive":
                case "Customer Support Executive":
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // DELIVERY / LOGISTICS / WAREHOUSE
                // =====================================================
                case "Delivery Coordinator":
                case "Logistics Executive":
                case "Warehouse Executive":
                case "Store Executive":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("Diploma in Logistics");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // DELIVERY EXECUTIVE / DRIVER
                // =====================================================
                case "Delivery Executive":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Valid Driving License");
                    Dropqual.Items.Add("Other");
                    break;

                case "Driver / Commercial Driver":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Valid Driving License");
                    Dropqual.Items.Add("Commercial Driving License");
                    Dropqual.Items.Add("Heavy Motor Vehicle License");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // ELECTRICIAN / MAINTENANCE
                // =====================================================
                case "Electrician / Maintenance Technician":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("ITI Electrician");
                    Dropqual.Items.Add("ITI Fitter");
                    Dropqual.Items.Add("Diploma Electrical");
                    Dropqual.Items.Add("Diploma Mechanical");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // FIELD SERVICE / SERVICE TECHNICIAN
                // =====================================================
                case "Field Service Technician":
                case "Service Technician":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("ITI");
                    Dropqual.Items.Add("Diploma");
                    Dropqual.Items.Add("Diploma Electrical");
                    Dropqual.Items.Add("Diploma Mechanical");
                    Dropqual.Items.Add("B.Tech");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // HOSPITALITY
                // =====================================================
                case "Hospitality Staff":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Diploma in Hospitality");
                    Dropqual.Items.Add("Hotel Management");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // HOUSEKEEPING
                // =====================================================
                case "Housekeeping Staff":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // HR
                // =====================================================
                case "HR Recruiter / Talent Acquisition Executive":
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("MBA HR");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // INSURANCE
                // =====================================================
                case "Insurance Sales Executive":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("Insurance Processing Training");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // IT SUPPORT
                // =====================================================
                case "IT Support Executive":
                case "Technical Support Executive":
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("BCA");
                    Dropqual.Items.Add("MCA");
                    Dropqual.Items.Add("B.Tech CSE");
                    Dropqual.Items.Add("M.Tech CSE");
                    Dropqual.Items.Add("Diploma in Computer Science");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // KYC / VERIFICATION
                // =====================================================
                case "KYC / Verification Executive":
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("B.Com");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // MACHINE / PRODUCTION OPERATOR
                // =====================================================
                case "Machine Operator":
                case "Production Operator":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("ITI");
                    Dropqual.Items.Add("Diploma");
                    Dropqual.Items.Add("Diploma Mechanical");
                    Dropqual.Items.Add("Diploma Electrical");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // MEDICAL REPRESENTATIVE
                // =====================================================
                case "Medical Representative":
                    Dropqual.Items.Add("B.Pharm");
                    Dropqual.Items.Add("D.Pharm");
                    Dropqual.Items.Add("B.Sc");
                    Dropqual.Items.Add("M.Sc");
                    Dropqual.Items.Add("B.Sc Life Sciences");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // OFFICE / ADMIN
                // =====================================================
                case "Office / Admin Executive":
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("B.Com");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // PHARMACY
                // =====================================================
                case "Pharmacy / Pharmacist":
                    Dropqual.Items.Add("D.Pharm");
                    Dropqual.Items.Add("B.Pharm");
                    Dropqual.Items.Add("M.Pharm");
                    Dropqual.Items.Add("Pharmacy Assistant Course");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // PICKERS & PACKERS
                // =====================================================
                case "Pickers & Packers":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // RECEPTIONIST / FRONT OFFICE
                // =====================================================
                case "Receptionist / Front Office Executive":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Hospital Front Office Training");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // RESTAURANT / FOOD SERVICE
                // =====================================================
                case "Restaurant / Food Service Staff":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Diploma in Hospitality");
                    Dropqual.Items.Add("Hotel Management");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // SECURITY
                // =====================================================
                case "Security Guard":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // STAFF NURSE
                // =====================================================
                case "Staff Nurse":
                    Dropqual.Items.Add("ANM");
                    Dropqual.Items.Add("GNM");
                    Dropqual.Items.Add("GNM / Bsc Nursing");
                    Dropqual.Items.Add("B.Sc Nursing");
                    Dropqual.Items.Add("Post B.Sc Nursing");
                    Dropqual.Items.Add("M.Sc Nursing");
                    Dropqual.Items.Add("MPHW");
                    Dropqual.Items.Add("MSc Nursing (Obg/Gynec)");
                    Dropqual.Items.Add("MSc Nursing (Pediatrics)");
                    Dropqual.Items.Add("MSc Nursing (Psychiatric)");
                    Dropqual.Items.Add("MSc Nursing (Medical & Surgical)");
                    Dropqual.Items.Add("MSc Nursing (Community Health)");
                    Dropqual.Items.Add("MSc Nursing (Critical Care)");
                    Dropqual.Items.Add("MSc Nursing (Oncology)");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // TEACHER / TUTOR
                // =====================================================
                case "Teacher / Tutor":
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("B.Ed");
                    Dropqual.Items.Add("M.Ed");
                    Dropqual.Items.Add("D.El.Ed");
                    Dropqual.Items.Add("B.A");
                    Dropqual.Items.Add("B.Sc");
                    Dropqual.Items.Add("M.A");
                    Dropqual.Items.Add("M.Sc");
                    Dropqual.Items.Add("Other");
                    break;


                // =====================================================
                // GENERAL DEFAULT
                // =====================================================
                default:
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("Diploma");
                    Dropqual.Items.Add("ITI");
                    Dropqual.Items.Add("Other");
                    break;
            }

            Dropqual.Items.Insert(
                0,
                new System.Web.UI.WebControls.ListItem(
                    "-- Select Qualification --",
                    ""));
        }

        private static void AddItems(ListControl control, params string[] items)
        {
            foreach (string item in items)
            {
                control.Items.Add(new ListItem(item, item));
            }
        }

        private void PopulateStates()
        {
            List<string> states = new List<string>
            {
                "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Delhi",
                "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala",
                "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "NA", "Nagaland",
                "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
                "Uttar Pradesh", "Uttarakhand", "West Bengal", "United Arab Emirates"
            };

            ddlStates.DataSource = states;
            ddlStates.DataBind();
            ddlStates.Items.Insert(0, new ListItem("Select a state", "Select a state"));
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

        public static bool IsValidInput(string input)
        {
            return !Regex.IsMatch(input ?? string.Empty, @"['""]");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    ShowAlert("Please fill all required fields.");
                    return;
                }

                if (ddlFreq.SelectedIndex == 0 || ddlStatus.SelectedIndex == 0)
                {
                    ShowAlert("Please select Interview Frequency and Status.");
                    return;
                }

                if (!DateTime.TryParse(calInterviewDate.Text, out DateTime interviewDate))
                {
                    ShowAlert("Please select a valid Interview Date.");
                    return;
                }

                byte[] logoBytes = ConvertFromBase64(ImageData.Value);
                byte[] hospitalImageBytes = GetUploadedFileBytes(FileUploadHospitalImages);
                byte[] qrImageBytes = GetUploadedFileBytes(FileUpload4);

                string selectedRepresentatives = string.Join(" / ",
                    cblJobRoles.Items.Cast<ListItem>()
                        .Where(i => i.Selected)
                        .Select(i => i.Text));
                string query;

                if (editId > 0)
                {
                    query = @"
    UPDATE JobPostInternal SET
    JTitle=@Title,
    Jqual=@Qual,
    Jexp=@Exp,
    Jsal=@Sal,
    Jposi=@Pos,
    Jtype=@Jtype,
    Jtimin=@Jtim,
    Jdesc=@Jdesc,
    Jrec=@Rnm,
    Jcont=@Contact,
    hname=@Hname,
    haddress=@Hadd,
    hcity=@City,
    hstat=@State,
    hCountry=@country,
    InterviewDate=@InterviewDate,
    InterviewStartTime=@InterviewStartTime,
    InterviewEndTime=@InterviewEndTime,
    accommodation=@accommodation,
    Schedule=@schedule,
    Representative=@JobRole,
    QRText=@QRtext,
    CategoryID=@Category,
    SubcategoryID=@Subcategory,
    Benefits=@Benefits,
    HasAccommodation=@HasAccommodation,
    GenderRequirement=@GenderRequirement,
    AboutHospital=@AboutHospital,
    InterviewFrequency=@InterviewFrequency,
    Status=@Status,
WHATSAPPLINK = @WHATSAPPLINK,
hlogo = ISNULL(@Photo, hlogo),
himages = ISNULL(@Photo1, himages),
QRCode = ISNULL(@Photo2, QRCode)
    WHERE JOBID=@ID";
                }
                else
                {
                    query = @"
                    INSERT INTO JobPostInternal
                    (JTitle, Jqual, Jexp, Jsal, Jposi, Jtype, Jtimin, Jdesc, Jrec, Jcont,
                     hlogo, himages, hname, haddress, hcity, hstat, JPostdate, hCountry,
                     InterviewDate, InterviewStartTime, InterviewEndTime, accommodation,
                     Schedule, Representative, QRCode, QRText, CategoryID, SubcategoryID,
                     Benefits, HasAccommodation, IsActive, GenderRequirement, AboutHospital,
                     InterviewFrequency, Status ,WHATSAPPLINK)
                    VALUES
                    (@Title, @Qual, @Exp, @Sal, @Pos, @Jtype, @Jtim, @Jdesc, @Rnm, @Contact,
                     @Photo, @Photo1, @Hname, @Hadd, @City, @State, @Postdate, @country,
                     @InterviewDate, @InterviewStartTime, @InterviewEndTime, @accommodation,
                     @schedule, @JobRole, @Photo2, @QRtext, @Category, @Subcategory,
                     @Benefits, @HasAccommodation, @IsActive, @GenderRequirement, @AboutHospital,
                     @InterviewFrequency, @Status,@WHATSAPPLINK);
                    SELECT CAST(SCOPE_IDENTITY() AS INT);";
                }
               

                int jobId;
                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Title", Txtnm.Text.Trim());
                    cmd.Parameters.AddWithValue("@Qual", Dropqual.SelectedValue);
                    cmd.Parameters.AddWithValue("@Exp", DrpExp.SelectedValue);
                    cmd.Parameters.AddWithValue("@Sal", Drpsal.SelectedValue);
                    cmd.Parameters.AddWithValue("@Pos", Drppos.SelectedValue);
                    cmd.Parameters.AddWithValue("@Jtype", DrpJob.SelectedValue);
                    cmd.Parameters.AddWithValue("@Jtim", Drptim.SelectedValue);
                    cmd.Parameters.AddWithValue("@Jdesc", Txtdesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@Rnm", Txtrnm.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contact", Txtcn.Text.Trim());
                    cmd.Parameters.AddWithValue("@Hname", Txthnm.Text.Trim());
                    cmd.Parameters.AddWithValue("@Hadd", Txtadd.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", Txtcity.Text.Trim());
                    cmd.Parameters.AddWithValue("@State", ddlStates.SelectedValue);
                    cmd.Parameters.AddWithValue("@country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@InterviewDate", interviewDate.Date);
                    cmd.Parameters.AddWithValue("@InterviewStartTime", ddlInterviewStartTime.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@InterviewEndTime", ddlInterviewEndTime.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@accommodation", DrpAccomo.SelectedValue);
                    cmd.Parameters.AddWithValue("@schedule", Drptiming.SelectedValue);
                    cmd.Parameters.AddWithValue("@JobRole", (object)selectedRepresentatives ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@QRtext", (object)QRText.Text.Trim() ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Benefits", (object)TxtBenefits.Text.Trim() ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@IsActive", "Y");
                    cmd.Parameters.AddWithValue("@GenderRequirement", ddlGenderReq.SelectedValue);
                    cmd.Parameters.AddWithValue("@AboutHospital", string.IsNullOrWhiteSpace(TxtAboutHospital.Text) ? (object)DBNull.Value : TxtAboutHospital.Text.Trim());
                    cmd.Parameters.AddWithValue("@InterviewFrequency", ddlFreq.SelectedValue);
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@WHATSAPPLINK", txtwhatsapplink.Text);
                    cmd.Parameters.AddWithValue("@Postdate", DateTime.Now);

                    cmd.Parameters.Add("@Photo", SqlDbType.VarBinary).Value = (object)logoBytes ?? DBNull.Value;
                    cmd.Parameters.Add("@Photo1", SqlDbType.VarBinary, -1).Value =
     (object)hospitalImageBytes ?? DBNull.Value;
                    cmd.Parameters.Add("@Photo2", SqlDbType.VarBinary).Value = (object)qrImageBytes ?? DBNull.Value;

                    if (editId > 0)
                    {
                        cmd.Parameters.AddWithValue("@ID", editId);
                    }
                    SqlParameter categoryParam = cmd.Parameters.Add("@Category", SqlDbType.Int);
                    categoryParam.Value = int.TryParse(ddlCategory.SelectedValue, out int categoryId) ? (object)categoryId : DBNull.Value;

                    SqlParameter subCategoryParam = cmd.Parameters.Add("@Subcategory", SqlDbType.Int);
                    subCategoryParam.Value = DBNull.Value;

                    SqlParameter hasAccommodationParam = cmd.Parameters.Add("@HasAccommodation", SqlDbType.Char, 1);
                    string hasAccommodation = ddlAcco.SelectedValue;
                    hasAccommodationParam.Value = (hasAccommodation == "T" || hasAccommodation == "F")
                        ? (object)hasAccommodation
                        : DBNull.Value;

                    con.Open();
                    jobId = Convert.ToInt32(cmd.ExecuteScalar());
                }
                if (editId > 0)
                {
                    ShowAlert("Interview updated successfully!");
                }
                else
                {
                    if (jobId > 0)
                    {
                        ShowAlert("Interview job posted successfully. Job ID: " + jobId);
                        ResetForm();
                    }
                    else
                    {
                        ShowAlert("Unable to post interview job. Please try again.");
                    }
                }
                
            }
            catch (Exception ex)
            {
                ShowAlert("Error while posting: " + ex.Message.Replace("'", ""));
            }
        }

        private static byte[] ConvertFromBase64(string base64)
        {
            if (string.IsNullOrWhiteSpace(base64))
            {
                return null;
            }

            try
            {
                return Convert.FromBase64String(base64);
            }
            catch
            {
                return null;
            }
        }

        private static byte[] GetUploadedFileBytes(FileUpload fileUpload)
        {
            if (fileUpload == null || !fileUpload.HasFile)
            {
                return null;
            }

            return fileUpload.FileBytes;
        }

        private void LoadRepresentatives()
        {
            cblJobRoles.Items.Clear();

            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand("SELECT RepName, RepContactNo FROM RepresentativesTable ORDER BY RepName", con))
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string repName = Convert.ToString(reader["RepName"]);
                            string repMobile = Convert.ToString(reader["RepContactNo"]);
                            cblJobRoles.Items.Add(new ListItem($"{repName}: {repMobile}", repMobile));
                        }
                    }
                }
            }
            catch
            {
                cblJobRoles.Items.Add(new ListItem("Recruiter Team: 9000000000", "9000000000"));
            }
        }

        protected void cvJobRoles_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cblJobRoles.Items.Cast<ListItem>().Any(i => i.Selected);
        }

        protected void cvAboutHospMaxWords_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrWhiteSpace(args.Value))
            {
                args.IsValid = true;
                return;
            }

            int wordCount = Regex.Matches(args.Value.Trim(), @"\S+").Count;
            args.IsValid = wordCount <= 10000;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        private void ResetForm()
        {
            Txtnm.Text = string.Empty;
            ddlCategory.SelectedIndex = 0;
            //ddlSubcategory.Items.Clear();
            //ddlSubcategory.Items.Add(new ListItem("-- Select Job Sub Category --", ""));

            Dropqual.Items.Clear();
            Dropqual.Items.Add(new ListItem("-- Select Qualification --", ""));

            DrpExp.SelectedIndex = 0;
            Drpsal.SelectedIndex = 0;
            Drppos.SelectedIndex = 0;
            DrpAccomo.SelectedIndex = 0;
            DrpJob.SelectedIndex = 0;
            Drptim.SelectedIndex = 0;
            Txtdesc.Text = string.Empty;
            Txtrnm.Text = string.Empty;
            Txtcn.Text = string.Empty;
            Txthnm.Text = string.Empty;
            TxtAboutHospital.Text = string.Empty;
            Txtadd.Text = string.Empty;
            Txtcity.Text = string.Empty;
            txtwhatsapplink.Text = string.Empty;
            ddlStates.SelectedIndex = 0;
            ddlCountry.SelectedIndex = 0;
            Drptiming.SelectedIndex = 0;
            calInterviewDate.Text = string.Empty;
            ddlInterviewStartTime.SelectedIndex = 0;
            ddlInterviewEndTime.SelectedIndex = 0;
            cblJobRoles.ClearSelection();
            QRText.Text = string.Empty;
            TxtBenefits.Text = string.Empty;
            if (ddlAcco.Items.Count > 0) ddlAcco.SelectedIndex = 0;
            if (ddlFreq.Items.Count > 0) ddlFreq.SelectedIndex = 0;
            if (ddlStatus.Items.Count > 0) ddlStatus.SelectedIndex = 0;
            ddlGenderReq.SelectedIndex = 0;

            ImageData.Value = string.Empty;
            ImageDataHospital.Value = string.Empty;
            ImageData4.Value = string.Empty;
            Image1.ImageUrl = string.Empty;
            Image2.ImageUrl = string.Empty;
            Image4.ImageUrl = string.Empty;
        }

        private void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString("N"),
                "alert('" + message.Replace("'", "\\'") + "');", true);
        }
    }
}
