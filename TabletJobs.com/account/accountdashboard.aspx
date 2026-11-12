<%@ Page Title="Accounts Dashboard"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountdashboard.aspx.cs"
    Inherits="TabletJobs.com.accounts.accountdashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .dashboard-page {
            max-width: 1100px;
            margin: 30px auto;
            padding: 20px;
        }

        .welcome-section {
            margin-bottom: 35px;
        }

        .welcome-title {
            font-size: 32px;
            font-weight: bold;
            color: #222;
            margin-bottom: 8px;
        }

        .dashboard-date {
            font-size: 20px;
            color: #555;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .dashboard-button {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 60px;
            padding: 2px;
            border-radius: 10px;
            background: #0094ff;
            color: white;
            text-decoration: none;
            font-size: 19px;
            font-weight: 600;
            text-align: center;
            box-sizing: border-box;
            transition: 0.2s;
        }

        .dashboard-button:hover {
            background: #444;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }

        .dashboard-section-title {
            margin-top: 5px;
            margin-bottom: 2px;
            font-size: 20px;
            font-weight: bold;
            color: #222;
        }

        @media(max-width:700px) {

            .dashboard-page {
                padding: 15px;
            }

            .welcome-title {
                font-size: 26px;
            }

            .dashboard-date {
                font-size: 18px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-button {
                min-height: 75px;
                font-size: 17px;
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
</asp:Content>

<asp:Content ID="Content4"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="dashboard-page">

        <!-- Welcome -->

        <div class="welcome-section">

            <div class="welcome-title">

                Welcome:
                <asp:Label ID="lblWelcome"
                    runat="server">
                </asp:Label>

            </div>

            <div class="dashboard-date">

                Date:
                <asp:Label ID="lblDate"
                    runat="server">
                </asp:Label>

            </div>

        </div>


        <!-- Main Buttons -->

        <div class="dashboard-grid">

            <asp:HyperLink ID="lnkDelivery"
                runat="server"
                NavigateUrl="~/account/accountrevenue.aspx"
                CssClass="dashboard-button">

                Enter Daily Delivery Details

            </asp:HyperLink>


            <asp:HyperLink ID="lnkBooking"
                runat="server"
                NavigateUrl="~/account/accountsbooking.aspx"
                CssClass="dashboard-button">

                Enter Daily Booking Details

            </asp:HyperLink>


            <asp:HyperLink ID="lnkExpenses"
                runat="server"
                NavigateUrl="~/account/accountexpenses.aspx"
                CssClass="dashboard-button">

                Enter Daily Expenses

            </asp:HyperLink>


            <asp:HyperLink ID="lnkCustomer"
                runat="server"
                NavigateUrl="~/account/accountsaddcustomers.aspx"
                CssClass="dashboard-button">

                Add New Customer

            </asp:HyperLink>

        </div>


        <!-- Dashboard -->

       <%-- <div class="dashboard-section-title">

            Dashboard

        </div>

        <div class="dashboard-grid">

            <asp:HyperLink ID="lnkDashboard"
                runat="server"
                NavigateUrl="~/accounts/accountsdashboardview.aspx"
                CssClass="dashboard-button">

                View Accounts Dashboard

            </asp:HyperLink>

        </div>--%>

    </div>

</asp:Content>