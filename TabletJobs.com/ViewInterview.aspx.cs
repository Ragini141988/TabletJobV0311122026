using System;
using System.Data.SqlClient;
using System.Configuration;

namespace TabletJobs.com
{
    public partial class ViewInterview : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                LoadData(id);

               // editLink.HRef = "EditInterview.aspx?id=" + id;
            }
        }

        private void LoadData(int id)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM JobPostInternal WHERE JOBID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTitle.Text = dr["JTitle"].ToString();
                    lblHospital.Text = dr["hname"].ToString();
                    lblCity.Text = dr["hcity"].ToString();
                    lblExp.Text = dr["Jexp"].ToString();
                    lblSalary.Text = dr["Jsal"].ToString();
                    lblDate.Text = Convert.ToDateTime(dr["InterviewDate"]).ToString("dd MMM yyyy");
                    lblDesc.Text = dr["Jdesc"].ToString();
                }
            }
        }
    }
}