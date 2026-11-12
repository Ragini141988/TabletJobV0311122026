using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class CandidateView : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidate();
            }
        }
       
private void LoadCandidate()
        {
            int candidateId =
                Convert.ToInt32(Request.QueryString["id"]);

            using (SqlConnection con =
                new SqlConnection(_connectionString))
            {
                SqlCommand cmd =
new SqlCommand(@"
SELECT
    C.*,
    JC.CategoryName,
    JS.SubCategoryName
FROM CandidateMaster C
LEFT JOIN Karim.JobCategories JC
    ON C.CandidateCategory = JC.CategoryID
LEFT JOIN Karim.JobSubCategories JS
    ON C.Department = JS.SubCategoryID
WHERE C.CandidateId=@Id", con);

                cmd.Parameters.AddWithValue("@Id", candidateId);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblCandidateCode.Text = dr["CandidateCode"].ToString();
                    lblFullName.Text = dr["FullName"].ToString();
                    lblGender.Text = dr["Gender"].ToString();
                    lblDOB.Text = Convert.ToString(dr["DateOfBirth"]);
                    lblAge.Text = dr["Age"].ToString();

                    lblMobile.Text = dr["MobileNumber"].ToString();
                    lblAltMobile.Text = dr["AlternateMobileNumber"].ToString();
                    lblWhatsApp.Text = dr["WhatsAppNumber"].ToString();
                    lblEmail.Text = dr["Email"].ToString();

                    lblCurrentCity.Text = dr["CurrentCity"].ToString();
                    lblCurrentState.Text = dr["CurrentState"].ToString();

                    lblNativePlace.Text = dr["NativePlace"].ToString();
                    lblNativeState.Text = dr["NativeState"].ToString();

                    lblCurrentAddress.Text = dr["CurrentAddress"].ToString();
                    lblPermanentAddress.Text = dr["PermanentAddress"].ToString();

                    lblPincode.Text = dr["Pincode"].ToString();

                    lblCategory.Text =
dr["CategoryName"].ToString();

                    lblDepartment.Text =
                    dr["SubCategoryName"].ToString();

                    lblDesignation.Text = dr["Designation"].ToString();

                    lblQualification.Text = dr["Qualification"].ToString();
                    lblSpecialization.Text = dr["Specialization"].ToString();

                    lblExperience.Text = dr["TotalExperienceYears"].ToString();
                    lblEmployer.Text = dr["CurrentEmployer"].ToString();

                    lblCurrentSalary.Text = dr["CurrentSalary"].ToString();
                    lblExpectedSalary.Text = dr["ExpectedSalary"].ToString();

                    lblNoticePeriod.Text = dr["NoticePeriod"].ToString();
                    lblPreferredLocation.Text = dr["PreferredLocation"].ToString();

                    lblCandidateStatus.Text = dr["CandidateStatus"].ToString();
                    lblVerificationStatus.Text = dr["VerificationStatus"].ToString();

                    lblSource.Text = dr["Source"].ToString();
                    lblRecruiter.Text = dr["AssignedRecruiter"].ToString();

                    lblLastContacted.Text = Convert.ToString(dr["LastContactedAt"]);
                    lblNextFollowup.Text = Convert.ToString(dr["NextFollowUpAt"]);

                    lblRemarks.Text = dr["InternalRemarks"].ToString();

                    lblCreatedAt.Text = Convert.ToString(dr["CreatedAt"]);
                    lblUpdatedAt.Text = Convert.ToString(dr["UpdatedAt"]);

                    imgPhoto.ImageUrl = dr["PhotoFileUrl"].ToString();

                    lnkResume.NavigateUrl =
                        dr["ResumeFileUrl"].ToString();

                    lnkCertificate.NavigateUrl =
                        dr["CertificateFileUrl"].ToString();

                    lnkAadhaar.NavigateUrl =
                        dr["AadhaarFileUrl"].ToString();
                }
            }
        }


    }
}