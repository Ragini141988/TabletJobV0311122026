<%@ Page Title="Daily Booking Details"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountsbooking.aspx.cs"
    Inherits="TabletJobs.com.accounts.accountsbooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .booking-page {
            max-width: 750px;
            margin: 30px auto;
            padding: 20px;
        }

        .booking-card {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        .booking-title {
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

            .booking-page {
                padding: 10px;
            }

            .booking-card {
                padding: 20px 15px;
            }

            .booking-title {
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

    <div class="booking-page">

        <div class="booking-card">

            <div class="booking-title">
                Daily Booking Details
            </div>


            <!-- 1 Booking Amount -->

            <div class="form-row">

                <asp:Label ID="lblBookingAmount"
                    runat="server"
                    CssClass="form-label"
                    Text="Enter Booking Amount *">
                </asp:Label>

                <asp:TextBox ID="txtBookingAmount"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Number">
                </asp:TextBox>

            </div>


            <!-- 2 Transport -->

            <div class="form-row">

                <asp:Label ID="lblTransport"
                    runat="server"
                    CssClass="form-label"
                    Text="Transport Name *">
                </asp:Label>

                <asp:DropDownList ID="ddlTransport"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem
                        Text="-- Select Transport --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="MSS" Value="MSS" />
                    <asp:ListItem Text="APSRTC" Value="APSRTC" />
                    <asp:ListItem Text="VPT" Value="VPT" />
                    <asp:ListItem Text="KSreeni" Value="KSreeni" />
                    <asp:ListItem Text="Praveen" Value="Praveen" />
                    <asp:ListItem Text="Deepak" Value="Deepak" />
                    <asp:ListItem Text="SLNT" Value="SLNT" />

                </asp:DropDownList>

            </div>


            <!-- 3 From City -->

            <div class="form-row">

                <asp:Label ID="lblFromCity"
                    runat="server"
                    CssClass="form-label"
                    Text="From City *">
                </asp:Label>

                <asp:DropDownList ID="ddlFromCity"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem
                        Text="-- Select From City --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem Text="Nellore"
                        Value="Nellore" />

                    <asp:ListItem Text="Ongole"
                        Value="Ongole" />

                    <asp:ListItem Text="Kavali"
                        Value="Kavali" />

                </asp:DropDownList>

            </div>


            <!-- 4 To City -->

            <div class="form-row">

                <asp:Label ID="lblToCity"
                    runat="server"
                    CssClass="form-label"
                    Text="To City *">
                </asp:Label>

                <asp:TextBox ID="txtToCity"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="100">
                </asp:TextBox>

            </div>


            <!-- 5 Articles -->

            <div class="form-row">

                <asp:Label ID="lblArticles"
                    runat="server"
                    CssClass="form-label"
                    Text="No of Articles *">
                </asp:Label>

                <asp:TextBox ID="txtArticles"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Number">
                </asp:TextBox>

            </div>


            <!-- 6 Customer -->

            <div class="form-row">

                <asp:Label ID="lblCustomerName"
                    runat="server"
                    CssClass="form-label"
                    Text="From Customer Name *">
                </asp:Label>

                <asp:TextBox ID="txtCustomerName"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="150">
                </asp:TextBox>

            </div>


            <!-- 7 Contact -->

            <div class="form-row">

                <asp:Label ID="lblCustomerContact"
                    runat="server"
                    CssClass="form-label"
                    Text="From Customer Contact Number *">
                </asp:Label>

                <asp:TextBox ID="txtCustomerContact"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Phone"
                    MaxLength="20">
                </asp:TextBox>

            </div>


            <!-- 8 Date -->

            <div class="form-row">

                <asp:Label ID="lblBookingDate"
                    runat="server"
                    CssClass="form-label"
                    Text="Date *">
                </asp:Label>

                <asp:TextBox ID="txtBookingDate"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Date">
                </asp:TextBox>

            </div>


            <!-- 9 Server Date Time -->

            <div class="form-row">

                <asp:Label ID="lblServerDate"
                    runat="server"
                    CssClass="form-label"
                    Text="Server Date &amp; Time">
                </asp:Label>

                <asp:TextBox ID="txtServerDate"
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