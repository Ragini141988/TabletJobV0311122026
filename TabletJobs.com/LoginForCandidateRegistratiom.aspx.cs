
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Http;
using System.Web.UI;

namespace TabletJobs.com
{
    public partial class LoginForCandidateRegistratiom : Page
    {
        private readonly string _connStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlStep1.Visible = true;
                pnlStep2.Visible = false;
            }
        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            var phone = txtPhone.Text.Trim();
            if (string.IsNullOrWhiteSpace(phone))
            {
                lblMessage.Text = "Please enter a mobile number.";
                return;
            }

            if (!IsAuthorizedPhone(phone))
            {
                lblMessage.Text = "Phone number is not authorized.";
                return;
            }

            var otp = GenerateOTP();
            Session["OTP"] = otp;
            Session["OTPExpiration"] = DateTime.Now.AddMinutes(5);
            Session["LoginPhone"] = phone;

            var status = SendOtpSms(otp, phone);
            if (status == "Success")
            {
                lblMessage.Text = "OTP sent. It is valid for 5 minutes.";
                pnlStep1.Visible = false;
                pnlStep2.Visible = true;
            }
            else
            {
                lblMessage.Text = "Failed to send OTP. Please try again.";
            }
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            var entered = txtOtp.Text.Trim();
            var otp = Session["OTP"] as string;
            var exp = Session["OTPExpiration"] as DateTime?;

            if (string.IsNullOrWhiteSpace(entered))
            {
                lblMessage.Text = "Enter the OTP.";
                return;
            }

            if (exp == null || DateTime.Now > exp.Value)
            {
                lblMessage.Text = "OTP expired. Please resend.";
                return;
            }

            if (entered == otp)
            {
                Session["IsNews"] = true;

                string phone = Session["LoginPhone"].ToString();
                Session["useridforcandidateregistration"] = phone;

                Response.Redirect("CandidateList.aspx"); 
            }
            else
            {
                lblMessage.Text = "Invalid OTP.";
            }
        }
      

        protected void btnResend_Click(object sender, EventArgs e)
        {
            var phone = Session["LoginPhone"] as string ?? txtPhone.Text.Trim();
            if (string.IsNullOrWhiteSpace(phone))
            {
                lblMessage.Text = "Enter your mobile number first.";
                return;
            }
            if (!IsAuthorizedPhone(phone))
            {
                lblMessage.Text = "Phone number is not authorized.";
                return;
            }
            var otp = GenerateOTP();
            Session["OTP"] = otp;
            Session["OTPExpiration"] = DateTime.Now.AddMinutes(5);
            var status = SendOtpSms(otp, phone);
            lblMessage.Text = status == "Success" ? "OTP resent." : "Failed to resend OTP.";
            pnlStep1.Visible = false;
            pnlStep2.Visible = true;
        }

        private bool IsAuthorizedPhone(string phone)
        {
            using (var con = new SqlConnection(_connStr))
            using (var cmd = new SqlCommand("SELECT 1 FROM AuthorizedPhoneNumbersForHealthCareNews WHERE PhoneNumber=@P", con))
            {
                cmd.Parameters.AddWithValue("@P", phone);
                con.Open();
                var o = cmd.ExecuteScalar();
                return o != null;
            }
        }

        private string GenerateOTP()
        {
            var rnd = new Random();
            return rnd.Next(100000, 999999).ToString();
        }

        private string SendOtpSms(string otp, string phone)
        {
            // Use your approved DLT template/sender
            string apiUrl = $"https://smslogin.co/v3/api.php?username=Uproblem&apikey=8542eed47b0877040c6f&mobile={phone}&senderid=TABJBS&message={otp}+is+your+OTP+for+www.tabletjobs.com+%2F+Login+%2F+Registration.+This+OTP+is+valid+for+5+minutes.+Please+don%27t+share+this+OTP+with+anyone.&templateid=1707173648842001103";
            try
            {
                using (var http = new HttpClient())
                {
                    var resp = http.GetAsync(apiUrl).Result;
                    if (resp.IsSuccessStatusCode) return "Success";
                    return "Fail";
                }
            }
            catch
            {
                return "Fail";
            }
        }
    }
}
