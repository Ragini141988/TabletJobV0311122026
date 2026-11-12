<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="ViewOnlineInterviewCandidates.aspx.cs" Inherits="TabletJobs.com.ViewOnlineInterviewCandidates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        body{font-family:Arial;background:#f5f7fb;margin:20px}.wrap{background:#fff;padding:20px;
            border-radius:10px;overflow:auto}.grid{width:100%;border-collapse:collapse}.grid th
   ,.grid td{border:1px solid #ddd;padding:9px}.grid th{font-weight:bold}</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">

    <style>
        .candidate-wrap {
            width: 95%;
            max-width: 1400px;
            margin: 25px auto;
        }

        .candidate-wrap h2 {
            margin-bottom: 20px;
        }

        .filter-box {
            background: #f5f7fa;
            border: 1px solid #ddd;
            padding: 18px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: end;
        }

        .filter-item {
            min-width: 180px;
        }

        .filter-item label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .filter-item select,
        .filter-item input {
            width: 100%;
            height: 38px;
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .btn-filter {
            height: 38px;
            padding: 0 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-search {
            background: #007bff;
            color: white;
        }

        .btn-reset {
            background: #6c757d;
            color: white;
        }

        .candidate-list {
            width: 100%;
        }

        .candidate-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            margin-bottom: 15px;
            padding: 18px;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.08);
        }

        /* Payment successful */
        .candidate-paid {
            border-left: 6px solid #28a745;
            background: #f0fff4;
        }

        /* Payment pending/failed */
        .candidate-unpaid {
            border-left: 6px solid #dc3545;
            background: #fff5f5;
        }

        .candidate-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }

        .candidate-name {
            font-size: 19px;
            font-weight: 700;
        }

        .application-id {
            color: #666;
            font-size: 13px;
        }

        .payment-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
        }

        .paid-status {
            background: #28a745;
            color: white;
        }

        .unpaid-status {
            background: #dc3545;
            color: white;
        }

        .candidate-details {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px 25px;
        }

        .detail-item {
            font-size: 14px;
        }

        .detail-label {
            font-weight: 600;
            color: #555;
        }

        .pagination {
            text-align: center;
            margin-top: 25px;
        }

        .legend {
            margin-bottom: 15px;
            font-size: 14px;
        }

        .legend span {
            display: inline-block;
            padding: 5px 10px;
            margin-right: 10px;
            border-radius: 5px;
            font-weight: 600;
        }

        .legend-paid {
            background: #d4edda;
            color: #155724;
        }

        .legend-unpaid {
            background: #f8d7da;
            color: #721c24;
        }

        @media (max-width: 768px) {

            .candidate-details {
                grid-template-columns: 1fr;
            }

            .filter-row {
                display: block;
            }

            .filter-item {
                margin-bottom: 12px;
            }

            .btn-filter {
                margin-right: 5px;
            }
        }
    </style>


    <div class="candidate-wrap">

        <h2>Online Interview Candidates</h2>


        <!-- FILTER -->
        <div class="filter-box">

            <div class="filter-row">

                <div class="filter-item">

                    <label>Job</label>

                    <asp:DropDownList
                        ID="ddlJobFilter"
                        runat="server">
                    </asp:DropDownList>

                </div>


                <div class="filter-item">

                    <label>From Date</label>

                    <asp:TextBox
                        ID="txtFromDate"
                        runat="server"
                        TextMode="Date">
                    </asp:TextBox>

                </div>


                <div class="filter-item">

                    <label>To Date</label>

                    <asp:TextBox
                        ID="txtToDate"
                        runat="server"
                        TextMode="Date">
                    </asp:TextBox>

                </div>


                <div class="filter-item">

                    <asp:Button
                        ID="btnFilter"
                        runat="server"
                        Text="Search"
                        CssClass="btn-filter btn-search"
                        OnClick="btnFilter_Click" />

                    <asp:Button
                        ID="btnReset"
                        runat="server"
                        Text="Reset"
                        CssClass="btn-filter btn-reset"
                        OnClick="btnReset_Click" />

                </div>

            </div>

        </div>


        <!-- LEGEND -->

        <div class="legend">

            <span class="legend-paid">
                Payment Done
            </span>

            <span class="legend-unpaid">
                Payment Pending / Failed
            </span>

        </div>


        <!-- LISTVIEW -->

        <asp:ListView
            ID="lvCandidates"
            runat="server">

            <LayoutTemplate>

                <div class="candidate-list">

                    <asp:PlaceHolder
                        ID="itemPlaceholder"
                        runat="server">
                    </asp:PlaceHolder>

                </div>

            </LayoutTemplate>


            <ItemTemplate>

                <div class='<%# GetCandidateCss(Eval("PaymentStatus")) %>'>

                    <div class="candidate-header">

                        <div>

                            <div class="candidate-name">

                                <%# Eval("CandidateName") %>

                            </div>

                            <div class="application-id">

                                Application ID:
                                <%# Eval("ApplicationID") %>

                            </div>

                        </div>


                        <div>

                            <span class='<%# GetPaymentStatusCss(Eval("PaymentStatus")) %>'>

                                <%# GetPaymentStatusText(Eval("PaymentStatus")) %>

                            </span>

                        </div>

                    </div>


                    <div class="candidate-details">

                        <div class="detail-item">

                            <span class="detail-label">
                                Mobile:
                            </span>

                            <%# Eval("Mobile") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Email:
                            </span>

                            <%# Eval("Email") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Hospital:
                            </span>

                            <%# Eval("HospitalName") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                City:
                            </span>

                            <%# Eval("City") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Applying For:
                            </span>

                            <%# Eval("ApplyingFor") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Qualification:
                            </span>

                            <%# Eval("Qualification") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Experience:
                            </span>

                            <%# Eval("Experience") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Application Status:
                            </span>

                            <%# Eval("ApplicationStatus") %>

                        </div>


                        <div class="detail-item">

                            <span class="detail-label">
                                Applied On:
                            </span>

                            <%# Eval("CreatedAt", "{0:dd-MM-yyyy HH:mm}") %>

                        </div>

                    </div>

                </div>

            </ItemTemplate>


            <EmptyDataTemplate>

                <div style="padding:30px;text-align:center;">
                    No candidates found.
                </div>

            </EmptyDataTemplate>

        </asp:ListView>


        <!-- PAGINATION -->

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
                        ButtonType="Button"
                        FirstPageText="First"
                        LastPageText="Last"
                        PreviousPageText="Previous"
                        NextPageText="Next" />

                </Fields>

            </asp:DataPager>

        </div>


    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
