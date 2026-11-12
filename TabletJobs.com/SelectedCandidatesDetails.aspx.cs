using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class SelectedCandidatesDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Hospital"] != null && Request.QueryString["Date"] != null)
                {
                    string hospital = Request.QueryString["Hospital"].ToString();
                    string interviewDate = Request.QueryString["Date"].ToString();
                    LoadSelectedCandidates(hospital, interviewDate);
                }
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("OnlineInterviewJobs.aspx");
        }
        private void LoadSelectedCandidates(string hospital, string interviewDate)
        {
            string query = @"
        SELECT CandidateName, Gender, City ,coordinator,HospitalName,InterviewDate
        FROM dbo.InterviewResult 
        WHERE HospitalName = @Hospital AND InterviewDate = @InterviewDate";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Hospital", hospital);
                    cmd.Parameters.AddWithValue("@InterviewDate", DateTime.Parse(interviewDate));
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    ListView4.DataSource = dt;
                    ListView4.DataBind();
                    if (dt.Rows.Count > 0)
                    {
                        lblheaderMessage.Text = dt.Rows[0]["HospitalName"].ToString() + ", " + dt.Rows[0]["City"].ToString() + " | Interview Date: " + Convert.ToDateTime(dt.Rows[0]["InterviewDate"]).ToString("dd/MM/yyyy");
                    }
                }
            }
        }
        protected void ListView4_DataBound(object sender, EventArgs e)
        {
            if (ListView4.Items.Count > 0)
            {
                HiddenField hfCoordinator = (HiddenField)ListView4.Items[0].FindControl("hfCoordinator");
                if (hfCoordinator != null && !string.IsNullOrEmpty(hfCoordinator.Value))
                {
                    Label lblFooterMessage = (Label)ListView4.FindControl("lblFooterMessage");
                    if (lblFooterMessage != null)
                    {
                        lblFooterMessage.Text = "For Joining Process, Please Call " + hfCoordinator.Value;
                        lblheaderMessage.Text = "";
                    }
                }
            }
        }



    }
}