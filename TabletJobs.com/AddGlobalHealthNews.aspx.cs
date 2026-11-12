using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class AddGlobalHealthNews : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                LoadCategory();
            }
        }

        private void LoadCategory()
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT CategoryID, CategoryName FROM NewsCategory WHERE IsActive=1",
                con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
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

        protected void btnSubmit_Click(object sender, EventArgs e)
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
            // string content = Request.Form[txtContent.UniqueID];
            string content = Request.Unvalidated.Form[txtContent.UniqueID];
            content = CleanHtml(content);


            SqlCommand cmd = new SqlCommand(
                "INSERT INTO GlobalHealthNews (Topic, NewsContent, CategoryID) VALUES (@Topic,@Content,@CatID)", con);

            cmd.Parameters.AddWithValue("@Topic", txtTopic.Text);
            cmd.Parameters.AddWithValue("@Content", content);
            cmd.Parameters.AddWithValue("@CatID", ddlCategory.SelectedValue);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            // Show success message
            lblMessage.Text = "✔ News successfully added.";
            lblMessage.Visible = true;

            // Clear fields after insert
            txtTopic.Text = "";
            txtContent.Value = "";
            ddlCategory.SelectedIndex = 0;
        }

    }
}