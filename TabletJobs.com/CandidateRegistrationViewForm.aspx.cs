using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class CandidateRegistrationViewForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidates();
            }
        }

        private void LoadCandidates()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
                .ConnectionString;

            string query = @"
                SELECT
                    CandidateID,
                    CandidateName,
                    Gender,
                    Qualification,
                    Experience,
                    PresentSalary,
                    PresentCity,
                    State,
                    ContactNumber,
                    EmailID
                FROM CandidateRegistration
                ORDER BY CandidateID DESC";

            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            lvCandidates.DataSource = dt;
            lvCandidates.DataBind();
        }
        protected void lvCandidates_PagePropertiesChanging(
            object sender,
            PagePropertiesChangingEventArgs e)
        {
            dpCandidates.SetPageProperties(
                e.StartRowIndex,
                e.MaximumRows,
                false);

            LoadCandidates();
        }
    }
}