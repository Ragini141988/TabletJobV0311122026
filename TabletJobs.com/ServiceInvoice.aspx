<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceInvoice.aspx.cs" Inherits="TabletJobs.com.ServiceInvoice" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Service Tax Invoice</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body{margin:0;background:#f3f6fb;font-family:Arial,Helvetica,sans-serif;color:#1f2937}
        .sheet{max-width:860px;margin:20px auto;background:#fff;border:1px solid #dbe3ef}
        .top{display:flex;justify-content:space-between;align-items:flex-start;padding:18px 20px;border-bottom:1px solid #e5edf8}
        .brand-logo{height:52px;max-width:280px;object-fit:contain}
        .inv-title{font-size:30px;font-weight:800;color:#111827}
        .cols{display:grid;grid-template-columns:1fr 1fr;border-bottom:1px solid #e5edf8}
        .box{padding:14px 16px;border-right:1px solid #e5edf8}
        .box:last-child{border-right:none}
        .h{font-size:24px;font-weight:700;margin-bottom:8px}
        .sub{font-size:15px;line-height:1.5;color:#374151}
        .kv{display:grid;grid-template-columns:180px 1fr;gap:6px;font-size:14px;line-height:1.5}
        .kv .k{color:#475569}
        .kv .v{font-weight:700;color:#1f2937}
        .status{display:inline-block;padding:5px 10px;border-radius:8px;font-weight:700;background:#16a34a;color:#fff}
        .twrap{padding:0 12px 12px}
        table{width:100%;border-collapse:collapse;font-size:14px}
        th,td{border:1px solid #e5edf8;padding:9px 10px;text-align:left}
        th{background:#f7faff;font-weight:700;color:#111827}
        .right{text-align:right}
        .sum{display:grid;grid-template-columns:1fr 1fr;gap:10px;padding:0 12px 12px}
        .sumbox{border:1px solid #e5edf8}
        .sumbox .head2{padding:8px 10px;background:#f7faff;font-weight:700}
        .sumbox .row{display:flex;justify-content:space-between;padding:8px 10px;border-top:1px solid #edf2fb}
        .total{font-size:22px;font-weight:800;color:#0f172a}
        .foot{padding:12px 16px;border-top:1px solid #e5edf8;font-size:13px;color:#374151;line-height:1.6}
        .ok-list{padding:10px 16px;background:#f8fffb;border-top:1px solid #e5edf8;border-bottom:1px solid #e5edf8;color:#065f46;font-size:14px;font-weight:700}
        .err{max-width:860px;margin:40px auto;padding:16px;background:#fff0f0;border:1px solid #f5c2c2;color:#9b1c1c;font-weight:700}
        @media (max-width:900px){
            .sheet{margin:10px}
            .brand-logo{height:44px}
            .inv-title{font-size:24px}
            .cols{grid-template-columns:1fr}
            .box{border-right:none;border-bottom:1px solid #e5edf8}
            .box:last-child{border-bottom:none}
            .kv{grid-template-columns:140px 1fr}
            .sum{grid-template-columns:1fr}
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblError" runat="server" CssClass="err" Visible="false"></asp:Label>

        <asp:Panel ID="pnlInvoice" runat="server">
            <div class="sheet">
                <div class="top">
                    <div>
                        <img class="brand-logo" src="<%= ResolveUrl("~/Images/jpglogopng.png") %>" alt="TabletJobs" />
                        <div style="font-size:13px;color:#6b7280;margin-top:4px;">Healthcare Recruitment Platform</div>
                    </div>
                    <div class="inv-title">TAX INVOICE</div>
                </div>

                <div class="cols">
                    <div class="box">
                        <div class="h">TabletJobs.com</div>
                        <div class="sub">
                            TJ Corporation<br />
                            Room No.7, 8, First Floor, D.No.10-1-12, Ward No. 11,<br />
                            Railway Road, Kavali - 524201<br />
                            Andhra Pradesh, India<br />
                            support@tabletjobs.com<br />
                            +91-9059724821
                        </div>
                    </div>
                    <div class="box">
                        <div class="h">Invoice Details</div>
                        <div class="kv">
                            <div class="k">Invoice No:</div><div class="v"><asp:Label ID="lblInvoiceNo" runat="server" /></div>
                            <div class="k">Date:</div><div class="v"><asp:Label ID="lblInvoiceDate" runat="server" /></div>
                            <div class="k">Booking ID:</div><div class="v"><asp:Label ID="lblBookingId" runat="server" /></div>
                            <div class="k">State Code:</div><div class="v"><asp:Label ID="lblStateCode" runat="server" /></div>
                            <div class="k">Payment Status:</div><div class="v"><span class="status"><asp:Label ID="lblPaymentStatus" runat="server" /></span></div>
                        </div>
                    </div>
                </div>

                <div class="cols">
                    <div class="box">
                        <div class="h">Bill To (Candidate)</div>
                        <div class="kv">
                            <div class="k">Name:</div><div class="v"><asp:Label ID="lblCandidateName" runat="server" /></div>
                            <div class="k">Mobile:</div><div class="v"><asp:Label ID="lblCandidateMobile" runat="server" /></div>
                            <div class="k">Email:</div><div class="v"><asp:Label ID="lblCandidateEmail" runat="server" /></div>
                            <div class="k">State:</div><div class="v"><asp:Label ID="lblCandidateState" runat="server" /></div>
                        </div>
                    </div>
                    <div class="box">
                        <div class="h">Interview Details</div>
                        <div class="kv">
                            <div class="k">Hospital:</div><div class="v"><asp:Label ID="lblHospital" runat="server" /></div>
                            <div class="k">Position:</div><div class="v"><asp:Label ID="lblPosition" runat="server" /></div>
                            <div class="k">Interview Date:</div><div class="v"><asp:Label ID="lblInterviewDate" runat="server" /></div>
                            <div class="k">Time:</div><div class="v"><asp:Label ID="lblInterviewTime" runat="server" /></div>
                            <div class="k">Mode:</div><div class="v"><asp:Label ID="lblInterviewMode" runat="server" Text="Online Service" /></div>
                        </div>
                    </div>
                </div>

                <div class="twrap">
                    <table>
                        <thead>
                            <tr>
                                <th style="width:70px;">Service</th>
                                <th>Description</th>
                                <th style="width:90px;">SAC</th>
                                <th style="width:70px;">Qty</th>
                                <th style="width:120px;" class="right">Amount (&#8377;)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Online Service Fee</td>
                                <td><asp:Label ID="lblSacCode" runat="server" Text="9983" /></td>
                                <td>1</td>
                                <td class="right"><asp:Label ID="lblTaxableAmount" runat="server" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="sum">
                    <div class="sumbox">
                        <div class="head2">Tax Summary</div>
                        <div class="row"><span>Online Service Fee</span><strong>&#8377; <asp:Label ID="lblTaxSummaryAmount" runat="server" /></strong></div>
                        <div class="row"><span>SAC</span><strong><asp:Label ID="lblTaxSummarySac" runat="server" Text="9983" /></strong></div>
                    </div>
                    <div class="sumbox">
                        <div class="head2">&nbsp;</div>
                        <div class="row"><span>Taxable Value</span><strong>&#8377; <asp:Label ID="lblTaxableValue" runat="server" /></strong></div>
                        <div class="row"><span>CGST (9%)</span><strong>&#8377; <asp:Label ID="lblCgst" runat="server" /></strong></div>
                        <div class="row"><span>SGST (9%)</span><strong>&#8377; <asp:Label ID="lblSgst" runat="server" /></strong></div>
                        <div class="row total"><span>TOTAL PAID</span><span>&#8377; <asp:Label ID="lblTotalPaid" runat="server" /></span></div>
                    </div>
                </div>

                <div class="ok-list">
                    &#10003; No &#8377;5,000-&#8377;10,000 consultancy charges<br />
                    &#10003; 100% transparent hiring process<br />
                    &#10003; Direct hospital interview access
                </div>

                <div class="foot">
                    <strong>Declaration</strong><br />
                    We declare that this invoice shows the actual price of the service subscribed and that all particulars are true and correct.<br /><br />
                    +91-9059724821 | support@tabletjobs.com
                    <div style="float:right;text-align:right;">
                        Authorized Signatory<br />
                        TabletJobs.com
                    </div>
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>

