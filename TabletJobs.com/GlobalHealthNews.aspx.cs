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
    public partial class GlobalHealthNews : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNews();
            }
        }

        private void LoadNews()
        {
            SqlDataAdapter da = new SqlDataAdapter(
                @"SELECT NewsID, Topic, NewsDate 
          FROM GlobalHealthNews 
          WHERE IsActive=1 
          ORDER BY NewsDate DESC", con);

            DataTable dt = new DataTable();
            da.Fill(dt);
            rptNews.DataSource = dt;
            rptNews.DataBind();
        }

    }
}