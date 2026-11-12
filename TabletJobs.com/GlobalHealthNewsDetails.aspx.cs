using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class GlobalHealthNewsDetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["NewsID"] != null)
            {
                LoadDetails();
            }
        }

        private void LoadDetails()
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT Topic, NewsContent, NewsDate FROM GlobalHealthNews WHERE NewsID=@ID", con);
            cmd.Parameters.AddWithValue("@ID", Request.QueryString["NewsID"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblTopic.Text = dr["Topic"].ToString();
                lblContent.Text = dr["NewsContent"].ToString();
                //lblDate.Text = Convert.ToDateTime(dr["NewsDate"]).ToString("dd MMM yyyy");
            }
            con.Close();
        }

    }
}