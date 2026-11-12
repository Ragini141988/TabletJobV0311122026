using System;

namespace TabletJobs.com.accounts
{
    public partial class accountdashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountID"] == null)
            {
                Response.Redirect("~/account/AccountLoginPage.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            string username = Convert.ToString(Session["Username"]);

            if (string.IsNullOrWhiteSpace(username))
            {
                username = "Nellore";
            }

            lblWelcome.Text = username;

            lblDate.Text =
                DateTime.Now.ToString("dd/MM/yyyy");
        }
    }
}