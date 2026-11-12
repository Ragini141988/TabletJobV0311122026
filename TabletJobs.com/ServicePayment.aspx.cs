using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ServicePayment : System.Web.UI.Page
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
            

            if (!IsPostBack)
            {
                LoadCategories();
                PopulateExpDropdown();
            }
        }
        private void LoadCategories()
        {
            ddlCategory.Items.Clear();
            ddlCategory.Items.Add(new ListItem("-- Select Category --", ""));

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
            ddlSubcategory.Items.Clear();
            ddlSubcategory.Items.Add(new ListItem("-- Select Job Sub Category --", ""));

            if (string.IsNullOrWhiteSpace(ddlCategory.SelectedValue))
            {
                PopulateQualifications();
                return;
            }

            const string query = "SELECT SubcategoryID, SubcategoryName FROM JobSubcategories WHERE CategoryID = @CategoryID ORDER BY SubcategoryName";

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlSubcategory.Items.Add(new ListItem(
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
            string category = ddlCategory.SelectedItem.Text;
            Dropqual.Items.Clear();

            switch (category)
            {
                case "Nurse":
                    Dropqual.Items.Add(new ListItem("Bsc Nursing"));
                    Dropqual.Items.Add(new ListItem("Post Bsc Nursing"));
                    Dropqual.Items.Add(new ListItem("Gnm"));
                    Dropqual.Items.Add(new ListItem("GNM / Bsc Nursing"));
                    Dropqual.Items.Add(new ListItem("ANM"));
                    Dropqual.Items.Add(new ListItem("Msc Nursing"));
                    Dropqual.Items.Add(new ListItem("MPHW"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Obg/Gynec)"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Pediatrics)"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Psychiatric)"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Medical & Surgical)"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Community Health)"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Critical Care)"));
                    Dropqual.Items.Add(new ListItem("MSc Nursing (Oncology)"));
                    break;

                case "Doctor":
                    Dropqual.Items.Add("MBBS");
                    Dropqual.Items.Add("MD");
                    Dropqual.Items.Add("MS");
                    Dropqual.Items.Add("DM");
                    Dropqual.Items.Add("MCH");
                    Dropqual.Items.Add("DNB");
                    Dropqual.Items.Add("Other");
                    break;

                case "Technician":
                    Dropqual.Items.Add("Diploma in Lab Technician");
                    Dropqual.Items.Add("B.Sc MLT");
                    Dropqual.Items.Add("X-Ray Technician");
                    Dropqual.Items.Add("ECG Technician");
                    Dropqual.Items.Add("Other");
                    break;

                case "Pharmacist":
                    Dropqual.Items.Add("D.Pharm");
                    Dropqual.Items.Add("B.Pharm");
                    Dropqual.Items.Add("M.Pharm");
                    Dropqual.Items.Add("Other");
                    break;

                case "Physiotherapist":
                    Dropqual.Items.Add("BPT");
                    Dropqual.Items.Add("MPT");
                    Dropqual.Items.Add("Other");
                    break;

                case "Physician Assistant":
                    Dropqual.Items.Add("Bachelor in Physician Assistant");
                    Dropqual.Items.Add("Other");
                    break;

                case "Dietician / Nutritionist":
                    Dropqual.Items.Add("B.Sc Nutrition");
                    Dropqual.Items.Add("M.Sc Nutrition");
                    Dropqual.Items.Add("Other");
                    break;

                case "Clinical Psychologist":
                    Dropqual.Items.Add("M.Phil Clinical Psychology");
                    Dropqual.Items.Add("MA Psychology");
                    Dropqual.Items.Add("Other");
                    break;

                case "Speech Therapist":
                    Dropqual.Items.Add("BASLP");
                    Dropqual.Items.Add("MASLP");
                    Dropqual.Items.Add("Other");
                    break;

                case "Top Management / Leadership":
                    Dropqual.Items.Add("MBA Hospital Management");
                    Dropqual.Items.Add("MBA General");
                    Dropqual.Items.Add("Other");
                    break;

                case "Accounts Department":
                case "Finance Department":
                    Dropqual.Items.Add("B.Com");
                    Dropqual.Items.Add("M.Com");
                    Dropqual.Items.Add("CA");
                    Dropqual.Items.Add("Other");
                    break;

                case "Billing Department":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("Hospital Billing Course");
                    Dropqual.Items.Add("Other");
                    break;

                case "Biomedical Technician / Engineer":
                    Dropqual.Items.Add("Diploma Biomedical");
                    Dropqual.Items.Add("B.E Biomedical");
                    Dropqual.Items.Add("Other");
                    break;

                case "Front Office Department":
                case "Receptionist":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    Dropqual.Items.Add("Hospital Front Office Training");
                    Dropqual.Items.Add("Other");
                    break;

                case "Hospital Admin Department":
                    Dropqual.Items.Add("MBA Hospital Administration");
                    Dropqual.Items.Add("BHA");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("Other");
                    break;

                case "HR Department":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("MBA HR");
                    Dropqual.Items.Add("Other");
                    break;

                case "Hostel Warden":
                case "Housekeeping Department":
                case "Laundry Staff":
                case "Security Department":
                case "Ward Attendant / Ward Boy":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    break;

                case "Insurance Department":
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Other Degree");
                    Dropqual.Items.Add("Insurance Processing Training");
                    break;

                case "IT Department":
                    Dropqual.Items.Add("BCA");
                    Dropqual.Items.Add("MCA");
                    Dropqual.Items.Add("B.Tech CSE");
                    Dropqual.Items.Add("M.Tech CSE");
                    Dropqual.Items.Add("Other");
                    break;

                case "Maintenance Department":
                    Dropqual.Items.Add("Diploma Electrical");
                    Dropqual.Items.Add("ITI Fitter");
                    Dropqual.Items.Add("12th");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    break;

                case "Marketing & Business Development":
                    Dropqual.Items.Add("MBA Marketing");
                    Dropqual.Items.Add("MBA");
                    Dropqual.Items.Add("BBA");
                    Dropqual.Items.Add("Other");
                    break;

                case "Medical Records (MRD) Department":
                    Dropqual.Items.Add("MRD Technician Course");
                    Dropqual.Items.Add("Other Degree");
                    break;

                case "Medical Social Worker":
                    Dropqual.Items.Add("MSW");
                    Dropqual.Items.Add("BSW");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    break;

                case "Patient Care Department":
                    Dropqual.Items.Add("Patient Care Assistant Course");
                    Dropqual.Items.Add("Nursing Diploma");
                    break;

                case "Pharmacy Assistant":
                    Dropqual.Items.Add("D.Pharm");
                    Dropqual.Items.Add("B.Pharm");
                    Dropqual.Items.Add("M.Pharm");
                    Dropqual.Items.Add("Pharmacy Assistant Course");
                    break;

                case "Purchase Department":
                case "Supply Chain / Stores Department":
                    Dropqual.Items.Add("Diploma in Logistics");
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    break;

                case "Transport / Logistics Dept":
                    Dropqual.Items.Add("Valid Driving License");
                    Dropqual.Items.Add("10th Pass");
                    Dropqual.Items.Add("12th Pass");
                    Dropqual.Items.Add("Graduate");
                    Dropqual.Items.Add("Post Graduate");
                    break;

                default:
                    Dropqual.Items.Add("Please select a qualification");
                    break;
            }

            Dropqual.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Qualification --", ""));
        }
        private static void AddItems(ListControl control, params string[] items)
        {
            foreach (string item in items)
            {
                control.Items.Add(new ListItem(item, item));
            }
        }
        private void PopulateExpDropdown()
        {
            DrpExp.Items.Clear();
            AddItems(DrpExp,
                "Select Experience",
                "0-10 Years",
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
       

       
        protected async void btnProceedPayment_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            if (!chkTerms.Checked)
            {
                lblMessage.Text = "Please accept Terms & Conditions to continue.";
                return;
            }
            if (string.IsNullOrEmpty(DrpExp.SelectedValue))
            {
                lblMessage.Text = "Please select Experience";
                return;
            }
            if (string.IsNullOrEmpty(Dropqual.SelectedValue))
            {
                lblMessage.Text = "Please select qualification";
                return;
            }

            if (string.IsNullOrEmpty(ddlServiceFee.SelectedValue))
            {
                lblMessage.Text = "Select service";
                return;
            }

            if (!chkTerms.Checked)
            {
                lblMessage.Text = "Accept terms";
                return;
            }

            string merchantTxnId = "SV_" + DateTime.UtcNow.Ticks;

            try
            {
                decimal amount = decimal.Parse(ddlServiceFee.SelectedValue);

                string merchantId = ConfigurationManager.AppSettings["PhonePe_MerchantId"];
                string saltKey = ConfigurationManager.AppSettings["PhonePe_SaltKey"];
                string saltIndexText = ConfigurationManager.AppSettings["PhonePe_SaltIndex"];
                string baseUrl = ConfigurationManager.AppSettings["PhonePe_BaseUrl"];

                int saltIndex = 1;
                int.TryParse(saltIndexText, out saltIndex);

                int appId = CreateApplication(merchantTxnId, amount);
                CreatePayment(appId, merchantTxnId, amount);



                string origin = Request.Url.GetLeftPart(UriPartial.Authority);
                string resultUrl = origin + "/ServicePaymentResult.aspx?applicationId=" + appId + "&merchantTxnId=" + merchantTxnId;
                PhonePeIntegration phonePe = new PhonePeIntegration(merchantId, saltKey, saltIndex, baseUrl);
                PhonePeIntegration.PaymentRequest request = new PhonePeIntegration.PaymentRequest
                {
                    MerchantTransactionId = merchantTxnId,
                    Amount = amount,
                    CallbackUrl = resultUrl,
                    RedirectUrl = resultUrl,
                    CustomerMobile = txtMobile.Text.Trim(),
                    CustomerEmail = txtEmail.Text.Trim()
                };

                string initResponse;
                string redirectUrl;
                string code;

                try
                {
                    initResponse = await phonePe.InitiatePaymentAsync(request);
                    redirectUrl = PhonePeIntegration.ExtractRedirectUrl(initResponse);
                    code = JObject.Parse(initResponse).SelectToken("code")?.ToString();
                }
                catch (Exception initEx)
                {
                    if (initEx.Message.IndexOf("KEY_NOT_CONFIGURED", StringComparison.OrdinalIgnoreCase) < 0)
                    {
                        throw;
                    }

                    initResponse = await InitiateV2PaymentAsync(merchantTxnId, amount, resultUrl);
                    JObject v2Obj = JObject.Parse(initResponse);
                    redirectUrl = v2Obj.SelectToken("redirectUrl")?.ToString();
                    code = v2Obj.SelectToken("state")?.ToString() ?? "INITIATED";
                }

                UpdatePaymentAfterInitiation(merchantTxnId, code ?? "INITIATED", initResponse);

                if (string.IsNullOrWhiteSpace(redirectUrl))
                {
                    lblMessage.Text = "Payment initiated but redirect URL missing. Txn: " + merchantTxnId;
                    return;
                }

                Response.Redirect(redirectUrl, false);
            }
            catch (Exception ex)
            {
                UpdatePaymentAfterInitiation(merchantTxnId, "FAILED", ex.ToString());
                lblMessage.Text = "Unable to initiate payment: " + ex.Message;
            }
        }

        private int CreateApplication(string txnId, decimal amount)
        {
            string sql = @"
INSERT INTO ServicePaymentApplications
(CandidateName, Mobile, Email, Gender
,CategoryID ,
               SubcategoryID ,
               Qualification,
                Experience,ServiceType, ServiceAmount, ApplicationStatus, MerchantTxnId)
VALUES
(@Name, @Mobile, @Email, @Gender,@CategoryID ,
               @SubcategoryID ,
               @Qualification,
                @Experience, @Service, @Amount, 'INITIATED', @Txn);
SELECT SCOPE_IDENTITY();";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Gender", ddlGenderReq.SelectedValue);
                cmd.Parameters.AddWithValue("@CategoryID",
                   int.TryParse(ddlCategory.SelectedValue, out int catId) ? (object)catId : DBNull.Value);

                cmd.Parameters.AddWithValue("@SubcategoryID",
                    int.TryParse(ddlSubcategory.SelectedValue, out int subId) ? (object)subId : DBNull.Value);

                cmd.Parameters.AddWithValue("@Qualification",
     string.IsNullOrEmpty(Dropqual.SelectedValue) ? (object)DBNull.Value : Dropqual.SelectedValue);

                cmd.Parameters.AddWithValue("@Experience",
                    string.IsNullOrEmpty(DrpExp.SelectedValue) ? (object)DBNull.Value : DrpExp.SelectedValue);

                cmd.Parameters.AddWithValue("@Service", ddlServiceFee.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@Txn", txnId);

                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private void CreatePayment(int appId, string txnId, decimal amount)
        {
            string sql = @"
INSERT INTO ServicePayments
(ApplicationID, MerchantTxnId, Amount, Status)
VALUES
(@AppId, @Txn, @Amt, 'INITIATED')";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@AppId", appId);
                cmd.Parameters.AddWithValue("@Txn", txnId);
                cmd.Parameters.AddWithValue("@Amt", amount);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        private void UpdatePaymentAfterInitiation(string merchantTxnId, string status, string response)
        {
            const string sql = @"
        UPDATE ServicePayments
        SET Status = @Status,
            ResponseCode = @ResponseCode,
            RawResponse = @RawResponse,
            UpdatedAt = GETDATE()
        WHERE MerchantTxnId = @MerchantTxnId;

        UPDATE ServicePaymentApplications
        SET ApplicationStatus = @ApplicationStatus,
            UpdatedAt = GETDATE()
        WHERE MerchantTxnId = @MerchantTxnId;
    ";

            string appStatus = "PAYMENT_INITIATED";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@Status", status ?? "INITIATED");
                cmd.Parameters.AddWithValue("@ResponseCode", status ?? "INITIATED");
                cmd.Parameters.AddWithValue("@RawResponse", (object)response ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MerchantTxnId", merchantTxnId);
                cmd.Parameters.AddWithValue("@ApplicationStatus", appStatus);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        private async Task<string> InitiateV2PaymentAsync(string merchantTxnId, decimal amount, string redirectUrl)
        {
            string authToken = await GenerateV2AuthTokenAsync();
            string paymentUrl = ReadConfigValue("PhonePe_V2_PaymentUrl");
            if (string.IsNullOrWhiteSpace(paymentUrl))
            {
                throw new Exception("PhonePe V2 payment URL is not configured.");
            }

            var paymentPayload = new
            {
                merchantOrderId = merchantTxnId,
                amount = Convert.ToInt64(amount * 100m),
                expireAfter = 1200,
                metaInfo = new
                {
                    udf1 = txtMobile.Text.Trim(),
                    udf2 = "OnlineInterview",
                    udf3 = "TabletJobs"
                },
                paymentFlow = new
                {
                    type = "PG_CHECKOUT",
                    message = "Payment for online interview booking",
                    merchantUrls = new
                    {
                        redirectUrl = redirectUrl
                    }
                }
            };

            using (HttpClient client = new HttpClient())
            using (HttpRequestMessage req = new HttpRequestMessage(HttpMethod.Post, paymentUrl))
            {
                req.Headers.Add("Authorization", "O-Bearer " + authToken);
                req.Headers.Add("Accept", "application/json");
                req.Content = new StringContent(JsonConvert.SerializeObject(paymentPayload), Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.SendAsync(req).ConfigureAwait(false);
                string responseText = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                if (!response.IsSuccessStatusCode)
                {
                    throw new Exception("PhonePe V2 payment failed: " + responseText);
                }

                return responseText;
            }
        }

        private async Task<string> GenerateV2AuthTokenAsync()
        {
            string clientId = ReadConfigValue("PhonePe_V2_ClientId");
            string clientSecret = ReadConfigValue("PhonePe_V2_ClientSecret");
            string baseUrl = ReadConfigValue("PhonePe_V2_BaseUrl");

            if (string.IsNullOrWhiteSpace(clientId) || string.IsNullOrWhiteSpace(clientSecret) || string.IsNullOrWhiteSpace(baseUrl))
            {
                throw new Exception("PhonePe V2 credentials are not configured.");
            }

            string authUrl = baseUrl.TrimEnd('/') + "/v1/oauth/token";
            var authRequest = new[]
            {
                new KeyValuePair<string, string>("client_id", clientId),
                new KeyValuePair<string, string>("client_version", "1"),
                new KeyValuePair<string, string>("client_secret", clientSecret),
                new KeyValuePair<string, string>("grant_type", "client_credentials")
            };

            using (HttpClient client = new HttpClient())
            {
                HttpResponseMessage response = await client.PostAsync(authUrl, new FormUrlEncodedContent(authRequest)).ConfigureAwait(false);
                string responseText = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                if (!response.IsSuccessStatusCode)
                {
                    throw new Exception("PhonePe V2 auth failed: " + responseText);
                }

                JObject authObj = JObject.Parse(responseText);
                string token = authObj.SelectToken("access_token")?.ToString();
                if (string.IsNullOrWhiteSpace(token))
                {
                    throw new Exception("PhonePe V2 auth token missing in response.");
                }

                return token;
            }
        }

        private static string ReadConfigValue(string key)
        {
            string raw = ConfigurationManager.AppSettings[key];
            if (string.IsNullOrWhiteSpace(raw))
            {
                return string.Empty;
            }

            string[] parts = raw.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 0)
            {
                return raw.Trim();
            }

            return parts[0].Trim();
        }
    }
}




