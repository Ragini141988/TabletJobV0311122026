using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabletJobs.com
{
    public partial class ZoomImagesV02 : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRecords();
            }
        }

        // ============================================================
        // LOAD ALL RECORDS
        // ============================================================

        private void LoadRecords()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"
                        SELECT 
                            Id,
                            ImageName,
                            InterviewConducted,
                            Description,
                            InterviewDate,
                            CreatedDate
                        FROM ZoomImages
                        ORDER BY InterviewDate DESC, Id DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            da.Fill(dt);

                            lvZoomImages.DataSource = dt;
                            lvZoomImages.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading records: " + ex.Message);
            }
        }

        // ============================================================
        // INSERT
        // ============================================================

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                DateTime interviewDate;

                if (!DateTime.TryParse(
                    calInterviewDate.Text,
                    out interviewDate))
                {
                    ShowMessage("Please select a valid Interview Date.");
                    return;
                }

                byte[] imageBytes = null;
                string imageName = null;

                // Get uploaded image
                if (FileUpload2.HasFile)
                {
                    imageName = Path.GetFileName(
                        FileUpload2.PostedFile.FileName);

                    using (Stream fs = FileUpload2.PostedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            imageBytes = br.ReadBytes(
                                (int)fs.Length);
                        }
                    }
                }

                bool interviewConducted = true;

                using (SqlConnection con =
                    new SqlConnection(ConnectionString))
                {
                    string query = @"
                        INSERT INTO ZoomImages
                        (
                            Image,
                            ImageName,
                            InterviewConducted,
                            Description,
                            InterviewDate
                        )
                        VALUES
                        (
                            @Image,
                            @ImageName,
                            @InterviewConducted,
                            @Description,
                            @InterviewDate
                        )";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@Image",
                            SqlDbType.VarBinary).Value =
                            imageBytes == null
                                ? (object)DBNull.Value
                                : imageBytes;

                        cmd.Parameters.Add(
                            "@ImageName",
                            SqlDbType.NVarChar, 255).Value =
                            string.IsNullOrEmpty(imageName)
                                ? (object)DBNull.Value
                                : imageName;

                        cmd.Parameters.Add(
                            "@InterviewConducted",
                            SqlDbType.Bit).Value =
                            interviewConducted;

                        cmd.Parameters.Add(
                            "@Description",
                            SqlDbType.NVarChar).Value =
                            txtDescription.Text.Trim();

                        cmd.Parameters.Add(
                            "@InterviewDate",
                            SqlDbType.Date).Value =
                            interviewDate.Date;

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                ClearForm();

                LoadRecords();

                ShowMessage(
                    "Interview record submitted successfully!");
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error while submitting: " + ex.Message);
            }
        }

        // ============================================================
        // EDIT / DELETE BUTTON COMMAND
        // ============================================================

        protected void lvZoomImages_ItemCommand(
            object sender,
            ListViewCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(
                e.CommandArgument.ToString(),
                out id))
            {
                ShowMessage("Invalid record ID.");
                return;
            }

            if (e.CommandName == "EditRecord")
            {
                LoadRecordForEdit(id);
            }
            else if (e.CommandName == "DeleteRecord")
            {
                DeleteRecord(id);
            }
        }

        // ============================================================
        // LOAD RECORD FOR EDIT
        // ============================================================

        private void LoadRecordForEdit(int id)
        {
            try
            {
                using (SqlConnection con =
                    new SqlConnection(ConnectionString))
                {
                    string query = @"
                        SELECT
                            Id,
                            Image,
                            ImageName,
                            Description,
                            InterviewDate
                        FROM ZoomImages
                        WHERE Id = @Id";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@Id",
                            SqlDbType.Int).Value = id;

                        con.Open();

                        using (SqlDataReader reader =
                            cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                hdnId.Value =
                                    reader["Id"].ToString();

                                txtDescription.Text =
                                    reader["Description"] == DBNull.Value
                                        ? ""
                                        : reader["Description"].ToString();

                                if (reader["InterviewDate"] != DBNull.Value)
                                {
                                    DateTime interviewDate =
                                        Convert.ToDateTime(
                                            reader["InterviewDate"]);

                                    calInterviewDate.Text =
                                        interviewDate.ToString(
                                            "yyyy-MM-dd");
                                }

                                // Show existing image
                                if (reader["Image"] != DBNull.Value)
                                {
                                    imgExisting.ImageUrl =
                                        "ZoomImageHandler.ashx?id=" + id;

                                    pnlExistingImage.Visible = true;
                                }
                                else
                                {
                                    pnlExistingImage.Visible = false;
                                }

                                Button1.Text = "Update";

                                Button1.CssClass =
                                    "btn btn-success";

                                btnCancel.Visible = true;

                                lblFormTitle.Text =
                                    "Edit Live Online Interview";

                                // Scroll to top
                                ScriptManager.RegisterStartupScript(
                                    this,
                                    GetType(),
                                    "ScrollTop",
                                    "window.scrollTo(0,0);",
                                    true);
                            }
                            else
                            {
                                ShowMessage(
                                    "Record not found.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error loading record: " + ex.Message);
            }
        }

        // ============================================================
        // UPDATE RECORD
        // ============================================================

        private void UpdateRecord(int id)
        {
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                DateTime interviewDate;

                if (!DateTime.TryParse(
                    calInterviewDate.Text,
                    out interviewDate))
                {
                    ShowMessage(
                        "Please select a valid Interview Date.");
                    return;
                }

                byte[] imageBytes = null;
                string imageName = null;

                bool newImageUploaded =
                    FileUpload2.HasFile;

                if (newImageUploaded)
                {
                    imageName =
                        Path.GetFileName(
                            FileUpload2.PostedFile.FileName);

                    using (Stream fs =
                        FileUpload2.PostedFile.InputStream)
                    {
                        using (BinaryReader br =
                            new BinaryReader(fs))
                        {
                            imageBytes =
                                br.ReadBytes(
                                    (int)fs.Length);
                        }
                    }
                }

                using (SqlConnection con =
                    new SqlConnection(ConnectionString))
                {
                    string query;

                    if (newImageUploaded)
                    {
                        query = @"
                            UPDATE ZoomImages
                            SET
                                Image = @Image,
                                ImageName = @ImageName,
                                InterviewConducted = @InterviewConducted,
                                Description = @Description,
                                InterviewDate = @InterviewDate
                            WHERE Id = @Id";
                    }
                    else
                    {
                        // Keep the existing image
                        query = @"
                            UPDATE ZoomImages
                            SET
                                InterviewConducted = @InterviewConducted,
                                Description = @Description,
                                InterviewDate = @InterviewDate
                            WHERE Id = @Id";
                    }

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@Id",
                            SqlDbType.Int).Value = id;

                        cmd.Parameters.Add(
                            "@InterviewConducted",
                            SqlDbType.Bit).Value = true;

                        cmd.Parameters.Add(
                            "@Description",
                            SqlDbType.NVarChar).Value =
                            txtDescription.Text.Trim();

                        cmd.Parameters.Add(
                            "@InterviewDate",
                            SqlDbType.Date).Value =
                            interviewDate.Date;

                        if (newImageUploaded)
                        {
                            cmd.Parameters.Add(
                                "@Image",
                                SqlDbType.VarBinary).Value =
                                imageBytes;

                            cmd.Parameters.Add(
                                "@ImageName",
                                SqlDbType.NVarChar, 255).Value =
                                imageName;
                        }

                        con.Open();

                        int rows =
                            cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            ClearForm();

                            LoadRecords();

                            ShowMessage(
                                "Interview record updated successfully!");
                        }
                        else
                        {
                            ShowMessage(
                                "Record not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error while updating: " + ex.Message);
            }
        }

        // ============================================================
        // DELETE RECORD
        // ============================================================

        private void DeleteRecord(int id)
        {
            try
            {
                using (SqlConnection con =
                    new SqlConnection(ConnectionString))
                {
                    string query = @"
                        DELETE FROM ZoomImages
                        WHERE Id = @Id";

                    using (SqlCommand cmd =
                        new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@Id",
                            SqlDbType.Int).Value = id;

                        con.Open();

                        int rows =
                            cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            LoadRecords();

                            ShowMessage(
                                "Interview record deleted successfully!");
                        }
                        else
                        {
                            ShowMessage(
                                "Record not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error while deleting: " + ex.Message);
            }
        }

        // ============================================================
        // CANCEL EDIT
        // ============================================================

        protected void btnCancel_Click(
            object sender,
            EventArgs e)
        {
            ClearForm();
        }

        // ============================================================
        // CLEAR FORM
        // ============================================================

        private void ClearForm()
        {
            hdnId.Value = "0";

            txtDescription.Text = "";

            calInterviewDate.Text = "";

            Button1.Text = "Submit";

            Button1.CssClass =
                "btn btn-primary";

            btnCancel.Visible = false;

            pnlExistingImage.Visible = false;

            imgExisting.ImageUrl = "";

            lblFormTitle.Text =
                "Live Online Interview";
        }

        // ============================================================
        // BUTTON CLICK HANDLER
        //
        // One button is used for both INSERT and UPDATE.
        // ============================================================

        protected void Button1_Click(
            object sender,
            EventArgs e)
        {
            int id;

            if (int.TryParse(
                hdnId.Value,
                out id) && id > 0)
            {
                UpdateRecord(id);
            }
            else
            {
                btnSubmit_Click(sender, e);
            }
        }

        // ============================================================
        // SHOW MESSAGE
        // ============================================================

        private void ShowMessage(string message)
        {
            string safeMessage =
                HttpUtility.JavaScriptStringEncode(
                    message);

            ClientScript.RegisterStartupScript(
                this.GetType(),
                Guid.NewGuid().ToString(),
                "alert('" + safeMessage + "');",
                true);
        }
    }
}

