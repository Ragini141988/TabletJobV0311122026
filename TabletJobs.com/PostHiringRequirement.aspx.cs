using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class PostHiringRequirement : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager
            .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // No initial database loading is required for this page.
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        protected void cvInformationConfirmed_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkInformationConfirmed.Checked;
        }

        protected void cvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkTerms.Checked;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblInformationError.Visible = false;
            lblTermsError.Visible = false;

            bool isValid = true;

            // Confirmation checkbox
            if (!chkInformationConfirmed.Checked)
            {
                lblInformationError.Visible = true;
                isValid = false;
            }

            // Terms checkbox
            if (!chkTerms.Checked)
            {
                lblTermsError.Visible = true;
                isValid = false;
            }
            // Stop here if confirmation is missing
            if (!isValid)
            {
                return;
            }

            Page.Validate("HiringForm");

            if (!Page.IsValid)
            {
                ShowAlert("Please fill all required fields and correct the highlighted errors.");
                return;
            }

            try
            {
                if (!ValidateSalaryRange())
                    return;

                DateTime? expectedInterviewDate = null;
                DateTime parsedDate;

                if (!string.IsNullOrWhiteSpace(txtInterviewDate.Text))
                {
                    if (!DateTime.TryParse(txtInterviewDate.Text, out parsedDate))
                    {
                        ShowAlert("Please select a valid Expected Interview Date.");
                        return;
                    }

                    expectedInterviewDate = parsedDate.Date;
                }

                int vacancies;
                if (!int.TryParse(txtVacancies.Text.Trim(), out vacancies) || vacancies < 1)
                {
                    ShowAlert("Please enter a valid Number of Vacancies.");
                    return;
                }

                int? expectedCandidates = null;
                int candidateCount;
                if (!string.IsNullOrWhiteSpace(txtCandidates.Text))
                {
                    if (!int.TryParse(txtCandidates.Text.Trim(), out candidateCount) || candidateCount < 1)
                    {
                        ShowAlert("Please enter a valid Expected Number of Candidates to Interview.");
                        return;
                    }

                    expectedCandidates = candidateCount;
                }

                decimal? minimumSalary = ParseSalary(txtMinSalary.Text);
                decimal? maximumSalary = ParseSalary(txtMaxSalary.Text);

                string interviewProcess = string.Join(" / ",
                    cblInterviewProcess.Items.Cast<ListItem>()
                        .Where(item => item.Selected)
                        .Select(item => item.Text));

                const string query = @"
INSERT INTO EmployerHiringRequirements
(
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
)
VALUES
(
    @CompanyName,
    @ContactPersonName,
    @MobileNumber,
    @EmailAddress,
    @CompanyLocation,
    @CompanyWebsite,
    @JobTitle,
    @NumberOfVacancies,
    @JobLocation,
    @WorkMode,
    @EmploymentType,
    @MinimumQualification,
    @ExperienceRequired,
    @RequiredSkills,
    @LanguagesRequired,
    @AgeRequirement,
    @MinimumSalary,
    @MaximumSalary,
    @IncentivesAvailable,
    @OtherBenefits,
    @PreferredInterviewMode,
    @ExpectedInterviewDate,
    @ExpectedCandidatesToInterview,
    @InterviewProcess,
    @InterviewInstructions,
    @JobDescription,
    @InformationConfirmed,
    @TermsAccepted,
    @Status,
    GETDATE()
);
SELECT CAST(SCOPE_IDENTITY() AS INT);";

                int hiringRequirementId;

                using (SqlConnection con = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    AddStringParameter(cmd, "@CompanyName", txtCompanyName.Text, 200);
                    AddStringParameter(cmd, "@ContactPersonName", txtContactPerson.Text, 150);
                    AddStringParameter(cmd, "@MobileNumber", txtMobile.Text, 20);
                    AddStringParameter(cmd, "@EmailAddress", txtEmail.Text, 200);
                    AddStringParameter(cmd, "@CompanyLocation", txtCompanyLocation.Text, 200);
                    AddStringParameter(cmd, "@CompanyWebsite", txtWebsite.Text, 300);
                    AddStringParameter(cmd, "@JobTitle", ddlJobTitle.SelectedValue, 200);
                    cmd.Parameters.Add("@NumberOfVacancies", SqlDbType.Int).Value = vacancies;
                    AddStringParameter(cmd, "@JobLocation", txtJobLocation.Text, 300);
                    AddStringParameter(cmd, "@WorkMode", rblWorkMode.SelectedValue, 50);
                    AddStringParameter(cmd, "@EmploymentType", rblEmploymentType.SelectedValue, 50);
                    AddStringParameter(cmd, "@MinimumQualification", ddlQualification.SelectedValue, 150);
                    AddStringParameter(cmd, "@ExperienceRequired", rblExperience.SelectedValue, 100);
                    AddStringParameter(cmd, "@RequiredSkills", txtSkills.Text, 1000);
                    AddStringParameter(cmd, "@LanguagesRequired", txtLanguages.Text, 500);
                    AddStringParameter(cmd, "@AgeRequirement", txtAge.Text, 100);
                    AddDecimalParameter(cmd, "@MinimumSalary", minimumSalary);
                    AddDecimalParameter(cmd, "@MaximumSalary", maximumSalary);
                    AddStringParameter(cmd, "@IncentivesAvailable", rblIncentives.SelectedValue, 10);
                    AddStringParameter(cmd, "@OtherBenefits", txtBenefits.Text, 1000);
                    AddStringParameter(cmd, "@PreferredInterviewMode", rblInterviewMode.SelectedValue, 100);

                    SqlParameter dateParam = cmd.Parameters.Add("@ExpectedInterviewDate", SqlDbType.Date);
                    dateParam.Value = expectedInterviewDate.HasValue
                        ? (object)expectedInterviewDate.Value
                        : DBNull.Value;

                    SqlParameter candidatesParam = cmd.Parameters.Add("@ExpectedCandidatesToInterview", SqlDbType.Int);
                    candidatesParam.Value = expectedCandidates.HasValue
                        ? (object)expectedCandidates.Value
                        : DBNull.Value;

                    AddStringParameter(cmd, "@InterviewProcess", interviewProcess, 500);
                    AddStringParameter(cmd, "@InterviewInstructions", txtInterviewInstructions.Text, -1);
                    AddStringParameter(cmd, "@JobDescription", txtJobDescription.Text, -1);
                    cmd.Parameters.Add("@InformationConfirmed", SqlDbType.Bit).Value = chkInformationConfirmed.Checked;
                    cmd.Parameters.Add("@TermsAccepted", SqlDbType.Bit).Value = chkTerms.Checked;
                    AddStringParameter(cmd, "@Status", "Pending", 50);

                    con.Open();
                    hiringRequirementId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                if (hiringRequirementId > 0)
                {
                    ShowAlert("Your hiring requirement has been submitted successfully. Reference ID: " + hiringRequirementId);
                    ResetForm();
                }
                else
                {
                    ShowAlert("Unable to submit the hiring requirement. Please try again.");
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error while submitting: " + ex.Message.Replace("'", ""));
            }
        }

        private bool ValidateSalaryRange()
        {
            decimal? minimumSalary = ParseSalary(txtMinSalary.Text);
            decimal? maximumSalary = ParseSalary(txtMaxSalary.Text);

            if (!string.IsNullOrWhiteSpace(txtMinSalary.Text) && !minimumSalary.HasValue)
            {
                ShowAlert("Please enter a valid Minimum Salary.");
                return false;
            }

            if (!string.IsNullOrWhiteSpace(txtMaxSalary.Text) && !maximumSalary.HasValue)
            {
                ShowAlert("Please enter a valid Maximum Salary.");
                return false;
            }

            if (minimumSalary.HasValue && maximumSalary.HasValue && maximumSalary.Value < minimumSalary.Value)
            {
                ShowAlert("Maximum Salary cannot be less than Minimum Salary.");
                return false;
            }

            return true;
        }

        private static decimal? ParseSalary(string value)
        {
            decimal salary;

            if (string.IsNullOrWhiteSpace(value))
                return null;

            if (decimal.TryParse(value.Trim(), out salary) && salary >= 0)
                return salary;

            return null;
        }

        private static void AddStringParameter(SqlCommand cmd, string name, string value, int size)
        {
            SqlParameter parameter;

            if (size == -1)
                parameter = cmd.Parameters.Add(name, SqlDbType.VarChar, -1);
            else
                parameter = cmd.Parameters.Add(name, SqlDbType.VarChar, size);

            parameter.Value = string.IsNullOrWhiteSpace(value)
                ? (object)DBNull.Value
                : value.Trim();
        }

        private static void AddDecimalParameter(SqlCommand cmd, string name, decimal? value)
        {
            SqlParameter parameter = cmd.Parameters.Add(name, SqlDbType.Decimal);
            parameter.Precision = 12;
            parameter.Scale = 2;
            parameter.Value = value.HasValue ? (object)value.Value : DBNull.Value;
        }

        private void ResetForm()
        {
            txtCompanyName.Text = string.Empty;
            txtContactPerson.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtCompanyLocation.Text = string.Empty;
            txtWebsite.Text = string.Empty;
            ddlJobTitle.SelectedIndex = 0;
            txtVacancies.Text = string.Empty;
            txtJobLocation.Text = string.Empty;
            rblWorkMode.ClearSelection();
            rblEmploymentType.ClearSelection();
            ddlQualification.SelectedIndex = 0;
            rblExperience.ClearSelection();
            txtSkills.Text = string.Empty;
            txtLanguages.Text = string.Empty;
            txtAge.Text = string.Empty;
            txtMinSalary.Text = string.Empty;
            txtMaxSalary.Text = string.Empty;
            rblIncentives.ClearSelection();
            txtBenefits.Text = string.Empty;
            rblInterviewMode.ClearSelection();
            txtInterviewDate.Text = string.Empty;
            txtCandidates.Text = string.Empty;
            cblInterviewProcess.ClearSelection();
            txtInterviewInstructions.Text = string.Empty;
            txtJobDescription.Text = string.Empty;
            chkInformationConfirmed.Checked = false;
            chkTerms.Checked = false;
        }

        private void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                Guid.NewGuid().ToString("N"),
                "alert('" + message.Replace("'", "\\'") + "');",
                true);
        }
        private void LoadCategories()
        {
            ddlJobTitle.Items.Clear();
            ddlJobTitle.Items.Add(new ListItem("-- Select Category --", ""));

            const string query = "SELECT CategoryID, CategoryName FROM JobCategoriesNew ORDER BY ISNULL(ordercolumn, CategoryID)";
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlJobTitle.Items.Add(new ListItem(
                                Convert.ToString(reader["CategoryName"]),
                                Convert.ToString(reader["CategoryID"])));
                        }
                    }
                }
            }
            catch
            {
                ddlJobTitle.Items.Add(new ListItem("Nurse", "1"));
                ddlJobTitle.Items.Add(new ListItem("Doctor", "2"));
                ddlJobTitle.Items.Add(new ListItem("Technician", "3"));
                ddlJobTitle.Items.Add(new ListItem("Pharmacist", "4"));
            }
        }
    }
}
