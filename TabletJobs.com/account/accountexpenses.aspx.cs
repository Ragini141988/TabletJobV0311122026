using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.account
{
    public partial class accountexpenses : System.Web.UI.Page
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
                txtExpenseDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

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
            decimal amount;

            if (!decimal.TryParse(txtAmount.Text.Trim(), out amount) ||
                amount <= 0)
            {
                ShowError("Please enter a valid amount.");
                return;
            }

            if (string.IsNullOrEmpty(ddlExpenseType.SelectedValue))
            {
                ShowError("Please select Expenses Type.");
                return;
            }

            DateTime expenseDate;

            if (!DateTime.TryParse(txtExpenseDate.Text, out expenseDate))
            {
                ShowError("Please select a valid date.");
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
                        INSERT INTO DailyExpenses
                        (
                            Amount,
                            ExpenseType,
                            ExpenseDetails,
                            ExpenseDate
                           ,AccountID
                        )
                        VALUES
                        (
                            @Amount,
                            @ExpenseType,
                            @ExpenseDetails,
                            @ExpenseDate
                            ,@AccountID
                        )";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@Amount",
                            amount);

                        cmd.Parameters.AddWithValue(
                            "@ExpenseType",
                            ddlExpenseType.SelectedValue);

                        cmd.Parameters.AddWithValue(
                            "@ExpenseDetails",
                            string.IsNullOrWhiteSpace(
                                txtExpenseDetails.Text)
                                ? (object)DBNull.Value
                                : txtExpenseDetails.Text.Trim());

                        cmd.Parameters.AddWithValue(
                            "@ExpenseDate",
                            expenseDate.Date);
                        // IMPORTANT: // Save the AccountID of the currently logged-in user 
                        cmd.Parameters.AddWithValue("@AccountID", accountID);
                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                ShowSuccess(
                    "Expense details submitted successfully.");

                ClearFields();
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        private void ClearFields()
        {
            txtAmount.Text = "";

            ddlExpenseType.SelectedIndex = 0;

            txtExpenseDetails.Text = "";

            txtExpenseDate.Text =
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