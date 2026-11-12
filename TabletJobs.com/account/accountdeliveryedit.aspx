<%@ Page Title="Edit Delivery"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="accountdeliveryedit.aspx.cs"
    Inherits="TabletJobs.com.account.accountdeliveryedit" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <style>

        .edit-container {
            max-width: 850px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        .edit-title {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 11px;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }

        .btn-update {
            background: #007bff;
        }

        .btn-delete {
            background: #dc3545;
        }

        .btn-back {
            background: #6c757d;
        }

        .message {
            display: block;
            padding: 10px;
            margin-bottom: 15px;
            text-align: center;
            border-radius: 5px;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }

        @media(max-width:600px) {

            .edit-container {
                margin: 15px 10px;
                padding: 18px;
            }

            .buttons {
                flex-direction: column;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="edit-container">

        <div class="edit-title">
            Edit Delivery Details
        </div>

        <asp:Label ID="lblMessage"
            runat="server">
        </asp:Label>

        <div class="form-group">

            <label>Customer Name</label>

            <asp:TextBox ID="txtCustomerName"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>Customer City</label>

            <asp:DropDownList ID="ddlCustomerCity"
                runat="server"
                CssClass="form-control">

                <asp:ListItem Value="Nellore">Nellore</asp:ListItem>
                <asp:ListItem Value="Ongole">Ongole</asp:ListItem>
                <asp:ListItem Value="Kavali">Kavali</asp:ListItem>

            </asp:DropDownList>

        </div>

        <div class="form-group">

            <label>Customer Contact Number</label>

            <asp:TextBox ID="txtCustomerContact"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>Transport Name</label>

            <asp:DropDownList ID="ddlTransportName"
                runat="server"
                CssClass="form-control">

                <asp:ListItem Value="VPT">VPT</asp:ListItem>
                <asp:ListItem Value="MSS">MSS</asp:ListItem>
                <asp:ListItem Value="KSreeni">KSreeni</asp:ListItem>
                <asp:ListItem Value="Deepak">Deepak</asp:ListItem>
                <asp:ListItem Value="Praveen">Praveen</asp:ListItem>
                <asp:ListItem Value="Lucky">Lucky</asp:ListItem>
                <asp:ListItem Value="Mumbai Fast">Mumbai Fast</asp:ListItem>
                <asp:ListItem Value="SLNT">SLNT</asp:ListItem>

            </asp:DropDownList>

        </div>

        <div class="form-group">

            <label>Transport City</label>

            <asp:DropDownList ID="ddlTransportCity"
                runat="server"
                CssClass="form-control">

                <asp:ListItem Value="Nellore">Nellore</asp:ListItem>
                <asp:ListItem Value="Kavali">Kavali</asp:ListItem>
                <asp:ListItem Value="Ongole">Ongole</asp:ListItem>

            </asp:DropDownList>

        </div>

        <div class="form-group">

            <label>LR Number</label>

            <asp:TextBox ID="txtLRNumber"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>Total Articles</label>

            <asp:TextBox ID="txtTotalArticles"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>Total LR Amount</label>

            <asp:TextBox ID="txtTotalLRAmount"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>LR Type</label>

            <asp:DropDownList ID="ddlLRType"
                runat="server"
                CssClass="form-control">

                <asp:ListItem Value="Paid">Paid</asp:ListItem>
                <asp:ListItem Value="To Pay">To Pay</asp:ListItem>
                <asp:ListItem Value="FOC">FOC</asp:ListItem>

            </asp:DropDownList>

        </div>

        <div class="form-group">

            <label>Delivery Charges</label>

            <asp:TextBox ID="txtDeliveryCharges"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>

        </div>

        <div class="buttons">

            <asp:Button ID="btnUpdate"
                runat="server"
                Text="Update"
                CssClass="btn btn-update"
                OnClick="btnUpdate_Click" />

            <asp:Button ID="btnDelete"
                runat="server"
                Text="Delete"
                CssClass="btn btn-delete"
                OnClick="btnDelete_Click"
                OnClientClick="return confirm('Are you sure you want to permanently delete this record?');" />

            <asp:Button ID="btnBack"
                runat="server"
                Text="Back to Report"
                CssClass="btn btn-back"
                OnClick="btnBack_Click" />

        </div>

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
