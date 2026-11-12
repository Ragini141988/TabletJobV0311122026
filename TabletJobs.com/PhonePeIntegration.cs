using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace TabletJobs.com
{
    public class PhonePeIntegration
    {
        private readonly string _merchantId;
        private readonly string _saltKey;
        private readonly int _saltIndex;
        private readonly string _baseUrl;
        private readonly HttpClient _httpClient;

        public PhonePeIntegration(string merchantId, string saltKey, int saltIndex, string baseUrl)
        {
            _merchantId = NormalizeConfigValue(merchantId);
            _saltKey = NormalizeConfigValue(saltKey);
            _saltIndex = saltIndex;

            string normalizedBaseUrl = NormalizeConfigValue(baseUrl).TrimEnd('/');
            if (_merchantId.StartsWith("TEST-", StringComparison.OrdinalIgnoreCase) &&
                normalizedBaseUrl.IndexOf("/apis/hermes", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                normalizedBaseUrl = "https://api-preprod.phonepe.com/apis/pg-sandbox";
            }

            _baseUrl = normalizedBaseUrl;
            _httpClient = new HttpClient();
        }

        public class PaymentRequest
        {
            public string MerchantTransactionId { get; set; }
            public decimal Amount { get; set; }
            public string CallbackUrl { get; set; }
            public string RedirectUrl { get; set; }
            public string CustomerMobile { get; set; }
            public string CustomerEmail { get; set; }
        }

        public async Task<string> InitiatePaymentAsync(PaymentRequest paymentRequest)
        {
            var payload = new
            {
                merchantId = _merchantId,
                merchantTransactionId = paymentRequest.MerchantTransactionId,
                merchantUserId = "OI_" + DateTime.UtcNow.Ticks,
                amount = (long)(paymentRequest.Amount * 100m),
                redirectUrl = paymentRequest.RedirectUrl,
                redirectMode = "REDIRECT",
                callbackUrl = paymentRequest.CallbackUrl,
                mobileNumber = paymentRequest.CustomerMobile,
                paymentInstrument = new
                {
                    type = "PAY_PAGE"
                }
            };

            string jsonPayload = JsonConvert.SerializeObject(payload);
            string base64Payload = Convert.ToBase64String(Encoding.UTF8.GetBytes(jsonPayload));

            const string apiPath = "/pg/v1/pay";
            string checksum = GenerateChecksum(base64Payload + apiPath + _saltKey);
            string xVerify = checksum + "###" + _saltIndex;

            var request = new HttpRequestMessage(HttpMethod.Post, _baseUrl + apiPath);
            request.Headers.Add("X-VERIFY", xVerify);
            request.Content = new StringContent(JsonConvert.SerializeObject(new { request = base64Payload }), Encoding.UTF8, "application/json");

            HttpResponseMessage response = await _httpClient.SendAsync(request).ConfigureAwait(false);
            string responseText = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            if (!response.IsSuccessStatusCode)
            {
                throw new Exception("PhonePe initiation failed: " + responseText);
            }

            return responseText;
        }

        public async Task<JObject> CheckPaymentStatusAsync(string merchantTransactionId)
        {
            string apiPath = "/pg/v1/status/" + _merchantId + "/" + merchantTransactionId;
            string checksum = GenerateChecksum(apiPath + _saltKey);
            string xVerify = checksum + "###" + _saltIndex;

            var request = new HttpRequestMessage(HttpMethod.Get, _baseUrl + apiPath);
            request.Headers.Add("X-VERIFY", xVerify);
            request.Headers.Add("X-MERCHANT-ID", _merchantId);

            HttpResponseMessage response = await _httpClient.SendAsync(request).ConfigureAwait(false);
            string responseText = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            if (!response.IsSuccessStatusCode)
            {
                throw new Exception("PhonePe status failed: " + responseText);
            }

            return JObject.Parse(responseText);
        }

        public static string ExtractRedirectUrl(string responseJson)
        {
            JObject obj = JObject.Parse(responseJson);
            return obj.SelectToken("data.instrumentResponse.redirectInfo.url")?.ToString();
        }

        private static string GenerateChecksum(string payload)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hash = sha256.ComputeHash(Encoding.UTF8.GetBytes(payload));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash)
                {
                    sb.Append(b.ToString("x2"));
                }

                return sb.ToString();
            }
        }

        private static string NormalizeConfigValue(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return string.Empty;
            }

            string[] parts = value.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 0)
            {
                return value.Trim();
            }

            return parts[0].Trim();
        }
    }
}
