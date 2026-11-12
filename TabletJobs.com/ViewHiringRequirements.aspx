<%@ Page Title="View Hiring Requirements"
    Language="C#"
    MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="ViewHiringRequirements.aspx.cs"
    Inherits="TabletJobs.com.ViewHiringRequirements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .hiring-page {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 15px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 25px;
            color: #222;
        }

        .filter-box {
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .filter-row {
            display: flex;
            gap: 15px;
            align-items: end;
            flex-wrap: wrap;
        }

        .filter-item {
            flex: 1;
            min-width: 180px;
        }

        .filter-item label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }

        .filter-item input {
            width: 100%;
            padding: 9px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .btn-search,
        .btn-clear {
            padding: 10px 22px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-search {
            background: #007bff;
            color: white;
        }

        .btn-clear {
            background: #6c757d;
            color: white;
        }

     .hiring-list {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
}

.hiring-card {
    background: #ffffff;
    border: 1px solid #ddd;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.hiring-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.12);
}


.hiring-card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 15px;
    padding: 18px;
    background: #f8f9fa;
    border-bottom: 1px solid #ddd;
}


.company-name {
    font-size: 18px;
    font-weight: 700;
    color: #222;
    margin-bottom: 5px;
}


.job-title {
    font-size: 15px;
    color: #555;
}


.requirement-status {
    background: #fff3cd;
    color: #856404;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    white-space: nowrap;
}


.hiring-card-body {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    padding: 18px;
}


.info-item {
    display: flex;
    flex-direction: column;
    gap: 4px;
}


.info-label {
    font-size: 12px;
    color: #777;
    font-weight: 600;
    text-transform: uppercase;
}


.info-value {
    font-size: 14px;
    color: #222;
    word-break: break-word;
}


.hiring-card-footer {
    padding: 15px 18px;
    border-top: 1px solid #eee;
    text-align: right;
}


.btn-view {
    display: inline-block;
    background: #28a745;
    color: white !important;
    padding: 8px 16px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
}


.btn-view:hover {
    background: #218838;
    text-decoration: none;
}


.no-records {
    text-align: center;
    padding: 40px;
    color: #777;
    background: #f8f9fa;
    border-radius: 8px;
}


/* TABLET */
@media (max-width: 900px) {

    .hiring-list {
        grid-template-columns: 1fr;
    }

}


/* MOBILE */
@media (max-width: 600px) {

    .hiring-list {
        display: block;
    }

    .hiring-card {
        margin-bottom: 15px;
    }

    .hiring-card-header {
        padding: 15px;
    }

    .company-name {
        font-size: 16px;
    }

    .job-title {
        font-size: 14px;
    }

    .hiring-card-body {
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        padding: 15px;
    }

    .hiring-card-footer {
        padding: 12px 15px;
    }

    .btn-view {
        width: 100%;
        text-align: center;
        box-sizing: border-box;
    }

}
        .btn-view {
            background: #28a745;
            color: white;
            padding: 7px 14px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
        }

        .details-box {
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-top: 25px;
            padding: 25px;
        }

        .details-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #222;
        }

        .detail-section {
            margin-bottom: 25px;
        }

        .detail-section h4 {
            background: #343a40;
            color: white;
            padding: 10px;
            margin: 0 0 15px 0;
            border-radius: 4px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 25px;
        }

        .detail-item {
            padding: 8px 0;
            border-bottom: 1px solid #e5e5e5;
        }

        .detail-label {
            font-weight: 600;
            color: #555;
        }

        .detail-value {
            color: #222;
        }

        .no-records {
            text-align: center;
            padding: 30px;
            color: #777;
            font-size: 16px;
        }

        @media (max-width: 700px) {
            .detail-grid {
                grid-template-columns: 1fr;
            }

            .filter-row {
                display: block;
            }

            .filter-item {
                margin-bottom: 12px;
            }

            .btn-search,
            .btn-clear {
                margin-right: 5px;
            }
        }
    </style>

    <div class="hiring-page">

        <h2 class="page-title">Hiring Requirements</h2>

        <!-- DATE FILTER -->
        <div class="filter-box">

            <div class="filter-row">

                <div class="filter-item">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate"
                        runat="server"
                        TextMode="Date">
                    </asp:TextBox>
                </div>

                <div class="filter-item">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate"
                        runat="server"
                        TextMode="Date">
                    </asp:TextBox>
                </div>

                <div class="filter-item" style="flex:0 0 auto;">
                    <asp:Button ID="btnSearch"
                        runat="server"
                        Text="Search"
                        CssClass="btn-search"
                        OnClick="btnSearch_Click" />
                </div>

                <div class="filter-item" style="flex:0 0 auto;">
                    <asp:Button ID="btnClear"
                        runat="server"
                        Text="Clear"
                        CssClass="btn-clear"
                        OnClick="btnClear_Click"
                        CausesValidation="false" />
                </div>

            </div>

        </div>

        <!-- LIST -->
        <div class="table-wrapper">

         <asp:ListView ID="lvHiringRequirements"
    runat="server"
    OnItemCommand="lvHiringRequirements_ItemCommand">

    <LayoutTemplate>

        <div class="hiring-list">

            <asp:PlaceHolder
                ID="itemPlaceholder"
                runat="server">
            </asp:PlaceHolder>

        </div>

    </LayoutTemplate>


    <ItemTemplate>

        <div class="hiring-card">

            <div class="hiring-card-header">

                <div>
                    <div class="company-name">
                        <%# Eval("CompanyName") %>
                    </div>

                    <div class="job-title">
                        <%# Eval("JobTitle") %>
                    </div>
                </div>

                <div class="requirement-status">
                    <%# Eval("Status") %>
                </div>

            </div>


            <div class="hiring-card-body">

                <div class="info-item">
                    <span class="info-label">Reference ID</span>
                    <span class="info-value">
                        <%# Eval("HiringRequirementID") %>
                    </span>
                </div>


                <div class="info-item">
                    <span class="info-label">Vacancies</span>
                    <span class="info-value">
                        <%# Eval("NumberOfVacancies") %>
                    </span>
                </div>


                <div class="info-item">
                    <span class="info-label">Location</span>
                    <span class="info-value">
                        <%# Eval("JobLocation") %>
                    </span>
                </div>


                <div class="info-item">
                    <span class="info-label">Posted Date</span>
                    <span class="info-value">
                        <%# Eval("CreatedDate", "{0:dd-MM-yyyy}") %>
                    </span>
                </div>

            </div>


            <div class="hiring-card-footer">

                <asp:LinkButton
                    ID="btnView"
                    runat="server"
                    Text="View Details"
                    CssClass="btn-view"
                    CommandName="ViewDetails"
                    CommandArgument='<%# Eval("HiringRequirementID") %>' />

            </div>

        </div>

    </ItemTemplate>


    <EmptyDataTemplate>

        <div class="no-records">
            No hiring requirements found.
        </div>

    </EmptyDataTemplate>

