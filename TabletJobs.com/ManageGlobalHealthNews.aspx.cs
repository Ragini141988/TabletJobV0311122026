using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ManageGlobalHealthNews : System.Web.UI.Page
    {
        string conStr = ConfigurationManager
            .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
            .ConnectionString;

        int PageSize = 6;

        int PageIndex
        {
            get { return ViewState["PageIndex"] == null ? 0 : (int)ViewState["PageIndex"]; }
            set { ViewState["PageIndex"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔒 ADMIN ONLY
            //if (Session["IsNews"] == null)
            //{
            //    Response.Redirect("LoginForGlobalHealthNews.aspx");
            //    return;
            //}


            if (!IsPostBack)
            {
                BindNews();
            }
        }

        void BindNews()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT NewsID, Topic, NewsContent
                      FROM GlobalHealthNews
                      WHERE IsActive = 1
                        AND (@Search = '' OR Topic LIKE '%' + @Search + '%')
                      ORDER BY NewsDate DESC
                      OFFSET @Offset ROWS FETCH NEXT @Size ROWS ONLY", con);

                cmd.Parameters.AddWithValue("@Search", txtSearch.Text.Trim());
                cmd.Parameters.AddWithValue("@Offset", PageIndex * PageSize);
                cmd.Parameters.AddWithValue("@Size", PageSize);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lvNews.DataSource = dt;
                lvNews.DataBind();
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            PageIndex = 0;
            BindNews();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageIndex++;
            BindNews();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (PageIndex > 0)
                PageIndex--;

            BindNews();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            //if (Session["IsNews"] == null)
            //{
            //    Response.Redirect("LoginForGlobalHealthNews.aspx");
            //    return;
            //}

            LinkButton btn = (LinkButton)sender;
            int newsId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE GlobalHealthNews SET IsActive = 0 WHERE NewsID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", newsId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // ✅ SHOW SUCCESS MESSAGE
            lblMessage.Text = "✔ News deleted successfully.";
            lblMessage.CssClass = "alert alert-success text-center";
            lblMessage.Visible = true;

            // Refresh list
            BindNews();
        }

    }
}
