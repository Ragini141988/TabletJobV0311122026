<%@ Page Title="Login" Language="C#" MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true" CodeBehind="AccountLoginPage.aspx.cs"
    Inherits="TabletJobs.com.account.AccountLoginPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .login-container {
            max-width: 400px;
            margin: 60px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.12);
        }

        .login-title {
            text-align: center;
            margin-bottom: 25px;
            color: #222;
        }

        .form-label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .login-button {
            width: 100%;
            padding: 11px;
            border: none;
            border-radius: 5px;
            background: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .login-button:hover {
            background: #0056b3;
        }

        .message {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: red;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <div class="login-container">

        <h2 class="login-title">Login</h2>

        <asp:Label ID="lblUsername" runat="server"
            Text="Username / Email"
            CssClass="form-label">
        </asp:Label>

        <asp:TextBox ID="txtUsername" runat="server"
            CssClass="form-control">
        </asp:TextBox>

        <asp:Label ID="lblPassword" runat="server"
            Text="Password"
            CssClass="form-label">
        </asp:Label>

        <asp:TextBox ID="txtPassword" runat="server"
            TextMode="Password"
            CssClass="form-control">
        </asp:TextBox>

        <asp:Button ID="btnLogin" runat="server"
            Text="Login"
            CssClass="login-button"
            OnClick="btnLogin_Click" />

        <asp:Label ID="lblMessage" runat="server"
            CssClass="message">
        </asp:Label>

    </div>

</asp:Content>

