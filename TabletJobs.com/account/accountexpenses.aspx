<%@ Page Title="Enter Daily Expenses"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountexpenses.aspx.cs"
    Inherits="TabletJobs.com.account.accountexpenses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .expense-page {
            max-width: 700px;
            margin: 30px auto;
            padding: 20px;
        }

        .expense-card {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        .expense-title {
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

            .expense-page {
                padding: 10px;
            }

            .expense-card {
                padding: 20px 15px;
            }

            .expense-title {
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

    <div class="expense-page">

        <div class="expense-card">

            <div class="expense-title">
                Enter Daily Expenses
            </div>

            <!-- Amount -->

            <div class="form-row">

                <asp:Label ID="lblAmount"
                    runat="server"
                    CssClass="form-label"
                    Text="Enter Amount *">
                </asp:Label>

                <asp:TextBox ID="txtAmount"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Number">
                </asp:TextBox>

            </div>


            <!-- Expense Type -->

            <div class="form-row">

                <asp:Label ID="lblExpenseType"
                    runat="server"
                    CssClass="form-label"
                    Text="Select Expenses Type *">
                </asp:Label>

                <asp:DropDownList ID="ddlExpenseType"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Expense Type --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Hamali Door Delivery Charges"
                        Value="Hamali Door Delivery Charges" />

                    <asp:ListItem
                        Text="Hamali Unloading Charges"
                        Value="Hamali Unloading Charges" />

                    <asp:ListItem
                        Text="Cash Deposited By Bank"
                        Value="Cash Deposited By Bank" />

                    <asp:ListItem
                        Text="Cash Deposited By UPI"
                        Value="Cash Deposited By UPI" />

                    <asp:ListItem
                        Text="Power Bill"
                        Value="Power Bill" />

                    <asp:ListItem
                        Text="Water Bill"
                        Value="Water Bill" />

                    <asp:ListItem
                        Text="Petrol Bill"
                        Value="Petrol Bill" />

                    <asp:ListItem
                        Text="Transport Charges"
                        Value="Transport Charges" />

                    <asp:ListItem
                        Text="Salary Advance"
                        Value="Salary Advance" />

                    <asp:ListItem
                        Text="Food Expenses"
                        Value="Food Expenses" />

                    <asp:ListItem
                        Text="Night Shift Charges"
                        Value="Night Shift Charges" />

                    <asp:ListItem
                        Text="Godown Rent"
                        Value="Godown Rent" />

                    <asp:ListItem
                        Text="Out Station Transport Charges"
                        Value="Out Station Transport Charges" />

                    <asp:ListItem
                        Text="Discount / Less Given"
                        Value="Discount / Less Given" />

                    <asp:ListItem
                        Text="Incentives"
                        Value="Incentives" />

                    <asp:ListItem
                        Text="Others"
                        Value="Others" />

                </asp:DropDownList>

            </div>


            <!-- Details -->

            <div class="form-row">

                <asp:Label ID="lblExpenseDetails"
                    runat="server"
                    CssClass="form-label"
                    Text="Expenses in Detail">
                </asp:Label>

                <asp:TextBox ID="txtExpenseDetails"
                    runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine"
                    Rows="4">
                </asp:TextBox>

            </div>


            <!-- Date -->

            <div class="form-row">

                <asp:Label ID="lblExpenseDate"
                    runat="server"
                    CssClass="form-label"
                    Text="Select Date *">
                </asp:Label>

                <asp:TextBox ID="txtExpenseDate"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Date">
                </asp:TextBox>

            </div>


            <!-- Server Timestamp -->

            <div class="form-row">

                <asp:Label ID="lblServerDate"
                    runat="server"
                    CssClass="form-label"
                    Text="Server Date and Time">
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