using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Linq;

namespace TabletJobs.com
{
    public partial class OnlineInterviewPaymentProceed : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;
        protected int ApplicationId { get { return ViewState["ApplicationId"] == null ? 0 : Convert.ToInt32(ViewState["ApplicationId"]); } set { ViewState["ApplicationId"] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["applicationId"], out int applicationId) || applicationId <= 0)
            {
                lblMessage.Text = "Invalid application.";
                btnProceedPayment.Enabled = false;
                return;
            }
            ApplicationId = applicationId;
            if (!IsPostBack) BindApplication(applicationId);
        }

        private void BindApplication(int applicationId)
        {
            const string sql = @"
        SELECT 
            a.ApplicationID,
            a.JobID,
            a.CandidateName,
            a.Mobile,
            a.Email,
            a.ApplicationStatus,

            j.JTitle,
            j.hname,
            j.hcity,
            j.hstat,
            j.Representative,
            j.InterviewDate,

            ISNULL(j.InterviewStartTime, '10:00 AM') AS InterviewStartTime

        FROM OnlineInterviewApplications a

        INNER JOIN JobPostInternal j 
            ON j.JobID = a.JobID

        WHERE a.ApplicationID = @ApplicationID";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ApplicationID", applicationId);

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        lblMessage.Text = "Application not found.";
                        btnProceedPayment.Enabled = false;
                        return;
                    }

                    // Hospital
                    lblHospitalName.Text = Convert.ToString(dr["hname"]);

                    // City + State
                    string city = Convert.ToString(dr["hcity"]);
                    string state = Convert.ToString(dr["hstat"]);

                    if (!string.IsNullOrWhiteSpace(state))
                    {
                        lblCity.Text = city + ", " + state;
                    }
                    else
                    {
                        lblCity.Text = city;
                    }

                    // Position
                    lblApplyingFor.Text = Convert.ToString(dr["JTitle"]);


                    // Interview Date + Time
                    DateTime interviewDate;

                    if (DateTime.TryParse(
                        Convert.ToString(dr["InterviewDate"]),
                        out interviewDate))
                    {
                        string interviewTime =
                            Convert.ToString(dr["InterviewStartTime"]);

                        lblInterviewDate.Text =
                            interviewDate.ToString(
                                "dddd, dd MMMM yyyy",
                                CultureInfo.InvariantCulture)
                            + " | "
                            + interviewTime;
                    }
                    else
                    {
                        lblInterviewDate.Text =
                            "Date will be confirmed";
                    }


                    // Representative
                    string representative =
                        Convert.ToString(dr["Representative"]);

                    if (!string.IsNullOrWhiteSpace(representative))
                    {
                        lnkCallCoordinator.Text =
                            "Call to Interview Coordinator: "
                            + representative;

                        // Example:
                        // Rashida: 7349068797

                        string[] parts =
                            representative.Split(':');

                        if (parts.Length > 1)
                        {
                            string mobile =
                                parts[parts.Length - 1].Trim();

                            // Keep only numbers
                            mobile = new string(
                                mobile.Where(char.IsDigit).ToArray());

                            // Add India country code
                            if (mobile.Length == 10)
                            {
                                mobile = "91" + mobile;
                            }

                            lnkCallCoordinator.NavigateUrl =
                                "tel:+" + mobile;
                        }
                    }
                    else
                    {
                        lnkCallCoordinator.Text =
                            "Interview Coordinator";

                        lnkCallCoordinator.NavigateUrl =
                            "javascript:void(0);";
                    }
                }
            }
        }

        protected async void btnProceedPayment_Click(object sender, EventArgs e)
        {
            try
            {
                decimal amount = GetInterviewFee();
                string merchantTxnId = "OI_" + DateTime.UtcNow.Ticks;
                CreatePaymentEntry(ApplicationId, merchantTxnId, amount);

                string resultUrl = Request.Url.GetLeftPart(UriPartial.Authority) +
                    "/OnlineInterviewPaymentResult.aspx?applicationId=" + ApplicationId +
                    "&merchantTxnId=" + merchantTxnId;

                string responseText = await InitiateV2PaymentAsync(merchantTxnId, amount, resultUrl);
                JObject response = JObject.Parse(responseText);
                string redirectUrl = response.SelectToken("redirectUrl")?.ToString();
                string state = response.SelectToken("state")?.ToString() ?? "INITIATED";
                UpdatePaymentAfterInitiation(merchantTxnId, state, responseText);

                if (string.IsNullOrWhiteSpace(redirectUrl))
                {
                    lblMessage.Text = "Payment initiated but redirect URL is missing. Transaction: " + merchantTxnId;
                    return;
                }
                Response.Redirect(redirectUrl, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Unable to initiate payment: " + ex.Message;
            }
        }

        private decimal GetInterviewFee()
        {
            string raw = ConfigurationManager.AppSettings["OnlineInterviewFee"];
            decimal fee;
            if (!decimal.TryParse(raw, NumberStyles.Number, CultureInfo.InvariantCulture, out fee) || fee <= 0)
                fee = 99m;
            decimal baseFee = fee;
            decimal gst = baseFee * 18m / 100m;
            decimal totalAmount = baseFee + gst;
            return totalAmount;
        }

        private void CreatePaymentEntry(int applicationId, string merchantTxnId, decimal amount)
        {
            const string sql = @"
                INSERT INTO OnlineInterviewPayments
                (ApplicationID, JobID, MerchantTxnId, Amount, Status, CreatedAt, UpdatedAt)
                SELECT ApplicationID, JobID, @MerchantTxnId, @Amount, 'INITIATED', GETDATE(), GETDATE()
                FROM OnlineInterviewApplications WHERE ApplicationID = @ApplicationID;
                UPDATE OnlineInterviewApplications
                SET MerchantTxnId = @MerchantTxnId, ApplicationStatus = 'PAYMENT_INITIATED', UpdatedAt = GETDATE()
                WHERE ApplicationID = @ApplicationID;";
            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ApplicationID", applicationId);
                cmd.Parameters.AddWithValue("@MerchantTxnId", merchantTxnId);
                cmd.Parameters.AddWithValue("@Amount", amount);
                con.Open(); cmd.ExecuteNonQuery();
            }
        }

        private void UpdatePaymentAfterInitiation(string merchantTxnId, string status, string response)
        {
            const string sql = "UPDATE OnlineInterviewPayments SET Status=@Status, RawResponse=@RawResponse, UpdatedAt=GETDATE() WHERE MerchantTxnId=@MerchantTxnId";
            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@Status", status ?? "INITIATED");
                cmd.Parameters.AddWithValue("@RawResponse", (object)response ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MerchantTxnId", merchantTxnId);
                con.Open(); cmd.ExecuteNonQuery();
            }
        }

        private async Task<string> InitiateV2PaymentAsync(string merchantTxnId, decimal amount, string redirectUrl)
        {
            string authToken = await GenerateV2AuthTokenAsync();
            string paymentUrl = ReadConfigValue("PhonePe_V2_PaymentUrl");
            if (string.IsNullOrWhiteSpace(paymentUrl)) throw new Exception("PhonePe V2 payment URL is not configured.");

            var payload = new
            {
                merchantOrderId = merchantTxnId,
                amount = Convert.ToInt64(amount * 100m),
                expireAfter = 1200,
                metaInfo = new { udf1 = "OnlineInterview", udf2 = "TabletJobs", udf3 = merchantTxnId },
                paymentFlow = new { type = "PG_CHECKOUT", message = "Payment for online interview booking", merchantUrls = new { redirectUrl = redirectUrl } }
            };

            using (HttpClient client = new HttpClient())
            using (HttpRequestMessage req = new HttpRequestMessage(HttpMethod.Post, paymentUrl))
            {
                req.Headers.Add("Authorization", "O-Bearer " + authToken);
                req.Headers.Add("Accept", "application/json");
                req.Content = new StringContent(JsonConvert.SerializeObject(payload), Encoding.UTF8, "application/json");
                HttpResponseMessage response = await client.SendAsync(req).ConfigureAwait(false);
                string responseText = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                if (!response.IsSuccessStatusCode) throw new Exception("PhonePe V2 payment failed: " + responseText);
                return responseText;
            }
        }

        private async Task<string> GenerateV2AuthTokenAsync()
        {
            string clientId = ReadConfigValue("PhonePe_V2_ClientId");
            string clientSecret = ReadConfigValue("PhonePe_V2_ClientSecret");
            string baseUrl = ReadConfigValue("PhonePe_V2_BaseUrl");
            if (string.IsNullOrWhiteSpace(clientId) || string.IsNullOrWhiteSpace(clientSecret) || string.IsNullOrWhiteSpace(baseUrl))
                throw new Exception("PhonePe V2 credentials are not configured.");

            string authUrl = baseUrl.TrimEnd('/') + "/v1/oauth/token";
            var form = new[] {
                new KeyValuePair<string,string>("client_id", clientId),
                new KeyValuePair<string,string>("client_version", "1"),
                new KeyValuePair<string,string>("client_secret", clientSecret),
                new KeyValuePair<string,string>("grant_type", "client_credentials")
            };
            using (HttpClient client = new HttpClient())
            {
                HttpResponseMessage response = await client.PostAsync(authUrl, new FormUrlEncodedContent(form)).ConfigureAwait(false);
                string text = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                if (!response.IsSuccessStatusCode) throw new Exception("PhonePe V2 auth failed: " + text);
                string token = JObject.Parse(text).SelectToken("access_token")?.ToString();
                if (string.IsNullOrWhiteSpace(token)) throw new Exception("PhonePe V2 auth token missing in response.");
                return token;
            }
        }

        private static string ReadConfigValue(string key)
        {
            string raw = ConfigurationManager.AppSettings[key];
            if (string.IsNullOrWhiteSpace(raw)) return string.Empty;
            string[] parts = raw.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            return parts.Length == 0 ? raw.Trim() : parts[0].Trim();
        }
    }
}
