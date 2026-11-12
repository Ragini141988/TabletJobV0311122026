using System;
using System.Web.Security;

namespace TabletJobs.com.account
{
    public partial class accountslogout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Sign out Forms Authentication
                FormsAuthentication.SignOut();

                // Clear all session data
                Session.Clear();
                Session.Abandon();

                // Prevent browser from caching account pages
                Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
                Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
            }
        }
    }
}