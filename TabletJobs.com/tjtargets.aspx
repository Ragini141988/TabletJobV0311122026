<%@ Page Title="Daily Business Details" Language="C#" 
    MasterPageFile="~/FirstMasterPAge.Master" 
    AutoEventWireup="true" 
    CodeBehind="tjtargets.aspx.cs" 
    Inherits="TabletJobs.com.tjtargets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">

        .business-container {
            max-width: 650px;
            margin: 30px auto;
            padding: 25px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.10);
        }

        .business-heading {
            font-size: 26px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-row {
            margin-bottom: 18px;
        }

        .form-label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        .form-control {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 15px;
        }

        .submit-button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .message {
            display: block;
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
        }

        @media(max-width:600px) {

            .business-container {
                margin: 15px;
                padding: 20px;
            }

            .business-heading {
                font-size: 22px;
            }
        }

    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">

    <div class="business-container">

        <div class="business-heading">
            Enter Daily Business Details
        </div>

        <!-- Amount -->
        <div class="form-row">

            <asp:Label ID="lblAmount" runat="server"
                Text="Select Amount:"
                CssClass="form-label">
            </asp:Label>

            <asp:DropDownList ID="ddlAmount"
                runat="server"
                CssClass="form-control">

                <asp:ListItem Text="-- Select Amount --"
                    Value="">
                </asp:ListItem>

                <asp:ListItem
                    Text="Rs 120 Interview Charges"
                    Value="120">
                </asp:ListItem>

                <asp:ListItem
                    Text="Rs 450 Hr coordination Charges"
                    Value="450">
                </asp:ListItem>

            </asp:DropDownList>

        </div>


        <!-- Date -->
        <div class="form-row">

            <asp:Label ID="lblDate" runat="server"
                Text="Date:"
                CssClass="form-label">
            </asp:Label>

            <asp:TextBox ID="txtBusinessDate"
                runat="server"
                TextMode="Date"
                CssClass="form-control">
            </asp:TextBox>

        </div>


        <!-- Collected By -->
        <div class="form-row">

            <asp:Label ID="lblCollectedBy" runat="server"
                Text="Collected By:"
                CssClass="form-label">
            </asp:Label>

            <asp:DropDownList ID="ddlCollectedBy"
                runat="server"
                CssClass="form-control">

                <asp:ListItem
                    Text="-- Select Person --"
                    Value="">
                </asp:ListItem>

                <asp:ListItem
                    Text="Rashida"
                    Value="Rashida">
                </asp:ListItem>

                <asp:ListItem
                    Text="Divya"
                    Value="Divya">
                </asp:ListItem>

            </asp:DropDownList>

        </div>


        <!-- Submit -->

        <div class="form-row">

            <asp:Button ID="btnSubmit"
                runat="server"
                Text="Submit"
                CssClass="submit-button"
                OnClick="btnSubmit_Click" />

        </div>


        <asp:Label ID="lblMessage"
            runat="server"
            CssClass="message">
        </asp:Label>

    </div>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>