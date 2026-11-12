<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="PostOnlineInterviewDetails.aspx.cs" Inherits="TabletJobs.com.PostOnlineInterviewDetails" %>
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

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
     <div class="container mt-5">
        <div class="row">
            <div class="col-12 text-center mb-4">
                <h2 class="form-header">Online Job Post</h2>
            </div>
        </div>
      <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
            <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
                <asp:Label ID="Label1" runat="server" Text=" Job Title:" AssociatedControlID="Txtnm" CssClass="form-label ml-1"></asp:Label>
            </div>
            <div class="mt-1">
                <asp:TextBox ID="Txtnm" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvTxtnm" runat="server" ControlToValidate="Txtnm" SetFocusOnError="true" Display="Dynamic" 
                    ErrorMessage="Enter Job Title" CssClass="mt-1" Style="color:#dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
</div>
       


 <div class="row mb-3">
        <div class="col-md-12">
            <div class="form-group">
                <div class="d-flex align-items-center">
                    <span style="color: red;">* </span>
                    <asp:Label ID="lblCategory" runat="server" Text="Job Category:" AssociatedControlID="ddlCategory" CssClass="form-label"></asp:Label>
                </div>
               <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" 
    OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
</asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" InitialValue="" ErrorMessage="Select a category" CssClass="text-danger" Display="Dynamic" />
            </div>
        </div>
    </div>

   <%-- <!-- Subcategory -->
    <div class="row mb-3">
        <div class="col-md-12">
            <div class="form-group">
                <asp:Label ID="lblSubcategory" runat="server" Text="Job Subcategory:" AssociatedControlID="ddlSubcategory" CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddlSubcategory" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Select Job Sub Category --" Value="" />
                </asp:DropDownList>
            </div>
        </div>
    </div>--%>



       
<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label12" runat="server" Text="Qualification:" AssociatedControlID="Dropqual" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="Dropqual" runat="server" CssClass="form-control" EnableViewState="true">
                <asp:ListItem Value="">Your Qualification</asp:ListItem>
               
            </asp:DropDownList>
            <asp:RequiredFieldValidator 
                ID="rfvDrpQual" 
                runat="server" 
                ControlToValidate="Dropqual" 
                InitialValue="" 
                SetFocusOnError="true" 
                Display="Dynamic" 
                ErrorMessage="Please select a qualification" 
                CssClass="mt-1" 
                Style="color: #dc3545; font-size: 15px; font-weight: normal;">
            </asp:RequiredFieldValidator>
        </div>
    </div>
</div>
</div>
<div class="mb-3">
  <label for="ddlGenderReq" class="form-label">
    Gender Required <span style="color:#dc3545">*</span>
  </label>
  <asp:DropDownList ID="ddlGenderReq" runat="server" CssClass="form-select">
    <asp:ListItem Text="-- Select --" Value="0"></asp:ListItem>
    <asp:ListItem Text="Only females can apply for this job" Value="Only females can apply for this job"></asp:ListItem>
    <asp:ListItem Text="Only males can apply for this job" Value="Only males can apply for this job"></asp:ListItem>
    <asp:ListItem Text="Both males and females can apply for this job" Value="Both males and females can apply for this job"></asp:ListItem>
  </asp:DropDownList>
  <!-- Required validator (since it’s mandatory) -->
  <asp:RequiredFieldValidator
      ID="rfvGenderReq"
      runat="server"
      ControlToValidate="ddlGenderReq"
      InitialValue="0"
      ErrorMessage="Please select Gender Required."
      CssClass="text-danger"
      Display="Dynamic" />
</div>

     
<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label6" runat="server" Text="Experience:" AssociatedControlID="DrpExp" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="DrpExp" runat="server" CssClass="form-control" EnableViewState="true">
               
               
            </asp:DropDownList>
            <asp:RequiredFieldValidator 
                ID="rfvDrpExp" 
                runat="server" 
                ControlToValidate="DrpExp" 
                InitialValue="Select Experience" 
                ErrorMessage="Please select your experience." 
                CssClass="text-danger" 
                Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
    </div>
