using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TabletJobs.com
{
    public partial class tjtargetsreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

                LoadReport();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadReport();
        }

        private void LoadReport()
        {
            DateTime fromDate;
            DateTime toDate;

            if (!DateTime.TryParse(txtFromDate.Text, out fromDate))
            {
                return;
            }

            if (!DateTime.TryParse(txtToDate.Text, out toDate))
            {
                return;
            }

            if (fromDate > toDate)
            {
                lblTotal.Text = "0.00";
                lvReport.DataSource = null;
                lvReport.DataBind();
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
                .ConnectionString;

            string query = @"
                SELECT
                    ID,
                    BusinessDate,
                    AmountType,
                    Amount,
                    CollectedBy
                FROM TJTargets
                WHERE BusinessDate >= @FromDate
                AND BusinessDate <= @ToDate
            ";

            if (!string.IsNullOrEmpty(ddlPerson.SelectedValue))
            {
                query += " AND CollectedBy = @CollectedBy ";
            }

            query += " ORDER BY BusinessDate DESC, ID DESC";

            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FromDate", fromDate.Date);
                    cmd.Parameters.AddWithValue("@ToDate", toDate.Date);

                    if (!string.IsNullOrEmpty(ddlPerson.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CollectedBy",
                            ddlPerson.SelectedValue
                        );
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            lvReport.DataSource = dt;
            lvReport.DataBind();

            decimal total = 0;

            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["Amount"]);
            }

            lblTotal.Text = total.ToString("N2");
        }
    }
}