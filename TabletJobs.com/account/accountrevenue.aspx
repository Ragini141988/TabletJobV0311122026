<%@ Page Title="Enter Daily Delivery Details"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountrevenue.aspx.cs"
    Inherits="TabletJobs.com.account.accountrevenue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .delivery-page {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
        }

        .delivery-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        .delivery-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #222;
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

        .required {
            color: red;
        }

        .submit-area {
            text-align: center;
            margin-top: 30px;
        }

        .btn-submit {
            background: #222;
            color: white;
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

        @media (max-width: 600px) {
            .delivery-page {
                padding: 10px;
                margin: 15px auto;
            }

            .delivery-card {
                padding: 20px 15px;
            }

            .delivery-title {
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

    <div class="delivery-page">

        <div class="delivery-card">

            <div class="delivery-title">
                Enter Daily Delivery Details
            </div>

            <!-- 1. Customer Name -->
            <div class="form-row">

                <asp:Label ID="lblCustomerName"
                    runat="server"
                    CssClass="form-label"
                    Text="Customer Name *">
                </asp:Label>

                <asp:TextBox ID="txtCustomerName"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="150">
                </asp:TextBox>

            </div>

            <!-- 2. Customer City -->
            <div class="form-row">

                <asp:Label ID="lblCustomerCity"
                    runat="server"
                    CssClass="form-label"
                    Text="Customer City *">
                </asp:Label>

                <asp:DropDownList ID="ddlCustomerCity"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Customer City --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="Nellore"
                        Value="Nellore">
                    </asp:ListItem>

                    <asp:ListItem Text="Ongole"
                        Value="Ongole">
                    </asp:ListItem>

                    <asp:ListItem Text="Kavali"
                        Value="Kavali">
                    </asp:ListItem>

                </asp:DropDownList>

            </div>

            <!-- 3. Customer Contact -->
            <div class="form-row">

                <asp:Label ID="lblCustomerContact"
                    runat="server"
                    CssClass="form-label"
                    Text="Customer Contact Number *">
                </asp:Label>

                <asp:TextBox ID="txtCustomerContact"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="20"
                    TextMode="Phone">
                </asp:TextBox>

            </div>

            <!-- 4. Transport Name -->
            <div class="form-row">

                <asp:Label ID="lblTransportName"
                    runat="server"
                    CssClass="form-label"
                    Text="Transport Name *">
                </asp:Label>

                <asp:DropDownList ID="ddlTransportName"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Transport --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="VPT" Value="VPT" />
                    <asp:ListItem Text="MSS" Value="MSS" />
                    <asp:ListItem Text="KSreeni" Value="KSreeni" />
                    <asp:ListItem Text="Deepak" Value="Deepak" />
                    <asp:ListItem Text="Praveen" Value="Praveen" />
                    <asp:ListItem Text="Lucky" Value="Lucky" />
                    <asp:ListItem Text="Mumbai Fast" Value="Mumbai Fast" />
                    <asp:ListItem Text="SLNT" Value="SLNT" />

                </asp:DropDownList>

            </div>

            <!-- 5. Transport City -->
            <div class="form-row">

                <asp:Label ID="lblTransportCity"
                    runat="server"
                    CssClass="form-label"
                    Text="Select Transport City *">
                </asp:Label>

                <asp:DropDownList ID="ddlTransportCity"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Transport City --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="Nellore"
                        Value="Nellore">
                    </asp:ListItem>

                    <asp:ListItem Text="Kavali"
                        Value="Kavali">
                    </asp:ListItem>

                    <asp:ListItem Text="Ongole"
                        Value="Ongole">
                    </asp:ListItem>

                </asp:DropDownList>

            </div>

            <!-- 6. LR Number -->
            <div class="form-row">

                <asp:Label ID="lblLRNumber"
                    runat="server"
                    CssClass="form-label"
                    Text="LR Number *">
                </asp:Label>

                <asp:TextBox ID="txtLRNumber"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="50">
                </asp:TextBox>

            </div>

            <!-- 7. Total Articles -->
            <div class="form-row">

                <asp:Label ID="lblTotalArticles"
                    runat="server"
                    CssClass="form-label"
                    Text="Total Articles *">
                </asp:Label>

                <asp:TextBox ID="txtTotalArticles"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Number">
                </asp:TextBox>

            </div>

            <!-- 8. Total LR Amount -->
            <div class="form-row">

                <asp:Label ID="lblTotalLRAmount"
                    runat="server"
                    CssClass="form-label"
                    Text="Enter Total LR Amount *">
                </asp:Label>

                <asp:TextBox ID="txtTotalLRAmount"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Number">
                </asp:TextBox>

            </div>

            <!-- 9. LR Type -->
            <div class="form-row">

                <asp:Label ID="lblLRType"
                    runat="server"
                    CssClass="form-label"
                    Text="LR Type *">
                </asp:Label>

                <asp:DropDownList ID="ddlLRType"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select LR Type --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="Topay"
                        Value="Topay">
                    </asp:ListItem>

                    <asp:ListItem Text="Paid"
                        Value="Paid">
                    </asp:ListItem>

                    <asp:ListItem Text="TBB"
                        Value="TBB">
                    </asp:ListItem>

                </asp:DropDownList>

            </div>

            <!-- 10. Delivery Charges -->
            <div class="form-row">

                <asp:Label ID="lblDeliveryCharges"
                    runat="server"
                    CssClass="form-label"
                    Text="Delivery Charges *">
                </asp:Label>

                <asp:TextBox ID="txtDeliveryCharges"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Number">
                </asp:TextBox>

            </div>

            <!-- 11. Server Date -->
            <div class="form-row">

                <asp:Label ID="lblDate"
                    runat="server"
                    CssClass="form-label"
                    Text="Date">
                </asp:Label>

                <asp:TextBox ID="txtDate"
                    runat="server"
                    CssClass="form-control"
                    ReadOnly="true">
                </asp:TextBox>

            </div>

            <!-- Submit -->
            <div class="submit-area">

                <asp:Button ID="btnSubmit"
                    runat="server"
                    Text="Submit"
                    CssClass="btn-submit"
                    OnClick="btnSubmit_Click" />

            </div>

            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

        </div>

    </div>

</asp:Content>