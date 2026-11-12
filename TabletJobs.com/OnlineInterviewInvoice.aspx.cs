using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Text;

namespace TabletJobs.com
{
    public partial class OnlineInterviewInvoice : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["hospi2yp_tabletjobssConnectionString_V02"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            int.TryParse(Request.QueryString["applicationId"], out int appId);
            string merchantTxnId = Request.QueryString["merchantTxnId"];
            bool downloadMode = string.Equals(Request.QueryString["download"], "1", StringComparison.OrdinalIgnoreCase);

            if (!BindInvoice(appId, merchantTxnId))
            {
                return;
            }

            if (downloadMode)
            {
                byte[] pdfBytes = BuildInvoicePdfBytes();
                string fileName = "TaxInvoice-" + lblInvoiceNo.Text + ".pdf";

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(pdfBytes);
                Response.Flush();
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        private bool BindInvoice(int appId, string merchantTxnId)
        {
            const string sql = @"
                SELECT TOP 1
                    a.ApplicationID,
                    a.CandidateName,
                    a.Mobile,
                    a.Email,
                    a.[State],
                    a.ApplicationStatus,
                    a.MerchantTxnId,
                    p.Amount,
                    p.Status AS PaymentStatus,
                    p.CreatedAt AS PaymentDate,
                    j.hname,
                    j.JTitle,
                    j.InterviewDate,
                    ISNULL(j.InterviewStartTime, '10:00 AM') AS InterviewStartTime
                FROM OnlineInterviewApplications a
                LEFT JOIN OnlineInterviewPayments p ON p.ApplicationID = a.ApplicationID
                LEFT JOIN JobPostInternal j ON j.JobID = a.JobID
                WHERE (@ApplicationID > 0 AND a.ApplicationID = @ApplicationID)
                   OR (@MerchantTxnId IS NOT NULL AND a.MerchantTxnId = @MerchantTxnId)
                ORDER BY p.PaymentID DESC, a.ApplicationID DESC";

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ApplicationID", appId);
                cmd.Parameters.AddWithValue("@MerchantTxnId", string.IsNullOrWhiteSpace(merchantTxnId) ? (object)DBNull.Value : merchantTxnId);
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        ShowError("Invoice not found.");
                        return false;
                    }

                    string paymentStatus = Convert.ToString(dr["PaymentStatus"]);
                    string appStatus = Convert.ToString(dr["ApplicationStatus"]);
                    bool isSuccess = string.Equals(paymentStatus, "SUCCESS", StringComparison.OrdinalIgnoreCase)
                                     || string.Equals(appStatus, "APPLIED", StringComparison.OrdinalIgnoreCase);

                    if (!isSuccess)
                    {
                        ShowError("Invoice can be downloaded only after successful payment. Please retry payment.");
                        return false;
                    }

                    int applicationId = Convert.ToInt32(dr["ApplicationID"]);
                    string txnId = Convert.ToString(dr["MerchantTxnId"]);
                    decimal totalPaid = dr["Amount"] == DBNull.Value ? 118m : Convert.ToDecimal(dr["Amount"]);

                    decimal taxableValue = Math.Round(totalPaid / 1.18m, 2);
                    decimal gstTotal = totalPaid - taxableValue;
                    decimal cgst = Math.Round(gstTotal / 2m, 2);
                    decimal sgst = gstTotal - cgst;

                    DateTime paymentDate;
                    DateTime.TryParse(Convert.ToString(dr["PaymentDate"]), out paymentDate);
                    if (paymentDate == DateTime.MinValue)
                    {
                        paymentDate = DateTime.Today;
                    }

                    DateTime interviewDate;
                    DateTime.TryParse(Convert.ToString(dr["InterviewDate"]), out interviewDate);

                    lblInvoiceNo.Text = BuildInvoiceNumber(applicationId, paymentDate);
                    lblInvoiceDate.Text = paymentDate.ToString("dd MMMM yyyy", CultureInfo.InvariantCulture);
                    lblBookingId.Text = txnId;
                    lblStateCode.Text = GetStateCode(Convert.ToString(dr["State"]));
                    lblPaymentStatus.Text = "Paid " + char.ConvertFromUtf32(8377) + totalPaid.ToString("0.00", CultureInfo.InvariantCulture);

                    lblCandidateName.Text = Convert.ToString(dr["CandidateName"]);
                    lblCandidateMobile.Text = Convert.ToString(dr["Mobile"]);
                    lblCandidateEmail.Text = Convert.ToString(dr["Email"]);
                    lblCandidateState.Text = Convert.ToString(dr["State"]);

                    lblHospital.Text = Convert.ToString(dr["hname"]);
                    lblPosition.Text = Convert.ToString(dr["JTitle"]);
                    lblInterviewDate.Text = interviewDate == DateTime.MinValue ? "TBD" : interviewDate.ToString("dd MMMM yyyy", CultureInfo.InvariantCulture);
                    lblInterviewTime.Text = Convert.ToString(dr["InterviewStartTime"]);

                    string taxableText = taxableValue.ToString("0.00", CultureInfo.InvariantCulture);
                    lblTaxableAmount.Text = taxableText;
                    lblTaxSummaryAmount.Text = taxableText;
                    lblTaxableValue.Text = taxableText;
                    lblCgst.Text = cgst.ToString("0.00", CultureInfo.InvariantCulture);
                    lblSgst.Text = sgst.ToString("0.00", CultureInfo.InvariantCulture);
                    lblTotalPaid.Text = totalPaid.ToString("0.00", CultureInfo.InvariantCulture);
                }
            }

