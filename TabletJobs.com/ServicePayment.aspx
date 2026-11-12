<%@ Page Title=""  Async="true"  Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="ServicePayment.aspx.cs" Inherits="TabletJobs.com.ServicePayment" %>
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
        .note{font-size:16px;color:#4b5563;margin-bottom:12px}
        .lbl{font-size:15px;font-weight:700;color:#1f2937;margin:8px 0 4px;display:block}
        .inp{width:100%;padding:12px;border:1px solid #d6dfec;border-radius:10px;font-size:16px}
        .agree{margin-top:14px;font-size:15px;color:#334155;display:flex;align-items:flex-start;gap:8px}
        .agree input{margin-top:4px}
        .pay-btn{width:100%;border:none;background:linear-gradient(90deg,#14907d,#2ca48d);color:#fff;font-size:20px;font-weight:700;padding:14px;border-radius:12px;margin-top:14px;cursor:pointer}
        .safe{margin-top:10px;color:#64748b;font-size:16px}
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
       
            <div class="card">
                <div class="head">
                    <h2 class="title" style="font-size:28px;">Candidate Information</h2>
                    <p class="sub">Fill details to continue</p>
                </div>
                <div class="body">
                       <!-- SERVICE DROPDOWN -->
        <div class="col-md-12 mt-3">
            <label>Select Service</label>
            <asp:DropDownList ID="ddlServiceFee" runat="server" 
                
                CssClass="form-control">
                <asp:ListItem Text="-- Select Service --" Value="0" />
                <asp:ListItem Text="Online Interview Facilitation Services Fee - Rs 118/-" Value="118" />
                <asp:ListItem Text="Post-Selection HR Coordination & Facilitation Services Fee – Rs 2359/-" Value="2359" />
            </asp:DropDownList>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0"
                             ControlToValidate="ddlServiceFee" ErrorMessage="Select option" CssClass="err" Display="Dynamic" />

        </div>

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
           
                    <label class="lbl">Your Department: *</label>
 
                    <asp:DropDownList ID="ddlSubcategory" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Select Job Sub Category --" Value="" />
                </asp:DropDownList>

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

                    <div class="agree">
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
</span>                    </div>

                    <asp:Button ID="btnProceedPayment" runat="server"
                        CssClass="pay-btn" Text="Proceed to Make Payment" OnClick="btnProceedPayment_Click" />
                    <div class="safe">&#128274; 100% Safe &amp; Secure Payment</div>
                    <asp:Label ID="lblMessage" runat="server" CssClass="err"></asp:Label>
                </div>
            </div>
        </div>
   
</asp:Content>