</div>
</div>

        <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label7" runat="server" Text="Salary Offered:" AssociatedControlID="Drpsal" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
                <asp:DropDownList ID="Drpsal" runat="server" EnableViewState="true">
                    <asp:ListItem Value="">Please Select Salary</asp:ListItem>
                    <asp:ListItem>Below Rs 10,000 per month</asp:ListItem>
                    <asp:ListItem>Rs 10,000 to Rs 15,000 per month</asp:ListItem>
                    <asp:ListItem>Rs 15,000 to Rs 20,000 per month</asp:ListItem>
                    <asp:ListItem>Rs 15,000 to Rs 35,000 per month</asp:ListItem>
                     <asp:ListItem>Rs 17,000 to Rs 30,000 per month</asp:ListItem>
                    <asp:ListItem>Rs 17,000 to Rs 40,000 per month</asp:ListItem>
                     <asp:ListItem>Rs 20,000 to Rs 30,000 per month</asp:ListItem>
                    <asp:ListItem>Rs 20,000 to Rs 35,000 per month</asp:ListItem>
                      <asp:ListItem>Rs 25,000 to Rs 40,000 per month</asp:ListItem>
                     <asp:ListItem>Rs 30,000 to Rs 40,000 per month</asp:ListItem>
                     <asp:ListItem>Rs 40,000 to Rs 60,000 per month</asp:ListItem>
                     <asp:ListItem>Rs 60,000 to Rs 80,000 per month</asp:ListItem>
                    
                     <asp:ListItem>Rs 80,000 to Rs 1,00,000 per month</asp:ListItem>
                    <asp:ListItem>Rs 1,00,000 to Rs 2,00,000</asp:ListItem>
                    <asp:ListItem>2 lakhs to 3 lakhs per month</asp:ListItem>
                    <asp:ListItem>3 lakhs to 4 lakhs per month</asp:ListItem>
                    <asp:ListItem>4 lakhs to 5 lakhs per month</asp:ListItem>
                    <asp:ListItem>More than 5 lakhs per month</asp:ListItem>
                    <asp:ListItem>Best In The Industry </asp:ListItem>
                    <asp:ListItem>Rs 20,000 to Rs 50,000 Per Month </asp:ListItem>
                    <asp:ListItem>Rs 20,000 to Rs 40,000 Per Month </asp:ListItem>
                    <asp:ListItem>Rs 20,000 to Rs Rs 70,000 Per Month</asp:ListItem>
                       <asp:ListItem>5,000 AED to 8,000 AED per month</asp:ListItem>
                    <asp:ListItem>We will inform after interview</asp:ListItem>
                </asp:DropDownList>
            <!-- Required Field Validator for Salary -->
            <asp:RequiredFieldValidator 
                ID="rfvTxtsal" 
                runat="server" 
                ControlToValidate="Drpsal" 
                ErrorMessage="Salary Offered is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
            <!-- Optional Range Validator if Salary needs to be a numeric value -->
          
        </div>
    </div>
</div>
        </div>
<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label3" runat="server" Text="No. of positions:" AssociatedControlID="Drppos" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="Drppos" runat="server" CssClass="form-control" EnableViewState="true">
                <asp:ListItem Value="">Select No. positions</asp:ListItem>
                <asp:ListItem>1-5</asp:ListItem>
                <asp:ListItem>6-10</asp:ListItem>
                <asp:ListItem>10-30</asp:ListItem>
                <asp:ListItem>30-50</asp:ListItem>
                <asp:ListItem>50+</asp:ListItem>
            </asp:DropDownList>
            <!-- Required Field Validator for DropDownList -->
            <asp:RequiredFieldValidator 
                ID="rfvDrppos" 
                runat="server" 
                ControlToValidate="Drppos" 
                InitialValue="" 
                ErrorMessage="Please select the number of positions." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
