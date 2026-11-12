using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace TabletJobs.com
{
    public class ZoomImageHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.Clear();

            int id;

            if (!int.TryParse(
                context.Request.QueryString["id"],
                out id))
            {
                context.Response.StatusCode = 400;
                return;
            }

            string connString =
                ConfigurationManager
                    .ConnectionStrings[
                        "hospi2yp_tabletjobssConnectionString_V02"
                    ]
                    .ConnectionString;

            using (SqlConnection con =
                new SqlConnection(connString))
            {
                string query = @"
                    SELECT Image, ImageName
                    FROM ZoomImages
                    WHERE Id = @Id";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Id",
                        id);

                    con.Open();

                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader["Image"] != DBNull.Value)
                            {
                                byte[] imageBytes =
                                    (byte[])reader["Image"];

                                string imageName =
                                    reader["ImageName"] == DBNull.Value
                                        ? ""
                                        : reader["ImageName"].ToString();

                                context.Response.ContentType =
                                    GetContentType(imageName);

                                context.Response.BinaryWrite(
                                    imageBytes);
                            }
                            else
                            {
                                context.Response.StatusCode = 404;
                            }
                        }
                        else
                        {
                            context.Response.StatusCode = 404;
                        }
                    }
                }
            }

            context.Response.End();
        }

        private string GetContentType(string fileName)
        {
            string extension =
                System.IO.Path.GetExtension(fileName)
                    .ToLower();

            switch (extension)
            {
                case ".jpg":
                case ".jpeg":
                    return "image/jpeg";

                case ".png":
                    return "image/png";

                case ".gif":
                    return "image/gif";

                case ".bmp":
                    return "image/bmp";

                case ".webp":
                    return "image/webp";

                default:
                    return "application/octet-stream";
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
