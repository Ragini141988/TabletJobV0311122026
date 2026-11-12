using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class FirstMasterPAge : System.Web.UI.MasterPage
    {
        private int _jobid = 0; // Default value set to 0
        private string _jobidsource = "NA";
        private string connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        public bool PanelVisibility
        {
            get { return phLoggedIn.Visible; }
            set { phLoggedIn.Visible = value; }
        }
        public int jobid
        {
            get { return _jobid; }
            set { _jobid = value; }
        }
        public string jobidsource
        {
            get { return _jobidsource; }
            set { _jobidsource = value; }
        }
        // Define the method to set panel visibility
        public void SetPanelVisibility(bool isVisible)
        {
            phLoggedIn.Visible = isVisible;
        }
      
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserID"] != null)
            {
                // User is logged in
                phLoggedIn.Visible = true;
                phAnonymous.Visible = false;

                // Set the username in the label
                lblUsername.Text = Session["Username"].ToString(); // Ensure that "username" is stored in the session
                string userid = Session["UserID"].ToString();
                Session["UserID"] = userid;

                string userRole = Session["UserRole"] as string;


            }

            else
            {
                // User is not logged in
                phLoggedIn.Visible = false;
                phAnonymous.Visible = true;
            }
            if (!IsPostBack)
            {
             //   BindCountries();
            }
            // Set the og:image meta tag

            //if (SiteMap.CurrentNode != null)
            //{
            //    Page.Title = SiteMap.CurrentNode.Title;

            //    HtmlMeta meta = new HtmlMeta();
            //    meta.Name = "description";
            //    meta.Content = SiteMap.CurrentNode.Description;
            //    Page.Header.Controls.Add(meta);
            //}
        }
        protected void lnkLogout_ServerClick(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {

                if (Session["UserID"] != null)
                {
                    string logintype = Session["UserRole"]?.ToString();

                    // Clear session variables and set default behavior
                    void ClearSessionAndRedirect(string redirectUrl)
                    {
                        phLoggedIn.Visible = false;
                        lblUsername.Text = string.Empty;

                        // Clear session variables
                        Session["UserID"] = null;
                        Session["UserLoggedIn"] = null;
                        Session["Username"] = null;
                        Session["Nmail"] = null;
                        Session["UserRole"] = null;

                        //Response.Redirect(redirectUrl, false);
                        Response.Redirect(redirectUrl, true);
                    }

                    // Use switch for logintype
                    switch (logintype)
                    {
                        case "EMPLOYER":
                            ClearSessionAndRedirect("HospitalLoginV02.aspx");
                            break;

                        case "Candidate":
                            ClearSessionAndRedirect("CandidateloginV02.aspx");
                            break;


                        default:
                            // If logintype is null or not in the expected list, redirect to HomePage3
                            ClearSessionAndRedirect("OnlineInterviewJobs.aspx");
                            break;
                    }
                }

            }
        }

        // Define the method to set panel visibility


        public void SetOpenGraphMetaTags(string title, string description, string url, string image, string type)
        {
            string tags = $@"
        <meta property='og:title' content='{title}' />
        <meta property='og:description' content='{description}' />
        <meta property='og:url' content='{url}' />
        <meta property='og:image' content='{image}' />
        <meta property='og:type' content='{type}' />
        
        <meta name='twitter:card' content='summary_large_image' />
        <meta name='twitter:title' content='{title}' />
        <meta name='twitter:description' content='{description}' />
        <meta name='twitter:image' content='{image}' />
    ";

            ogMetaTags.Text = tags;
        }


    }
}