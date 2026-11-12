using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com.account
{
    public partial class accountsummary : System.Web.UI.Page
    {
        private int CurrentAccountID
        {
            get
            {
                if (Session["AccountID"] == null)
                    return 0;

                int accountID;

                if (int.TryParse(
                    Session["AccountID"].ToString(),
                    out accountID))
                {
                    return accountID;
                }

                return 0;
            }
        }


        private bool IsAdmin
        {
            get
            {
                return CurrentAccountID == 4;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountID"] == null)
            {
                Response.Redirect(
                    "~/account/AccountLoginPage.aspx");

                return;
            }


            if (!IsPostBack)
            {
                string today =
                    DateTime.Today.ToString("yyyy-MM-dd");

                txtFromDate.Text = today;
                txtToDate.Text = today;


                if (IsAdmin)
                {
                    lblLoggedInUser.Text =
                        "Logged in as: Admin";
                }
                else
                {
                    string username =
                        Session["Username"] != null
                            ? Session["Username"].ToString()
                            : "";

                    lblLoggedInUser.Text =
                        "Logged in as: " + username;
                }
            }
        }


        protected void btnViewReport_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.CssClass = "message";


            DateTime fromDate;
            DateTime toDate;


            if (!DateTime.TryParse(
                txtFromDate.Text,
                out fromDate))
            {
                ShowError("Please select a valid From Date.");
                return;
            }


            if (!DateTime.TryParse(
                txtToDate.Text,
                out toDate))
            {
                ShowError("Please select a valid To Date.");
                return;
            }


            if (fromDate.Date > toDate.Date)
            {
                ShowError(
                    "From Date cannot be greater than To Date.");

                return;
            }


            lblReportPeriod.Text =
                "Report From " +
                fromDate.ToString("dd/MM/yyyy") +
                " To " +
                toDate.ToString("dd/MM/yyyy");


            pnlReport.Visible = true;


            if (IsAdmin)
            {
                pnlUserReport.Visible = false;
                pnlAdminReport.Visible = true;

                LoadAdminReport(
                    fromDate.Date,
                    toDate.Date);
            }
            else
            {
                pnlAdminReport.Visible = false;
                pnlUserReport.Visible = true;

                LoadUserReport(
                    CurrentAccountID,
                    fromDate.Date,
                    toDate.Date);
            }
        }


        private void LoadUserReport(
            int accountID,
            DateTime fromDate,
            DateTime toDate)
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
                            ISNULL(SUM(
                                CASE
                                    WHEN LRType = 'Topay'
                                    THEN TotalLRAmount
                                    ELSE 0
                                END
                            ), 0) AS ToPayBusiness,

                            ISNULL(SUM(
                                CASE
                                    WHEN LRType = 'Paid'
                                    THEN TotalLRAmount
                                    ELSE 0
                                END
                            ), 0) AS PaidBusiness,

                            ISNULL(SUM(
                                CASE
                                    WHEN LRType = 'TBB'
                                    THEN TotalLRAmount
                                    ELSE 0
                                END
                            ), 0) AS TBBBusiness,

                            ISNULL(SUM(
                                DeliveryCharges
                            ), 0) AS DeliveryCharges

                        FROM [sqladmin].[DailyDeliveryDetails]

                        WHERE AccountID = @AccountID

                        AND CreatedDate >= @FromDate

                        AND CreatedDate < DATEADD(day, 1, @ToDate)";


                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@AccountID",
                            accountID);

                        cmd.Parameters.AddWithValue(
                            "@FromDate",
                            fromDate);

                        cmd.Parameters.AddWithValue(
                            "@ToDate",
                            toDate);


                        con.Open();


                        using (SqlDataReader reader =
                            cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                decimal toPay =
                                    Convert.ToDecimal(
                                        reader["ToPayBusiness"]);

                                decimal paid =
                                    Convert.ToDecimal(
                                        reader["PaidBusiness"]);

                                decimal tbb =
                                    Convert.ToDecimal(
                                        reader["TBBBusiness"]);

                                decimal delivery =
                                    Convert.ToDecimal(
                                        reader["DeliveryCharges"]);


                                lblUserToPay.Text =
                                    toPay.ToString("N2");

                                lblUserPaid.Text =
                                    paid.ToString("N2");

                                lblUserTBB.Text =
                                    tbb.ToString("N2");

                                lblUserDeliveryCharges.Text =
                                    delivery.ToString("N2");
                            }
                        }
                    }
                }


                lblUserAccountName.Text =
                    Session["Username"] != null
                        ? Session["Username"].ToString() + " Reports"
                        : "Account Reports";
            }
            catch (Exception ex)
            {
                ShowError(
                    "Error loading report: " +
                    ex.Message);
            }
        }


        private void LoadAdminReport(
      DateTime fromDate,
      DateTime toDate)
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
                    A.AccountID,
                    A.Username,

                    ISNULL(SUM(
                        CASE
                            WHEN D.LRType = 'Topay'
                            THEN D.TotalLRAmount
                            ELSE 0
                        END
                    ), 0) AS ToPayBusiness,

                    ISNULL(SUM(
                        CASE
                            WHEN D.LRType = 'paid'
                            THEN D.TotalLRAmount
                            ELSE 0
                        END
                    ), 0) AS PaidBusiness,

                    ISNULL(SUM(
                        CASE
                            WHEN D.LRType = 'TBB'
                            THEN D.TotalLRAmount
                            ELSE 0
                        END
                    ), 0) AS TBBBusiness,

                    ISNULL(SUM(
                        D.DeliveryCharges
                    ), 0) AS DeliveryCharges

                FROM [sqladmin].[Account] A

                LEFT JOIN [sqladmin].[DailyDeliveryDetails] D
                    ON A.AccountID = D.AccountID

                    AND D.CreatedDate >= @FromDate

                    AND D.CreatedDate < DATEADD(day, 1, @ToDate)

                WHERE A.AccountID IN (1, 2, 3,4)

                GROUP BY
                    A.AccountID,
                    A.Username

                ORDER BY
                    A.AccountID";


                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@FromDate",
                            fromDate);

                        cmd.Parameters.AddWithValue(
                            "@ToDate",
                            toDate);

                        con.Open();

                        decimal overallToPay = 0;
                        decimal overallPaid = 0;
                        decimal overallTBB = 0;
                        decimal overallDelivery = 0;


                        // Reset values first
                        lblNelloreToPay.Text = "0.00";
                        lblNellorePaid.Text = "0.00";
                        lblNelloreTBB.Text = "0.00";
                        lblNelloreDelivery.Text = "0.00";

                        lblKavaliToPay.Text = "0.00";
                        lblKavaliPaid.Text = "0.00";
                        lblKavaliTBB.Text = "0.00";
                        lblKavaliDelivery.Text = "0.00";

                        lblOngoleToPay.Text = "0.00";
                        lblOngolePaid.Text = "0.00";
                        lblOngoleTBB.Text = "0.00";
                        lblOngoleDelivery.Text = "0.00";


                        using (SqlDataReader reader =
                            cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int accountID =
                                    Convert.ToInt32(
                                        reader["AccountID"]);


                                decimal toPay =
                                    Convert.ToDecimal(
                                        reader["ToPayBusiness"]);

                                decimal paid =
                                    Convert.ToDecimal(
                                        reader["PaidBusiness"]);

                                decimal tbb =
                                    Convert.ToDecimal(
                                        reader["TBBBusiness"]);

                                decimal delivery =
                                    Convert.ToDecimal(
                                        reader["DeliveryCharges"]);


                                // Overall totals
                                overallToPay += toPay;
                                overallPaid += paid;
                                overallTBB += tbb;
                                overallDelivery += delivery;


                                // NELLORE
                                if (accountID == 1)
                                {
                                    lblNelloreToPay.Text =
                                        toPay.ToString("N2");

                                    lblNellorePaid.Text =
                                        paid.ToString("N2");

                                    lblNelloreTBB.Text =
                                        tbb.ToString("N2");

                                    lblNelloreDelivery.Text =
                                        delivery.ToString("N2");
                                }


                                // KAVALI
                                else if (accountID == 2)
                                {
                                    lblKavaliToPay.Text =
                                        toPay.ToString("N2");

                                    lblKavaliPaid.Text =
                                        paid.ToString("N2");

                                    lblKavaliTBB.Text =
                                        tbb.ToString("N2");

                                    lblKavaliDelivery.Text =
                                        delivery.ToString("N2");
                                }


                                // ONGOLE
                                else if (accountID == 3)
                                {
                                    lblOngoleToPay.Text =
                                        toPay.ToString("N2");

                                    lblOngolePaid.Text =
                                        paid.ToString("N2");

                                    lblOngoleTBB.Text =
                                        tbb.ToString("N2");

                                    lblOngoleDelivery.Text =
                                        delivery.ToString("N2");
                                }
                                // ONGOLE
                                
                            }
                        }


                        // OVERALL TOTAL
                        lblOverallToPay.Text =
                            overallToPay.ToString("N2");

                        lblOverallPaid.Text =
                            overallPaid.ToString("N2");

                        lblOverallTBB.Text =
                            overallTBB.ToString("N2");

                        lblOverallDelivery.Text =
                            overallDelivery.ToString("N2");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(
                    "Error loading Admin report: " +
                    ex.Message);
            }
        }


        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass =
                "message error";
        }
    }
}