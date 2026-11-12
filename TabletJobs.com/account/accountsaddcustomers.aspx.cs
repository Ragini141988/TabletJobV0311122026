using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.accounts
{
    public partial class accountsaddcustomers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }
        }

        protected void btnAddCustomer_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.CssClass = "message";
            // Make sure AccountID exists in Session
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }
            int accountID;
            if (!int.TryParse(Session["AccountID"].ToString(), out accountID))
            {
                ShowError("Invalid login session. Please login again.");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtCustomerName.Text))
            {
                ShowError("Please enter Customer Name.");
                return;
            }

            if (string.IsNullOrEmpty(ddlCustomerCity.SelectedValue))
            {
                ShowError("Please select Customer City.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtContact.Text))
            {
                ShowError("Please enter Customer Contact Number.");
                return;
            }

            if (string.IsNullOrEmpty(ddlRating.SelectedValue))
            {
                ShowError("Please select Customer Rating.");
                return;
            }

            if (string.IsNullOrEmpty(ddlTransport.SelectedValue))
            {
                ShowError("Please select Target Transport.");
                return;
            }

            try
            {
                string connectionString =
                    ConfigurationManager.ConnectionStrings[
                        "hospi2yp_tabletjobssConnectionString_V02"
                    ].ConnectionString;

                using (SqlConnection con =
                    new SqlConnection(connectionString))
                {
                    string query = @"
                        INSERT INTO AccountCustomers
                        (
                            CustomerName,
                            CustomerCity,
                            CustomerContactNumber,
                            CustomerRating,
                            TargetTransport
                            ,AccountID
                        )
                        VALUES
                        (
                            @CustomerName,
                            @CustomerCity,
                            @CustomerContactNumber,
                            @CustomerRating,
                            @TargetTransport,
                            @AccountID
                        )";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CustomerName",
                            txtCustomerName.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@CustomerCity",
                            ddlCustomerCity.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@CustomerContactNumber",
                            txtContact.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@CustomerRating",
                            ddlRating.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@TargetTransport",
                            ddlTransport.SelectedValue);
                        // IMPORTANT: // Save the AccountID of the currently logged-in user 
                        cmd.Parameters.AddWithValue("@AccountID", accountID);
                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                ShowSuccess("Customer added successfully.");

                ClearFields();
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        private void ClearFields()
        {
            txtCustomerName.Text = "";
            ddlCustomerCity.SelectedIndex = 0;
            txtContact.Text = "";
            ddlRating.SelectedIndex = 0;
            ddlTransport.SelectedIndex = 0;
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "message error";
        }

        private void ShowSuccess(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "message success";
        }
    }
}