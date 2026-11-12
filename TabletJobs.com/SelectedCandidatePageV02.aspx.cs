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
    public partial class SelectedCandidatePageV02 : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var cities = new List<string>
        {
                    "Select City",
            "Bangalore",
            "Mumbai",
            "Navi Mumbai",
            "Pune",
            "Hyderabad",
            "Chennai",
            "Gurgaon",
            "Noida",
            "Delhi",
            "Delhi NCR",
            "Kolkata",
            "Visakhapatnam",
            "Vijayawada",
            "Mangalore",
            "Kochi",
            "Trivandrum",
            "Coimbatore",
            "Surat",
            "Ahmedabad",
            "Raipur",
            "Patna",
            "Bhubaneswar",
            "New Delhi",
            "Chandigarh",
            "Lucknow",
            "Nagpur",
            "Gwalior",
            "Jabalpur",
            "Sambalpur Odisha"
        };

                // Bind cities to dropdown
                foreach (var city in cities)
                {
                    ddlCities.Items.Add(new ListItem(city, city));
                }
            }
        }



        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid == true)
            {
                // Get the values from the form fields
                string serialNo = Txtsrno.Text;
                string hospitalName = Txtnm.Text;
                string interviewDate = InterviewDate.Text;
                string candidateName = Txtcname.Text;
                string gender = Drpgen.SelectedValue;
                string coordinator = drpcoordinator.SelectedValue;
                // Log the form data to check if the values are being retrieved correctly
                System.Diagnostics.Debug.WriteLine($"SerialNo: {serialNo}");
                System.Diagnostics.Debug.WriteLine($"HospitalName: {hospitalName}");
                System.Diagnostics.Debug.WriteLine($"InterviewDate: {interviewDate}");
                System.Diagnostics.Debug.WriteLine($"CandidateName: {candidateName}");
                System.Diagnostics.Debug.WriteLine($"Gender: {gender}");

                // SQL query to insert the data
                string query = "INSERT INTO dbo.InterviewResult (SerialNo, HospitalName, InterviewDate, CandidateName, Gender,city,coordinator) " +
                               "VALUES (@SerialNo, @HospitalName, @InterviewDate, @CandidateName, @Gender,@city,@coordinator)";

                // Using the class-level connection string to create a connection
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@SerialNo", serialNo);
                    cmd.Parameters.AddWithValue("@HospitalName", hospitalName);
                    cmd.Parameters.AddWithValue("@InterviewDate", interviewDate);
                    cmd.Parameters.AddWithValue("@CandidateName", candidateName);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@city", ddlCities.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@coordinator", drpcoordinator.SelectedValue.ToString());

                    try
                    {
                        // Open the connection
                        conn.Open();

                        // Execute the insert command
                        int rowsAffected = cmd.ExecuteNonQuery();

                        // Check if any rows were inserted
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Data inserted successfully!";
                            Response.Redirect("viewselectedcandidatesummaryV02.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "No data was inserted.";
                        }
                    }
                    catch (SqlException ex)
                    {
                        // Log the error details to help identify the issue
                        lblMessage.Text = "SQL Error: " + ex.Message;
                        System.Diagnostics.Debug.WriteLine("SQL Error: " + ex.Message);
                    }
                    catch (Exception ex)
                    {
                        // Log the error details for general exceptions
                        lblMessage.Text = "Error: " + ex.Message;
                        System.Diagnostics.Debug.WriteLine("General Error: " + ex.Message);
                    }
                }
            }
        }
    }
}