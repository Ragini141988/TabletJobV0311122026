using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com
{
    public partial class CandidateRegistrationForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            decimal salary;

            if (!decimal.TryParse(txtPresentSalary.Text.Trim(), out salary))
            {
                lblMessage.Text = "Please enter a valid salary.";
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
                .ConnectionString;

            string query = @"
                INSERT INTO CandidateRegistration
                (
                    CandidateName,
                    Gender,
                    Qualification,
                    Experience,
                    PresentSalary,
                    PresentCity,
                    State,
                    ContactNumber,
                    EmailID,
                    CreatedDate
                )
                VALUES
                (
                    @CandidateName,
                    @Gender,
                    @Qualification,
                    @Experience,
                    @PresentSalary,
                    @PresentCity,
                    @State,
                    @ContactNumber,
                    @EmailID,
                    GETDATE()
                )";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@CandidateName",
                        txtCandidateName.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@Gender",
                        ddlGender.SelectedValue);

                    cmd.Parameters.AddWithValue(
                        "@Qualification",
                        ddlQualification.SelectedValue);

                    cmd.Parameters.AddWithValue(
                        "@Experience",
                        ddlExperience.SelectedValue);

                    cmd.Parameters.AddWithValue(
                        "@PresentSalary",
                        salary);

                    cmd.Parameters.AddWithValue(
                        "@PresentCity",
                        txtPresentCity.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@State",
                        ddlState.SelectedValue);

                    cmd.Parameters.AddWithValue(
                        "@ContactNumber",
                        txtContactNumber.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@EmailID",
                        txtEmailID.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Candidate registered successfully.";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.BackColor = System.Drawing.Color.Honeydew;

            ClearForm();
        }

        private void ClearForm()
        {
            txtCandidateName.Text = "";
            ddlGender.SelectedIndex = 0;
            ddlQualification.SelectedIndex = 0;
            ddlExperience.SelectedIndex = 0;
            txtPresentSalary.Text = "";
            txtPresentCity.Text = "";
            ddlState.SelectedIndex = 0;
            txtContactNumber.Text = "";
            txtEmailID.Text = "";
        }
    }
}