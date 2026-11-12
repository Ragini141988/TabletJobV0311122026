<%@ Page Title="Online Interview Details" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="OnlineInterviewApply.aspx.cs" Inherits="TabletJobs.com.OnlineInterviewApply" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .oi-wrap{max-width:1120px;margin:20px auto;padding:0 12px}
        .oi-card{background:#fff;border:1px solid #e3ecf7;border-radius:18px;box-shadow:0 8px 24px rgba(16,24,40,.06)}
        .oi-head{padding:20px 22px;border-bottom:1px solid #eef3fa;background:linear-gradient(180deg,#f8fbff 0%,#f2f7ff 100%)}
        .oi-title{font-size:34px;font-weight:700;color:#1557b0;line-height:1.15;margin:0 0 6px}
        .oi-sub{font-size:18px;color:#334155;margin:0}
        .oi-body{padding:20px 22px}
        .grid4{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px;margin-bottom:14px}
        .info{background:#f9fcff;border:1px solid #e6eef9;border-radius:14px;padding:14px;font-size:16px;color:#253243}
        .info strong{color:#111827}
        .panel{background:#f9fcff;border:1px solid #e6eef9;border-radius:14px;padding:16px;margin-bottom:12px;font-size:16px;color:#253243}
        .line{border-top:1px solid #e5edf8;margin:10px 0}
        .red{color:#b42318;font-weight:700}
        .usp{background:#fff;border:1px solid #e6eef9;border-radius:14px;padding:14px;margin-bottom:14px}
        .check{display:block;font-size:16px;color:#0f5132;margin-bottom:6px}
        .btn-main{width:100%;border:none;background:linear-gradient(90deg,#14907d,#2ca48d);color:#fff;font-size:20px;font-weight:700;padding:14px;border-radius:12px;cursor:pointer}
        .err{display:block;margin-top:10px;color:#b91c1c;font-weight:700}
        .hospital-logo-wrap{text-align:center;margin-bottom:14px}
        .hospital-logo{width:100%;height:220px;object-fit:cover;border-radius:14px;border:1px solid #e4edf7;background:#fff}
        .share-row{text-align:center;margin-top:12px}
        .share-link{display:inline-block;color:#1557b0;font-weight:700;text-decoration:none;border-bottom:1px dashed #1557b0;padding-bottom:2px}
                .latest-btn{background:linear-gradient(90deg,#1379BE,#1379BE);color:#fff;border:none;border-radius:12px;padding:12px 18px;font-size:15px;font-weight:700;cursor:pointer;white-space:nowrap;text-decoration:none;display:inline-block}

        .share-link:hover{color:#0f4a96}
        .social-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 42px;
    height: 42px;
    margin: 2px;
    border-radius: 50%;
    background: #f1f5f9;
    color: #1379BE;
    font-size: 18px;
    transition: all 0.3s ease;
    text-decoration: none;
}
       .share-social .d-flex {
    flex-wrap: nowrap !important;
}
        .pay-btn-container {
    width: 100%;
    text-align: center;
}

        @media (max-width:768px){
            .oi-title{font-size:28px}
            .oi-sub{font-size:16px}
            .grid4{grid-template-columns:1fr}
            .btn-main{font-size:18px}
        }
        
/* Main action container */
.pay-btn-container {
    width: 100%;
    margin-top: 18px;
    text-align: left;
}

/* Primary action */
.primary-action {
    padding: 16px;
    background: #f5f8fc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    margin-bottom: 18px;
}

.action-label {
    display: block;
    margin-bottom: 9px;
    color: #64748b;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 1px;
}

.pay-btn-container .btn-main {
    display: block;
    width: 100%;
    padding: 14px 18px;
    border: none;
    border-radius: 8px;
    background: #1379BE;
    color: #fff;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: background .2s ease;
}

.pay-btn-container .btn-main:hover {
    background: #0f639d;
}

/* Optional actions */
.secondary-actions {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 9px;
}

.secondary-heading {
    flex-basis: 100%;
    margin-bottom: 2px;
    color: #64748b;
    font-size: 12px;
    font-weight: 600;
}

.pay-btn-container .secondary-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 9px 12px;
    border: 1px solid #dbe2ea;
    border-radius: 7px;
    background: #fff;
    color: #374151;
    font-size: 13px;
    font-weight: 600;
    line-height: 1.4;
    text-decoration: none;
    cursor: pointer;
    transition: background .2s ease;
}

.pay-btn-container .secondary-link:hover {
    background: #f3f6f9;
}

/* WhatsApp retains its recognizable color */
.pay-btn-container .whatsapp-link {
    border-color: #b7e9ca;
    color: #168747;
}

/* Registration is a secondary text-style action */
.pay-btn-container .register-link {
    color: #1379BE;
}

/* Mobile */
@media (max-width: 480px) {
    .primary-action {
        padding: 13px;
    }

    .pay-btn-container .btn-main {
        font-size: 15px;
        padding: 13px 10px;
    }

    .pay-btn-container .secondary-actions {
        gap: 8px;
    }

    .pay-btn-container .secondary-link {
        font-size: 12px;
        padding: 9px 10px;
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="oi-wrap">
    <div class="oi-card">
        
        <div class="oi-head">
            <div class="hospital-logo-wrap">
                <asp:Image ID="imgHospitalImage" runat="server" CssClass="hospital-logo" AlternateText="Hospital Image" />
            </div><h1 class="oi-title">
                <i class="fa-solid fa-briefcase"></i>
                <asp:Label ID="lblJobTitle" runat="server" />
            </h1>

            <p class="oi-sub">
                <i class="fa-solid fa-location-dot"></i>
                <asp:Label ID="lblHospitalLocation" runat="server" />
            </p>
        </div>

        <div class="oi-body">

            <div class="grid4">
                <div class="info">
                    <i class="fa-solid fa-users"></i>
                    <strong> No Of Vacancies:</strong>
                    <asp:Label ID="lblVacancies" runat="server" />
                </div>

                <div class="info">
                    <i class="fa-solid fa-graduation-cap"></i>
                    <strong> Qualification:</strong>
                    <asp:Label ID="lblQualification" runat="server" />
                </div>

                <div class="info">
                    <i class="fa-solid fa-briefcase-medical"></i>
                    <strong> Experience:</strong>
                    <asp:Label ID="lblExperience" runat="server" />
                </div>

                <div class="info">
                    <i class="fa-solid fa-indian-rupee-sign"></i>
                    <strong> Salary Offered:</strong>
                    <asp:Label ID="lblSalary" runat="server" />
                </div>
            </div>

            <div class="panel">
                <div>
                    <i class="fa-solid fa-venus-mars"></i>
                    <strong> Gender Required:</strong>
                    <asp:Label ID="lblGenderRequired" runat="server" />
                </div>

                <div class="line"></div>

                <div class="red">
                    <i class="fa-solid fa-calendar-days"></i>
                    Interview Date & Time:
                    <asp:Label ID="lblInterviewDateTime" runat="server" />
                </div>
            </div>

            <%--<div class="panel">
                <i class="fa-solid fa-user-tie"></i>
                <strong> Interviewer Required:</strong>
                <asp:Label ID="lblInterviewerRequired" runat="server" />
            </div>--%>

            <div class="usp">
                <span class="check">
                    <i class="fa-solid fa-circle-check"></i> Direct Hospital Interview
                </span>

              

                 <span class="check">
                    <i class="fa-solid fa-circle-check"></i>  One-Time Online Interview Facilitation Fee – Just ₹99/
                </span>
            </div>
           
<div class="pay-btn-container">

    <!-- PRIMARY ACTION -->
    <div class="primary-action">
        <span class="action-label">READY TO ATTEND?</span>

        <asp:Button ID="btnAttendOnline" runat="server"
            CssClass="btn-main"
            Text="Attend Online Interview"
            OnClick="btnAttendOnline_Click" />
    </div>

    <!-- SECONDARY OPTIONAL LINKS -->
    <div class="secondary-actions">
        <div class="secondary-heading">Explore More</div>

        <asp:HyperLink ID="lnklatestonlineinterview"
            runat="server"
            CssClass="secondary-link"
            NavigateUrl="~/ViewZoomImagesV02.aspx"
            Text="Latest Online Interviews">
        </asp:HyperLink>

        <a class="secondary-link whatsapp-link"
           href="https://whatsapp.com/channel/0029VbC3aJp9Gv7Zn02qSt3e"
           target="_blank"
           rel="noopener noreferrer">
            Follow Us On WhatsApp
        </a>

        <a class="secondary-link register-link"
           href="CandidateRegistrationForm.aspx">
            Register Now
        </a>
    </div>

</div>

            
            
            
            
            <div class="share-social mt-2 border-top pt-1">
                <div class="share-social-title text-center fw-semibold mb-1 small">Share This Website With Your Friends</div>
                <div class="d-flex justify-content-center flex-wrap">
                    <a href='<%= GetFacebookShareUrl(JobId) %>' class="social-icon" target="_blank" title="Share on Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href='<%= GetWhatsAppShareUrl(JobId) %>' class="social-icon" target="_blank" title="Share on WhatsApp"><i class="fab fa-whatsapp"></i></a>
                    <a href='<%= GetTelegramShareUrl(JobId) %>' class="social-icon" target="_blank" title="Share on Telegram"><i class="fab fa-telegram-plane"></i></a>
                    <a href='https://www.instagram.com/' class="social-icon" target="_blank" title="Share on Instagram"><i class="fab fa-instagram"></i></a>
                    <a href='<%= GetTwitterShareUrl(JobId) %>' class="social-icon" target="_blank" title="Share on Twitter"><i class="fab fa-twitter"></i></a>
                    <a href='<%= GetLinkedInShareUrl(JobId) %>' class="social-icon" target="_blank" title="Share on LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="err"></asp:Label>

        </div>
    </div>
</div>
</asp:Content>




