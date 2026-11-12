using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com.account
{
    public partial class ExpensesReport : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadExpenses();
            }
        }


        private int GetAccountID()
        {
            if (Session["AccountID"] == null)
            {
                return 0;
            }

            int accountID;

            if (int.TryParse(
                Session["AccountID"].ToString(),
                out accountID))
            {
                return accountID;
            }

            return 0;
        }


        private bool IsAdmin
        {
            get
            {
                return GetAccountID() == 1;
            }
        }


        private void LoadExpenses()
        {
            int accountID = GetAccountID();

            if (accountID <= 0)
            {
                lblMessage.Text = "Please login to view expenses.";
                lblMessage.Visible = true;

                lvExpenses.DataSource = null;
                lvExpenses.DataBind();

                lblTotalRecords.Text = "0";
                lblTotalAmount.Text = "0.00";

                return;
            }


            DateTime? fromDate = null;
            DateTime? toDate = null;


            // FROM DATE
            if (!string.IsNullOrWhiteSpace(txtFromDate.Text))
            {
                DateTime parsedFromDate;

                if (DateTime.TryParse(
                    txtFromDate.Text,
                    out parsedFromDate))
                {
                    fromDate = parsedFromDate.Date;
                }
            }


            // TO DATE
            if (!string.IsNullOrWhiteSpace(txtToDate.Text))
            {
                DateTime parsedToDate;

                if (DateTime.TryParse(
                    txtToDate.Text,
                    out parsedToDate))
                {
                    toDate = parsedToDate.Date;
                }
            }


            // Validate date range
            if (fromDate.HasValue &&
                toDate.HasValue &&
                fromDate.Value > toDate.Value)
            {
                lblMessage.Text =
                    "From Date cannot be greater than To Date.";

                lblMessage.Visible = true;

                lvExpenses.DataSource = null;
                lvExpenses.DataBind();

                lblTotalRecords.Text = "0";
                lblTotalAmount.Text = "0.00";

                return;
            }


            lblMessage.Visible = false;


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT
                        ExpenseID,
                        Amount,
                        ExpenseType,
                        ExpenseDetails,
                        ExpenseDate,
                        CreatedDate,
                        AccountID
                    FROM sqladmin.DailyExpenses
                    WHERE 1 = 1
                ";


                // Account filtering
                // Admin AccountID = 1 can see all records.
                if (!IsAdmin)
                {
                    sql += @"
                        AND AccountID = @AccountID
                    ";
                }


                // From Date
                if (fromDate.HasValue)
                {
                    sql += @"
                        AND ExpenseDate >= @FromDate
                    ";
                }


                // To Date
                if (toDate.HasValue)
                {
                    sql += @"
                        AND ExpenseDate <= @ToDate
                    ";
                }


                // Latest expense date first
                // ExpenseID DESC handles same-date records.
                sql += @"
                    ORDER BY
                        ExpenseDate DESC,
                        ExpenseID DESC
                ";


                using (SqlCommand cmd =
                    new SqlCommand(sql, con))
                {
                    if (!IsAdmin)
                    {
                        cmd.Parameters.Add(
                            "@AccountID",
                            SqlDbType.Int).Value = accountID;
                    }


                    if (fromDate.HasValue)
                    {
                        cmd.Parameters.Add(
                            "@FromDate",
                            SqlDbType.Date).Value =
                            fromDate.Value;
                    }


                    if (toDate.HasValue)
                    {
                        cmd.Parameters.Add(
                            "@ToDate",
                            SqlDbType.Date).Value =
                            toDate.Value;
                    }


                    DataTable dt = new DataTable();


                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }


                    // Bind ListView
                    lvExpenses.DataSource = dt;
                    lvExpenses.DataBind();


                    // Summary
                    lblTotalRecords.Text =
                        dt.Rows.Count.ToString();


                    decimal totalAmount = 0;


                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["Amount"] != DBNull.Value)
                        {
                            totalAmount +=
                                Convert.ToDecimal(
                                    row["Amount"]);
                        }
                    }


                    lblTotalAmount.Text =
                        totalAmount.ToString("N2");
                }
            }
        }


        protected void btnSearch_Click(
            object sender,
            EventArgs e)
        {
            LoadExpenses();
        }


        protected void btnClear_Click(
            object sender,
            EventArgs e)
        {
            txtFromDate.Text = "";
            txtToDate.Text = "";

            LoadExpenses();
        }


        protected void lvExpenses_PagePropertiesChanging(
            object sender,
            PagePropertiesChangingEventArgs e)
        {
            dpExpenses.SetPageProperties(
                e.StartRowIndex,
                e.MaximumRows,
                false);

            LoadExpenses();
        }
    }
}