</div>
        </div>

        <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label10" runat="server" Text="Food and accommodation:" AssociatedControlID="DrpAccomo" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="DrpAccomo" runat="server" CssClass="form-control" EnableViewState="true">
                <asp:ListItem Value="">Please Select</asp:ListItem>
                 <asp:ListItem>Accommodation Available</asp:ListItem>
                 <asp:ListItem>Food and Accommodation Available </asp:ListItem>
                <asp:ListItem>Food and Accommodation Available Only for Females</asp:ListItem>
                <asp:ListItem>Food and Accommodation Available for Both Males and Females</asp:ListItem>
                <asp:ListItem>Accommodation Available For Females and Food Needs to Cook</asp:ListItem>
                <asp:ListItem>Accommodation Available For Both Females and Males, But Food Needs to Cook</asp:ListItem>
                <asp:ListItem>Food and accommodation not Available for Both Males and Females</asp:ListItem>
                <asp:ListItem>Food available  for both male and female but accommodation available for only female.</asp:ListItem>

            </asp:DropDownList>
          <asp:RequiredFieldValidator 
                ID="RequiredFieldValidator1" 
                runat="server" 
                ControlToValidate="DrpAccomo" 
                InitialValue="" 
                ErrorMessage="Please select the food and accommodation option" 
                CssClass="text-danger" 
                Display="Dynamic" SetFocusOnError="true"/>
        </div>
    </div>
</div>
</div>


<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label4" runat="server" Text="Job Type:" AssociatedControlID="DrpJob" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="DrpJob" runat="server" CssClass="form-control" EnableViewState="true">
                <asp:ListItem Value="">Select Job Type</asp:ListItem>
                <asp:ListItem>PartTime</asp:ListItem>
                <asp:ListItem>FullTime</asp:ListItem>
            </asp:DropDownList>
            <!-- Required Field Validator for DropDownList -->
            <asp:RequiredFieldValidator 
                ID="rfvDrpJob" 
                runat="server" 
                ControlToValidate="DrpJob" 
                InitialValue="" 
                ErrorMessage="Please select a job type." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
</div>
</div>
    <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label5" runat="server" Text="Job Time:" AssociatedControlID="Drptim" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="Drptim" runat="server" CssClass="form-control">
                <asp:ListItem Value="">Select Job Time</asp:ListItem>
                <asp:ListItem>General shift</asp:ListItem>
                <asp:ListItem>3 Shifts a Day</asp:ListItem>
                <asp:ListItem>2 Shifts a Day</asp:ListItem>
                <asp:ListItem>10hrs/12hrs/24hrs</asp:ListItem>
                <asp:ListItem>Others</asp:ListItem>
            </asp:DropDownList>
            <!-- Required Field Validator for DropDownList -->
            <asp:RequiredFieldValidator 
                ID="rfvDrptim" 
                runat="server" 
                ControlToValidate="Drptim" 
                InitialValue="" 
                ErrorMessage="Please select a job time." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
</div>
</div>
<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label13" runat="server" Text="Job Description:" AssociatedControlID="Txtdesc" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="Txtdesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
            <!-- Required Field Validator for TextBox -->
            <asp:RequiredFieldValidator 
                ID="rfvTxtdesc" 
                runat="server" 
                ControlToValidate="Txtdesc" 
                ErrorMessage="Job Description is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
            <!-- Optional Regular Expression Validator to enforce minimum length for Job Description -->
           
        </div>
            </div>
    </div>
</div>

       <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label14" runat="server" Text="Recruiter Name:" AssociatedControlID="Txtrnm" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="Txtrnm" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for Recruiter Name -->
            <asp:RequiredFieldValidator 
                ID="rfvTxtrnm" 
                runat="server" 
                ControlToValidate="Txtrnm" 
                ErrorMessage="Recruiter Name is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
</div>
        </div>

<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label15" runat="server" Text="Recruiter Contact Number:." AssociatedControlID="Txtcn" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="Txtcn" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for Contact No. -->
            <asp:RequiredFieldValidator 
                ID="rfvTxtcn" 
                runat="server" 
                ControlToValidate="Txtcn" 
                ErrorMessage="Contact Number is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
            <!-- Optional Regular Expression Validator to enforce phone number format -->
           
        </div>
    </div>
</div>
</div>
      
      <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
            <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label16" runat="server" Text="Hospital Logo:" AssociatedControlID="FileUpload2" CssClass="form-label"></asp:Label>
                </div>
            <asp:FileUpload ID="FileUpload2" runat="server" />
            <asp:HiddenField ID="ImageData" runat="server" />
           
            <asp:Image ID="Image1" runat="server" CssClass="img-thumbnail mt-2" />
        </div>
    </div>
