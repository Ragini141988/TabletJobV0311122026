<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" 
    CodeBehind="PrivacyPolicy.aspx.cs" Inherits="TabletJobs.com.PrivacyPolicy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .policy-container { max-width: 900px; margin: auto; padding: 20px; }
        .policy-title { font-size: 28px; font-weight: bold; margin-bottom: 10px; }
        .policy-section { margin-top: 20px; }
        .policy-section h3 { font-size: 20px; margin-bottom: 10px; }
        .policy-section ul { padding-left: 20px; }
    </style>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="policy-container">
        <div class="policy-title">🔒 Privacy Policy</div>
        <p><strong>Last Updated:</strong> 28/03/2026</p>

        <div class="policy-section">
            <h3>1. Information We Collect</h3>
            <ul>
                <li>Name, email, mobile number</li>
                <li>Professional details</li>
                <li>Login and usage data</li>
            </ul>
        </div>

        <div class="policy-section">
            <h3>2. How We Use Information</h3>
            <ul>
                <li>To schedule interviews</li>
                <li>To improve services</li>
                <li>To communicate updates</li>
            </ul>
        </div>

        <div class="policy-section">
            <h3>3. Data Security</h3>
            <p>Your data is securely stored and protected against unauthorized access.</p>
        </div>

        <div class="policy-section">
            <h3>4. Sharing of Information</h3>
            <p>We do not sell your data. Information is only shared with hospitals for interview purposes.</p>
        </div>
    </div>
</asp:Content>
