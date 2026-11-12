using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ViewHiringRequirements : System.Web.UI.Page
    {
        private readonly string _connectionString =
            ConfigurationManager
            .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
            .ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHiringRequirements();
            }
        }


        private void LoadHiringRequirements()
        {
            string query = @"
                SELECT
                    HiringRequirementID,
                    CompanyName,
                    JobTitle,
                    NumberOfVacancies,
                    JobLocation,
                    Status,
                    CreatedDate
                FROM EmployerHiringRequirements
                WHERE 1 = 1";


            DateTime fromDate;
            DateTime toDate;


            if (DateTime.TryParse(txtFromDate.Text, out fromDate))
            {
                query += " AND CreatedDate >= @FromDate";
            }


            if (DateTime.TryParse(txtToDate.Text, out toDate))
            {
                query += " AND CreatedDate < @ToDate";
            }


            query += " ORDER BY CreatedDate DESC";


            using (SqlConnection con =
                new SqlConnection(_connectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, con))
            {
                if (DateTime.TryParse(txtFromDate.Text, out fromDate))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.DateTime)
                        .Value = fromDate.Date;
                }


                if (DateTime.TryParse(txtToDate.Text, out toDate))
                {
                    // Include the complete To Date
                    cmd.Parameters.Add("@ToDate", SqlDbType.DateTime)
                        .Value = toDate.Date.AddDays(1);
                }


                using (SqlDataAdapter da =
                    new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    lvHiringRequirements.DataSource = dt;
                    lvHiringRequirements.DataBind();
                }
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;

            LoadHiringRequirements();
        }


        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = string.Empty;
            txtToDate.Text = string.Empty;

            pnlDetails.Visible = false;

            LoadHiringRequirements();
        }


        protected void lvHiringRequirements_ItemCommand(
        object sender,
        ListViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int hiringRequirementID;

                if (int.TryParse(
                    e.CommandArgument.ToString(),
                    out hiringRequirementID))
                {
                    LoadDetails(hiringRequirementID);
                }
            }
        }


        private void LoadDetails(int hiringRequirementID)
        {
            const string query = @"
                SELECT
                    HiringRequirementID,
                    CompanyName,
                    ContactPersonName,
                    MobileNumber,
                    EmailAddress,
                    CompanyLocation,
                    CompanyWebsite,
                    JobTitle,
                    NumberOfVacancies,
                    JobLocation,
                    WorkMode,
                    EmploymentType,
                    MinimumQualification,
                    ExperienceRequired,
                    RequiredSkills,
                    LanguagesRequired,
                    AgeRequirement,
                    MinimumSalary,
                    MaximumSalary,
                    IncentivesAvailable,
                    OtherBenefits,
                    PreferredInterviewMode,
                    ExpectedInterviewDate,
                    ExpectedCandidatesToInterview,
                    InterviewProcess,
                    InterviewInstructions,
                    JobDescription,
                    InformationConfirmed,
                    TermsAccepted,
                    Status,
                    CreatedDate
                FROM EmployerHiringRequirements
                WHERE HiringRequirementID = @HiringRequirementID";


            using (SqlConnection con =
                new SqlConnection(_connectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@HiringRequirementID",
                    SqlDbType.Int).Value = hiringRequirementID;

                con.Open();

                using (SqlDataReader reader =
                    cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblID.Text =
                            GetValue(reader, "HiringRequirementID");

                        lblStatus.Text =
                            GetValue(reader, "Status");

                        lblCreatedDate.Text =
                            FormatDate(reader, "CreatedDate");


                        // COMPANY
                        lblCompanyName.Text =
                            GetValue(reader, "CompanyName");

                        lblContactPerson.Text =
                            GetValue(reader, "ContactPersonName");

                        lblMobile.Text =
                            GetValue(reader, "MobileNumber");

                        lblEmail.Text =
                            GetValue(reader, "EmailAddress");

                        lblCompanyLocation.Text =
                            GetValue(reader, "CompanyLocation");

                        lblWebsite.Text =
                            GetValue(reader, "CompanyWebsite");


                        // JOB
                        lblJobTitle.Text =
                            GetValue(reader, "JobTitle");

                        lblVacancies.Text =
                            GetValue(reader, "NumberOfVacancies");

                        lblJobLocation.Text =
                            GetValue(reader, "JobLocation");

                        lblWorkMode.Text =
                            GetValue(reader, "WorkMode");

                        lblEmploymentType.Text =
                            GetValue(reader, "EmploymentType");


                        // REQUIREMENTS
                        lblQualification.Text =
                            GetValue(reader, "MinimumQualification");

                        lblExperience.Text =
                            GetValue(reader, "ExperienceRequired");

                        lblSkills.Text =
                            GetValue(reader, "RequiredSkills");

                        lblLanguages.Text =
                            GetValue(reader, "LanguagesRequired");

                        lblAge.Text =
                            GetValue(reader, "AgeRequirement");

                        lblMinSalary.Text =
                            GetValue(reader, "MinimumSalary");

                        lblMaxSalary.Text =
                            GetValue(reader, "MaximumSalary");

                        lblIncentives.Text =
                            GetValue(reader, "IncentivesAvailable");

                        lblBenefits.Text =
                            GetValue(reader, "OtherBenefits");


                        // INTERVIEW
                        lblInterviewMode.Text =
                            GetValue(reader, "PreferredInterviewMode");

                        lblInterviewDate.Text =
                            FormatDate(reader, "ExpectedInterviewDate");

                        lblCandidates.Text =
                            GetValue(reader, "ExpectedCandidatesToInterview");

                        lblInterviewProcess.Text =
                            GetValue(reader, "InterviewProcess");


                        // DESCRIPTION
                        lblJobDescription.Text =
                            GetValue(reader, "JobDescription");

                        lblInterviewInstructions.Text =
                            GetValue(reader, "InterviewInstructions");


                        pnlDetails.Visible = true;
                    }
                    else
                    {
                        pnlDetails.Visible = false;

                        ShowAlert(
                            "Hiring requirement not found.");
                    }
                }
            }
        }


        private string GetValue(
            SqlDataReader reader,
            string columnName)
        {
            if (reader[columnName] == DBNull.Value)
                return "-";

            return Server.HtmlEncode(
                Convert.ToString(reader[columnName]));
        }


        private string FormatDate(
            SqlDataReader reader,
            string columnName)
        {
            if (reader[columnName] == DBNull.Value)
                return "-";

            DateTime date;

            if (DateTime.TryParse(
                reader[columnName].ToString(),
                out date))
            {
                return date.ToString("dd-MM-yyyy");
            }

            return "-";
        }


        private void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                Guid.NewGuid().ToString("N"),
                "alert('" +
                message.Replace("'", "\\'") +
                "');",
                true);
        }
    }
}