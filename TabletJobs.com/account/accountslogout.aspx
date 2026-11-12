<%@ Page Title="Logout" Language="C#" MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true" CodeBehind="accountslogout.aspx.cs"
    Inherits="TabletJobs.com.account.accountslogout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .logout-container {
            min-height: 70vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        .logout-box {
            width: 100%;
            max-width: 500px;
            background: #ffffff;
            border-radius: 15px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 5px 25px rgba(0,0,0,0.12);
        }

        .logout-icon {
            width: 75px;
            height: 75px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #28a745;
            color: white;
            font-size: 42px;
            line-height: 75px;
            font-weight: bold;
        }

        .logout-box h2 {
            color: #222;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .logout-box p {
            color: #666;
            font-size: 16px;
            margin-bottom: 25px;
        }

        .login-button {
            display: inline-block;
            background: #007bff;
            color: white !important;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 7px;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
        }

        .login-button:hover {
            background: #0056b3;
            text-decoration: none;
        }

        @media (max-width: 576px) {
            .logout-box {
                padding: 30px 20px;
            }

            .logout-box h2 {
                font-size: 24px;
            }

            .logout-box p {
                font-size: 15px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <div class="logout-container">

        <div class="logout-box">

            <div class="logout-icon">
                ✓
            </div>

            <h2>Logout Successful</h2>

            <p>
                You have been successfully logged out of your account.
            </p>

            <a href="AccountLoginPage.aspx"" class="login-button">
                Login Again
            </a>

        </div>

    </div>

</asp:Content>