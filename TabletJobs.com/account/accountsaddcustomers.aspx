<%@ Page Title="Add New Customer"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountsaddcustomers.aspx.cs"
    Inherits="TabletJobs.com.accounts.accountsaddcustomers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .account-form-page {
            max-width: 750px;
            margin: 30px auto;
            padding: 20px;
        }

        .account-form-card {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        .account-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #222;
            margin-bottom: 30px;
        }

        .form-row {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            margin-bottom: 7px;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 11px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #555;
        }

        .submit-area {
            text-align: center;
            margin-top: 30px;
        }

        .btn-submit {
            background: #222;
            color: #fff;
            border: none;
            padding: 12px 35px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-submit:hover {
            background: #444;
        }

        .message {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-weight: 600;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        @media(max-width:600px) {

            .account-form-page {
                padding: 10px;
            }

            .account-form-card {
                padding: 20px 15px;
            }

            .account-title {
                font-size: 23px;
            }

        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <div class="account-form-page">

        <div class="account-form-card">

            <div class="account-title">
                Add New Customer
            </div>


            <!-- Customer Name -->

            <div class="form-row">

                <asp:Label ID="lblCustomerName"
                    runat="server"
                    CssClass="form-label"
                    Text="Enter Customer Name *">
                </asp:Label>

                <asp:TextBox ID="txtCustomerName"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="150">
                </asp:TextBox>

            </div>


            <!-- Customer City -->

            <div class="form-row">

                <asp:Label ID="lblCustomerCity"
                    runat="server"
                    CssClass="form-label"
                    Text="Customer City *">
                </asp:Label>

                <asp:DropDownList ID="ddlCustomerCity"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem
                        Text="-- Select City --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="Nellore"
                        Value="Nellore" />

                    <asp:ListItem Text="Kavali"
                        Value="Kavali" />

                    <asp:ListItem Text="Ongole"
                        Value="Ongole" />

                </asp:DropDownList>

            </div>


            <!-- Contact -->

            <div class="form-row">

                <asp:Label ID="lblContact"
                    runat="server"
                    CssClass="form-label"
                    Text="Customer Contact Number *">
                </asp:Label>

                <asp:TextBox ID="txtContact"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Phone"
                    MaxLength="20">
                </asp:TextBox>

            </div>


            <!-- Rating -->

            <div class="form-row">

                <asp:Label ID="lblRating"
                    runat="server"
                    CssClass="form-label"
                    Text="Customer Rating *">
                </asp:Label>

                <asp:DropDownList ID="ddlRating"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem
                        Text="-- Select Rating --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="5 Star (Daily and Loyal With Reference)"
                        Value="5 Star" />

                    <asp:ListItem
                        Text="4 Star (Daily - Weekly twice and above)"
                        Value="4 Star" />

                    <asp:ListItem
                        Text="3 Star (Regular - Weekly once)"
                        Value="3 Star" />

                    <asp:ListItem
                        Text="2 Star (Occasional)"
                        Value="2 Star" />

                    <asp:ListItem
                        Text="1 Star (New)"
                        Value="1 Star" />

                </asp:DropDownList>

            </div>


            <!-- Target Transport -->

            <div class="form-row">

                <asp:Label ID="lblTransport"
                    runat="server"
                    CssClass="form-label"
                    Text="Target Transport *">
                </asp:Label>

                <asp:DropDownList ID="ddlTransport"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem
                        Text="-- Select Transport --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="VPT" Value="VPT" />
                    <asp:ListItem Text="MSS" Value="MSS" />
                    <asp:ListItem Text="Deepak" Value="Deepak" />
                    <asp:ListItem Text="KSreeni" Value="KSreeni" />
                    <asp:ListItem Text="Praveen" Value="Praveen" />
                    <asp:ListItem Text="SLNT" Value="SLNT" />
                    <asp:ListItem Text="APSRTC" Value="APSRTC" />

                </asp:DropDownList>

            </div>


            <!-- Submit -->

            <div class="submit-area">

                <asp:Button ID="btnAddCustomer"
                    runat="server"
                    Text="Add Customer"
                    CssClass="btn-submit"
                    OnClick="btnAddCustomer_Click" />

            </div>


            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

        </div>

    </div>

</asp:Content>