</div>
          <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
            <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="LabelHospitalImages" runat="server" Text="Hospital Images:" AssociatedControlID="FileUploadHospitalImages" CssClass="form-label"></asp:Label>
                </div>
            <asp:FileUpload ID="FileUploadHospitalImages" runat="server" AllowMultiple="true" />
            <asp:HiddenField ID="ImageDataHospital" runat="server" />
            <!-- Optional: Placeholder for multiple images -->
            <asp:Image ID="Image2" runat="server" CssClass="img-thumbnail mt-2" />
        </div>
    </div>
</div>



<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label17" runat="server" Text="Hospital Name:" AssociatedControlID="Txthnm" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="Txthnm" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for TextBox -->
            <asp:RequiredFieldValidator 
                ID="rfvTxthnm" 
                runat="server" 
                ControlToValidate="Txthnm" 
                ErrorMessage="Hospital Name is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
</div>
</div>
         <div class="mb-3">
  <label for="TxtAboutHospital" class="form-label">
    About Hospital <span style="color:#dc3545">*</span>
  </label>
  <asp:TextBox ID="TxtAboutHospital" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control" />
  <!-- Enforce only the max words if provided -->
               <asp:RequiredFieldValidator 
                ID="RequiredFieldValidator2" 
                runat="server" 
                ControlToValidate="TxtAboutHospital" 
                ErrorMessage="About Hospital is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
  <asp:CustomValidator ID="cvAboutHospMaxWords" runat="server"
      ControlToValidate="TxtAboutHospital"
      OnServerValidate="cvAboutHospMaxWords_ServerValidate"
      ErrorMessage="About Hospital must be 10,000 words or fewer."
      CssClass="text-danger"
      Display="Dynamic" />
</div>

   <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Lblhadd" runat="server" Text="Hospital Address:" AssociatedControlID="Txtadd" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="Txtadd" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for Hospital Address -->
            <asp:RequiredFieldValidator 
                ID="rfvTxtadd" 
                runat="server" 
                ControlToValidate="Txtadd" 
                ErrorMessage="Hospital Address is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
        </div>
</div>

<div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label19" runat="server" Text="City:" AssociatedControlID="Txtcity" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="Txtcity" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for City -->
            <asp:RequiredFieldValidator 
                ID="rfvTxtcity" 
                runat="server" 
                ControlToValidate="Txtcity" 
                ErrorMessage="City is required." 
                CssClass="text-danger" 
                Display="Dynamic" />
        </div>
    </div>
</div>
</div>
     <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label8" runat="server" Text="State:" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="ddlStates" CssClass="form-control" runat="server" AppendDataBoundItems="true" AutoPostBack="false" EnableViewState="true">
   
</asp:DropDownList>

<asp:RequiredFieldValidator 
    ID="rfvStates" 
    runat="server" 
    ControlToValidate="ddlStates" 
    InitialValue="Select a state" 
    ErrorMessage="Please select a state." 
    Display="Dynamic"
    CssClass="text-danger" />
        </div>
    </div>
</div>

</div>
         <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label9" runat="server" Text="Country:" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="ddlCountry" CssClass="form-control" runat="server" AppendDataBoundItems="true" AutoPostBack="false" EnableViewState="true">
    <asp:ListItem Text="Select Country" Value="" />
                <asp:ListItem>India</asp:ListItem>
                <asp:ListItem>Saudi Arabia</asp:ListItem>
                <asp:ListItem>UAE</asp:ListItem>
                <asp:ListItem>Oman</asp:ListItem>
                <asp:ListItem>Qatar</asp:ListItem>
                <asp:ListItem>Kuwait</asp:ListItem>
                <asp:ListItem>Bahrain</asp:ListItem>
</asp:DropDownList>

<asp:RequiredFieldValidator 
    ID="rfvCountry" 
    runat="server" 
    ControlToValidate="ddlCountry" 
    InitialValue="" 
    Display="Dynamic"
    ErrorMessage="Please select Country." 
    CssClass="text-danger" />
        </div>
    </div>
</div>

