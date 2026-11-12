using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ViewZoomImagesV02 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ListView11_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            // Handle page change events if necessary
            DataPager dp = (DataPager)listview11.FindControl("DataPager1");
            dp.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            // Register a script to scroll to the "jobSeekers" div
            ScriptManager.RegisterStartupScript(this, GetType(), "scrollToJobSeekers", "scrollToJobSeekers();", true);
        }
    }
}