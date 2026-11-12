using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.account
{
    public partial class accountrevenue : System.Web.UI.Page
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
                txtDate.Text = DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
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

            // Customer Name
            if (string.IsNullOrWhiteSpace(txtCustomerName.Text))
            {
                ShowError("Please enter Customer Name.");
                return;
            }

            // Customer City
            if (string.IsNullOrEmpty(ddlCustomerCity.SelectedValue))
            {
                ShowError("Please select Customer City.");
                return;
            }

            // Contact Number
            if (string.IsNullOrWhiteSpace(txtCustomerContact.Text))
            {
                ShowError("Please enter Customer Contact Number.");
                return;
            }

            // Transport
            if (string.IsNullOrEmpty(ddlTransportName.SelectedValue))
            {
                ShowError("Please select Transport Name.");
                return;
            }

            // Transport City
            if (string.IsNullOrEmpty(ddlTransportCity.SelectedValue))
            {
                ShowError("Please select Transport City.");
                return;
            }

            // LR Number
            if (string.IsNullOrWhiteSpace(txtLRNumber.Text))
            {
                ShowError("Please enter LR Number.");
                return;
            }

            // Total Articles
            int totalArticles;

            if (!int.TryParse(txtTotalArticles.Text.Trim(), out totalArticles) ||
                totalArticles <= 0)
            {
                ShowError("Please enter a valid Total Articles.");
                return;
            }

            // Total LR Amount
            decimal totalLRAmount;

            if (!decimal.TryParse(txtTotalLRAmount.Text.Trim(), out totalLRAmount) ||
                totalLRAmount < 0)
            {
                ShowError("Please enter a valid Total LR Amount.");
                return;
            }

            // LR Type
            if (string.IsNullOrEmpty(ddlLRType.SelectedValue))
            {
                ShowError("Please select LR Type.");
                return;
            }

            // Delivery Charges
            decimal deliveryCharges;

            if (!decimal.TryParse(txtDeliveryCharges.Text.Trim(), out deliveryCharges) ||
                deliveryCharges < 0)
            {
                ShowError("Please enter valid Delivery Charges.");
                return;
            }

            try
            {
                string connectionString =
                    ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"
                        INSERT INTO DailyDeliveryDetails
                        (
                            CustomerName,
                            CustomerCity,
                            CustomerContactNumber,
                            TransportName,
                            TransportCity,
                            LRNumber,
                            TotalArticles,
                            TotalLRAmount,
                            LRType,
                            DeliveryCharges
                           ,AccountID
                        )
                        VALUES
                        (
                            @CustomerName,
                            @CustomerCity,
                            @CustomerContactNumber,
                            @TransportName,
                            @TransportCity,
                            @LRNumber,
                            @TotalArticles,
                            @TotalLRAmount,
                            @LRType,
                            @DeliveryCharges
                           ,@AccountID
                        )";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CustomerName",
                            txtCustomerName.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@CustomerCity",
                            ddlCustomerCity.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@CustomerContactNumber",
                            txtCustomerContact.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@TransportName",
                            ddlTransportName.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@TransportCity",
                            ddlTransportCity.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@LRNumber",
                            txtLRNumber.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@TotalArticles",
                            totalArticles);

                        cmd.Parameters.AddWithValue(
                            "@TotalLRAmount",
                            totalLRAmount);

                        cmd.Parameters.AddWithValue(
                            "@LRType",
                            ddlLRType.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@DeliveryCharges",
                            deliveryCharges);

                        // IMPORTANT: // Save the AccountID of the currently logged-in user 
                        cmd.Parameters.AddWithValue("@AccountID", accountID);

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                ShowSuccess("Delivery details submitted successfully.");

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
            txtCustomerContact.Text = "";
            ddlTransportName.SelectedIndex = 0;
            ddlTransportCity.SelectedIndex = 0;
            txtLRNumber.Text = "";
            txtTotalArticles.Text = "";
            txtTotalLRAmount.Text = "";
            ddlLRType.SelectedIndex = 0;
            txtDeliveryCharges.Text = "";

            txtDate.Text = DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
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