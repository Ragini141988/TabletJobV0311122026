using System;
using System.Data.SqlClient;
using System.Configuration;

namespace TabletJobs.com
{
    public partial class EditInterview : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                LoadData(id);
            }
        }

        private void LoadData(int id)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM JobPostInternal WHERE ID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    TxtTitle.Text = dr["JTitle"].ToString();
                    TxtHospital.Text = dr["hname"].ToString();
                    TxtCity.Text = dr["hcity"].ToString();
                    TxtExp.Text = dr["Jexp"].ToString();
                    TxtSalary.Text = dr["Jsal"].ToString();
                    TxtDate.Text = Convert.ToDateTime(dr["InterviewDate"]).ToString("yyyy-MM-dd");
                    TxtDesc.Text = dr["Jdesc"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                UPDATE JobPostInternal SET
                JTitle=@Title,
                hname=@Hospital,
                hcity=@City,
                Jexp=@Exp,
                Jsal=@Salary,
                InterviewDate=@Date,
                Jdesc=@Desc
                WHERE ID=@ID", con);

                cmd.Parameters.AddWithValue("@Title", TxtTitle.Text);
                cmd.Parameters.AddWithValue("@Hospital", TxtHospital.Text);
                cmd.Parameters.AddWithValue("@City", TxtCity.Text);
                cmd.Parameters.AddWithValue("@Exp", TxtExp.Text);
                cmd.Parameters.AddWithValue("@Salary", TxtSalary.Text);
                cmd.Parameters.AddWithValue("@Date", Convert.ToDateTime(TxtDate.Text));
                cmd.Parameters.AddWithValue("@Desc", TxtDesc.Text);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageInterview.aspx");
        }
    }
}