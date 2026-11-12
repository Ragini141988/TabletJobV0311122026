using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class CandidateList : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidates();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            using (SqlConnection con =
                new SqlConnection(_connectionString))
            {
                string sql =
        @"SELECT *
FROM CandidateMaster
WHERE IsActive=1
AND
(
FullName LIKE '%' + @Search + '%'
OR MobileNumber LIKE '%' + @Search + '%'
)";

                SqlCommand cmd =
                    new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue(
                    "@Search",
                    txtSearch.Text.Trim());

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                System.Data.DataTable dt =
                    new DataTable();

                da.Fill(dt);

                lvCandidates.DataSource = dt;
                lvCandidates.DataBind();
            }
        }
        protected void btnDelete_Click(
object sender,
EventArgs e)
        {
            LinkButton btn =
                (LinkButton)sender;

            int id =
                Convert.ToInt32(
                btn.CommandArgument);

            using (SqlConnection con =
                new SqlConnection(_connectionString))
            {
                SqlCommand cmd =
                new SqlCommand(
        @"UPDATE CandidateMaster
SET IsActive=0,
UpdatedAt=GETDATE()
WHERE CandidateID=@ID", con);

                cmd.Parameters.AddWithValue(
                    "@ID",
                    id);

                con.Open();

                cmd.ExecuteNonQuery();
            }

            LoadCandidates();
        }
        private void LoadCandidates()
        {
            using (SqlConnection con =
                new SqlConnection(_connectionString))
            {
                string sql =
        @"SELECT CandidateID,
CandidateCode,
FullName,
MobileNumber,
CurrentCity,
CandidateStatus
FROM CandidateMaster
WHERE IsActive=1
ORDER BY CandidateID DESC";

                SqlDataAdapter da =
                    new SqlDataAdapter(sql, con);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                lvCandidates.DataSource = dt;
                lvCandidates.DataBind();
            }
        }
    }
}