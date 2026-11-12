using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

namespace TabletJobs.com
{
    public partial class EditGlobalHealthNews : System.Web.UI.Page
    {
        string conStr = ConfigurationManager
            .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
            .ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // POINT 3 — ADMIN ONLY
       

        if (!IsPostBack)
        {
            LoadCategory();
            LoadNews();
        }
    }

    void LoadCategory()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT CategoryID, CategoryName FROM NewsCategory WHERE IsActive=1", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
        }
    }

    void LoadNews()
    {
        if (Request.QueryString["NewsID"] == null) return;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT Topic, NewsContent, CategoryID FROM GlobalHealthNews WHERE NewsID=@ID", con);
            cmd.Parameters.AddWithValue("@ID", Request.QueryString["NewsID"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtTopic.Text = dr["Topic"].ToString();
                txtContent.InnerHtml = dr["NewsContent"].ToString();
                ddlCategory.SelectedValue = dr["CategoryID"].ToString();
            }
        }
    }
    private string CleanHtml(string html)
    {
        html = Regex.Replace(html, @"style\s*=\s*""[^""]*""", "", RegexOptions.IgnoreCase);
        html = Regex.Replace(html, @"<span[^>]*>", "", RegexOptions.IgnoreCase);
        html = Regex.Replace(html, @"</span>", "", RegexOptions.IgnoreCase);
        html = html.Replace("&nbsp;", "");
        html = html.Replace("•", "");

        return html.Trim();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtTopic.Text))
        {
            lblMessage.Text = "⚠ Topic is required.";
            lblMessage.CssClass = "alert alert-danger";
            lblMessage.Visible = true;
            return;
        }
        if (string.IsNullOrWhiteSpace(txtContent.Value))
        {
            lblMessage.Text = "⚠ Content is required.";
            lblMessage.CssClass = "alert alert-danger";
            lblMessage.Visible = true;
            return;
        }
        string content = Request.Unvalidated.Form[txtContent.UniqueID];
        content = CleanHtml(content);
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
                @"UPDATE GlobalHealthNews
                      SET Topic=@Topic, NewsContent=@Content, CategoryID=@CatID
                      WHERE NewsID=@ID", con);

            cmd.Parameters.AddWithValue("@Topic", txtTopic.Text);
            cmd.Parameters.AddWithValue("@Content", content);
            cmd.Parameters.AddWithValue("@CatID", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@ID", Request.QueryString["NewsID"]);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "✔ News updated successfully";
        lblMessage.CssClass = "alert alert-success";
        lblMessage.Visible = true;
    }
}
}
