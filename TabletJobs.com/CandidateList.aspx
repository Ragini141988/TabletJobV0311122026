<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="CandidateList.aspx.cs" Inherits="TabletJobs.com.CandidateList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <div class="container-fluid">

<h3>Candidate List</h3>


<div class="row">

<div class="col-md-4 col-12 mb-2">
    <asp:TextBox
        ID="txtSearch"
        runat="server"
        CssClass="form-control"
        placeholder="Name or Mobile">
    </asp:TextBox>
</div>

<div class="col-md-2 col-12">
    <asp:Button
        ID="Button1"
        runat="server"
        Text="Search"
        CssClass="btn btn-primary w-100"
        OnClick="btnSearch_Click" />
</div>
     <div class="col-md-2 col-6 mb-2">
        <a href="CandidateRegistration.aspx"
           class="btn btn-success w-100">
            + Add Candidate
        </a>
    </div>
</div>




<br />

<asp:ListView ID="lvCandidates"
    runat="server">

<ItemTemplate>

<div class="card mb-3 shadow-sm">

<div class="card-body">

<h5>
<%# Eval("FullName") %>
</h5>

<p>
<b>Code:</b>
<%# Eval("CandidateCode") %>
</p>

<p>
<b>Mobile:</b>
<%# Eval("MobileNumber") %>
</p>

<p>
<b>City:</b>
<%# Eval("CurrentCity") %>
</p>



<div>

<a class="btn btn-info btn-sm"
href='CandidateView.aspx?id=<%# Eval("CandidateID") %>'>
View
</a>

<a class="btn btn-success btn-sm"
href='CandidateEdit.aspx?id=<%# Eval("CandidateID") %>'>
Edit
</a>

<asp:LinkButton
ID="btnDelete"
runat="server" Text="Delete"
CssClass="btn btn-danger btn-sm"
CommandArgument='<%# Eval("CandidateID") %>'
OnClick="btnDelete_Click"
OnClientClick="return confirm('Delete Candidate?');">

</asp:LinkButton>

</div>

</div>

</div>

</ItemTemplate>

</asp:ListView>
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
