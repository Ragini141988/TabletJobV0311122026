<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="TabletJobs.com.ContactUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .subscribe-box {
            max-width: 500px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-subscribe {
            background-color: #d32f2f!important;
            color: #fff!important;
            font-weight: bold;
        }
        .btn-subscribe:hover {
            background-color: #b71c1c;
        }
        .required-star {
            color: red;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subscribe-box">
       <div class="text-center mb-4">
    <h3 style="
        font-weight:700; 
        font-size:28px; 
        background: linear-gradient(90deg, #007bff, #6610f2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        display:inline-block;
        padding-bottom:8px;
        border-bottom:3px solid #007bff;
    ">
        <i class="bi bi-envelope-paper-heart-fill"></i> Contact Us
    </h3>
    <p class="text-muted mt-2" style="font-size:15px;">
        Get the latest <b>healthcare job updates</b> directly in your inbox 🚀
    </p>
</div>

        <asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3 d-block"></asp:Label>
        <div class="mb-3">
            <label for="txtName" class="form-label">Name <span class="required-star">*</span></label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label for="txtEmail" class="form-label">Email <span class="required-star">*</span></label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required="required"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label for="txtPhone" class="form-label">Phone <span class="required-star">*</span></label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" required="required"></asp:TextBox>
        </div>

        <div class="form-check mb-3">
            <asp:CheckBox ID="chkConsent" runat="server" CssClass="form-check-input" />
            <label class="form-check-label" for="chkConsent">
               I agree to receive calls, SMS, WhatsApp, or RCS messages from TabletJobs.com 
related to jobs, interviews, and recruitment services. 
Message frequency may vary. Consent can be withdrawn anytime.
            </label>
        </div>

        <asp:Button ID="btnSubscribe" runat="server" Text="Contact Us" 
            CssClass="btn btn-subscribe w-100" OnClick="btnSubscribe_Click" />

        <%--<asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3 d-block"></asp:Label>--%>

        <p>
             <p><strong>Andhra Pradesh (Registered Office)</strong></p>
        <p>
            Room No. 7 & 8, First Floor<br />
            D.No. 10-1-12, Ward No. 11<br />
            Railway Road, Kavali, Nellore – 524201<br />
            📞 Phone: +91 8074660555 / +91 7013107986<br />
            🧾 GST: 37ARRPM1229P3Z0
        </p>

        <hr />

        <p><strong>📍 Bangalore</strong></p>
        <p>
            #102, RV Residency<br />
            Krishna Reddy Layout, GS Palya<br />
            Electronic City, Bangalore – 560100<br />
            📞 Phone: +91 8074660555 / +91 7013107986
        </p>

        <hr />

        <p><strong>📍 Hyderabad</strong></p>
        <p>
            A13/03, North East Business Center<br />
            Errum Manzil, Khairtabad<br />
            Hyderabad – 500004<br />
            📞 Phone: 9704797476 / 7989788410
        </p>

        <hr />

        <p><strong>📍 Kolkata</strong></p>
        <p>
            39, Purba Sinthi Road<br />
            Dumdum, Kolkata – 700030<br />
            📞 Phone: 7980879741
        </p>

        <hr />

        <p><strong>📍 Kerala (Kottayam)</strong></p>
        <p>
            A3, Mulla Building<br />
            Behind Lakshmi Silks, Near KSRTC<br />
            Kottayam – 686001<br />
            📞 Phone: 9895880902
        </p>

        <hr />

        <p><strong>📍 Delhi / NCR</strong></p>
        <p>📞 Phone: 9873960913</p>

        <hr />

        <p><strong>📍 Mumbai</strong></p>
        <p>📞 Phone: 7710023823</p>

        <hr />
        </p>
    </div>
</asp:Content>