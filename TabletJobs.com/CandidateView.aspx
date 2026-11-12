<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master"
AutoEventWireup="true"
CodeBehind="CandidateView.aspx.cs"
Inherits="TabletJobs.com.CandidateView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-3">

<div class="card shadow">

<div class="card-header bg-primary text-white">
    <h4>Candidate Profile</h4>
</div>

<div class="card-body">

<div class="row">

<div class="col-md-3 text-center">

<asp:Image ID="imgPhoto"
runat="server"
CssClass="img-fluid rounded border"
Width="180" />

<br /><br />

<asp:HyperLink ID="lnkResume"
runat="server"
CssClass="btn btn-success btn-sm"
Target="_blank"
Text="Download Resume" />

<br /><br />

<asp:HyperLink ID="lnkCertificate"
runat="server"
CssClass="btn btn-info btn-sm"
Target="_blank"
Text="View Certificate" />

<br /><br />

<asp:HyperLink ID="lnkAadhaar"
runat="server"
CssClass="btn btn-warning btn-sm"
Target="_blank"
Text="View Aadhaar" />

    <br /><br />

<asp:HyperLink ID="lnkBack"
    runat="server"
    CssClass="btn btn-secondary"
    NavigateUrl="~/CandidateList.aspx">
    <i class="fa fa-arrow-left"></i> Back to Candidate List
</asp:HyperLink>

</div>

<div class="col-md-9">

<table class="table table-bordered table-striped">

<tr>
<td><b>Candidate Code</b></td>
<td><asp:Label ID="lblCandidateCode" runat="server" /></td>
</tr>

<tr>
<td><b>Full Name</b></td>
<td><asp:Label ID="lblFullName" runat="server" /></td>
</tr>

<tr>
<td><b>Gender</b></td>
<td><asp:Label ID="lblGender" runat="server" /></td>
</tr>

<tr>
<td><b>Date Of Birth</b></td>
<td><asp:Label ID="lblDOB" runat="server" /></td>
</tr>

<tr>
<td><b>Age</b></td>
<td><asp:Label ID="lblAge" runat="server" /></td>
</tr>

<tr>
<td><b>Mobile</b></td>
<td><asp:Label ID="lblMobile" runat="server" /></td>
</tr>

<tr>
<td><b>Alternate Mobile</b></td>
<td><asp:Label ID="lblAltMobile" runat="server" /></td>
</tr>

<tr>
<td><b>WhatsApp</b></td>
<td><asp:Label ID="lblWhatsApp" runat="server" /></td>
</tr>

<tr>
<td><b>Email</b></td>
<td><asp:Label ID="lblEmail" runat="server" /></td>
</tr>

<tr>
<td><b>Current City</b></td>
<td><asp:Label ID="lblCurrentCity" runat="server" /></td>
</tr>

<tr>
<td><b>Current State</b></td>
<td><asp:Label ID="lblCurrentState" runat="server" /></td>
</tr>

<tr>
<td><b>Native Place</b></td>
<td><asp:Label ID="lblNativePlace" runat="server" /></td>
</tr>

<tr>
<td><b>Native State</b></td>
<td><asp:Label ID="lblNativeState" runat="server" /></td>
</tr>

<tr>
<td><b>Current Address</b></td>
<td><asp:Label ID="lblCurrentAddress" runat="server" /></td>
</tr>

<tr>
<td><b>Permanent Address</b></td>
<td><asp:Label ID="lblPermanentAddress" runat="server" /></td>
</tr>

<tr>
<td><b>Pincode</b></td>
<td><asp:Label ID="lblPincode" runat="server" /></td>
</tr>

<tr>
<td><b>Category</b></td>
<td><asp:Label ID="lblCategory" runat="server" /></td>
</tr>

<tr>
<td><b>Department</b></td>
<td><asp:Label ID="lblDepartment" runat="server" /></td>
</tr>

<tr>
<td><b>Designation</b></td>
<td><asp:Label ID="lblDesignation" runat="server" /></td>
</tr>

<tr>
<td><b>Qualification</b></td>
<td><asp:Label ID="lblQualification" runat="server" /></td>
</tr>

<tr>
<td><b>Specialization</b></td>
<td><asp:Label ID="lblSpecialization" runat="server" /></td>
</tr>

<tr>
<td><b>Experience</b></td>
<td><asp:Label ID="lblExperience" runat="server" /></td>
</tr>

<tr>
<td><b>Current Employer</b></td>
<td><asp:Label ID="lblEmployer" runat="server" /></td>
</tr>

<tr>
<td><b>Current Salary</b></td>
<td><asp:Label ID="lblCurrentSalary" runat="server" /></td>
</tr>

<tr>
<td><b>Expected Salary</b></td>
<td><asp:Label ID="lblExpectedSalary" runat="server" /></td>
</tr>

<tr>
<td><b>Notice Period</b></td>
<td><asp:Label ID="lblNoticePeriod" runat="server" /></td>
</tr>

<tr>
<td><b>Preferred Location</b></td>
<td><asp:Label ID="lblPreferredLocation" runat="server" /></td>
</tr>

<tr>
<td><b>Candidate Status</b></td>
<td><asp:Label ID="lblCandidateStatus" runat="server" /></td>
</tr>

<tr>
<td><b>Verification Status</b></td>
<td><asp:Label ID="lblVerificationStatus" runat="server" /></td>
</tr>

<tr>
<td><b>Source</b></td>
<td><asp:Label ID="lblSource" runat="server" /></td>
</tr>

<tr>
<td><b>Assigned Recruiter</b></td>
<td><asp:Label ID="lblRecruiter" runat="server" /></td>
</tr>

<tr>
<td><b>Last Contacted</b></td>
<td><asp:Label ID="lblLastContacted" runat="server" /></td>
</tr>

<tr>
<td><b>Next Followup</b></td>
<td><asp:Label ID="lblNextFollowup" runat="server" /></td>
</tr>

<tr>
<td><b>Remarks</b></td>
<td><asp:Label ID="lblRemarks" runat="server" /></td>
</tr>

<tr>
<td><b>Created At</b></td>
<td><asp:Label ID="lblCreatedAt" runat="server" /></td>
</tr>

<tr>
<td><b>Updated At</b></td>
<td><asp:Label ID="lblUpdatedAt" runat="server" /></td>
</tr>

</table>

</div>

</div>

</div>

</div>

</div>

</asp:Content>