</div>


         <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <!--<span class="required-lbl" style="color: red;">* </span>-->
            <asp:Label ID="Label11" runat="server" Text="Interview Date & Time" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:DropDownList ID="Drptiming" CssClass="form-control" runat="server" AppendDataBoundItems="true" AutoPostBack="false">
    <asp:ListItem Text="Select Option" Value="" />
                <asp:ListItem>Coming Soon</asp:ListItem>
                <asp:ListItem>Upcoming Week</asp:ListItem>
                
</asp:DropDownList>

        </div>
    </div>
</div>

</div>


<!-- Row for Interview Date -->
<div class="row mb-3">
    <div class="col-md-2">
        <div class="form-group">
            <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
                <asp:Label ID="LabelInterviewDate" runat="server" Text="Interview Date:" AssociatedControlID="calInterviewDate" CssClass="form-label ml-1"></asp:Label>
            </div>
            <div class="mt-1">
                <asp:TextBox ID="calInterviewDate" runat="server" CssClass="form-control date-picker"  TextMode="Date" />
               <asp:RequiredFieldValidator ID="rfvInterviewDate" runat="server" ControlToValidate="calInterviewDate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Select Interview Date" CssClass="mt-1" Style="color:#dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="form-group">
            <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
                <asp:Label ID="LabelInterviewStartTime" runat="server" Text="Interview Start Time:" AssociatedControlID="ddlInterviewStartTime" CssClass="form-label ml-1"></asp:Label>
            </div>
            <div class="mt-1">
                <asp:DropDownList ID="ddlInterviewStartTime" runat="server" CssClass="form-control" EnableViewState="true">
                     <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                    <asp:ListItem Text="8:00 AM" Value="08:00 AM"></asp:ListItem>
                    <asp:ListItem Text="9:00 AM" Value="09:00 AM"></asp:ListItem>
                    <asp:ListItem Text="10:00 AM" Value="10:00 AM"></asp:ListItem>
                    <asp:ListItem Text="11:00 AM" Value="11:00 AM"></asp:ListItem>
                    <asp:ListItem Text="12:00 PM" Value="12:00 PM"></asp:ListItem>
                    <asp:ListItem Text="1:00 PM" Value="13:00 PM"></asp:ListItem>
                    <asp:ListItem Text="2:00 PM" Value="14:00 PM"></asp:ListItem>
                    <asp:ListItem Text="3:00 PM" Value="15:00 PM"></asp:ListItem>
                    <asp:ListItem Text="4:00 PM" Value="16:00 PM"></asp:ListItem>
                    <asp:ListItem Text="5:00 PM" Value="17:00 PM"></asp:ListItem>
                    <asp:ListItem Text="6:00 PM" Value="18:00 PM"></asp:ListItem>
                   <asp:ListItem Text="7:00 PM" Value="19:00 PM"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvInterviewStartTime" runat="server" ControlToValidate="ddlInterviewStartTime" SetFocusOnError="true" 
                    Display="Dynamic" ErrorMessage="Select Start Time" InitialValue="0" CssClass="mt-1" Style="color:#dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="form-group">
            <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
                <asp:Label ID="LabelInterviewEndTime" runat="server" Text="Interview End Time:" AssociatedControlID="ddlInterviewEndTime" CssClass="form-label ml-1"></asp:Label>
            </div>
            <div class="mt-1">
                <asp:DropDownList ID="ddlInterviewEndTime" runat="server" CssClass="form-control" EnableViewState="true">
                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                    <asp:ListItem Text="9:00 AM" Value="09:00 AM"></asp:ListItem>
                    <asp:ListItem Text="10:00 AM" Value="10:00 AM"></asp:ListItem>
                    <asp:ListItem Text="11:00 AM" Value="11:00 AM"></asp:ListItem>
                    <asp:ListItem Text="12:00 PM" Value="12:00 PM"></asp:ListItem>
                    <asp:ListItem Text="1:00 PM" Value="13:00 PM"></asp:ListItem>
                    <asp:ListItem Text="2:00 PM" Value="14:00 PM"></asp:ListItem>
                    <asp:ListItem Text="3:00 PM" Value="15:00 PM"></asp:ListItem>
                    <asp:ListItem Text="4:00 PM" Value="16:00 PM"></asp:ListItem>
                    <asp:ListItem Text="5:00 PM" Value="17:00 PM"></asp:ListItem>
                    <asp:ListItem Text="6:00 PM" Value="18:00 PM"></asp:ListItem>
                    <asp:ListItem Text="7:00 PM" Value="19:00 PM"></asp:ListItem>
                    <asp:ListItem Text="8:00 PM" Value="20:00 PM"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvInterviewEndTime" runat="server" InitialValue="0" ControlToValidate="ddlInterviewEndTime" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Select End Time" CssClass="mt-1" Style="color:#dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
