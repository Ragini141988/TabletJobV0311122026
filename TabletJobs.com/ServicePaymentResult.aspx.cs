using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

namespace TabletJobs.com
{
    public partial class ServicePaymentResult : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int.TryParse(Request.QueryString["applicationId"], out int appId);
                string merchantTxnId = Request.QueryString["merchantTxnId"];

                if (appId > 0 && !string.IsNullOrWhiteSpace(merchantTxnId))
                {
                    await TryVerifyWithPhonePe(appId, merchantTxnId);
                }

                BindCurrentStatus(appId, merchantTxnId);
            }
        }

        private async System.Threading.Tasks.Task TryVerifyWithPhonePe(int appId, string merchantTxnId)
        {
            try
            {
                string merchantId = ConfigurationManager.AppSettings["PhonePe_MerchantId"];
                string saltKey = ConfigurationManager.AppSettings["PhonePe_SaltKey"];
                string saltIndexText = ConfigurationManager.AppSettings["PhonePe_SaltIndex"];
                string baseUrl = ConfigurationManager.AppSettings["PhonePe_BaseUrl"];

                int saltIndex = 1;
                int.TryParse(saltIndexText, out saltIndex);

                PhonePeIntegration phonePe = new PhonePeIntegration(merchantId, saltKey, saltIndex, baseUrl);
                JObject statusObj = await phonePe.CheckPaymentStatusAsync(merchantTxnId);

                string phonePeState = statusObj.SelectToken("data.state")?.ToString();
                string transactionId = statusObj.SelectToken("data.transactionId")?.ToString();
                string dbStatus = MapPhonePeState(phonePeState);

                UpdatePaymentStatus(appId, merchantTxnId, dbStatus, phonePeState, transactionId, statusObj.ToString());
            }
            catch (Exception ex)
            {
                bool shouldTryV2 = ex.Message.IndexOf("KEY_NOT_CONFIGURED", StringComparison.OrdinalIgnoreCase) >= 0
                                   || ex.Message.IndexOf("merchant", StringComparison.OrdinalIgnoreCase) >= 0;

                if (shouldTryV2)
                {
                    bool v2Updated = await TryVerifyWithPhonePeV2(appId, merchantTxnId);
                    if (!v2Updated)
                    {
                        lblMessage.Text = "Payment verification pending.";
                    }
                }
                else
                {
                    lblMessage.Text = "Payment verification pending: " + ex.Message;
                }
            }
        }

        private string MapPhonePeState(string phonePeState)
        {
            if (string.IsNullOrWhiteSpace(phonePeState))
            {
                return "PENDING";
            }

            switch (phonePeState.ToUpperInvariant())
            {
                case "COMPLETED":
                    return "SUCCESS";
                case "FAILED":
                case "DECLINED":
                    return "FAILED";
                case "PENDING":
                case "PAYMENT_PENDING":
                    return "PENDING";
                default:
                    return "PENDING";
            }
        }

        private void UpdatePaymentStatus(int appId, string merchantTxnId, string status, string responseCode, string phonePeTxn, string rawResponse)
        {
            const string sql = @"
        UPDATE ServicePayments
        SET Status = @Status,
            ResponseCode = @ResponseCode,
            PhonePeTransactionId = @PhonePeTransactionId,
            RawResponse = @RawResponse,
            UpdatedAt = GETDATE()
        WHERE MerchantTxnId = @MerchantTxnId;

        UPDATE ServicePaymentApplications
        SET ApplicationStatus = @ApplicationStatus,
            UpdatedAt = GETDATE()
        WHERE ApplicationID = @ApplicationID;";

            string appStatus = status == "SUCCESS"
                ? "COMPLETED"
                : status == "FAILED"
                    ? "FAILED"
                    : "PAYMENT_PENDING";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@ResponseCode", (object)responseCode ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhonePeTransactionId", (object)phonePeTxn ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@RawResponse", (object)rawResponse ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MerchantTxnId", merchantTxnId);
                cmd.Parameters.AddWithValue("@ApplicationStatus", appStatus);
                cmd.Parameters.AddWithValue("@ApplicationID", appId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        private void BindCurrentStatus(int appId, string merchantTxnId)
        {
            const string sql = @"
        SELECT TOP 1
            a.ApplicationID,
            a.MerchantTxnId,
            a.ApplicationStatus,
            a.ServiceType,
            p.Status AS PaymentStatus,
            p.Amount,
            p.PhonePeTransactionId
        FROM ServicePaymentApplications a
        LEFT JOIN ServicePayments p ON p.ApplicationID = a.ApplicationID
        WHERE (@ApplicationID > 0 AND a.ApplicationID = @ApplicationID)
           OR (@MerchantTxnId IS NOT NULL AND a.MerchantTxnId = @MerchantTxnId)
        ORDER BY p.PaymentID DESC, a.ApplicationID DESC";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ApplicationID", appId);
                cmd.Parameters.AddWithValue("@MerchantTxnId",
                    string.IsNullOrWhiteSpace(merchantTxnId) ? (object)DBNull.Value : merchantTxnId);

                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        lblHeaderTitle.Text = "Payment Pending";
                        lblMessage.Text = "No record found.";
                        return;
                    }

                    int applicationId = Convert.ToInt32(dr["ApplicationID"]);
                    string dbMerchantTxn = Convert.ToString(dr["MerchantTxnId"]);
                    string phonePeTxn = Convert.ToString(dr["PhonePeTransactionId"]);

                    lblBookingId.Text = BuildBookingId(applicationId, dbMerchantTxn, phonePeTxn);

                    // 👉 SERVICE NAME
                    lblJobTitle.Text = Convert.ToString(dr["ServiceType"]);

                    lblHospitalLocation.Text = "Service Payment";

                    lblInterviewDateTime.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");

                    decimal amount = dr["Amount"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["Amount"]);
                    lblAmountPaid.Text = amount.ToString("0");

                    string paymentStatus = Convert.ToString(dr["PaymentStatus"]);
                    string appStatus = Convert.ToString(dr["ApplicationStatus"]);

                    bool isSuccess = paymentStatus == "SUCCESS" || appStatus == "COMPLETED";

                    lblHeaderTitle.Text = isSuccess ? "Payment Successful!" : "Payment Pending";
                    divStatusIcon.InnerText = isSuccess ? "✓" : "!";

                    if (isSuccess)
                    {
                        lblMessage.Text = "Your payment has been successfully completed.";

                        lnkJoinInterview.Text = "Back to Home";
                        lnkJoinInterview.NavigateUrl = "~/Default.aspx";

                        lnkDownloadConfirmation.Visible = true;
                        lnkDownloadConfirmation.NavigateUrl =
                            "~/ServiceInvoice.aspx?applicationId=" + applicationId +
                            "&merchantTxnId=" + HttpUtility.UrlEncode(dbMerchantTxn) + "&download=1";

                    }
                    else
                    {
                        lblMessage.Text = "Payment failed or pending. Please retry.";

                        lnkJoinInterview.Text = "Retry Payment";
                        lnkJoinInterview.NavigateUrl = "~/ServicePayment.aspx";

                        lnkDownloadConfirmation.Visible = false;
                    }

                    SetSupportLinks();
                }
            }
        }
        private async Task<bool> TryVerifyWithPhonePeV2(int appId, string merchantTxnId)
        {
            try
            {
                string authToken = await GenerateV2AuthTokenAsync();
                if (string.IsNullOrWhiteSpace(authToken))
                {
                    return false;
                }

                string statusUrl = "https://api.phonepe.com/apis/pg/checkout/v2/order/" + merchantTxnId + "/status";
                using (HttpClient client = new HttpClient())
                using (HttpRequestMessage req = new HttpRequestMessage(HttpMethod.Get, statusUrl))
                {
                    req.Headers.Add("Authorization", "O-Bearer " + authToken);
                    req.Headers.Add("Accept", "application/json");

                    HttpResponseMessage response = await client.SendAsync(req).ConfigureAwait(false);
                    string responseText = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    if (!response.IsSuccessStatusCode)
                    {
                        return false;
                    }

                    JObject obj = JObject.Parse(responseText);
                    string state = obj.SelectToken("state")?.ToString()
                                   ?? obj.SelectToken("data.state")?.ToString();
                    string phonePeTxn = obj.SelectToken("paymentDetails[0].transactionId")?.ToString()
                                    ?? obj.SelectToken("data.paymentDetails[0].transactionId")?.ToString()
                                    ?? obj.SelectToken("orderId")?.ToString();

                    string dbStatus = MapPhonePeState(state);
                    UpdatePaymentStatus(appId, merchantTxnId, dbStatus, state, phonePeTxn, responseText);
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        private async Task<string> GenerateV2AuthTokenAsync()
        {
            string clientId = ReadConfigValue("PhonePe_V2_ClientId");
            string clientSecret = ReadConfigValue("PhonePe_V2_ClientSecret");
            string baseUrl = ReadConfigValue("PhonePe_V2_BaseUrl");

            if (string.IsNullOrWhiteSpace(clientId) || string.IsNullOrWhiteSpace(clientSecret) || string.IsNullOrWhiteSpace(baseUrl))
            {
                return null;
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
                    return null;
                }

                JObject authObj = JObject.Parse(responseText);
                return authObj.SelectToken("access_token")?.ToString();
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

        private static string CombineLocation(string city, string state)
        {
            if (string.IsNullOrWhiteSpace(city) && string.IsNullOrWhiteSpace(state))
            {
                return "NA";
            }

            if (string.IsNullOrWhiteSpace(city))
            {
                return state;
            }

            if (string.IsNullOrWhiteSpace(state))
            {
                return city;
            }

            return city + ", " + state;
        }

        private static string BuildBookingId(int applicationId, string merchantTxnId, string phonePeTxn)
        {
            string source = !string.IsNullOrWhiteSpace(phonePeTxn)
                ? phonePeTxn
                : (!string.IsNullOrWhiteSpace(merchantTxnId) ? merchantTxnId : applicationId.ToString(CultureInfo.InvariantCulture));

            source = source.Replace("OI_", string.Empty).Replace("-", string.Empty).Trim();
            if (source.Length > 10)
            {
                source = source.Substring(source.Length - 10, 10);
            }

            return source;
        }

        private void SetSupportLinks()
        {
            string supportPhone = ConfigurationManager.AppSettings["SupportPhone"];
            if (string.IsNullOrWhiteSpace(supportPhone))
            {
                supportPhone = "919059724821";
            }

            string digits = supportPhone.Replace(" ", string.Empty).Replace("+", string.Empty);
            lnkCallSupport.NavigateUrl = "tel:+" + digits;

            string whatsappUrl = ConfigurationManager.AppSettings["SupportWhatsAppUrl"];
            if (string.IsNullOrWhiteSpace(whatsappUrl))
            {
                whatsappUrl = "https://wa.me/" + digits;
            }

            lnkOpenWhatsApp.NavigateUrl = whatsappUrl;
        }
    }
}
