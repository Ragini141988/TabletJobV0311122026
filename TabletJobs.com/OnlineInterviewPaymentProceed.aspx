<%@ Page Title="Online Interview Booking"
    Async="true"
    Language="C#"
    MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="OnlineInterviewPaymentProceed.aspx.cs"
    Inherits="TabletJobs.com.OnlineInterviewPaymentProceed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style type="text/css">

    body {
        font-family: Arial, sans-serif;
        background: #f4f8fc;
    }

    .interview-page {
        max-width: 1100px;
        margin: 25px auto 50px auto;
        padding: 0 15px;
    }

    /* HERO */

    .hero-card {
        background: linear-gradient(135deg, #ffffff, #eef7ff);
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 4px 15px rgba(0,0,0,.10);
        border: 1px solid #e1edf7;
        margin-bottom: 20px;
    }

    .hero-title {
        color: #102c54;
        font-size: 34px;
        font-weight: bold;
        margin-bottom: 5px;
          text-align: center;
    }

    .hero-title span {
        color: #1379BE;
    }

    .hero-subtitle {
        font-size: 19px;
        color: #333;
        margin-bottom: 20px;
        text-align: center;
    }

    .hospital-box {
        background: #fff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,.07);
    }

    .hospital-name {
        font-size: 25px;
        font-weight: bold;
        color: #12345b;
        margin-bottom: 15px;
    }

    .info-row {
        font-size: 16px;
        color: #333;
        margin: 10px 0;
    }

    .info-row i {
        color: #1379BE;
        width: 28px;
        font-size: 18px;
    }

    .coordinator {
        margin-top: 15px;
        padding: 13px;
        background: #f0f9ff;
        border-left: 5px solid #1379BE;
        border-radius: 7px;
    }

    .call-link {
        color: #1379BE;
        font-weight: bold;
        text-decoration: none;
    }

    .call-link:hover {
        text-decoration: underline;
    }

    /* PAYMENT */

    .payment-section {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
    }

    .payment-card,
    .process-card {
        background: #fff;
        border-radius: 14px;
        padding: 25px;
        box-shadow: 0 3px 12px rgba(0,0,0,.08);
    }

    .payment-card {
        flex: 1;
        background: linear-gradient(135deg,#eff9ff,#ffffff);
    }

    .process-card {
        flex: 1.5;
    }

    .section-title {
        color: #102c54;
        font-size: 23px;
        font-weight: bold;
        margin-bottom: 18px;
    }

    .fee {
        font-size: 46px;
        color: #1379BE;
        font-weight: bold;
    }

    .fee-note {
        color: #555;
        margin-bottom: 18px;
    }

    .pay-button {
        display: block;
        width: 100%;
        background: #e3262e;
        color: white;
        border: none;
        border-radius: 7px;
        padding: 15px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
    }

    .pay-button:hover {
        background: #c91d25;
    }

    .secure-text {
        margin-top: 15px;
        color: #26733d;
        font-size: 14px;
        text-align: center;
    }

    /* PROCESS */

    .steps {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }

    .step {
        flex: 1;
        text-align: center;
    }

    .step-icon {
        width: 55px;
        height: 55px;
        line-height: 55px;
        margin: auto;
        border-radius: 50%;
        background: #e5f3ff;
        color: #1379BE;
        font-size: 23px;
    }

    .step-number {
        font-weight: bold;
        color: #1379BE;
        margin-top: 8px;
    }

    .step-text {
        font-size: 14px;
        color: #444;
        margin-top: 5px;
    }

    .arrow {
        align-self: center;
        color: #1379BE;
        font-size: 25px;
    }

    /* LATEST INTERVIEWS */

    .latest-section {
        background: #fff;
        padding: 22px;
        border-radius: 14px;
        box-shadow: 0 3px 12px rgba(0,0,0,.08);
        margin-bottom: 20px;
    }

    .latest-title {
        font-size: 25px;
        font-weight: bold;
        color: #102c54;
        margin-bottom: 20px;
    }

    .latest-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 18px;
    }

    .interview-card {
        border: 1px solid #e2e8ee;
        border-radius: 10px;
        overflow: hidden;
        background: #fff;
    }

    .interview-card img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        display: block;
    }

    .interview-description {
        padding: 12px;
        color: #333;
        font-size: 14px;
    }

    .interview-date {
        padding: 0 12px 12px;
        color: #1379BE;
        font-weight: bold;
        font-size: 13px;
    }

    /* WHY 99 */

    .why-section {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
    }

    .why-card,
    .help-card {
        flex: 1;
        background: #fff;
        border-radius: 14px;
        padding: 22px;
        box-shadow: 0 3px 12px rgba(0,0,0,.08);
    }

    .why-card h3,
    .help-card h3 {
        color: #102c54;
        margin-top: 0;
    }

    .why-card ul {
        padding-left: 20px;
    }

    .why-card li {
        margin: 10px 0;
    }

    .help-card {
        background: #eef9f1;
    }

    .help-number {
        font-size: 28px;
        font-weight: bold;
        color: #168b48;
    }

    .message {
        display: block;
        color: #c62828;
        text-align: center;
        margin-top: 15px;
        font-weight: bold;
    }

    /* MOBILE */

    @media(max-width:768px) {

        .interview-page {
            margin-top: 15px;
        }

        .hero-title {
            font-size: 27px;
        }

        .hero-subtitle {
            font-size: 17px;
        }

        .payment-section,
        .why-section {
            display: block;
        }

        .payment-card,
        .process-card,
        .why-card,
        .help-card {
            margin-bottom: 18px;
        }

        .steps {
            flex-wrap: wrap;
        }

        .step {
            min-width: 42%;
            margin-bottom: 15px;
        }

        .arrow {
            display: none;
        }

        .latest-grid {
            grid-template-columns: 1fr;
        }

        .interview-card img {
            height: 210px;
        }
    }

