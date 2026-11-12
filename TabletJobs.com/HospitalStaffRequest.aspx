<%@ Page Title="Hire Hospital Staff" Language="C#" MasterPageFile="~/FirstMasterPage.Master" AutoEventWireup="true" CodeBehind="HospitalStaffRequest.aspx.cs" Inherits="TabletJobs.com.HospitalStaffRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">
    
    <h3 class="text-center fw-bold mb-4">
        Get qualified nurses, doctors & hospital staff across India — fast and reliable
    </h3>

    <div class="card p-4 shadow">

        <div class="row">
            <div class="col-md-12 mb-6">
                <label>Hospital Name</label>
                <asp:TextBox ID="txtHospital" CssClass="form-control" runat="server" />
            </div>
             </div>
         <div class="row">
            <div class="col-md-12 mb-6">
                <label>City</label>
                <asp:TextBox ID="txtCity" CssClass="form-control" runat="server" />
            </div>
             </div>
            <div class="col-md-12 mb-3">
                <label>Contact Person Name</label>
                <asp:TextBox ID="txtContact" CssClass="form-control" runat="server" />
            </div>

            <div class="col-md-12 mb-3">
                <label>Mobile Number</label>
                <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server" />
            </div>

            <div class="col-md-12 mb-3">
                <label>Email ID</label>
                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
            </div>

            <div class="col-md-12 mb-3">
                <label>Staff Required</label>
                <asp:DropDownList ID="ddlStaff" CssClass="form-control" runat="server">
                  
                </asp:DropDownList>
            </div>

            <div class="col-12 mb-3">
                <label>Message</label>
                <asp:TextBox ID="txtMessage" TextMode="MultiLine" Rows="4" CssClass="form-control" runat="server" />
            </div>
        </div>

        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success w-100" OnClick="btnSubmit_Click" />

        <div class="mt-3 text-center text-success">
            ✔ Trusted by hospitals across India <br />
            ✔ Quick response within 24 hours <br />
            ✔ No upfront commitment
        </div>

    </div>
</div>

</asp:Content>