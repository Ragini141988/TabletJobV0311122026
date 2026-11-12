<%@ Page Title="Expenses Report"
    Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="ExpensesReport.aspx.cs"
    Inherits="TabletJobs.com.account.ExpensesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">

        .expense-report-container {
            max-width: 1100px;
            margin: 20px auto;
            padding: 0 15px;
        }

        .report-title {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #222;
        }

        .filter-box {
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: end;
        }

        .filter-field {
            flex: 1;
            min-width: 180px;
        }

        .filter-field label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #444;
        }

        .date-input {
            width: 100%;
            box-sizing: border-box;
            height: 42px;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .btn-search {
            height: 42px;
            padding: 0 22px;
            border: none;
            border-radius: 6px;
            background: #007bff;
            color: white;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-search:hover {
            opacity: 0.9;
        }

        .btn-clear {
            height: 42px;
            padding: 0 22px;
            border: none;
            border-radius: 6px;
            background: #6c757d;
            color: white;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .summary-box {
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px 18px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
        }

        .summary-item {
            font-size: 16px;
            font-weight: 600;
        }

        .summary-amount {
            font-size: 20px;
            color: #c0392b;
        }

        .expense-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .expense-card {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 9px;
            padding: 16px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .expense-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 12px;
        }

        .expense-type {
            font-size: 18px;
            font-weight: 700;
            color: #222;
        }

        .expense-amount {
            font-size: 20px;
            font-weight: 700;
            color: #c0392b;
            white-space: nowrap;
        }

        .expense-detail-row {
            display: flex;
            margin-top: 7px;
            line-height: 1.5;
        }

        .expense-label {
            width: 140px;
            min-width: 140px;
            font-weight: 600;
            color: #555;
        }

        .expense-value {
            color: #333;
            word-break: break-word;
        }

        .pagination {
            margin-top: 25px;
            text-align: center;
        }

        .pagination a,
        .pagination span {
            display: inline-block;
            min-width: 38px;
            padding: 9px 12px;
            margin: 3px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .pagination a {
            color: #007bff;
            background: white;
        }

        .pagination a:hover {
            background: #f1f1f1;
        }

        .pagination span {
            background: #007bff;
            color: white;
            border-color: #007bff;
            font-weight: 600;
        }

        .no-records {
            text-align: center;
            padding: 35px 15px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            color: #777;
            font-size: 16px;
        }

        .message {
            display: block;
            margin-bottom: 15px;
            color: #c0392b;
            font-weight: 600;
        }

        @media (max-width: 600px) {

            .expense-report-container {
                padding: 0 10px;
            }

            .report-title {
                font-size: 22px;
            }

            .filter-box {
                padding: 15px;
            }

            .filter-field {
                min-width: 100%;
            }

            .btn-search,
            .btn-clear {
                width: 100%;
            }

            .expense-top {
                align-items: flex-start;
            }

            .expense-type {
                font-size: 16px;
            }

            .expense-amount {
                font-size: 18px;
            }

            .expense-detail-row {
                display: block;
            }

            .expense-label {
                display: block;
                width: auto;
                min-width: 0;
                margin-bottom: 2px;
            }

            .summary-box {
                display: block;
            }

            .summary-item {
                margin-bottom: 8px;
            }
        }

    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <div class="expense-report-container">

        <div class="report-title">
            Expenses Report
        </div>

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message"
            Visible="false">
        </asp:Label>


        <!-- FILTER -->
        <div class="filter-box">

            <div class="filter-row">

                <div class="filter-field">

                    <label for="<%= txtFromDate.ClientID %>">
                        From Date
                    </label>

                    <asp:TextBox
                        ID="txtFromDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="date-input">
                    </asp:TextBox>

                </div>


                <div class="filter-field">

                    <label for="<%= txtToDate.ClientID %>">
                        To Date
                    </label>

                    <asp:TextBox
                        ID="txtToDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="date-input">
                    </asp:TextBox>

                </div>


                <div class="filter-field" style="flex:0 0 auto;">

                    <asp:Button
                        ID="btnSearch"
                        runat="server"
                        Text="Search"
                        CssClass="btn-search"
                        OnClick="btnSearch_Click" />

                </div>


                <div class="filter-field" style="flex:0 0 auto;">

                    <asp:LinkButton
                        ID="btnClear"
                        runat="server"
                        Text="Clear"
                        CssClass="btn-clear"
                        OnClick="btnClear_Click">
                    </asp:LinkButton>

                </div>

            </div>

        </div>


        <!-- SUMMARY -->
        <div class="summary-box">

            <div class="summary-item">

                Total Records:
                <asp:Label
                    ID="lblTotalRecords"
                    runat="server"
                    Text="0">
                </asp:Label>

            </div>


            <div class="summary-item">

                Total Expense:
                <span class="summary-amount">
                    ₹<asp:Label
                        ID="lblTotalAmount"
                        runat="server"
                        Text="0.00">
                    </asp:Label>
                </span>

            </div>

        </div>


        <!-- EXPENSE LIST -->
        <asp:ListView
            ID="lvExpenses"
            runat="server"
            OnPagePropertiesChanging="lvExpenses_PagePropertiesChanging">

            <LayoutTemplate>

                <div class="expense-list">

                    <asp:PlaceHolder
                        ID="itemPlaceholder"
                        runat="server">
                    </asp:PlaceHolder>

                </div>

            </LayoutTemplate>


            <ItemTemplate>

                <div class="expense-card">

                    <div class="expense-top">

                        <div class="expense-type">
                            <%# Eval("ExpenseType") %>
                        </div>

                        <div class="expense-amount">
                            ₹<%# Eval("Amount", "{0:N2}") %>
                        </div>

                    </div>


                    <div class="expense-detail-row">

                        <span class="expense-label">
                            Expense Date
                        </span>

                        <span class="expense-value">
                            <%# Eval("ExpenseDate", "{0:dd-MM-yyyy}") %>
                        </span>

                    </div>


                    <div class="expense-detail-row">

                        <span class="expense-label">
                            Details
                        </span>

                        <span class="expense-value">
                            <%# Eval("ExpenseDetails") == DBNull.Value
                                ? "-"
                                : Eval("ExpenseDetails") %>
                        </span>

                    </div>


                    <div class="expense-detail-row">

                        <span class="expense-label">
                            Created Date
                        </span>

                        <span class="expense-value">
                            <%# Eval("CreatedDate", "{0:dd-MM-yyyy hh:mm tt}") %>
                        </span>

                    </div>

                </div>

            </ItemTemplate>


            <EmptyDataTemplate>

                <div class="no-records">
                    No expense records found.
                </div>

            </EmptyDataTemplate>

        </asp:ListView>


        <!-- PAGINATION -->
        <div class="pagination">

            <asp:DataPager
                ID="dpExpenses"
                runat="server"
                PagedControlID="lvExpenses"
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

