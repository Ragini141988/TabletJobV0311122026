<%@ Page Title="Requests" Language="C#" MasterPageFile="~/FirstMasterPage.Master" AutoEventWireup="true" CodeBehind="HospitalStaffRequestList.aspx.cs" Inherits="TabletJobs.com.HospitalStaffRequestList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">
    <h3 class="text-center mb-4">Hospital Staff Requests</h3>

    <asp:ListView ID="lvData" runat="server" OnItemCommand="lvData_ItemCommand">
        <ItemTemplate>

            <div class="card mb-3 p-3 shadow-sm">

                <h5><%# Eval("HospitalName") %> - <%# Eval("City") %></h5>

                <p>
                    <b>Contact:</b> <%# Eval("ContactPerson") %><br />
                    <b>Mobile:</b> <%# Eval("Mobile") %><br />
                    <b>Email:</b> <%# Eval("Email") %><br />
                    <b>Staff:</b> <%# Eval("CategoryName") %><br />
                    <b>Message:</b> <%# Eval("Message") %>
                </p>

                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditItem"
                    CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-warning btn-sm" />

                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteItem"
                    CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-danger btn-sm" />

            </div>

        </ItemTemplate>
    </asp:ListView>

</div>

</asp:Content>