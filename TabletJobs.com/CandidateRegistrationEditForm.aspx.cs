using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TabletJobs.com
{
    public partial class CandidateRegistrationEditForm : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidate();
            }
        }

        private void LoadCandidate()
        {
            int candidateID;

            if (!int.TryParse(Request.QueryString["id"], out candidateID))
            {
                lblMessage.Text = "Invalid candidate ID.";
                return;
            }

            string query = @"
                SELECT
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
                WHERE CandidateID = @CandidateID";

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CandidateID", candidateID);

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            txtCandidateName.Text =
                                dr["CandidateName"].ToString();

                            ddlGender.SelectedValue =
                                dr["Gender"].ToString();

                            ddlQualification.SelectedValue =
                                dr["Qualification"].ToString();

                            ddlExperience.SelectedValue =
                                dr["Experience"].ToString();

                            txtPresentSalary.Text =
                                dr["PresentSalary"].ToString();

                            txtPresentCity.Text =
                                dr["PresentCity"].ToString();

                            ddlState.SelectedValue =
                                dr["State"].ToString();

                            txtContactNumber.Text =
                                dr["ContactNumber"].ToString();

                            txtEmailID.Text =
                                dr["EmailID"].ToString();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Candidate not found.";

                            btnUpdate.Enabled = false;
                        }
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            int candidateID;

            if (!int.TryParse(Request.QueryString["id"], out candidateID))
            {
                lblMessage.Text = "Invalid candidate ID.";
                return;
            }

            decimal salary;

            if (!decimal.TryParse(
                txtPresentSalary.Text.Trim(),
                out salary))
            {
                lblMessage.Text =
                    "Please enter a valid salary.";

                return;
            }

            string query = @"
                UPDATE CandidateRegistration
                SET
                    CandidateName = @CandidateName,
                    Gender = @Gender,
                    Qualification = @Qualification,
                    Experience = @Experience,
                    PresentSalary = @PresentSalary,
                    PresentCity = @PresentCity,
                    State = @State,
                    ContactNumber = @ContactNumber,
                    EmailID = @EmailID
                WHERE CandidateID = @CandidateID";

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@CandidateID",
                        candidateID);

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

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text =
                            "Candidate updated successfully.";

                        lblMessage.ForeColor =
                            System.Drawing.Color.Green;

                        lblMessage.BackColor =
                            System.Drawing.Color.Honeydew;
                    }
                    else
                    {
                        lblMessage.Text =
                            "Candidate could not be updated.";
                    }
                }
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("CandidateRegistrationViewForm.aspx");
        }
    }
}