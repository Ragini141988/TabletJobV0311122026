using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com.account
{
    public partial class accountreports : System.Web.UI.Page
    {
        protected bool IsAdmin
        {
            get
            {
                if (Session["AccountID"] == null)
                    return false;

                int accountID;

                if (int.TryParse(Session["AccountID"].ToString(), out accountID))
                {
                    return accountID == 4;
                }

                return false;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (IsAdmin)
                {
                    pnlSummaryLink.Visible = true;

                    lblLoggedInUser.Text =
                        "Logged in as: Admin | Showing all delivery records";
                }
                else
                {
                    pnlSummaryLink.Visible = false;

                    string username =
                        Session["Username"] != null
                            ? Session["Username"].ToString()
                            : "";

                    lblLoggedInUser.Text =
                        "Logged in as: " + username;
                }

                LoadReport();
            }
        }

        private void LoadReport()
        {
            try
            {
                int accountID =
                    Convert.ToInt32(Session["AccountID"]);

                string username =
                    Session["Username"] != null
                        ? Session["Username"].ToString()
                        : "";

                if (IsAdmin)
                {
                    lblLoggedInUser.Text =
                        "Logged in as: Admin | Showing all delivery records";
                }
                else
                {
                    lblLoggedInUser.Text =
                        "Logged in as: " + username;
                }

                string connectionString =
                    ConfigurationManager.ConnectionStrings[
                        "hospi2yp_tabletjobssConnectionString_V02"
                    ].ConnectionString;

                using (SqlConnection con =
                    new SqlConnection(connectionString))
                {
                    string query;

                    if (IsAdmin)
                    {
                        query = @"
                            SELECT
                                D.DeliveryID,
                                D.CustomerName,
                                D.CustomerCity,
                                D.CustomerContactNumber,
                                D.TransportName,
                                D.TransportCity,
                                D.LRNumber,
                                D.TotalArticles,
                                D.TotalLRAmount,
                                D.LRType,
                                D.DeliveryCharges,
                                D.CreatedDate,
                                D.AccountID,
                                A.Username,
                                A.FullName
                            FROM [sqladmin].[DailyDeliveryDetails] D
                            LEFT JOIN [sqladmin].[Account] A
                                ON D.AccountID = A.AccountID
                            ORDER BY D.CreatedDate DESC";
                    }
                    else
                    {
                        query = @"
                            SELECT
                                D.DeliveryID,
                                D.CustomerName,
                                D.CustomerCity,
                                D.CustomerContactNumber,
                                D.TransportName,
                                D.TransportCity,
                                D.LRNumber,
                                D.TotalArticles,
                                D.TotalLRAmount,
                                D.LRType,
                                D.DeliveryCharges,
                                D.CreatedDate,
                                D.AccountID,
                                A.Username,
                                A.FullName
                            FROM [sqladmin].[DailyDeliveryDetails] D
                            LEFT JOIN [sqladmin].[Account] A
                                ON D.AccountID = A.AccountID
                            WHERE D.AccountID = @AccountID
                            ORDER BY D.CreatedDate DESC";
                    }

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        if (!IsAdmin)
                        {
                            cmd.Parameters.AddWithValue(
                                "@AccountID",
                                accountID);
                        }

                        using (SqlDataAdapter da =
                            new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            da.Fill(dt);

                            lvDelivery.DataSource = dt;
                            lvDelivery.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblLoggedInUser.Text =
                    "Error loading report: " + ex.Message;
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;

            int deliveryID = Convert.ToInt32(btn.CommandArgument);

            DeleteDelivery(deliveryID);
        }
        public void DeleteDelivery(int DeliveryID)
        {
            if (!IsAdmin)
            {
                ShowAlert("You are not authorized to delete this record.");
                return;
            }

            if (DeliveryID <= 0)
            {
                ShowAlert("Invalid Delivery ID.");
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

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            LoadReport();

                            ShowAlert("Delivery record deleted successfully.");
                        }
                        else
                        {
                            ShowAlert("Delivery record was not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error deleting record: " + ex.Message);
            }
        }
        private void ShowAlert(string message)
        {
            string safeMessage =
                message.Replace("\\", "\\\\")
                      .Replace("'", "\\'")
                      .Replace("\r", "")
                      .Replace("\n", "\\n");

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "alert",
                "alert('" + safeMessage + "');",
                true
            );
        }
    }
}