</style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
</asp:Content>


<asp:Content ID="Content3"
    ContentPlaceHolderID="FeaturedContent"
    runat="server">

<div class="interview-page">

    <!-- HERO -->

    <div class="hero-card">

        <div class="hero-title">
            Online <span>Interview</span> Booking
        </div>

        <div class="hero-subtitle">
            Attend your interview online from anywhere.
        </div>

        <div class="hospital-box">

            <div class="hospital-name">
                <asp:Label ID="lblHospitalName" runat="server" />
            </div>

            <div class="info-row">
                <i class="fa fa-briefcase"></i>
                <strong>Position:</strong>
                <asp:Label ID="lblApplyingFor" runat="server" />
            </div>

            <div class="info-row">
                <i class="fa fa-map-marker"></i>
                <strong>Location:</strong>
                <asp:Label ID="lblCity" runat="server" />
            </div>

            <div class="info-row">
                <i class="fa fa-calendar"></i>
                <strong>Interview Date:</strong>
                <asp:Label ID="lblInterviewDate" runat="server" />
            </div>

            <div class="coordinator">

                <i class="fa fa-user"></i>
                <strong>Interview Coordinator:</strong>

                <asp:HyperLink
                    ID="lnkCallCoordinator"
                    runat="server"
                    CssClass="call-link" />

            </div>

        </div>

    </div>


    <!-- PAYMENT + PROCESS -->

    <div class="payment-section">

        <div class="payment-card">

            <div class="section-title">
                Online Interview Fee
            </div>

            <div class="fee">
                ₹99
            </div>

            <div class="fee-note">
                One-time payment for this interview
                <br />
                + applicable GST
            </div>

            <asp:Button
                ID="btnProceedPayment"
                runat="server"
                Text="Pay ₹99 & Attend Interview  →"
                CssClass="pay-button"
                OnClick="btnProceedPayment_Click" />

            <div class="secure-text">
                🔒 Secure Payment &nbsp; | &nbsp; UPI &nbsp; | &nbsp; Cards
            </div>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message" />

        </div>


        <div class="process-card">

            <div class="section-title">
                How Your Online Interview Works
            </div>

            <div class="steps">

                <div class="step">
                    <div class="step-icon">
                        <i class="fa fa-credit-card"></i>
                    </div>
                    <div class="step-number">1</div>
                    <div class="step-text">
                        Pay Interview Fee
                    </div>
                </div>

                <div class="arrow">→</div>

                <div class="step">
                    <div class="step-icon">
                        <i class="fa fa-calendar"></i>
                    </div>
                    <div class="step-number">2</div>
                    <div class="step-text">
                        Interview Scheduled
                    </div>
                </div>

                <div class="arrow">→</div>

                <div class="step">
                    <div class="step-icon">
                        <i class="fa fa-video-camera"></i>
                    </div>
                    <div class="step-number">3</div>
                    <div class="step-text">
                        Attend Online
                    </div>
                </div>

                <div class="arrow">→</div>

                <div class="step">
                    <div class="step-icon">
                        <i class="fa fa-file-text"></i>
                    </div>
                    <div class="step-number">4</div>
                    <div class="step-text">
                        Get Interview Result
                    </div>
                </div>

            </div>

        </div>

    </div>


    <!-- LATEST INTERVIEWS -->

    <div class="latest-section">

        <div class="latest-title">
            Latest Online Interviews
        </div>

        <asp:SqlDataSource
            ID="dsLatestInterviews"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:hospi2yp_tabletjobssConnectionString_V02 %>"
            SelectCommand="
                SELECT TOP 6
                    Id,
                    Description,
                    InterviewDate
                FROM ZoomImages
                ORDER BY InterviewDate DESC">
        </asp:SqlDataSource>


        <asp:ListView
            ID="lvLatestInterviews"
            runat="server"
            DataSourceID="dsLatestInterviews">

            <LayoutTemplate>

                <div class="latest-grid">

                    <asp:PlaceHolder
                        ID="itemPlaceholder"
                        runat="server" />

                </div>

            </LayoutTemplate>


            <EmptyDataTemplate>

                <div style="text-align:center;padding:25px;">
                    🎥 Latest interview images will appear here.
                </div>

            </EmptyDataTemplate>


            <ItemTemplate>

                <div class="interview-card">

                    <img
                        src='<%# "Handler5V02.ashx?JobID=" + Eval("Id") %>'
                        alt="Latest Online Interview" />

                    <div class="interview-description">
                        <%# Eval("Description") %>
                    </div>

                    <div class="interview-date">
                        <i class="fa fa-calendar"></i>
                        <%#
                            Eval("InterviewDate") != null
                            ? string.Format("{0:dd MMM yyyy}", Eval("InterviewDate"))
                            : ""
                        %>
                    </div>

                </div>

            </ItemTemplate>

        </asp:ListView>

    </div>


    <!-- WHY ₹99 + HELP -->

    <div class="why-section">

        <div class="why-card">

            <h3>Why ₹99?</h3>

            <ul>
                <li>✔ Online interview facilitation fee</li>
                <li>✔ No consultancy fee</li>
                <li>✔ No percentage of salary</li>
                <li>✔ No joining fee from TabletJobs</li>
                <li>✔ Simple and transparent pricing</li>
            </ul>

        </div>


        <div class="help-card">

            <h3>Need Help Before Paying?</h3>

            <p>
                Our team will be happy to help you.
            </p>

            <div class="help-number">
                📞 7013107986
            </div>

            <p>
                Call / WhatsApp
                <br />
                Mon – Sat | 9:00 AM – 7:00 PM
            </p>

        </div>

    </div>

</div>

</asp:Content>


<asp:Content ID="Content4"
    ContentPlaceHolderID="MainContent"
    runat="server">
</asp:Content>