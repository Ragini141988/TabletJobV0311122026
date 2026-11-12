using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com
{
    public partial class tjtargets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtBusinessDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Validate Amount
            if (string.IsNullOrEmpty(ddlAmount.SelectedValue))
            {
                lblMessage.Text = "Please select an amount.";
                return;
            }

            // Validate Date
            if (string.IsNullOrEmpty(txtBusinessDate.Text))
            {
                lblMessage.Text = "Please select a date.";
                return;
            }

            // Validate Collected By
            if (string.IsNullOrEmpty(ddlCollectedBy.SelectedValue))
            {
                lblMessage.Text = "Please select who collected the amount.";
                return;
            }

            decimal amount;

            if (!decimal.TryParse(ddlAmount.SelectedValue, out amount))
            {
                lblMessage.Text = "Invalid amount.";
                return;
            }

            DateTime businessDate;

            if (!DateTime.TryParse(txtBusinessDate.Text, out businessDate))
            {
                lblMessage.Text = "Invalid date.";
                return;
            }

            string amountType = ddlAmount.SelectedItem.Text;
            string collectedBy = ddlCollectedBy.SelectedValue;

            string connectionString =
                ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
                .ConnectionString;

            string query = @"
                INSERT INTO TJTargets
                (
                    AmountType,
                    Amount,
                    BusinessDate,
                    CollectedBy
                )
                VALUES
                (
                    @AmountType,
                    @Amount,
                    @BusinessDate,
                    @CollectedBy
                )";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@AmountType", amountType);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@BusinessDate", businessDate.Date);
                    cmd.Parameters.AddWithValue("@CollectedBy", collectedBy);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Business details saved successfully.";

            // Reset form
            ddlAmount.SelectedIndex = 0;
            ddlCollectedBy.SelectedIndex = 0;
            txtBusinessDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
        }
    }
}