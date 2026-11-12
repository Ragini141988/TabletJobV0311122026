using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.account
{
    public partial class accountdeliveryedit : System.Web.UI.Page
    {
        private int DeliveryID
        {
            get
            {
                int id;

                if (int.TryParse(
                    Request.QueryString["id"],
                    out id))
                {
                    return id;
                }

                return 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Must be logged in
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }

            // Only Admin can edit/delete
            if (!IsAdmin())
            {
                Response.Redirect("~/account/accountreports.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (DeliveryID <= 0)
                {
                    ShowError("Invalid Delivery ID.");
                    return;
                }

                LoadDelivery();
            }
        }

        private bool IsAdmin()
        {
            int accountID;

            if (Session["AccountID"] == null)
                return false;

            if (!int.TryParse(
                Session["AccountID"].ToString(),
                out accountID))
            {
                return false;
            }

            return accountID == 4;
        }

        private void LoadDelivery()
        {
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
                        SELECT
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
                        FROM [sqladmin].[DailyDeliveryDetails]
                        WHERE DeliveryID = @DeliveryID";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@DeliveryID",
                            DeliveryID);

                        con.Open();

                        using (SqlDataReader reader =
                            cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtCustomerName.Text =
                                    reader["CustomerName"].ToString();

                                ddlCustomerCity.SelectedValue =
                                    reader["CustomerCity"].ToString();

                                txtCustomerContact.Text =
                                    reader["CustomerContactNumber"].ToString();

                                ddlTransportName.SelectedValue =
                                    reader["TransportName"].ToString();

                                ddlTransportCity.SelectedValue =
                                    reader["TransportCity"].ToString();

                                txtLRNumber.Text =
                                    reader["LRNumber"].ToString();

                                txtTotalArticles.Text =
                                    reader["TotalArticles"].ToString();

                                txtTotalLRAmount.Text =
                                    Convert.ToDecimal(
                                        reader["TotalLRAmount"])
                                    .ToString("0.00");

                                ddlLRType.SelectedValue =
                                    reader["LRType"].ToString();

                                txtDeliveryCharges.Text =
                                    Convert.ToDecimal(
                                        reader["DeliveryCharges"])
                                    .ToString("0.00");
                            }
                            else
                            {
                                ShowError(
                                    "Delivery record not found.");

                                btnUpdate.Enabled = false;
                                btnDelete.Enabled = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        protected void btnUpdate_Click(
            object sender,
            EventArgs e)
        {
            if (!IsAdmin())
            {
                Response.Redirect("~/account/accountreports.aspx");
                return;
            }

            if (DeliveryID <= 0)
            {
                ShowError("Invalid Delivery ID.");
                return;
            }

            int totalArticles;

            if (!int.TryParse(
                txtTotalArticles.Text.Trim(),
                out totalArticles) ||
                totalArticles <= 0)
            {
                ShowError("Please enter a valid Total Articles.");
                return;
            }

            decimal totalLRAmount;

            if (!decimal.TryParse(
                txtTotalLRAmount.Text.Trim(),
                out totalLRAmount) ||
                totalLRAmount < 0)
            {
                ShowError("Please enter a valid Total LR Amount.");
                return;
            }

            decimal deliveryCharges;

            if (!decimal.TryParse(
                txtDeliveryCharges.Text.Trim(),
                out deliveryCharges) ||
                deliveryCharges < 0)
            {
                ShowError(
                    "Please enter valid Delivery Charges.");
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
                        UPDATE [sqladmin].[DailyDeliveryDetails]
                        SET
                            CustomerName = @CustomerName,
                            CustomerCity = @CustomerCity,
                            CustomerContactNumber = @CustomerContactNumber,
                            TransportName = @TransportName,
                            TransportCity = @TransportCity,
                            LRNumber = @LRNumber,
                            TotalArticles = @TotalArticles,
                            TotalLRAmount = @TotalLRAmount,
                            LRType = @LRType,
                            DeliveryCharges = @DeliveryCharges
                        WHERE DeliveryID = @DeliveryID";

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

                        cmd.Parameters.AddWithValue(
                            "@DeliveryID",
                            DeliveryID);

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                ShowSuccess(
                    "Delivery details updated successfully.");
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        protected void btnDelete_Click(
            object sender,
            EventArgs e)
        {
            if (!IsAdmin())
            {
                Response.Redirect("~/account/accountreports.aspx");
                return;
            }

            if (DeliveryID <= 0)
            {
                ShowError("Invalid Delivery ID.");
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
                        DELETE FROM [sqladmin].[DailyDeliveryDetails]
                        WHERE DeliveryID = @DeliveryID";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@DeliveryID",
                            DeliveryID);

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect(
                    "~/account/accountreports.aspx");
            }
            catch (Exception ex)
            {
                ShowError("Error deleting record: " + ex.Message);
            }
        }

        protected void btnBack_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "~/account/accountreports.aspx");
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

