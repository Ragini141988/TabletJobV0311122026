using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.account
{
    public partial class AccountLoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter username and password.";
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT AccountID, Username
                    FROM Account
                    WHERE Username = @Username
                    AND Password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Session["AccountID"] = reader["AccountID"].ToString();
                            Session["Username"] = reader["Username"].ToString();

                            Response.Redirect("~/account/accountdashboard.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid username or password.";
                        }
                    }
                }
            }
        }
    }
}