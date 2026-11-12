<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="CandidateRegistration.aspx.cs" Inherits="TabletJobs.com.CandidateRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        .date-picker {
    width: 150px;  /* Adjust as needed */
      }
        .form-header {
            text-align: center;
            background-color: #1379BE;
            color: white;
            font-size: 20px;
            padding: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 12px; /* Adjusted font size for labels */
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-footer {
            text-align: center;
            margin-top: 20px;
        }
       .form-footer button {
    background-color: darkslategrey; /* Brighter blue */
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    font-weight: bold; /* Makes the text slightly bolder */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* Adds a slight shadow for better visibility */
}
.btn.btn-primary.mt-3 {
    background-color: #1379BE !important; /* Override the Bootstrap primary color */
    transition: none !important; /* Disable any transition effects */
}
.form-footer button:hover {
    background-color: #0056b3; /* Darker blue on hover */
}
        .form-group img {
          
            max-width: 100px;
            height: auto;
            margin-top: 10px;
        }
           
    .date-picker {
        background-color: #f5f5f5; /* Optional: change background color */
        cursor: not-allowed; /* Optional: change cursor when hovering */
    }
     .checkbox-container {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

/* Ensure CheckBoxList items are spaced properly */
.checkbox-grid input[type="checkbox"] {
    margin-right: 5px;
}

/* Desktop view: Display in multiple columns */
@media (min-width: 768px) {
    .checkbox-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr); /* Three columns */
        gap: 10px;
    }
}

/* Mobile view: Stack checkboxes in a single column */
@media (max-width: 767px) {
    .checkbox-grid {
        display: flex;
        flex-direction: column;
    }
}
/* Uniform spacing */
.form-section {
    margin-top: 5px;
    margin-bottom: 15px;
}

.form-section-title {
    background: #f8f9fa;
    border-left: 5px solid #1379BE;
    padding: 5px 5px;
    margin-bottom: 5px;
    font-size: 18px;
    font-weight: 600;
    color: #1379BE;
    border-radius: 4px;
}

.row > div {
    margin-bottom: 15px;
}

label {
    font-weight: 600;
    margin-bottom: 5px;
    display: block;
}

.required {
    color: red;
    font-weight: bold;
}

.field-validator {
    color: red;
    display: block;
    margin-top: 3px;
    font-size: 13px;
}

.form-control {
    min-height: 40px;
}

textarea.form-control {
    min-height: 100px;
}

hr {
    margin-top: 10px;
}

/* Better card */
.card {
    border: none;
    border-radius: 10px;
}

.card-body {
    padding: 30px;
}

/* File upload spacing */
input[type=file] {
    width: 100%;
    margin-top: 5px;
}

/* Checkbox alignment */
.checkbox-control {
    margin-top: 35px;
}

