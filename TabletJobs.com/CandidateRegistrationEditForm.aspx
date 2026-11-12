<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="CandidateRegistrationEditForm.aspx.cs" Inherits="TabletJobs.com.CandidateRegistrationEditForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .edit-container {
            max-width: 900px;
            margin: 30px auto;
            padding: 25px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.10);
        }

        .edit-title {
            font-size: 27px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 18px;
        }

        .form-group {
            flex: 1;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .validator {
            color: red;
            font-size: 13px;
        }

        .btn-update {
            padding: 11px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-back {
    padding: 11px 30px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px;
}
        @media(max-width:768px) {

            .edit-container {
                margin: 15px;
                padding: 18px;
            }

            .form-row {
                display: block;
                margin-bottom: 0;
            }

            .form-group {
                margin-bottom: 18px;
            }

        }

    </style>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
</asp:Content>

<asp:Content ID="Content3"
    ContentPlaceHolderID="FeaturedContent"
    runat="server">
</asp:Content>

<asp:Content ID="Content4"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="edit-container">

        <div class="edit-title">
            Edit Candidate
        </div>

        <asp:ValidationSummary
            ID="ValidationSummary1"
            runat="server"
            ForeColor="Red" />

        <div class="form-row">

            <div class="form-group">

                <label>Candidate Name</label>

                <asp:TextBox
                    ID="txtCandidateName"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtCandidateName"
                    ErrorMessage="Candidate Name is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

            <div class="form-group">

                <label>Gender</label>

                <asp:DropDownList
                    ID="ddlGender"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Gender --" Value="" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Other" Value="Other" />

                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="ddlGender"
                    InitialValue=""
                    ErrorMessage="Gender is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

        </div>


        <div class="form-row">

            <div class="form-group">

                <label>Qualification</label>

                <asp:DropDownList
                    ID="ddlQualification"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Qualification --" Value="" />
                    <asp:ListItem Text="Class 10th" Value="Class 10th" />
                    <asp:ListItem Text="Class 12th" Value="Class 12th" />
                    <asp:ListItem Text="BTech" Value="BTech" />
                    <asp:ListItem Text="MTech" Value="MTech" />
                    <asp:ListItem Text="MBA" Value="MBA" />
                    <asp:ListItem Text="BSc" Value="BSc" />
                    <asp:ListItem Text="B Com" Value="B Com" />
                    <asp:ListItem Text="BA" Value="BA" />
                    <asp:ListItem Text="MBBS" Value="MBBS" />
                    <asp:ListItem Text="MBBS MD" Value="MBBS MD" />
                    <asp:ListItem Text="MBBS MS" Value="MBBS MS" />
                    <asp:ListItem Text="BAMS" Value="BAMS" />
                    <asp:ListItem Text="BHMS" Value="BHMS" />
                    <asp:ListItem Text="BDS" Value="BDS" />
                    <asp:ListItem Text="ANM" Value="ANM" />
                    <asp:ListItem Text="GNM" Value="GNM" />
                    <asp:ListItem Text="BSc Nursing" Value="BSc Nursing" />
                    <asp:ListItem Text="MSc Nursing" Value="MSc Nursing" />
                    <asp:ListItem Text="Post BSc Nursing" Value="Post BSc Nursing" />
                    <asp:ListItem Text="BVSC" Value="BVSC" />
                    <asp:ListItem Text="BPharm" Value="BPharm" />
                    <asp:ListItem Text="MPharm" Value="MPharm" />
                    <asp:ListItem Text="BSc Agriculture" Value="BSc Agriculture" />

                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="ddlQualification"
                    InitialValue=""
                    ErrorMessage="Qualification is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>


            <div class="form-group">

                <label>Experience</label>

                <asp:DropDownList
                    ID="ddlExperience"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select Experience --" Value="" />
                    <asp:ListItem Text="Fresher" Value="Fresher" />
                    <asp:ListItem Text="0-1 Years" Value="0-1 Years" />
                    <asp:ListItem Text="1-2 Years" Value="1-2 Years" />
                    <asp:ListItem Text="2-3 Years" Value="2-3 Years" />
                    <asp:ListItem Text="3-5 Years" Value="3-5 Years" />
                    <asp:ListItem Text="5-10 Years" Value="5-10 Years" />
                    <asp:ListItem Text="10+ Years" Value="10+ Years" />

                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="ddlExperience"
                    InitialValue=""
                    ErrorMessage="Experience is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

        </div>


        <div class="form-row">

            <div class="form-group">

                <label>Present Salary</label>

                <asp:TextBox
                    ID="txtPresentSalary"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtPresentSalary"
                    ErrorMessage="Present Salary is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

            <div class="form-group">

                <label>Present City</label>

                <asp:TextBox
                    ID="txtPresentCity"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtPresentCity"
                    ErrorMessage="Present City is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

        </div>


        <div class="form-row">

            <div class="form-group">

                <label>State</label>

                <asp:DropDownList
                    ID="ddlState"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem Text="-- Select State --" Value="" />
                    <asp:ListItem Text="Andhra Pradesh" />
                    <asp:ListItem Text="Bihar" />
                    <asp:ListItem Text="Chhattisgarh" />
                    <asp:ListItem Text="Delhi" />
                    <asp:ListItem Text="Gujarat" />
                    <asp:ListItem Text="Haryana" />
                    <asp:ListItem Text="Jharkhand" />
                    <asp:ListItem Text="Karnataka" />
                    <asp:ListItem Text="Kerala" />
                    <asp:ListItem Text="Madhya Pradesh" />
                    <asp:ListItem Text="Maharashtra" />
                    <asp:ListItem Text="Odisha" />
                    <asp:ListItem Text="Punjab" />
                    <asp:ListItem Text="Rajasthan" />
                    <asp:ListItem Text="Tamil Nadu" />
                    <asp:ListItem Text="Telangana" />
                    <asp:ListItem Text="Uttar Pradesh" />
                    <asp:ListItem Text="Uttarakhand" />
                    <asp:ListItem Text="West Bengal" />

                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="ddlState"
                    InitialValue=""
                    ErrorMessage="State is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>


            <div class="form-group">

                <label>Contact Number</label>

                <asp:TextBox
                    ID="txtContactNumber"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtContactNumber"
                    ErrorMessage="Contact Number is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

        </div>


        <div class="form-row">

            <div class="form-group">

                <label>Email ID</label>

                <asp:TextBox
                    ID="txtEmailID"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Email">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtEmailID"
                    ErrorMessage="Email ID is required"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>

            <div class="form-group">
            </div>

        </div>


        <div style="text-align:center;">

    <asp:Button
        ID="btnUpdate"
        runat="server"
        Text="Update Candidate"
        CssClass="btn-update"
        OnClick="btnUpdate_Click" />

    <asp:Button
        ID="btnBack"
        runat="server"
        Text="Back"
        CssClass="btn-back"
        CausesValidation="false"
        OnClick="btnBack_Click" />

</div>

        <asp:Label
            ID="lblMessage"
            runat="server">
        </asp:Label>

    </div>

</asp:Content>