<%@ Page Title="Account Summary Report"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountsummary.aspx.cs"
    Inherits="TabletJobs.com.account.accountsummary" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <style>

        .summary-container {
            max-width: 1100px;
            margin: 25px auto;
            padding: 15px;
        }

        .summary-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .logged-user {
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 25px;
        }

        /* DATE FILTER */

        .filter-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.10);
            margin-bottom: 25px;
        }

        .filter-row {
            display: flex;
            gap: 15px;
            align-items: end;
        }

        .filter-group {
            flex: 1;
        }

        .filter-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .date-control {
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .btn-view {
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            background: #007bff;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-view:hover {
            opacity: 0.9;
        }

        /* MESSAGE */

        .message {
            display: block;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 6px;
            text-align: center;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
        }

        .message.success {
            background: #d4edda;
            color: #155724;
        }

        /* REPORT */

        .report-period {
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .account-section {
            margin-bottom: 30px;
        }

        .account-heading {
            background: #343a40;
            color: white;
            padding: 13px 18px;
            border-radius: 8px 8px 0 0;
            font-size: 20px;
            font-weight: bold;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            padding: 18px;
            background: white;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .summary-card {
            padding: 20px 15px;
            border-radius: 8px;
            text-align: center;
            background: #f8f9fa;
            border: 1px solid #e5e5e5;
        }

        .summary-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .summary-value {
            display: block;
            font-size: 22px;
            font-weight: bold;
        }

        .overall-section {
            margin-top: 35px;
        }

        .overall-heading {
            background: #212529;
            color: white;
            padding: 15px 18px;
            border-radius: 8px 8px 0 0;
            font-size: 21px;
            font-weight: bold;
        }

        .overall-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            padding: 18px;
            background: white;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.12);
        }

        .overall-card {
            padding: 22px 15px;
            border-radius: 8px;
            text-align: center;
            background: #f8f9fa;
            border: 1px solid #ddd;
        }

        .overall-card .summary-value {
            font-size: 24px;
        }

        .no-report {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        /* MOBILE */

        @media(max-width:800px) {

            .summary-grid,
            .overall-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .filter-row {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-view {
                width: 100%;
            }
        }

        @media(max-width:500px) {

            .summary-container {
                margin: 10px auto;
                padding: 10px;
            }

            .summary-title {
                font-size: 23px;
            }

            .summary-grid,
            .overall-grid {
                grid-template-columns: 1fr;
            }

            .account-heading {
                font-size: 18px;
            }

            .summary-value {
                font-size: 21px;
            }
        }

    </style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="summary-container">

        <div class="summary-title">
            Account Reports
        </div>

        <div class="logged-user">
            <asp:Label ID="lblLoggedInUser"
                runat="server">
            </asp:Label>
        </div>


        <!-- DATE FILTER -->

        <div class="filter-box">

            <div class="filter-row">

                <div class="filter-group">

                    <label>From Date</label>

                    <asp:TextBox ID="txtFromDate"
                        runat="server"
                        CssClass="date-control"
                        TextMode="Date">
                    </asp:TextBox>

                </div>


                <div class="filter-group">

                    <label>To Date</label>

                    <asp:TextBox ID="txtToDate"
                        runat="server"
                        CssClass="date-control"
                        TextMode="Date">
                    </asp:TextBox>

                </div>


                <div>

                    <asp:Button ID="btnViewReport"
                        runat="server"
                        Text="View Report"
                        CssClass="btn-view"
                        OnClick="btnViewReport_Click" />

                </div>

            </div>

        </div>


        <asp:Label ID="lblMessage"
            runat="server">
        </asp:Label>


        <asp:Panel ID="pnlReport"
            runat="server"
            Visible="false">

            <div class="report-period">

                <asp:Label ID="lblReportPeriod"
                    runat="server">
                </asp:Label>

            </div>


            <!-- NORMAL USER REPORT -->

            <asp:Panel ID="pnlUserReport"
                runat="server"
                Visible="false">

                <div class="account-section">

                    <div class="account-heading">

                        <asp:Label ID="lblUserAccountName"
                            runat="server">
                        </asp:Label>

                    </div>


                    <div class="summary-grid">

                        <div class="summary-card">

                            <span class="summary-label">
                                Total ToPay Business
                            </span>

                            <span class="summary-value">

                                ₹
                                <asp:Label ID="lblUserToPay"
                                    runat="server">
                                </asp:Label>

                            </span>

                        </div>


                        <div class="summary-card">

                            <span class="summary-label">
                                Total Paid Business
                            </span>

                            <span class="summary-value">

                                ₹
                                <asp:Label ID="lblUserPaid"
                                    runat="server">
                                </asp:Label>

                            </span>

                        </div>


                        <div class="summary-card">

                            <span class="summary-label">
                                Total TBB Business
                            </span>

                            <span class="summary-value">

                                ₹
                                <asp:Label ID="lblUserTBB"
                                    runat="server">
                                </asp:Label>

                            </span>

                        </div>


                        <div class="summary-card">

                            <span class="summary-label">
                                Total Delivery Charges
                            </span>

                            <span class="summary-value">

                                ₹
                                <asp:Label ID="lblUserDeliveryCharges"
                                    runat="server">
                                </asp:Label>

                            </span>

                        </div>

                    </div>

                </div>

            </asp:Panel>


            <!-- ADMIN REPORT -->

            <asp:Panel ID="pnlAdminReport"
                runat="server"
                Visible="false">


                <!-- NELLORE -->

                <div class="account-section">

                    <div class="account-heading">
                        Nellore
                    </div>

                    <div class="summary-grid">

                        <div class="summary-card">

                            <span class="summary-label">
                                Total ToPay Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblNelloreToPay"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total Paid Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblNellorePaid"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total TBB Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblNelloreTBB"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total Delivery Charges
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblNelloreDelivery"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                    </div>

                </div>


                <!-- KAVALI -->

                <div class="account-section">

                    <div class="account-heading">
                        Kavali
                    </div>

                    <div class="summary-grid">

                        <div class="summary-card">

                            <span class="summary-label">
                                Total ToPay Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblKavaliToPay"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total Paid Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblKavaliPaid"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total TBB Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblKavaliTBB"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total Delivery Charges
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblKavaliDelivery"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                    </div>

                </div>


                <!-- ONGOLE -->

                <div class="account-section">

                    <div class="account-heading">
                        Ongole
                    </div>

                    <div class="summary-grid">

                        <div class="summary-card">

                            <span class="summary-label">
                                Total ToPay Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOngoleToPay"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total Paid Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOngolePaid"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total TBB Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOngoleTBB"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                        <div class="summary-card">

                            <span class="summary-label">
                                Total Delivery Charges
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOngoleDelivery"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                    </div>

                </div>


                <!-- OVERALL -->

                <div class="overall-section">

                    <div class="overall-heading">
                        Overall Total
                    </div>

                    <div class="overall-grid">

                        <div class="overall-card">

                            <span class="summary-label">
                                Total ToPay Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOverallToPay"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>


                        <div class="overall-card">

                            <span class="summary-label">
                                Total Paid Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOverallPaid"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>


                        <div class="overall-card">

                            <span class="summary-label">
                                Total TBB Business
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOverallTBB"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>


                        <div class="overall-card">

                            <span class="summary-label">
                                Total Delivery Charges
                            </span>

                            <span class="summary-value">
                                ₹
                                <asp:Label ID="lblOverallDelivery"
                                    runat="server">
                                </asp:Label>
                            </span>

                        </div>

                    </div>

                </div>

            </asp:Panel>

        </asp:Panel>

    </div>

</asp:Content>


<asp:Content ID="Content3"
    ContentPlaceHolderID="FeaturedContent"
    runat="server">
</asp:Content>


<asp:Content ID="Content4"
    ContentPlaceHolderID="MainContent"
    runat="server">
</asp:Content>

