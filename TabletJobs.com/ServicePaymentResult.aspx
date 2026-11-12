<%@ Page  Async="true"  Title="Payment Confirmed" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="ServicePaymentResult.aspx.cs" Inherits="TabletJobs.com.ServicePaymentResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .c-wrap{max-width:1120px;margin:20px auto;padding:0 12px}
        .c-grid{display:grid;grid-template-columns:2fr 1fr;gap:18px}
        .card{background:#fff;border:1px solid #e3ecf7;border-radius:18px;box-shadow:0 8px 24px rgba(16,24,40,.06)}
        .head{padding:24px 22px;border-bottom:1px solid #eef3fa;background:linear-gradient(180deg,#f8fbff 0%,#f2f7ff 100%)}
        .ok{width:88px;height:88px;border-radius:50%;display:flex;align-items:center;justify-content:center;margin-bottom:12px;
            background:radial-gradient(circle at 35% 30%,#77e0cc 0%,#35b7a0 45%,#14907d 100%);color:#fff;font-size:46px;font-weight:700}
        .ok.warn{background:radial-gradient(circle at 35% 30%,#fbc37a 0%,#f59e0b 50%,#d97706 100%)}
        .title{font-size:36px;font-weight:700;color:#111827;line-height:1.1;margin:0 0 6px}
        .book{font-size:18px;color:#5b6473;margin:0}
        .book span{font-weight:700;color:#374151}
        .msg{display:block;padding:10px 22px 0;color:#b45309;font-weight:700}
        .body{padding:20px 22px}
        .job-title{font-size:30px;font-weight:700;color:#1557b0;line-height:1.2;margin-bottom:8px}
        .job-line{font-size:18px;color:#334155;margin-bottom:10px}
        .meta{font-size:16px;color:#334155;margin-bottom:10px}
        .meta-row{display:flex;justify-content:space-between;gap:10px;align-items:center;flex-wrap:wrap}
        .paid{font-size:17px;color:#0f766e;font-weight:700}
        .chip{background:linear-gradient(90deg,#14907d,#2ca48d);color:#fff;border-radius:10px;padding:6px 12px;font-weight:700;font-size:15px}
        .action{display:flex;justify-content:space-between;align-items:center;background:#fff;border:1px solid #e5ecf8;border-radius:12px;padding:12px 14px;color:#1f2937;text-decoration:none;font-size:17px;font-weight:600;margin-bottom:10px}
        .action:hover{text-decoration:none;color:#0f172a}
        .side{padding:20px 22px}
        .wa-title{font-size:20px;font-weight:700;color:#166534;margin-bottom:4px}
        .wa-sub{font-size:15px;color:#4b5563;margin-bottom:14px}
        .wa-open{display:inline-block;background:linear-gradient(90deg,#14907d,#2ca48d);color:#fff !important;border-radius:10px;padding:10px 14px;text-decoration:none;font-weight:700}
        @media (max-width:900px){
            .c-grid{grid-template-columns:1fr}
            .title{font-size:30px}
            .job-title{font-size:26px}
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="c-wrap">
        <div class="c-grid">
            <div class="card">
                <div class="head">
                    <div id="divStatusIcon" runat="server" class="ok">&#10003;</div>
                    <h1 class="title"><asp:Label ID="lblHeaderTitle" runat="server" Text="Interview Confirmed!" /></h1>
                    <p class="book">Booking Id: <span><asp:Label ID="lblBookingId" runat="server" /></span></p>
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

                <div class="body">
                    <div class="job-title"><asp:Label ID="lblJobTitle" runat="server" /></div>
                    <div class="job-line"><asp:Label ID="lblHospitalLocation" runat="server" /></div>
                    <div class="meta">&#128197; <asp:Label ID="lblInterviewDateTime" runat="server" /></div>
                    <div class="meta-row" style="margin-bottom:16px;">
                        <div class="paid">&#9989; Paid: &#8377;<asp:Label ID="lblAmountPaid" runat="server" Text="118" /></div>
                        <div class="chip"><asp:Label ID="lblAttendChip" runat="server" Text="Attend Online &#8377;118" /></div>
                    </div>

<asp:HyperLink 
    ID="lnkJoinInterview" 
    runat="server" 
    CssClass="action" 
    Text="Join WhatsApp Group" 
    Target="_blank"  NavigateUrl='<%# Eval("WHATSAPPLINK") %>' />                    
                    <asp:HyperLink ID="lnkDownloadConfirmation" runat="server" CssClass="action" NavigateUrl="javascript:window.print();" Text="Download Confirmation  &#8250;" />
                    <asp:HyperLink ID="lnkCallSupport" runat="server" CssClass="action" Text="Call Support  &#8250;" />
                </div>
            </div>

            <div class="card">
                <div class="side">
                    <div class="wa-title">Have Questions? Chat on WhatsApp</div>
                    <div class="wa-sub">Our support team is here to assist you.</div>
                    <asp:HyperLink ID="lnkOpenWhatsApp" runat="server" CssClass="wa-open" Text="Open WhatsApp" Target="_blank" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
