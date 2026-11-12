<%@ Page Title="Terms & Conditions" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" 
    AutoEventWireup="true" CodeBehind="TermsAndConditionsV02.aspx.cs" Inherits="TabletJobs.com.TermsAndConditionsV02" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .terms-container { max-width: 900px; margin: auto; padding: 20px; }
        .terms-title { font-size: 28px; font-weight: bold; margin-bottom: 10px; }
        .terms-section { margin-top: 20px; }
        .terms-section h3 { font-size: 20px; margin-bottom: 10px; }
        .terms-section ul { padding-left: 20px; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="terms-container">
        <div class="terms-title">📄 Terms & Conditions</div>

        <div class="terms-section">
            <h3>1. Service Overview</h3>
            <p>TabletJobs connects candidates with hospitals for online interviews.</p>
            <ul>
                <li>No job guarantee</li>
                <li>Only interview facilitation</li>
            </ul>
        </div>

        <div class="terms-section">
            <h3>2. Interview Fee</h3>
            <ul>
                <li>₹100 + GST (₹118 total)</li>
                <li>Includes scheduling & coordination</li>
            </ul>
        </div>

        <div class="terms-section">
            <h3>3. No Refund Policy</h3>
            <ul>
                <li>Payment is non-refundable</li>
                <li>Applicable in all scenarios</li>
            </ul>
        </div>

        <div class="terms-section">
            <h3>4. Candidate Responsibility</h3>
            <ul>
                <li>Provide accurate details</li>
                <li>Attend interview on time</li>
                <li>Maintain professionalism</li>
            </ul>
        </div>

        <div class="terms-section">
            <h3>5. Hospital Selection</h3>
            <p>Hiring decisions are made only by hospitals.</p>
        </div>

        <div class="terms-section">
            <h3>6. Fraud & Misuse</h3>
            <ul>
                <li>Account suspension possible</li>
                <li>Permanent ban for misuse</li>
            </ul>
        </div>

        <div class="terms-section">
            <h3>7. Limitation of Liability</h3>
            <p>We are not responsible for job outcomes or disputes.</p>
        </div>

        <div class="terms-section">
            <h3>8. Changes to Terms</h3>
            <p>We may update terms anytime without notice.</p>
        </div>
    </div>
</asp:Content>