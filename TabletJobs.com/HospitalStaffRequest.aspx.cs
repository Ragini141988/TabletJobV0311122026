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
    public partial class HospitalStaffRequest : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadCategories();
            }
            if (!IsPostBack && Request.QueryString["Id"] != null)
            {
                LoadData();
            }
        }
        void LoadData()
        {
            string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM HospitalStaffRequest WHERE Id=@Id", con);
                cmd.Parameters.AddWithValue("@Id", Request.QueryString["Id"]);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtHospital.Text = dr["HospitalName"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtContact.Text = dr["ContactPerson"].ToString();
                    txtMobile.Text = dr["Mobile"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    ddlStaff.SelectedValue = dr["StaffRequired"].ToString();
                    txtMessage.Text = dr["Message"].ToString();
                }
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    string query = "";
                    SqlCommand cmd;
                    if (Request.QueryString["Id"] != null && int.TryParse(Request.QueryString["Id"], out int id))
                    {
                        query = @"UPDATE HospitalStaffRequest SET
              HospitalName=@Hospital, City=@City, ContactPerson=@Contact,
              Mobile=@Mobile, Email=@Email, StaffRequired=@Staff, Message=@Message
              WHERE Id=@Id";

                        cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Id", id);
                    }
                    else
                    {
                        query = @"INSERT INTO HospitalStaffRequest
              (HospitalName, City, ContactPerson, Mobile, Email, StaffRequired, Message)
              VALUES (@Hospital, @City, @Contact, @Mobile, @Email, @Staff, @Message)";

                        cmd = new SqlCommand(query, con);
                    }

                    cmd.Parameters.AddWithValue("@Hospital", txtHospital.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contact", txtContact.Text.Trim());
                    cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Staff", ddlStaff.SelectedValue);
                    cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // ✅ Success message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Request submitted successfully');", true);

                // ✅ Clear controls after save
                ClearControls();
            }
            catch (Exception ex)
            {
                // ❌ Error message (for debugging or log)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "err", "alert('Something went wrong!');", true);

                // Optional: log error
                // System.IO.File.AppendAllText(Server.MapPath("~/ErrorLog.txt"), ex.ToString());
            }
        }
        private void ClearControls()
        {
            txtHospital.Text = "";
            txtCity.Text = "";
            txtContact.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";
            ddlStaff.SelectedIndex = 0;
        }
        private void LoadCategories()
        {
            ddlStaff.Items.Clear();
            ddlStaff.Items.Add(new ListItem("-- Select Category --", ""));

            const string query = "SELECT CategoryID, CategoryName FROM JobCategories ORDER BY ISNULL(ordercolumn, CategoryID)";
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
                            ddlStaff.Items.Add(new ListItem(
                                Convert.ToString(reader["CategoryName"]),
                                Convert.ToString(reader["CategoryID"])));
                        }
                    }
                }
            }
            catch
            {
                ddlStaff.Items.Add(new ListItem("Nurse", "1"));
                ddlStaff.Items.Add(new ListItem("Doctor", "2"));
                ddlStaff.Items.Add(new ListItem("Technician", "3"));
                ddlStaff.Items.Add(new ListItem("Pharmacist", "4"));
            }
        }
    }
}