/* Mobile */
@media(max-width:768px) {
    .card-body {
        padding: 15px;
    }

    .form-section-title {
        font-size: 16px;
    }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent" runat="server">

  <div class="container mt-5">

    <div class="card shadow">
        
         <div class="row">
            <div class="col-12 text-center mb-4">
                <h2 class="form-header">Candidate Registration</h2>
            </div>
        </div>
        <div class="card-body">

            <asp:ValidationSummary
                ID="ValidationSummary1"
                runat="server"
                CssClass="alert alert-danger"
                ShowMessageBox="true"
                ShowSummary="false" />

            <div class="row">

                <!-- Candidate Code -->
                <div class="col-md-4 mb-3">
                    <label>Candidate Code</label>
                    <asp:TextBox ID="txtCandidateCode"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true" />
                </div>

                <!-- Full Name -->
                <div class="col-md-4 mb-3">
                    <label>Full Name <span class="required">*</span></label>

                    <asp:TextBox ID="txtFullName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="150" />

                    <asp:RequiredFieldValidator
                        ID="rfvFullName"
                        runat="server"
                        ControlToValidate="txtFullName"
                        ErrorMessage="Full Name Required"
                        ForeColor="Red"
                           CssClass="field-validator"
    Display="Dynamic" />
                </div>

                <!-- Gender -->
                <div class="col-md-4 mb-3">
                    <label>Gender <span class="required">*</span></label>
                    <asp:DropDownList
                        ID="ddlGender"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem Text="Select" Value="" />
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                        <asp:ListItem>Other</asp:ListItem>

                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="ddlGender"  Display="Dynamic"
                        InitialValue=""
                        ErrorMessage="Select Gender"
                        ForeColor="Red"     CssClass="field-validator" />
                </div>

                <!-- DOB -->
                <div class="col-md-4 mb-3">
                    <label>Date Of Birth <span class="required">*</span></label>

                    <asp:TextBox
                        ID="txtDOB"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Date" />

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="txtDOB"
                        ErrorMessage="DOB Required"
                        ForeColor="Red"      CssClass="field-validator"
    Display="Dynamic"/>
                </div>

                <!-- Age -->
                <div class="col-md-4 mb-3">
                    <label>Age <span class="required">*</span></label>

                    <asp:TextBox
                        ID="txtAge"
                        runat="server"
                        CssClass="form-control" />

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="txtAge"
                        ErrorMessage="Age Required"
                        ForeColor="Red"     CssClass="field-validator"
    Display="Dynamic" />

                    
                </div>

                <!-- Mobile -->
                <div class="col-md-4 mb-3">
                    <label>Mobile Number <span class="required">*</span></label>

                    <asp:TextBox
                        ID="txtMobile"
                        runat="server"
                        MaxLength="10"
                        CssClass="form-control" />

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="txtMobile"
                        ErrorMessage="Mobile Required"
                        ForeColor="Red"     CssClass="field-validator"
    Display="Dynamic"/>

                    <asp:RegularExpressionValidator
                        runat="server"
                        ControlToValidate="txtMobile"
                        ValidationExpression="^[6-9]\d{9}$"
                        ErrorMessage="Invalid Mobile Number"
                        ForeColor="Red" />
                </div>

                <!-- Alternate Mobile -->
                <div class="col-md-4 mb-3">
                    <label>Alternate Mobile</label>

                    <asp:TextBox
                        ID="txtAltMobile"
                        runat="server"
                        MaxLength="10"
                        CssClass="form-control" />
                </div>

                <!-- WhatsApp -->
                <div class="col-md-4 mb-3">
                    <label>WhatsApp Number</label>

                    <asp:TextBox
                        ID="txtWhatsApp"
                        runat="server"
                        MaxLength="10"
                        CssClass="form-control" />
                </div>

                <!-- Email -->
                <div class="col-md-4 mb-3">
                    <label>Email <span class="required">*</span></label>

                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="form-control" />

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email Required"
                        ForeColor="Red"      CssClass="field-validator"
    Display="Dynamic" />

                   
                </div>

            </div>

            <hr />

            <div class="form-section">
    <div class="form-section-title">
        Address Information
    </div>
</div>

            <div class="row">

                <div class="col-md-4 mb-3">
                    <label>Current City</label>
                    <asp:TextBox ID="txtCurrentCity"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Current State</label>
                    <asp:DropDownList ID="ddlCurrentState"
                        runat="server"
                        CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <div class="col-md-4 mb-3">
                    <label>Native Place</label>
                    <asp:TextBox ID="txtNativePlace"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Native State</label>
                    <asp:DropDownList ID="ddlNativeState"
                        runat="server"
                        CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <div class="col-md-8 mb-3">
                    <label>Current Address</label>
                    <asp:TextBox
                        ID="txtCurrentAddress"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3" />
                </div>

                <div class="col-md-8 mb-3">
                    <label>Permanent Address</label>
                    <asp:TextBox
                        ID="txtPermanentAddress"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Pincode</label>

                    <asp:TextBox
                        ID="txtPincode"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="6" />

                 
                </div>

            </div>

            <hr />

           <div class="form-section">
    <div class="form-section-title">
        Professional Information
    </div>
</div>

            <div class="row">

                <div class="col-md-4 mb-3">
                    <label>Candidate Category <span class="required">*</span></label>

                    <asp:DropDownList
                        ID="ddlCandidateCategory"
                        runat="server"
                        CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidateCategory_SelectedIndexChanged">
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="ddlCandidateCategory"
                        InitialValue=""
                        ErrorMessage="Select Category"
                        ForeColor="Red"      CssClass="field-validator"
    Display="Dynamic"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label>Department <span class="required">*</span></label>

                    <asp:DropDownList
                        ID="ddlDepartment"
                        runat="server"
                        CssClass="form-control">
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="ddlDepartment"
                        InitialValue=""
                        ErrorMessage="Select Department"
                        ForeColor="Red"     CssClass="field-validator"
    Display="Dynamic" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Designation <span class="required">*</span></label>

                    <asp:TextBox
                        ID="txtDesignation"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Qualification  <span class="required">*</span></label>

                    <asp:DropDownList
                        ID="ddlQualification"
                        runat="server"
                        CssClass="form-control">
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        runat="server"
                        ControlToValidate="ddlQualification"
                        InitialValue=""
                        ErrorMessage="Select Qualification"
                        ForeColor="Red"     CssClass="field-validator"
    Display="Dynamic"/>
                </div>
                <div class="col-md-4 mb-3">
<label>Specialization</label>
<asp:TextBox ID="txtSpecialization"
runat="server"
CssClass="form-control" />
</div>

<div class="col-md-4 mb-3">
<label>Registration State</label>
<asp:DropDownList ID="ddlRegistrationState"
runat="server"
CssClass="form-control">
</asp:DropDownList>
</div>

<div class="col-md-4 mb-3">
<label>Registration Status</label>

<asp:DropDownList ID="ddlRegistrationStatus"
runat="server"
CssClass="form-control">

<asp:ListItem Value="">Select</asp:ListItem>
<asp:ListItem>Registered</asp:ListItem>
<asp:ListItem>Applied</asp:ListItem>
<asp:ListItem>Not Registered</asp:ListItem>

</asp:DropDownList>

</div>
<div class="col-md-4 mb-3">
                    <label>Total Experience</label>

                    <asp:TextBox
                        ID="txtExperience"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Current Employer</label>

                    <asp:TextBox
                        ID="txtEmployer"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Current Salary</label>

                    <asp:TextBox
                        ID="txtCurrentSalary"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label>Expected Salary</label>

                    <asp:TextBox
                        ID="txtExpectedSalary"
                        runat="server"
                        CssClass="form-control" />
                </div>
<div class="col-md-4 mb-3">
<label>Notice Period</label>

<asp:DropDownList ID="ddlNoticePeriod"
runat="server"
CssClass="form-control">
<asp:ListItem>Select</asp:ListItem>
<asp:ListItem>Immediate</asp:ListItem>
<asp:ListItem>15 Days</asp:ListItem>
<asp:ListItem>30 Days</asp:ListItem>
<asp:ListItem>45 Days</asp:ListItem>
<asp:ListItem>60 Days</asp:ListItem>
<asp:ListItem>90 Days</asp:ListItem>

</asp:DropDownList>
</div>

<div class="col-md-4 mb-3">
<label>Preferred Location</label>
<asp:TextBox ID="txtPreferredLocation"
runat="server"
CssClass="form-control" />
</div>

<div class="col-md-4 mb-3">
<label>Relocate</label>

<div class="checkbox-control">
    <asp:CheckBox
        ID="chkRelocate"
        runat="server"
        Text=" Yes" />
</div>

</div>

<div class="col-md-4 mb-3">
<label>Food/Accommodation</label>

<div class="checkbox-control">
    <asp:CheckBox
        ID="chkFoodAccommodation"
        runat="server"
        Text=" Required" />
</div>

</div>
                

            </div>

            <hr />
           <div class="form-section">
    <div class="form-section-title">
        Recruiter Tracking
    </div>
</div>

<div class="row">

<div class="col-md-4">
<label>Candidate Status</label>

<asp:DropDownList
ID="ddlCandidateStatus"
runat="server"
CssClass="form-control">
<asp:ListItem>Select</asp:ListItem>

<asp:ListItem>New</asp:ListItem>
<asp:ListItem>Active</asp:ListItem>
<asp:ListItem>Shortlisted</asp:ListItem>
<asp:ListItem>Interviewing</asp:ListItem>
<asp:ListItem>Selected</asp:ListItem>
<asp:ListItem>Joined</asp:ListItem>
<asp:ListItem>Rejected</asp:ListItem>
<asp:ListItem>Inactive</asp:ListItem>

</asp:DropDownList>

</div>

<div class="col-md-4">
<label>Verification Status</label>

<asp:DropDownList
ID="ddlVerificationStatus"
runat="server"
CssClass="form-control">

<asp:ListItem>Select</asp:ListItem>
<asp:ListItem>Pending</asp:ListItem>
<asp:ListItem>Verified</asp:ListItem>
<asp:ListItem>Rejected</asp:ListItem>

</asp:DropDownList>

</div>

<div class="col-md-4">
<label>Source</label>

<asp:DropDownList
ID="ddlSource"
runat="server"
CssClass="form-control">

<asp:ListItem>Select</asp:ListItem>
<asp:ListItem>Website</asp:ListItem>
<asp:ListItem>WhatsApp</asp:ListItem>
<asp:ListItem>Referral</asp:ListItem>
<asp:ListItem>College</asp:ListItem>
<asp:ListItem>Job Fair</asp:ListItem>
<asp:ListItem>Walk-in</asp:ListItem>

</asp:DropDownList>

</div>

<div class="col-md-4">
<label>Assigned Recruiter</label>

    <asp:TextBox ID="txtAssignedRecruiter"
runat="server"
CssClass="form-control" />
</div>

<div class="col-md-4">
<label>Last Contacted</label>

<asp:TextBox
ID="txtLastContacted"
runat="server"
TextMode="Date"
CssClass="form-control" />

</div>

<div class="col-md-4">
<label>Next Followup</label>

<asp:TextBox
ID="txtNextFollowup"
runat="server"
TextMode="Date"
CssClass="form-control" />

</div>

<div class="col-md-4">
<label>Internal Remarks</label>

<asp:TextBox
ID="txtInternalRemarks"
runat="server"
TextMode="MultiLine"
Rows="4"
CssClass="form-control" />

</div>

</div>
            <hr />
            <div class="form-section">
    <div class="form-section-title">
        Documents
    </div>
</div>

            <div class="row">

                <div class="col-md-4">
                    <label>Resume <span class="required">*</span></label>
                    <asp:FileUpload ID="fuResume" runat="server" />
                </div>

                <div class="col-md-4">
                    <label>Photo</label>
                    <asp:FileUpload ID="fuPhoto" runat="server" />
                </div>
                </div>    <div class="row">
                <div class="col-md-4">
                    <label>Certificate</label>
                    <asp:FileUpload ID="fuCertificate" runat="server" />
                </div>

                <div class="col-md-4">
                    <label>Aadhaar</label>
                    <asp:FileUpload ID="fuAadhaar" runat="server" />
                </div>

            </div>
            <asp:HiddenField ID="hfResume" runat="server" />
<asp:HiddenField ID="hfPhoto" runat="server" />
<asp:HiddenField ID="hfCertificate" runat="server" />
<asp:HiddenField ID="hfAadhaar" runat="server" />
            <hr />

            <div class="text-center">

                <asp:Button
                    ID="btnSave"
                    runat="server"
                    Text="Save Candidate"
                    CssClass="btn btn-success btn-lg"
                    OnClick="btnSave_Click" />

                <asp:Button
                    ID="btnCancel"
                    runat="server"
                    Text="Cancel"
                    CssClass="btn btn-danger btn-lg" PostBackUrl="~/CandidateList.aspx"
                    CausesValidation="false" />

            </div>

        </div>
    </div>

</div>

</asp:Content>


