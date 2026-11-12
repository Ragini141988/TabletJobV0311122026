using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.accounts
{
    public partial class accountsbooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }
            if (!IsPostBack)
            {
                txtBookingDate.Text =
                    DateTime.Now.ToString("yyyy-MM-dd");

                txtServerDate.Text =
                    DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
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
            decimal bookingAmount;

            if (!decimal.TryParse(
                txtBookingAmount.Text.Trim(),
                out bookingAmount) ||
                bookingAmount < 0)
            {
                ShowError("Please enter a valid Booking Amount.");
                return;
            }

            if (string.IsNullOrEmpty(ddlTransport.SelectedValue))
            {
                ShowError("Please select Transport Name.");
                return;
            }

            if (string.IsNullOrEmpty(ddlFromCity.SelectedValue))
            {
                ShowError("Please select From City.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtToCity.Text))
            {
                ShowError("Please enter To City.");
                return;
            }

            int articles;

            if (!int.TryParse(
                txtArticles.Text.Trim(),
                out articles) ||
                articles <= 0)
            {
                ShowError("Please enter a valid number of Articles.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtCustomerName.Text))
            {
                ShowError("Please enter Customer Name.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtCustomerContact.Text))
            {
                ShowError("Please enter Customer Contact Number.");
                return;
            }

            DateTime bookingDate;

            if (!DateTime.TryParse(
                txtBookingDate.Text,
                out bookingDate))
            {
                ShowError("Please select a valid Date.");
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
                        INSERT INTO DailyBookingDetails
                        (
                            BookingAmount,
                            TransportName,
                            FromCity,
                            ToCity,
                            NoOfArticles,
                            FromCustomerName,
                            FromCustomerContactNumber,
                            BookingDate,
                            AccountID
                        )
                        VALUES
                        (
                            @BookingAmount,
                            @TransportName,
                            @FromCity,
                            @ToCity,
                            @NoOfArticles,
                            @FromCustomerName,
                            @FromCustomerContactNumber,
                            @BookingDate,
                            @AccountID
                        )";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@BookingAmount",
                            bookingAmount);

                        cmd.Parameters.AddWithValue(
                            "@TransportName",
                            ddlTransport.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@FromCity",
                            ddlFromCity.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@ToCity",
                            txtToCity.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@NoOfArticles",
                            articles);

                        cmd.Parameters.AddWithValue(
                            "@FromCustomerName",
                            txtCustomerName.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@FromCustomerContactNumber",
                            txtCustomerContact.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@BookingDate",
                            bookingDate.Date);
                        // IMPORTANT: // Save the AccountID of the currently logged-in user 
                        cmd.Parameters.AddWithValue( "@AccountID", accountID);
                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                ShowSuccess(
                    "Booking details submitted successfully.");

                ClearFields();
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        private void ClearFields()
        {
            txtBookingAmount.Text = "";

            ddlTransport.SelectedIndex = 0;

            ddlFromCity.SelectedIndex = 0;

            txtToCity.Text = "";

            txtArticles.Text = "";

            txtCustomerName.Text = "";

            txtCustomerContact.Text = "";

            txtBookingDate.Text =
                DateTime.Now.ToString("yyyy-MM-dd");

            txtServerDate.Text =
                DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
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