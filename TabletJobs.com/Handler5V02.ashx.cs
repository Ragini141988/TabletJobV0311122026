using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TabletJobs.com
{
    /// <summary>
    /// Summary description for Handler5
    /// </summary>
    public class Handler5V02 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string JobID = context.Request.QueryString["JobID"];
                if (string.IsNullOrEmpty(JobID))
                {
                    context.Response.StatusCode = 400; // Bad Request
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

                using (SqlConnection connection = new System.Data.SqlClient.SqlConnection(connectionString))
                {
                    string query = "SELECT Image FROM ZoomImages WHERE Id = @JobID";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@JobID", JobID);
                        connection.Open();

                        object result = command.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            byte[] imageData = (byte[])result;
                            context.Response.ContentType = "image/jpeg";
                            context.Response.BinaryWrite(imageData);
                        }
                        else
                        {
                            //context.Response.StatusCode = 404; // Not Found
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception (optional: log to a file or monitoring system)
                // context.Response.StatusCode = 500; // Internal Server Error
                //context.Response.Write("An error occurred while processing the request.");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}