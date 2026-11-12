<%@ Page Title="Post Your Hiring Requirement" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="PostHiringRequirement.aspx.cs" Inherits="TabletJobs.com.PostHiringRequirement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --tj-primary: #1a73e8;
            --tj-primary-dark: #135ab5;
            --tj-accent: #0f9d58;
            --tj-accent-dark: #0c7d46;
            --tj-ink: #1f2430;
            --tj-muted: #667085;
            --tj-border: #e6e8ee;
            --tj-surface: #ffffff;
            --tj-surface-soft: #f6f8fb;
            --tj-danger: #e0344c;
            --tj-radius: 14px;
        }

        .hiring-page { max-width: 1080px; margin: 30px auto 60px; font-family: inherit; }

        .hiring-card {
            background: var(--tj-surface);
            border: 1px solid var(--tj-border);
            border-radius: var(--tj-radius);
            padding: 0;
            box-shadow: 0 10px 30px rgba(20, 30, 60, .06);
            overflow: hidden;
        }

        .hiring-hero {
            padding: 36px 40px 30px;
            background: linear-gradient(135deg, #eef4ff 0%, #f7fbf9 100%);
            border-bottom: 1px solid var(--tj-border);
        }

        .hiring-title {
            font-size: 32px;
            font-weight: 800;
            color: var(--tj-ink);
            margin-bottom: 10px;
            letter-spacing: -0.3px;
        }

        .hiring-intro {
            color: var(--tj-muted);
            line-height: 1.75;
            font-size: 15.5px;
            margin-bottom: 0;
            max-width: 760px;
        }

        .hiring-body { padding: 8px 40px 40px; }

        .section-title {
            font-size: 22px;
            font-weight: 800;
            color: var(--tj-ink);
            border-bottom: none;
            padding-bottom: 0;
            margin: 40px 0 18px;
            position: relative;
            padding-left: 16px;
        }
        .section-title:before {
            content: "";
            position: absolute;
            left: 0; top: 4px; bottom: 4px;
            width: 4px;
            border-radius: 4px;
            background: linear-gradient(180deg, var(--tj-primary), var(--tj-accent));
        }
        .section-title:first-child { margin-top: 0; }

        h4.section-title { font-size: 17px !important; margin: 34px 0 16px; text-transform: uppercase; letter-spacing: .04em; color: var(--tj-primary-dark); }
        h4.section-title:before { background: var(--tj-primary); }

        /* "Why hire" feature grid */
        .hiring-body > .row:first-of-type { margin: 0 -10px 6px; }
        .hiring-body > .row:first-of-type > div {
            padding: 16px;
            margin-bottom: 4px;
        }
        .hiring-body > .row:first-of-type p {
            background: var(--tj-surface-soft);
            border: 1px solid var(--tj-border);
            border-radius: 10px;
            padding: 16px 18px;
            margin: 0;
            height: 100%;
            box-sizing: border-box;
            font-size: 14.5px;
            line-height: 1.6;
            color: var(--tj-muted);
        }
        .hiring-body > .row:first-of-type p strong {
            display: block;
            color: var(--tj-ink);
            font-size: 15.5px;
            margin-bottom: 4px;
        }

        .field-label { display: block; font-weight: 600; color: var(--tj-ink); margin-bottom: 7px; font-size: 14.5px; }
        .required { color: var(--tj-danger); margin-left: 2px; }
        .field-help { display: block; color: #8a93a3; font-size: 12.5px; margin-top: 6px; }
        .field-error { color: var(--tj-danger); font-size: 12.5px; display: block; margin-top: 5px; font-weight: 500; }

        .form-group { margin-bottom: 20px; }

        .form-control {
            width: 100%;
            box-sizing: border-box;
            border: 1px solid var(--tj-border);
            border-radius: 9px;
            padding: 10px 13px;
            font-size: 14.5px;
            color: var(--tj-ink);
            background: var(--tj-surface);
            transition: border-color .15s ease, box-shadow .15s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--tj-primary);
            box-shadow: 0 0 0 3px rgba(26, 115, 232, .12);
        }
        textarea.form-control { resize: vertical; }

     /* Radio buttons - override Master Page CSS */
     /* Checkboxes - override Master Page CSS */
.check-list {
    width: auto !important;
    margin-top: 8px;
}

.check-list tr {
    display: block !important;
}

.check-list td {
    display: block !important;
    padding: 0 0 10px 0 !important;
    vertical-align: middle !important;
    white-space: nowrap !important;
}

.check-list input[type="checkbox"] {
    display: inline-block !important;
    width: auto !important;
    height: auto !important;
    margin: 0 7px 0 0 !important;
    padding: 0 !important;
    vertical-align: middle !important;
    accent-color: var(--tj-primary);
}

.check-list label {
    display: inline !important;
    width: auto !important;
    margin: 0 !important;
    padding: 0 !important;
    font-weight: 400 !important;
    color: var(--tj-ink) !important;
    font-size: 14.5px !important;
    vertical-align: middle !important;
}
.radio-list {
    width: auto !important;
    margin-top: 8px;
}

.radio-list tr {
    display: block !important;
}

.radio-list td {
    display: block !important;
    padding: 0 0 10px 0 !important;
    vertical-align: middle !important;
    white-space: nowrap !important;
}

.radio-list input[type="radio"] {
    display: inline-block !important;
    width: auto !important;
    height: auto !important;
    margin: 0 7px 0 0 !important;
    padding: 0 !important;
    vertical-align: middle !important;
    accent-color: var(--tj-primary);
}

.radio-list label {
    display: inline !important;
    width: auto !important;
    margin: 0 !important;
    padding: 0 !important;
    font-weight: 400 !important;
    color: var(--tj-ink) !important;
    font-size: 14.5px !important;
    vertical-align: middle !important;
}


.confirmation-item {
    margin-bottom: 15px;
}

.confirmation-item input[type="checkbox"] {
    width: auto !important;
    height: auto !important;
    display: inline-block !important;
    margin: 0 7px 0 0 !important;
    vertical-align: middle !important;
}

.confirmation-item label {
    display: inline !important;
    width: auto !important;
    margin: 0 !important;
    padding: 0 !important;
    font-weight: 400 !important;
    color: var(--tj-ink) !important;
    font-size: 15px !important;
}

.checkbox-error {
    display: block !important;
    color: #dc3545 !important;
    font-size: 13px !important;
    margin-top: 6px !important;
}



        .submit-area { text-align: center; margin-top: 32px; }
        .submit-btn {
            background: linear-gradient(135deg, var(--tj-accent), var(--tj-accent-dark));
            border: none;
            color: #fff;
            padding: 14px 38px;
            border-radius: 999px;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: .01em;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(15, 157, 88, .28);
            transition: transform .12s ease, box-shadow .12s ease;
        }
        .submit-btn:hover { background: linear-gradient(135deg, var(--tj-accent-dark), var(--tj-accent-dark)); transform: translateY(-1px); box-shadow: 0 10px 24px rgba(15, 157, 88, .34); }
        .submit-btn:active { transform: translateY(0); }

        .validation-summary {
            color: var(--tj-danger);
            background: #fdeeee;
            border: 1px solid #f6c6cc;
            border-radius: 10px;
            padding: 14px 18px;
            margin-bottom: 22px;
            font-size: 14px;
        }

        @media (max-width: 767px) {
            .hiring-page { margin: 15px 10px 35px; }
            .hiring-hero { padding: 24px 20px 20px; }
            .hiring-body { padding: 4px 20px 28px; }
            .hiring-title { font-size: 24px; }
            .section-title { margin: 30px 0 14px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <div class="hiring-page">
        <div class="hiring-card">

            <div class="hiring-hero">
                <div class="hiring-title">Hire Faster. Interview Online. Hire Better.</div>
                <div class="hiring-intro">
                    Find job-ready candidates across India and conduct interviews online through TabletJobs.<br />
                    Discuss your hiring requirement and connect with relevant candidates without the cost and hassle of traditional walk-in interviews.
                </div>
            </div>

            <div class="hiring-body">

            <h3 class="section-title">Why Hire Through TabletJobs?</h3>
            <div class="row">
                <div class="col-md-6"><p><strong>Reach Candidates Across India</strong>Access candidates from multiple cities, states and job categories.</p></div>
                <div class="col-md-6"><p><strong>Online Interviews</strong>Conduct interviews online and save time on scheduling and travel.</p></div>
                <div class="col-md-6"><p><strong>High-Volume Hiring</strong>Ideal for companies hiring multiple candidates for the same role.</p></div>
                <div class="col-md-6"><p><strong>Faster Recruitment</strong>Shortlist candidates and move them through the interview process quickly.</p></div>
                <div class="col-md-6"><p><strong>Multiple Job Categories</strong>Hire across BPO, Sales, Customer Support, Logistics, Retail, Healthcare, Manufacturing, Hospitality, IT Support and more.</p></div>
                <div class="col-md-6"><p><strong>Pan-India Hiring</strong>Hire candidates from Tier 1, Tier 2 and Tier 3 cities.</p></div>
            </div>

            <h3 class="section-title">Post Your Hiring Requirement</h3>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-summary" ValidationGroup="HiringForm" HeaderText="Please correct the following:" />

            <h4 class="section-title" style="font-size:18px;">Employer Details</h4>
            <div class="row">
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblCompanyName" runat="server" CssClass="field-label" AssociatedControlID="txtCompanyName">Company Name<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="Enter company name" MaxLength="200" />
                    <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName" ValidationGroup="HiringForm" ErrorMessage="Company Name is required." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblContactPerson" runat="server" CssClass="field-label" AssociatedControlID="txtContactPerson">Contact Person Name<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-control" placeholder="Enter contact person's name" MaxLength="150" />
                    <asp:RequiredFieldValidator ID="rfvContactPerson" runat="server" ControlToValidate="txtContactPerson" ValidationGroup="HiringForm" ErrorMessage="Contact Person Name is required." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblMobile" runat="server" CssClass="field-label" AssociatedControlID="txtMobile">Mobile Number<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter mobile number" MaxLength="20" />
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile" ValidationGroup="HiringForm" ErrorMessage="Mobile Number is required." CssClass="field-error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile" ValidationGroup="HiringForm" ValidationExpression="^[0-9+()\- ]{10,20}$" ErrorMessage="Please enter a valid mobile number." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblEmail" runat="server" CssClass="field-label" AssociatedControlID="txtEmail">Email Address<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter email address" MaxLength="200" TextMode="Email" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="HiringForm" ErrorMessage="Email Address is required." CssClass="field-error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="HiringForm" ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$" ErrorMessage="Please enter a valid email address." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblCompanyLocation" runat="server" CssClass="field-label" AssociatedControlID="txtCompanyLocation">Company Location<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtCompanyLocation" runat="server" CssClass="form-control" placeholder="City / State" MaxLength="200" />
                    <asp:RequiredFieldValidator ID="rfvCompanyLocation" runat="server" ControlToValidate="txtCompanyLocation" ValidationGroup="HiringForm" ErrorMessage="Company Location is required." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblWebsite" runat="server" CssClass="field-label" AssociatedControlID="txtWebsite">Company Website</asp:Label>
                    <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" placeholder="Enter website" MaxLength="300" />
                </div>
            </div>

            <h4 class="section-title" style="font-size:18px;">Hiring Requirements</h4>
            <div class="row">
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblJobTitle" runat="server" CssClass="field-label" AssociatedControlID="ddlJobTitle">Job Title<span class="required">*</span></asp:Label>
                    <asp:DropDownList ID="ddlJobTitle" runat="server" CssClass="form-control">
                        
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvJobTitle" runat="server" ControlToValidate="ddlJobTitle" InitialValue="" ValidationGroup="HiringForm" ErrorMessage="Job Title is required." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblVacancies" runat="server" CssClass="field-label" AssociatedControlID="txtVacancies">Number of Vacancies<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtVacancies" runat="server" CssClass="form-control" placeholder="Enter number" MaxLength="6" TextMode="Number" />
                    <asp:RequiredFieldValidator ID="rfvVacancies" runat="server" ControlToValidate="txtVacancies" ValidationGroup="HiringForm" ErrorMessage="Number of Vacancies is required." CssClass="field-error" Display="Dynamic" />
                    <asp:RangeValidator ID="rvVacancies" runat="server" ControlToValidate="txtVacancies" Type="Integer" MinimumValue="1" MaximumValue="1000000" ValidationGroup="HiringForm" ErrorMessage="Vacancies must be at least 1." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblJobLocation" runat="server" CssClass="field-label" AssociatedControlID="txtJobLocation">Job Location<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtJobLocation" runat="server" CssClass="form-control" placeholder="City / State / Multiple Locations" MaxLength="300" />
                    <asp:RequiredFieldValidator ID="rfvJobLocation" runat="server" ControlToValidate="txtJobLocation" ValidationGroup="HiringForm" ErrorMessage="Job Location is required." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <span class="field-label">Work Mode<span class="required">*</span></span>
                    <asp:RadioButtonList ID="rblWorkMode" runat="server" RepeatDirection="Vertical" CssClass="radio-list">
                        <asp:ListItem Text="Work From Office" Value="Work From Office" />
                        <asp:ListItem Text="Work From Home" Value="Work From Home" />
                        <asp:ListItem Text="Hybrid" Value="Hybrid" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="rfvWorkMode" runat="server" ControlToValidate="rblWorkMode" ValidationGroup="HiringForm" ErrorMessage="Please select Work Mode." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <span class="field-label">Employment Type<span class="required">*</span></span>
                    <asp:RadioButtonList ID="rblEmploymentType" runat="server" RepeatDirection="Vertical" CssClass="radio-list">
                        <asp:ListItem Text="Full Time" Value="Full Time" />
                        <asp:ListItem Text="Part Time" Value="Part Time" />
                        <asp:ListItem Text="Contract" Value="Contract" />
                        <asp:ListItem Text="Internship" Value="Internship" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="rfvEmploymentType" runat="server" ControlToValidate="rblEmploymentType" ValidationGroup="HiringForm" ErrorMessage="Please select Employment Type." CssClass="field-error" Display="Dynamic" />
                </div>
            </div>

            <h4 class="section-title" style="font-size:18px;">Candidate Requirements</h4>
            <div class="row">
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblQualification" runat="server" CssClass="field-label" AssociatedControlID="ddlQualification">Minimum Qualification</asp:Label>
                    <asp:DropDownList ID="ddlQualification" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select qualification" Value="" />
                        <asp:ListItem Text="10th Pass" Value="10th Pass" />
                        <asp:ListItem Text="12th Pass" Value="12th Pass" />
                        <asp:ListItem Text="Graduate" Value="Graduate" />
                        <asp:ListItem Text="Post Graduate" Value="Post Graduate" />
                        <asp:ListItem Text="Diploma" Value="Diploma" />
                        <asp:ListItem Text="ITI" Value="ITI" />
                        <asp:ListItem Text="B.Com" Value="B.Com" />
                        <asp:ListItem Text="BBA" Value="BBA" />
                        <asp:ListItem Text="BCA" Value="BCA" />
                        <asp:ListItem Text="B.Tech" Value="B.Tech" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 form-group">
                    <span class="field-label">Experience Required</span>
                    <asp:RadioButtonList ID="rblExperience" runat="server" RepeatDirection="Vertical" CssClass="radio-list">
                        <asp:ListItem Text="Fresher" Value="Fresher" />
        <asp:ListItem Text="0-1 Years" Value="0-1 Years" />
        <asp:ListItem Text="1-3 Years" Value="1-3 Years" />
        <asp:ListItem Text="3-5 Years" Value="3-5 Years" />
        <asp:ListItem Text="5+ Years" Value="5+ Years" />
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblSkills" runat="server" CssClass="field-label" AssociatedControlID="txtSkills">Required Skills</asp:Label>
                    <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="Enter skills" MaxLength="1000" TextMode="MultiLine" Rows="3" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblLanguages" runat="server" CssClass="field-label" AssociatedControlID="txtLanguages">Languages Required</asp:Label>
                    <asp:TextBox ID="txtLanguages" runat="server" CssClass="form-control" placeholder="e.g. Hindi, English" MaxLength="500" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblAge" runat="server" CssClass="field-label" AssociatedControlID="txtAge">Age Requirement</asp:Label>
                    <asp:TextBox ID="txtAge" runat="server" CssClass="form-control" placeholder="Optional" MaxLength="100" />
                </div>
            </div>

            <h4 class="section-title" style="font-size:18px;">Salary &amp; Benefits</h4>
            <div class="row">
              <div class="col-md-6 form-group">
    <span class="field-label">
        Salary Range <span style="color:red;">*</span>
    </span>

    <div style="display:flex; align-items:center; gap:8px;">

        <span>Rs.</span>

        <asp:TextBox ID="txtMinSalary" runat="server"
            CssClass="form-control"
            placeholder="Minimum" />

        <span>-</span>

        <span>Rs.</span>

        <asp:TextBox ID="txtMaxSalary" runat="server"
            CssClass="form-control"
            placeholder="Maximum" />

    </div>

    <asp:RequiredFieldValidator
        ID="rfvMinimumSalary"
        runat="server"
        ControlToValidate="txtMinSalary"
        ErrorMessage="Enter minimum salary."
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="HiringForm" />

    <asp:RequiredFieldValidator
        ID="rfvMaximumSalary"
        runat="server"
        ControlToValidate="txtMaxSalary"
        ErrorMessage="Enter maximum salary."
        CssClass="field-error"
        Display="Dynamic"
        ValidationGroup="HiringForm" />

</div>
                <div class="col-md-6 form-group">
                    <span class="field-label">Incentives Available?</span>
                    <asp:RadioButtonList ID="rblIncentives" runat="server" RepeatDirection="Vertical" CssClass="radio-list">
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                    </asp:RadioButtonList>
                </div>
                <div class="col-md-12 form-group">
                    <asp:Label ID="lblBenefits" runat="server" CssClass="field-label" AssociatedControlID="txtBenefits">Other Benefits</asp:Label>
                    <asp:TextBox ID="txtBenefits" runat="server" CssClass="form-control" placeholder="Food / Accommodation / Insurance / Transport / etc." MaxLength="1000" TextMode="MultiLine" Rows="3" />
                </div>
            </div>

            <h4 class="section-title" style="font-size:18px;">Interview Details</h4>
            <div class="row">
                <div class="col-md-6 form-group">
                    <span class="field-label">Preferred Interview Mode<span class="required">*</span></span>
                    <asp:RadioButtonList ID="rblInterviewMode" runat="server" RepeatDirection="Vertical" CssClass="radio-list">
                        <asp:ListItem Text="TabletJobs Online Interview" Value="TabletJobs Online Interview" />
                        <asp:ListItem Text="Employer's Online Interview" Value="Employer's Online Interview" />
                        <asp:ListItem Text="Either" Value="Either" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="rfvInterviewMode" runat="server" ControlToValidate="rblInterviewMode" ValidationGroup="HiringForm" ErrorMessage="Please select Preferred Interview Mode." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblInterviewDate" runat="server" CssClass="field-label" AssociatedControlID="txtInterviewDate">Expected Interview Date</asp:Label>
                    <asp:TextBox ID="txtInterviewDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-6 form-group">
                    <asp:Label ID="lblCandidates" runat="server" CssClass="field-label" AssociatedControlID="txtCandidates">Expected Number of Candidates to Interview</asp:Label>
                    <asp:TextBox ID="txtCandidates" runat="server" CssClass="form-control" placeholder="Number" MaxLength="6" TextMode="Number" />
                    <asp:RangeValidator ID="rvCandidates" runat="server" ControlToValidate="txtCandidates" Type="Integer" MinimumValue="1" MaximumValue="1000000" ValidationGroup="HiringForm" ErrorMessage="Please enter a valid candidate number." CssClass="field-error" Display="Dynamic" />
                </div>
                <div class="col-md-6 form-group">
                    <span class="field-label">Interview Process</span>
                    <asp:CheckBoxList ID="cblInterviewProcess" runat="server" CssClass="check-list">
                        <asp:ListItem Text="HR Round" Value="HR Round" />
                        <asp:ListItem Text="Technical Round" Value="Technical Round" />
                        <asp:ListItem Text="Voice Assessment" Value="Voice Assessment" />
                        <asp:ListItem Text="Multiple Rounds" Value="Multiple Rounds" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:CheckBoxList>
                </div>
                <div class="col-md-12 form-group">
                    <asp:Label ID="lblInterviewInstructions" runat="server" CssClass="field-label" AssociatedControlID="txtInterviewInstructions">Interview Instructions</asp:Label>
                    <asp:TextBox ID="txtInterviewInstructions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Tell candidates anything they should know before the interview" />
                </div>
                <div class="col-md-12 form-group">
                    <asp:Label ID="lblJobDescription" runat="server" CssClass="field-label" AssociatedControlID="txtJobDescription">Job Description<span class="required">*</span></asp:Label>
                    <asp:TextBox ID="txtJobDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" placeholder="Please describe the role, responsibilities, working conditions and other important information candidates should know." />
                    <asp:RequiredFieldValidator ID="rfvJobDescription" runat="server" ControlToValidate="txtJobDescription" ValidationGroup="HiringForm" ErrorMessage="Job Description is required." CssClass="field-error" Display="Dynamic" />
                </div>
            </div>

         <h4 class="section-title" style="font-size:18px;">
    Final Confirmation
</h4>



  

    <div class="confirmation">

    <div class="confirmation-item">

        <asp:CheckBox ID="chkInformationConfirmed"
            runat="server"
            Text=" I confirm that the information provided above is accurate and that I am authorized to submit this hiring requirement on behalf of the company." />

        <asp:Label ID="lblInformationError"
            runat="server"
            Text="Please confirm that the information provided is accurate."
            CssClass="checkbox-error"
            Visible="false">
        </asp:Label>

    </div>

    <div class="confirmation-item">

        <asp:CheckBox ID="chkTerms"
            runat="server"
            Text=" I agree to the TabletJobs terms and conditions." />

        <asp:Label ID="lblTermsError"
            runat="server"
            Text="Please agree to the TabletJobs terms and conditions."
            CssClass="checkbox-error"
            Visible="false">
        </asp:Label>

    </div>

</div>



            <div class="submit-area">
                <asp:Button ID="btnSubmit" runat="server" Text="Start Hiring &amp; Schedule Interviews"
                    CssClass="submit-btn" ValidationGroup="HiringForm" OnClick="btnSubmit_Click" />
            </div>

            <p style="text-align:center; margin-top:15px; color:#555;">
                <strong>Our recruitment team will review your requirements and contact you regarding the next steps.</strong>
            </p>

            </div>

        </div>
    </div>
</asp:Content>