</asp:ListView>

        </div>


        <!-- DETAILS -->
        <asp:Panel ID="pnlDetails"
            runat="server"
            CssClass="details-box"
            Visible="false">

            <div class="details-title">
                Hiring Requirement Details
            </div>

            <!-- BASIC INFORMATION -->
            <div class="detail-section">

                <h4>Basic Information</h4>

                <div class="detail-grid">

                    <div class="detail-item">
                        <span class="detail-label">Reference ID:</span>
                        <asp:Label ID="lblID" runat="server" CssClass="detail-value" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Status:</span>
                        <asp:Label ID="lblStatus" runat="server" CssClass="detail-value" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Created Date:</span>
                        <asp:Label ID="lblCreatedDate" runat="server" CssClass="detail-value" />
                    </div>

                </div>

            </div>


            <!-- COMPANY INFORMATION -->
            <div class="detail-section">

                <h4>Company Information</h4>

                <div class="detail-grid">

                    <div class="detail-item">
                        <span class="detail-label">Company Name:</span>
                        <asp:Label ID="lblCompanyName" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Contact Person:</span>
                        <asp:Label ID="lblContactPerson" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Mobile:</span>
                        <asp:Label ID="lblMobile" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Email:</span>
                        <asp:Label ID="lblEmail" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Company Location:</span>
                        <asp:Label ID="lblCompanyLocation" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Website:</span>
                        <asp:Label ID="lblWebsite" runat="server" />
                    </div>

                </div>

            </div>


            <!-- JOB INFORMATION -->
            <div class="detail-section">

                <h4>Job Information</h4>

                <div class="detail-grid">

                    <div class="detail-item">
                        <span class="detail-label">Job Title:</span>
                        <asp:Label ID="lblJobTitle" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Number of Vacancies:</span>
                        <asp:Label ID="lblVacancies" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Job Location:</span>
                        <asp:Label ID="lblJobLocation" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Work Mode:</span>
                        <asp:Label ID="lblWorkMode" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Employment Type:</span>
                        <asp:Label ID="lblEmploymentType" runat="server" />
                    </div>

                </div>

            </div>


            <!-- REQUIREMENTS -->
            <div class="detail-section">

                <h4>Requirements</h4>

                <div class="detail-grid">

                    <div class="detail-item">
                        <span class="detail-label">Minimum Qualification:</span>
                        <asp:Label ID="lblQualification" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Experience Required:</span>
                        <asp:Label ID="lblExperience" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Required Skills:</span>
                        <asp:Label ID="lblSkills" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Languages Required:</span>
                        <asp:Label ID="lblLanguages" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Age Requirement:</span>
                        <asp:Label ID="lblAge" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Minimum Salary:</span>
                        <asp:Label ID="lblMinSalary" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Maximum Salary:</span>
                        <asp:Label ID="lblMaxSalary" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Incentives:</span>
                        <asp:Label ID="lblIncentives" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Other Benefits:</span>
                        <asp:Label ID="lblBenefits" runat="server" />
                    </div>

                </div>

            </div>


            <!-- INTERVIEW -->
            <div class="detail-section">

                <h4>Interview Information</h4>

                <div class="detail-grid">

                    <div class="detail-item">
                        <span class="detail-label">Interview Mode:</span>
                        <asp:Label ID="lblInterviewMode" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Expected Interview Date:</span>
                        <asp:Label ID="lblInterviewDate" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Expected Candidates:</span>
                        <asp:Label ID="lblCandidates" runat="server" />
                    </div>

                    <div class="detail-item">
                        <span class="detail-label">Interview Process:</span>
                        <asp:Label ID="lblInterviewProcess" runat="server" />
                    </div>

                </div>

            </div>


            <!-- DESCRIPTION -->
            <div class="detail-section">

                <h4>Job Description</h4>

                <div class="detail-item">
                    <asp:Label ID="lblJobDescription"
                        runat="server" />
                </div>

            </div>


            <!-- INSTRUCTIONS -->
            <div class="detail-section">

                <h4>Interview Instructions</h4>

                <div class="detail-item">
                    <asp:Label ID="lblInterviewInstructions"
                        runat="server" />
                </div>

            </div>

        </asp:Panel>

    </div>

</asp:Content>