</div>
        
        <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
             <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label18" runat="server" Text="Representative:" AssociatedControlID="cblJobRoles" CssClass="form-label ml-1"></asp:Label>
           </div>
            <div class="checkbox-container">
                <asp:CheckBoxList ID="cblJobRoles" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" CssClass="checkbox-grid">
                  
                
                </asp:CheckBoxList>
            </div>
            
            <asp:CustomValidator 
                ID="cvJobRoles" 
                runat="server" 
                ClientValidationFunction="validateJobRoles" 
                ErrorMessage="Please select ." 
                Display="Dynamic" 
               OnServerValidate="cvJobRoles_ServerValidate"
                 CssClass="mt-1 text-danger"
    EnableClientScript="true">
            </asp:CustomValidator>
        </div>
    </div>
</div>
         <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
            <asp:Label ID="Label20" runat="server" Text="QR Code:" AssociatedControlID="FileUpload4" CssClass="form-label"></asp:Label>
            <asp:FileUpload ID="FileUpload4" runat="server" AllowMultiple="true" />
             <asp:TextBox ID="QRText" runat="server"></asp:TextBox>
            <asp:HiddenField ID="ImageData4" runat="server" />
            <!-- Optional: Placeholder for multiple images -->
            <asp:Image ID="Image4" runat="server" CssClass="img-thumbnail mt-2" />
        </div>
    </div>
</div>
         <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label2" runat="server" Text="Benefits" AssociatedControlID="TxtBenefits" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="TxtBenefits" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for City -->
           
        </div>
    </div>
</div>
</div>
         <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="Label21" runat="server" Text="HasAccomodation:" AssociatedControlID="ddlAcco" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
               <asp:DropDownList ID="ddlAcco" runat="server">
                   <asp:ListItem>--Please select--</asp:ListItem>
    <asp:ListItem Text="Yes" Value="T"></asp:ListItem>
    <asp:ListItem Text="No" Value="F"></asp:ListItem>
</asp:DropDownList>         
          </div>
            <br />
            <%--New  Fields added--%>
                     <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">* </span>
            <asp:Label ID="lblFreq" runat="server" Text="Interview Frequency:" AssociatedControlID="ddlFreq" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
               <asp:DropDownList ID="ddlFreq" runat="server">
                   <asp:ListItem>--Please select--</asp:ListItem>
    <asp:ListItem Text="Daily" Value="Daily"></asp:ListItem>
    <asp:ListItem Text="Weekly"  Value="Weekly"></asp:ListItem>
    <asp:ListItem Text="Monthly"  Value="Monthly"></asp:ListItem>
</asp:DropDownList>   
                <asp:RequiredFieldValidator 
                    ID="rfvFreq" 
                    runat="server" 
                    ControlToValidate="ddlFreq" 
                    InitialValue="" 
                    ErrorMessage="Please select Interview Frequency." 
                    ForeColor="Red" 
                    Display="Dynamic" />
    </div>
            </div>
        </div>
                         
                          
     <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <span class="required-lbl" style="color: red;">*</span>
                 <asp:Label ID="lblStatus" runat="server" Text="Status:" AssociatedControlID="ddlFreq" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
               <asp:DropDownList ID="ddlStatus" runat="server">
                   <asp:ListItem>--Please select--</asp:ListItem>
    <asp:ListItem Text="Not Scheduled" Value="Not Scheduled"></asp:ListItem>
    <asp:ListItem Text="Scheduled"  Value="Scheduled"></asp:ListItem>
    <asp:ListItem Text="Cancelled"  Value="Cancelled"></asp:ListItem>
 <asp:ListItem Text="Completed"  Value="Completed"></asp:ListItem>