            pnlInvoice.Visible = true;
            lblError.Visible = false;
            return true;
        }

        private byte[] BuildInvoicePdfBytes()
        {
            int logoWidth;
            int logoHeight;
            byte[] logoBytes = LoadLogoJpeg(out logoWidth, out logoHeight);
            int signWidth;
            int signHeight;
            byte[] signBytes = LoadSignatureJpeg(out signWidth, out signHeight);
            List<byte[]> objectBodies = new List<byte[]>();

            int fontRegularObj = AddObject(objectBodies, "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>");
            int fontBoldObj = AddObject(objectBodies, "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>");

            int imageObj = 0;
            if (logoBytes != null && logoBytes.Length > 0)
            {
                imageObj = AddObject(objectBodies, BuildImageObject(logoBytes, logoWidth, logoHeight));
            }
            int signObj = 0;
            if (signBytes != null && signBytes.Length > 0)
            {
                signObj = AddObject(objectBodies, BuildImageObject(signBytes, signWidth, signHeight));
            }
            string content = BuildPdfContent();
            if (imageObj > 0)
            {
                float drawWidth = 150f;
                float drawHeight = logoHeight > 0 ? drawWidth * logoHeight / logoWidth : 40f;
                content = "q " + drawWidth.ToString("0.##", CultureInfo.InvariantCulture) + " 0 0 " +
                          drawHeight.ToString("0.##", CultureInfo.InvariantCulture) + " 40 785 cm /Im1 Do Q\n" + content;
            }

            int contentObj = AddObject(objectBodies, BuildStreamObject(Encoding.ASCII.GetBytes(content)));

            int pageObj = objectBodies.Count + 1;
            int pagesObj = pageObj + 1;
            int catalogObj = pagesObj + 1;

            string resources = "<< /Font << /F1 " + fontRegularObj + " 0 R /F2 " + fontBoldObj + " 0 R >>";

            if (imageObj > 0 || signObj > 0)
            {
                resources += " /XObject <<";
                if (imageObj > 0)
                    resources += " /Im1 " + imageObj + " 0 R";
                if (signObj > 0)
                    resources += " /Im2 " + signObj + " 0 R";
                resources += " >>";
            }

            resources += " >>";

            AddObject(objectBodies, "<< /Type /Page /Parent " + pagesObj + " 0 R /MediaBox [0 0 595 842] /Resources " + resources + " /Contents " + contentObj + " 0 R >>");
            AddObject(objectBodies, "<< /Type /Pages /Count 1 /Kids [" + pageObj + " 0 R] >>");
            AddObject(objectBodies, "<< /Type /Catalog /Pages " + pagesObj + " 0 R >>");

            return BuildPdfFile(objectBodies, catalogObj);
        }

        private string BuildPdfContent()
        {
            StringBuilder sb = new StringBuilder();

            // Header
            DrawText(sb, "F2", 20, 420, 800, "TAX INVOICE");
            DrawText(sb, "F1", 9, 40, 770, "Healthcare Recruitment Platform");
            DrawLine(sb, 35, 765, 560, 765);

            // Left business block
            DrawText(sb, "F2", 13, 40, 748, "TabletJobs.com");
            DrawText(sb, "F1", 10, 40, 733, "TJ Corporation");
            DrawText(sb, "F1", 10, 40, 719, "Room No.7, 8, First Floor, D.No.10-1-12, Ward No. 11");
            DrawText(sb, "F1", 10, 40, 705, "Railway Road, Kavali - 524201");
            DrawText(sb, "F1", 10, 40, 691, "Andhra Pradesh, India");
            DrawText(sb, "F1", 10, 40, 677, "support@tabletjobs.com  |  +91-9059724821");

            // Invoice details right
            DrawText(sb, "F2", 13, 330, 748, "Invoice Details");
            DrawText(sb, "F1", 10, 330, 732, "Invoice No: " + lblInvoiceNo.Text);
            DrawText(sb, "F1", 10, 330, 718, "Date: " + lblInvoiceDate.Text);
            DrawText(sb, "F1", 10, 330, 704, "Booking ID: " + lblBookingId.Text);
            DrawText(sb, "F1", 10, 330, 690, "State Code: " + lblStateCode.Text);
            DrawText(sb, "F1", 10, 330, 676, "Payment Status: " + NormalizeInvoiceText(lblPaymentStatus.Text));

            DrawLine(sb, 35, 664, 560, 664);

            // Candidate
            DrawText(sb, "F2", 13, 40, 642, "Bill To (Candidate)");
            DrawText(sb, "F1", 10, 40, 626, "Name: " + lblCandidateName.Text);
            DrawText(sb, "F1", 10, 40, 612, "Mobile: " + lblCandidateMobile.Text);
            DrawText(sb, "F1", 10, 40, 598, "Email: " + lblCandidateEmail.Text);
            DrawText(sb, "F1", 10, 40, 584, "State: " + lblCandidateState.Text);

            // Interview details
            DrawText(sb, "F2", 13, 330, 642, "Interview Details");
            DrawText(sb, "F1", 10, 330, 626, "Hospital: " + lblHospital.Text);
            DrawText(sb, "F1", 10, 330, 612, "Position: " + lblPosition.Text);
            DrawText(sb, "F1", 10, 330, 598, "Interview Date: " + lblInterviewDate.Text);
            DrawText(sb, "F1", 10, 330, 584, "Time: " + lblInterviewTime.Text);
            DrawText(sb, "F1", 10, 330, 570, "Mode: " + lblInterviewMode.Text);

            DrawLine(sb, 35, 555, 560, 555);

            // Service table
            DrawText(sb, "F2", 11, 40, 538, "Service Details");
            DrawLine(sb, 35, 528, 560, 528);
            DrawText(sb, "F2", 10, 40, 514, "#");
            DrawText(sb, "F2", 10, 80, 514, "Description");
            DrawText(sb, "F2", 10, 320, 514, "SAC");
            DrawText(sb, "F2", 10, 400, 514, "Qty");
            DrawText(sb, "F2", 10, 460, 514, "Amount (Rs)");
            DrawLine(sb, 35, 504, 560, 504);
            DrawText(sb, "F1", 10, 40, 490, "1");
            DrawText(sb, "F1", 10, 80, 490, "Online Interview Booking Fee");
            DrawText(sb, "F1", 10, 320, 490, lblSacCode.Text);
            DrawText(sb, "F1", 10, 400, 490, "1");
            DrawText(sb, "F1", 10, 460, 490, "Rs " + NormalizeInvoiceText(lblTaxableAmount.Text));

            DrawLine(sb, 35, 478, 560, 478);

            // Tax summary - 2 column layout
            // Left box: Tax Summary header + fee name + SAC
            DrawText(sb, "F2", 11, 40, 462, "Tax Summary");
            DrawText(sb, "F1", 10, 40, 446, "Online Interview Booking Fee");
            DrawText(sb, "F1", 10, 40, 432, "Rs " + NormalizeInvoiceText(lblTaxSummaryAmount.Text));
            DrawText(sb, "F1", 10, 40, 418, "SAC: " + lblTaxSummarySac.Text);

            // Vertical divider between two tax summary columns
            DrawLine(sb, 295, 470, 295, 405);

            // Right box: Taxable Value, CGST, SGST, TOTAL PAID
            DrawText(sb, "F1", 10, 310, 446, "Taxable Value");
            DrawText(sb, "F1", 10, 480, 446, "Rs " + NormalizeInvoiceText(lblTaxableValue.Text));
            DrawText(sb, "F1", 10, 310, 432, "CGST (9%)");
            DrawText(sb, "F1", 10, 480, 432, "Rs " + NormalizeInvoiceText(lblCgst.Text));
            DrawText(sb, "F1", 10, 310, 418, "SGST (9%)");
            DrawText(sb, "F1", 10, 480, 418, "Rs " + NormalizeInvoiceText(lblSgst.Text));
            DrawText(sb, "F2", 11, 310, 404, "TOTAL PAID");
            DrawText(sb, "F2", 11, 460, 404, "Rs " + NormalizeInvoiceText(lblTotalPaid.Text));

            DrawLine(sb, 35, 392, 560, 392);

            // Benefit lines with checkmark symbols
            DrawText(sb, "F1", 10, 40, 378, "* No Rs 5,000-Rs 10,000 consultancy charges");
            DrawText(sb, "F1", 10, 40, 364, "* 100% transparent hiring process");
            DrawText(sb, "F1", 10, 40, 350, "* Direct hospital interview access");

            DrawLine(sb, 35, 338, 560, 338);
            DrawText(sb, "F2", 11, 40, 322, "Declaration");
            DrawText(sb, "F1", 10, 40, 308, "We declare that this invoice shows the actual price of the service");
            DrawText(sb, "F1", 10, 40, 294, "subscribed and that all particulars are true and correct.");
            DrawText(sb, "F1", 10, 40, 276, "+91-9059724821   |   support@tabletjobs.com");
            // Draw Signature Image
            sb.Append("q 100 0 0 40 420 250 cm /Im2 Do Q\n");

            // Optional text below signature
            DrawText(sb, "F1", 10, 420, 240, "Authorized Signatory");
            DrawText(sb, "F1", 10, 420, 226, "TabletJobs.com");

            return sb.ToString();
        }

        private static void DrawText(StringBuilder sb, string font, int size, int x, int y, string text)
        {
            sb.Append("BT /")
              .Append(font)
              .Append(" ")
              .Append(size.ToString(CultureInfo.InvariantCulture))
              .Append(" Tf 1 0 0 1 ")
              .Append(x.ToString(CultureInfo.InvariantCulture))
              .Append(" ")
              .Append(y.ToString(CultureInfo.InvariantCulture))
              .Append(" Tm (")
              .Append(EscapePdfText(NormalizeInvoiceText(text)))
              .Append(") Tj ET\n");
        }

        private static void DrawLine(StringBuilder sb, int x1, int y1, int x2, int y2)
        {
            sb.Append("0.85 0.88 0.93 RG 1 w ")
              .Append(x1.ToString(CultureInfo.InvariantCulture))
              .Append(" ")
              .Append(y1.ToString(CultureInfo.InvariantCulture))
              .Append(" m ")
              .Append(x2.ToString(CultureInfo.InvariantCulture))
              .Append(" ")
              .Append(y2.ToString(CultureInfo.InvariantCulture))
              .Append(" l S\n");
        }

        private static string NormalizeInvoiceText(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return string.Empty;
            }

            text = text.Replace(char.ConvertFromUtf32(8377), "Rs ");
            StringBuilder sb = new StringBuilder(text.Length);
            foreach (char c in text)
            {
                if (c < 32 || c > 126)
                {
                    sb.Append(' ');
                }
                else
                {
                    sb.Append(c);
                }
            }

            return sb.ToString();
        }

        private static string EscapePdfText(string value)
        {
            return value.Replace("\\", "\\\\").Replace("(", "\\(").Replace(")", "\\)");
        }

        private static int AddObject(List<byte[]> objectBodies, string body)
        {
            objectBodies.Add(Encoding.ASCII.GetBytes(body));
            return objectBodies.Count;
        }

        private static int AddObject(List<byte[]> objectBodies, byte[] bodyBytes)
        {
            objectBodies.Add(bodyBytes);
            return objectBodies.Count;
        }

        private static byte[] BuildStreamObject(byte[] streamBytes)
        {
            byte[] header = Encoding.ASCII.GetBytes("<< /Length " + streamBytes.Length + " >>\nstream\n");
            byte[] footer = Encoding.ASCII.GetBytes("\nendstream");

            using (MemoryStream ms = new MemoryStream())
            {
                ms.Write(header, 0, header.Length);
                ms.Write(streamBytes, 0, streamBytes.Length);
                ms.Write(footer, 0, footer.Length);
                return ms.ToArray();
            }
        }

        private static byte[] BuildImageObject(byte[] imageBytes, int width, int height)
        {
            string dict = "<< /Type /XObject /Subtype /Image /Width " + width +
                          " /Height " + height +
                          " /ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /DCTDecode /Length " + imageBytes.Length +
                          " >>\nstream\n";

            byte[] header = Encoding.ASCII.GetBytes(dict);
            byte[] footer = Encoding.ASCII.GetBytes("\nendstream");

            using (MemoryStream ms = new MemoryStream())
            {
                ms.Write(header, 0, header.Length);
                ms.Write(imageBytes, 0, imageBytes.Length);
                ms.Write(footer, 0, footer.Length);
                return ms.ToArray();
            }

        }

        private byte[] LoadLogoJpeg(out int width, out int height)
        {
            width = 0;
            height = 0;

            try
            {
                string logoPath = Server.MapPath("~/Images/jpglogopng.png");
                if (!File.Exists(logoPath))
                {
                    return null;
                }

                using (Image img = Image.FromFile(logoPath))
                using (MemoryStream ms = new MemoryStream())
                {
                    width = img.Width;
                    height = img.Height;
                    img.Save(ms, ImageFormat.Jpeg);
                    return ms.ToArray();
                }
            }
            catch
            {
                return null;
            }
           
        }
        private byte[] LoadSignatureJpeg(out int width, out int height)
        {
            width = 0;
            height = 0;

            try
            {
                string path = Server.MapPath("~/Images/signature.jpeg"); // keep your image here
                if (!File.Exists(path))
                    return null;

                using (Image img = Image.FromFile(path))
                using (MemoryStream ms = new MemoryStream())
                {
                    width = img.Width;
                    height = img.Height;
                    img.Save(ms, ImageFormat.Jpeg);
                    return ms.ToArray();
                }
            }
            catch
            {
                return null;
            }
        }


        private static byte[] BuildPdfFile(List<byte[]> objectBodies, int catalogObjectNumber)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                byte[] pdfHeader = Encoding.ASCII.GetBytes("%PDF-1.4\n");
                ms.Write(pdfHeader, 0, pdfHeader.Length);

                List<long> offsets = new List<long>();
                for (int i = 0; i < objectBodies.Count; i++)
                {
                    offsets.Add(ms.Position);
                    byte[] objHeader = Encoding.ASCII.GetBytes((i + 1).ToString(CultureInfo.InvariantCulture) + " 0 obj\n");
                    ms.Write(objHeader, 0, objHeader.Length);
                    ms.Write(objectBodies[i], 0, objectBodies[i].Length);
                    byte[] objFooter = Encoding.ASCII.GetBytes("\nendobj\n");
                    ms.Write(objFooter, 0, objFooter.Length);
                }

                long xrefPos = ms.Position;
                byte[] xrefHeader = Encoding.ASCII.GetBytes("xref\n0 " + (objectBodies.Count + 1).ToString(CultureInfo.InvariantCulture) + "\n");
                ms.Write(xrefHeader, 0, xrefHeader.Length);
                byte[] freeEntry = Encoding.ASCII.GetBytes("0000000000 65535 f \n");
                ms.Write(freeEntry, 0, freeEntry.Length);

                for (int i = 0; i < offsets.Count; i++)
                {
                    string entry = offsets[i].ToString("0000000000", CultureInfo.InvariantCulture) + " 00000 n \n";
                    byte[] entryBytes = Encoding.ASCII.GetBytes(entry);
                    ms.Write(entryBytes, 0, entryBytes.Length);
                }

                string trailer = "trailer\n<< /Size " + (objectBodies.Count + 1).ToString(CultureInfo.InvariantCulture) +
                                 " /Root " + catalogObjectNumber.ToString(CultureInfo.InvariantCulture) + " 0 R >>\n" +
                                 "startxref\n" + xrefPos.ToString(CultureInfo.InvariantCulture) + "\n%%EOF";
                byte[] trailerBytes = Encoding.ASCII.GetBytes(trailer);
                ms.Write(trailerBytes, 0, trailerBytes.Length);

                return ms.ToArray();
            }
        }

        private void ShowError(string message)
        {
            pnlInvoice.Visible = false;
            lblError.Visible = true;
            lblError.Text = message;
        }

        private static string BuildInvoiceNumber(int applicationId, DateTime invoiceDate)
        {
            return "TJ-" + invoiceDate.ToString("yyyy", CultureInfo.InvariantCulture) + "-" + applicationId.ToString("D6", CultureInfo.InvariantCulture);
        }

        private static string GetStateCode(string stateName)
        {
            if (string.IsNullOrWhiteSpace(stateName))
            {
                return "NA";
            }

            Dictionary<string, string> stateCode = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "Andhra Pradesh", "37" }, { "Arunachal Pradesh", "12" }, { "Assam", "18" }, { "Bihar", "10" },
                { "Chhattisgarh", "22" }, { "Delhi", "07" }, { "Goa", "30" }, { "Gujarat", "24" },
                { "Haryana", "06" }, { "Himachal Pradesh", "02" }, { "Jharkhand", "20" }, { "Karnataka", "29" },
                { "Kerala", "32" }, { "Madhya Pradesh", "23" }, { "Maharashtra", "27" }, { "Manipur", "14" },
                { "Meghalaya", "17" }, { "Mizoram", "15" }, { "Nagaland", "13" }, { "Odisha", "21" },
                { "Punjab", "03" }, { "Rajasthan", "08" }, { "Sikkim", "11" }, { "Tamil Nadu", "33" },
                { "Telangana", "36" }, { "Tripura", "16" }, { "Uttar Pradesh", "09" }, { "Uttarakhand", "05" },
                { "West Bengal", "19" }
            };

            return stateCode.ContainsKey(stateName.Trim()) ? stateCode[stateName.Trim()] : "NA";
        }
    }
}
