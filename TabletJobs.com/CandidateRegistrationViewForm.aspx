<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true" CodeBehind="CandidateRegistrationViewForm.aspx.cs" Inherits="TabletJobs.com.CandidateRegistrationViewForm" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .candidate-list-container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 15px;
        }

        .page-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .candidate-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 18px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.10);
        }

        .candidate-name {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .detail-row {
            display: flex;
            margin-bottom: 9px;
        }

        .detail-label {
            width: 170px;
            font-weight: 600;
        }

        .detail-value {
            flex: 1;
        }

        .action-buttons {
            margin-top: 18px;
        }

        .btn-edit {
            display: inline-block;
            padding: 8px 18px;
            border-radius: 5px;
            text-decoration: none;
            margin-right: 8px;
        }

        @media(max-width:768px) {

            .candidate-list-container {
                margin: 10px;
                padding: 5px;
            }

            .candidate-card {
                padding: 16px;
            }

            .detail-row {
                display: block;
                margin-bottom: 12px;
            }

            .detail-label {
                width: auto;
                display: block;
                margin-bottom: 3px;
            }

            .candidate-name {
                font-size: 20px;
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

    <div class="candidate-list-container">

        <div class="page-title">
            Registered Candidates
        </div>

        <asp:ListView
    ID="lvCandidates"
    runat="server"
    OnPagePropertiesChanging="lvCandidates_PagePropertiesChanging">

            <LayoutTemplate>

                <div>
                    <asp:PlaceHolder
                        ID="itemPlaceholder"
                        runat="server">
                    </asp:PlaceHolder>
                </div>
                 <!-- PAGINATION -->
   
            </LayoutTemplate>

            <ItemTemplate>

                <div class="candidate-card">

                    <div class="candidate-name">
                        <%# Eval("CandidateName") %>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Gender</span>
                        <span class="detail-value">
                            <%# Eval("Gender") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Qualification</span>
                        <span class="detail-value">
                            <%# Eval("Qualification") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Experience</span>
                        <span class="detail-value">
                            <%# Eval("Experience") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Present Salary</span>
                        <span class="detail-value">
                            <%# Eval("PresentSalary", "{0:N2}") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Present City</span>
                        <span class="detail-value">
                            <%# Eval("PresentCity") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">State</span>
                        <span class="detail-value">
                            <%# Eval("State") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Contact Number</span>
                        <span class="detail-value">
                            <%# Eval("ContactNumber") %>
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Email ID</span>
                        <span class="detail-value">
                            <%# Eval("EmailID") %>
                        </span>
                    </div>

                    <div class="action-buttons">

                        <asp:HyperLink
                            ID="lnkEdit"
                            runat="server"
                            Text="Edit"
                            CssClass="btn-edit"
                            NavigateUrl='<%# "CandidateRegistrationEditForm.aspx?id=" + Eval("CandidateID") %>'>
                        </asp:HyperLink>

                    </div>

                </div>

            </ItemTemplate>

            <EmptyDataTemplate>

                <div>
                    No candidates found.
                </div>

            </EmptyDataTemplate>

        </asp:ListView>
             <div class="pagination">

            <asp:DataPager
                ID="dpCandidates"
                runat="server"
                PagedControlID="lvCandidates"
                PageSize="10">

                <Fields>

                    <asp:NextPreviousPagerField
                        ShowFirstPageButton="true"
                        ShowLastPageButton="true"
                        ShowNextPageButton="true"
                        ShowPreviousPageButton="true"
                        ButtonType="Link"
                        FirstPageText="First"
                        LastPageText="Last"
                        NextPageText="Next"
                        PreviousPageText="Previous" />

                </Fields>

            </asp:DataPager>

        </div>
    </div>

</asp:Content>