</asp:DropDownList>  
                 <asp:RequiredFieldValidator 
                    ID="rfvStatus" 
                    runat="server" 
                    ControlToValidate="ddlStatus" 
                    InitialValue="" 
                    ErrorMessage="Please select Status." 
                    ForeColor="Red" 
                    Display="Dynamic" />
    </div>
            <%--Close New Added Fields--%>

    </div>
</div>
</div>

                                <div class="row mb-3">
    <div class="col-md-12">
        <div class="form-group">
             <div class="d-flex align-items-center">
                <%--<span class="required-lbl" style="color: red;">* </span>--%>
            <asp:Label ID="Label22" runat="server" Text="Whatsapp link::" AssociatedControlID="txtwhatsapplink" CssClass="form-label"></asp:Label>
                 </div>
            <div class="mt-1">
            <asp:TextBox ID="txtwhatsapplink" runat="server" CssClass="form-control" />
            <!-- Required Field Validator for Recruiter Name -->
           <%-- <asp:RequiredFieldValidator 
                ID="RequiredFieldValidator3" 
                runat="server" 
                ControlToValidate="txtwhatsapplink" 
                ErrorMessage="WhatsApp Link is required." 
                CssClass="text-danger" 
                Display="Dynamic" />--%>
        </div>
    </div>
</div>
        </div>

       

        
        <div class="form-footer">
            <asp:Button ID="Button1" runat="server" Text="Submit Now" CausesValidation="true" CssClass="btn btn-primary mt-3" OnClick="Button1_Click" />
            <asp:Button ID="Button2" runat="server" Text="Manage Interview" CausesValidation="false" CssClass="btn btn-primary mt-3" PostBackUrl="ManageInterview.aspx"/>
        </div>
        <asp:Label ID="lblErrorMessage" runat="server" Text="Label"></asp:Label>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:hospi2yp_tabletjobssConnectionString_V02 %>" SelectCommand="SELECT * FROM [JobPost]"></asp:SqlDataSource>
    </div>

    <!-- Bootstrap JavaScript and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>


        document.getElementById('<%= FileUpload2.ClientID %>').addEventListener('change', function (event) {
            var file = event.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var img = document.getElementById('<%= Image1.ClientID %>');
                    img.src = e.target.result;
                    img.style.display = 'block';
                    //alert(e.target.result);
                    //alert(e.target.result);
                    document.getElementById('<%= ImageData.ClientID %>').value = e.target.result.split(',')[1];

                }
                reader.readAsDataURL(file);
            }
        });


        document.addEventListener('DOMContentLoaded', function () {
            var datePicker = document.querySelector('.date-picker');
            if (datePicker) {
                var today = new Date().toISOString().split('T')[0];
                datePicker.setAttribute('min', today);
            }
        });
    </script>
    
<script>
    // JavaScript function to disable Interview controls when Drptiming is selected
    function toggleInterviewControls() {
        var drpTiming = document.getElementById('<%= Drptiming.ClientID %>');
        var interviewDate = document.getElementById('<%= calInterviewDate.ClientID %>');
        var startTime = document.getElementById('<%= ddlInterviewStartTime.ClientID %>');
        var endTime = document.getElementById('<%= ddlInterviewEndTime.ClientID %>');

        // Check if a value is selected in Drptiming dropdown
        if (drpTiming.value !== "") {
            // Disable Interview Date, Start Time, and End Time if Drptiming is selected
            interviewDate.disabled = true;
            startTime.disabled = true;
            endTime.disabled = true;
        } else {
            // Enable Interview Date, Start Time, and End Time if Drptiming is reset
            interviewDate.disabled = false;
            startTime.disabled = false;
            endTime.disabled = false;
        }
    }
</script>
     <script type="text/javascript">
         function validateJobRoles(source, args) {
             var checkBoxList = document.getElementById('<%= cblJobRoles.ClientID %>');
             var checkboxes = checkBoxList.getElementsByTagName("input");
             var isChecked = false;

             for (var i = 0; i < checkboxes.length; i++) {
                 if (checkboxes[i].type == "checkbox" && checkboxes[i].checked) {
                     isChecked = true;
                     break;
                 }
             }

             args.IsValid = isChecked;
         }
</script>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

