<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="LoginForCandidateRegistratiom.aspx.cs" Inherits="TabletJobs.com.LoginForCandidateRegistratiom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container py-4">
  <div class="row justify-content-center">
    <div class="col-md-7 col-lg-6">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body p-4">
          <h3 class="mb-1">Secure Login</h3>
          <p class="text-muted mb-4">Only registered mobile numbers can log in.</p>

          <asp:Panel ID="pnlStep1" runat="server">
            <div class="mb-3">
              <label for="txtPhone" class="form-label">Mobile number</label>
              <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+91XXXXXXXXXX"></asp:TextBox>
            </div>
            <asp:Button ID="btnSendOTP" runat="server" Text="Send OTP" CssClass="btn btn-primary" OnClick="btnSendOTP_Click" />
          </asp:Panel>

          <asp:Panel ID="pnlStep2" runat="server" Visible="false" CssClass="mt-3">
            <div class="mb-3">
              <label for="txtOtp" class="form-label">Enter OTP</label>
              <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control" MaxLength="6" placeholder="6-digit code"></asp:TextBox>
            </div>
            <div class="d-grid gap-2 d-md-flex">
              <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify & Continue" CssClass="btn btn-success me-2" OnClick="btnVerifyOTP_Click"/>
              <asp:Button ID="btnResend" runat="server" Text="Resend OTP" CssClass="btn btn-outline-secondary" OnClick="btnResend_Click"/>
            </div>
          </asp:Panel>

          <div class="mt-3">
            <asp:Label ID="lblMessage" runat="server" CssClass="d-block text-center"></asp:Label>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</asp:Content>