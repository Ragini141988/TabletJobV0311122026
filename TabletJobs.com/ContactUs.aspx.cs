using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubscribe_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                bool consent = chkConsent.Checked;

                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO Subscribers (Name, Email, Phone, Consent, CreatedAt) " +
                                       "VALUES (@Name, @Email, @Phone, @Consent, GETDATE())";

                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Consent", consent);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    // ✅ Success message
                    lblMessage.Text = "✅ Subscription successful!";
                    lblMessage.CssClass = "text-success mt-3 d-block"; // 🟢 Green

                    // Clear form fields
                    txtName.Text = txtEmail.Text = txtPhone.Text = "";
                    chkConsent.Checked = false;
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627 || ex.Number == 2601) // Duplicate error (unique constraint)
                    {
                        lblMessage.Text = "⚠️ This Email or Phone number is already subscribed.";
                        lblMessage.CssClass = "text-danger mt-3 d-block"; // 🔴 Red
                    }
                    else
                    {
                        lblMessage.Text = "❌ Error: " + ex.Message;
                        lblMessage.CssClass = "text-danger mt-3 d-block"; // 🔴 Red
                    }
                }
            }
        }
    }
}