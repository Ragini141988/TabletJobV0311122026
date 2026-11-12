<%@ Page Title="Enter Details" Async="true" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="OnlineInterviewPayment.aspx.cs" Inherits="TabletJobs.com.OnlineInterviewPayment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pay-wrap{max-width:1120px;margin:20px auto;padding:0 12px}
        .pay-grid{display:grid;grid-template-columns:1fr 1fr;gap:18px}
        .card{background:#fff;border:1px solid #e3ecf7;border-radius:18px;box-shadow:0 8px 24px rgba(16,24,40,.06)}
        .head{padding:20px 22px;border-bottom:1px solid #eef3fa;background:linear-gradient(180deg,#f8fbff 0%,#f2f7ff 100%)}
        .title{font-size:34px;font-weight:700;color:#111827;line-height:1.15;margin:0 0 6px}
        .sub{font-size:17px;color:#64748b;margin:0}
        .body{padding:20px 22px}
        .job-title{font-size:30px;font-weight:700;color:#1557b0;line-height:1.2;margin-bottom:8px}
        .job-line{font-size:17px;color:#334155;margin-bottom:10px}
        .job-meta{display:flex;justify-content:space-between;gap:10px;flex-wrap:wrap;font-size:15px;color:#334155;margin-bottom:8px}
        .chip{background:linear-gradient(90deg,#14907d,#2ca48d);color:#fff;border-radius:10px;padding:6px 12px;font-weight:700}
        
.meta-item {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    white-space: nowrap;
}

.vacancies {
    font-weight: 600;
}

.payment-info {
    color: #444;
}

.payment-info strong {
    color: #198754;
    font-weight: 700;
}

.amount-chip {
    display: inline-flex;
    align-items: center;
    padding: 5px 10px;
    border-radius: 20px;
    background: #f1f8f4;
    color: #198754;
    font-weight: 700;
    border: 1px solid #b7dfc8;
    white-space: nowrap;
}
        .note{font-size:16px;color:#4b5563;margin-bottom:12px}
        .lbl{font-size:15px;font-weight:700;color:#1f2937;margin:8px 0 4px;display:block}
        .inp{width:100%;padding:12px;border:1px solid #d6dfec;border-radius:10px;font-size:16px}
        .agree{margin-top:14px;font-size:15px;color:#334155;display:flex;align-items:flex-start;gap:8px}
        .agree input{margin-top:4px}
        .pay-btn-container {
    width: 100%;
    text-align: center;
}

.pay-btn {
    width: 250px;
    border: none;
    background: linear-gradient(90deg, #14907d, #2ca48d);
    color: #fff;
    font-size: 20px;
    font-weight: 700;
    padding: 14px;
    border-radius: 12px;
    margin-top: 14px;
    cursor: pointer;
}       .safe{margin-top:10px;color:#64748b;font-size:16px}
        .err{display:block;color:#b91c1c;font-weight:700;margin-top:8px}
        .hospital-logo-wrap{text-align:center;margin-bottom:14px}
        .hospital-logo{width:100%;height:220px;object-fit:cover;border-radius:14px;border:1px solid #e4edf7;background:#fff}
        .share-row{text-align:center;margin-top:10px}
        .share-link{display:inline-block;color:#1557b0;font-weight:700;text-decoration:none;border-bottom:1px dashed #1557b0;padding-bottom:2px}
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
        @media (max-width:900px){
            .pay-grid{grid-template-columns:1fr}
            .title{font-size:28px}
            .job-title{font-size:26px}
            .pay-btn{font-size:18px}
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pay-wrap">
        <div class="pay-grid">
            <div class="card">
                <div class="head">
                    <h1 class="title">Enter Your Details</h1>
                    <p class="sub">To proceed, please provide your information.</p>
                </div>
                <div class="body">
                    <div class="hospital-logo-wrap">
                        <asp:Image ID="imgHospitalImage" runat="server" CssClass="hospital-logo" AlternateText="Hospital Image" />
                    </div>
                    <div class="job-title"><asp:Label ID="lblJobTitle" runat="server" /></div>
                    <div class="job-line"><asp:Label ID="lblHospitalLocation" runat="server" /></div>
                    <div class="job-meta">
                        <span>&#128197; <asp:Label ID="lblInterviewDateTime" runat="server" /></span>
                        <span>&#128188; <asp:Label ID="lblExperience" runat="server" /> Experience</span>
                    </div>
                   <div class="job-meta">

    <span class="meta-item vacancies">
        👥
        <asp:Label ID="lblVacancies" runat="server" />
        <span>Vacancies</span>
    </span>

   <%-- <span class="meta-item payment-info">
        👉 Pay only <strong>₹99 + GST</strong>
    </span>

    <span class="amount-chip">
        ₹<asp:Label ID="lblAmount" runat="server" Text="116.82" />
    </span>--%>

</div>
                   <%-- <div class="note">Required for Interview slot booking</div>--%>
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
                </div>
            </div>

            <div class="card">
                <div class="head">
                    <h2 class="title" style="font-size:28px;">Candidate Information</h2>
                    <p class="sub">Fill details to continue to online interview slot booking</p>
                </div>
                <div class="body">
                    <label class="lbl">Full Name *</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="inp" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name required" CssClass="err" Display="Dynamic" />

                    <label class="lbl">Email Address *</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="inp" TextMode="Email" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email required" CssClass="err" Display="Dynamic" />

                    <label class="lbl">Mobile *</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="inp" MaxLength="15" />
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="Mobile required" CssClass="err" Display="Dynamic" />

                    <label class="lbl">Gender: *</label>
  <asp:DropDownList ID="ddlGenderReq" runat="server" CssClass="form-select">
    <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
  </asp:DropDownList>                    
             <asp:RequiredFieldValidator ID="rfvDob" runat="server" InitialValue="0" ControlToValidate="ddlGenderReq" ErrorMessage="Gender required" CssClass="err" Display="Dynamic" />

                   
                    <label class="lbl">Your Profession: *</label>
 
                    <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" 
    OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"  CssClass="form-control">
</asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" InitialValue="" ErrorMessage="Select a category" CssClass="err" Display="Dynamic" />
           
                   

                       <label class="lbl">Qualification: *</label>
 
                    <asp:DropDownList ID="Dropqual" runat="server" CssClass="form-control" EnableViewState="true">
                <asp:ListItem Value="">Your Qualification</asp:ListItem>
               
            </asp:DropDownList>
            <asp:RequiredFieldValidator 
                ID="rfvDrpQual" 
                runat="server" 
                ControlToValidate="Dropqual" 
                InitialValue="" 
                SetFocusOnError="true" 
                Display="Dynamic" 
                ErrorMessage="Please select a qualification" 
                CssClass="err" >
            </asp:RequiredFieldValidator>

                    <label class="lbl">Experience: *</label>
 
                      <asp:DropDownList ID="DrpExp" runat="server" CssClass="form-control" EnableViewState="true">
               
               
            </asp:DropDownList>
            <asp:RequiredFieldValidator 
                ID="rfvDrpExp" 
                runat="server" 
                ControlToValidate="DrpExp" 
                InitialValue="Select Experience" 
                ErrorMessage="Please select your experience." 
                CssClass="err" 
                Display="Dynamic"></asp:RequiredFieldValidator>

                  <%--  <div class="agree">
                        <asp:CheckBox ID="chkTerms" runat="server" />
<span>
    I agree to the 
    <strong>
        <a href="TermsAndConditionsV02.aspx" target="_blank">Terms &amp; Conditions</a>
    </strong> 
    and 
    <strong>
        <a href="PrivacyPolicy.aspx" target="_blank">Privacy Policy</a>
    </strong>
</span>                    </div>--%>

                   <div class="pay-btn-container">
    <asp:Button ID="btnNext"
        runat="server"
        CssClass="pay-btn"
        Text="Next"
        OnClick="btnNext_Click" />
</div>
                   <%-- <div class="safe">&#128274; 100% Safe &amp; Secure Payment</div>--%>
                    <asp:Label ID="lblMessage" runat="server" CssClass="err"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>




