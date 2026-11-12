<%@ Page Title="Business Collection Report" Language="C#" 
    MasterPageFile="~/FirstMasterPAge.Master" 
    AutoEventWireup="true" 
    CodeBehind="tjtargetsreport.aspx.cs" 
    Inherits="TabletJobs.com.tjtargetsreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">

        .report-container {
            max-width: 1100px;
            margin: 25px auto;
            padding: 20px;
        }

        .report-heading {
            text-align: center;
            font-size: 27px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .filter-box {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.10);
            margin-bottom: 20px;
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

        .filter-label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
        }

        .filter-control {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .filter-button {
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .total-box {
            background: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.10);
        }

        .total-label {
            font-size: 17px;
            font-weight: bold;
        }

        .total-amount {
            font-size: 28px;
            font-weight: bold;
            margin-top: 8px;
        }

       .report-list {
    width: 100%;
}

.report-card {
    background: #ffffff;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 16px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.report-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 9px 0;
    border-bottom: 1px solid #eee;
}

.report-row:last-child {
    border-bottom: none;
}

.report-label {
    font-weight: bold;
    color: #555;
}

.report-value {
    text-align: right;
}

.amount-value {
    font-weight: bold;
}

.no-records {
    text-align: center;
    padding: 25px;
    background: #ffffff;
    border-radius: 10px;
    color: #777;
}


/* Desktop */

@media (min-width: 768px) {

    .report-card {
        display: grid;
        grid-template-columns: 1fr 1.5fr 1fr 1fr;
        gap: 15px;
        align-items: center;
    }

    .report-row {
        border-bottom: none;
        padding: 5px;
        display: block;
    }

    .report-label {
        display: block;
        font-size: 12px;
        margin-bottom: 4px;
    }

    .report-value {
        display: block;
        text-align: left;
    }
}


/* Mobile */

@media (max-width: 600px) {

    .report-card {
        padding: 14px;
    }

    .report-row {
        font-size: 14px;
    }

    .report-label {
        max-width: 40%;
    }

    .report-value {
        max-width: 60%;
        word-break: break-word;
    }
}

        .report-grid {
            width: 100%;
            border-collapse: collapse;
        }

        .report-grid th,
        .report-grid td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .report-grid th {
            font-weight: bold;
        }

        @media(max-width:600px) {

            .report-container {
                margin: 10px;
                padding: 10px;
            }

            .filter-item {
                min-width: 100%;
            }

            .filter-button {
                width: 100%;
            }
        }

    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">

    <div class="report-container">

        <div class="report-heading">
            Business Collection Report
        </div>


        <!-- Filters -->

        <div class="filter-box">

            <div class="filter-row">

                <div class="filter-item">

                    <asp:Label ID="lblFromDate"
                        runat="server"
                        Text="From Date"
                        CssClass="filter-label">
                    </asp:Label>

                    <asp:TextBox ID="txtFromDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="filter-control">
                    </asp:TextBox>

                </div>


                <div class="filter-item">

                    <asp:Label ID="lblToDate"
                        runat="server"
                        Text="To Date"
                        CssClass="filter-label">
                    </asp:Label>

                    <asp:TextBox ID="txtToDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="filter-control">
                    </asp:TextBox>

                </div>


                <div class="filter-item">

                    <asp:Label ID="lblPerson"
                        runat="server"
                        Text="Collected By"
                        CssClass="filter-label">
                    </asp:Label>

                    <asp:DropDownList ID="ddlPerson"
                        runat="server"
                        CssClass="filter-control">

                        <asp:ListItem
                            Text="All"
                            Value="">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Rashida"
                            Value="Rashida">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Divya"
                            Value="Divya">
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>


                <div class="filter-item">

                    <asp:Button ID="btnSearch"
                        runat="server"
                        Text="View Report"
                        CssClass="filter-button"
                        OnClick="btnSearch_Click" />

                </div>

            </div>

        </div>


        <!-- Total -->

        <div class="total-box">

            <div class="total-label">
                Total Collection
            </div>

            <div class="total-amount">
                ₹
                <asp:Label ID="lblTotal"
                    runat="server"
                    Text="0.00">
                </asp:Label>
            </div>

        </div>


        <!-- Report -->

        <div class="grid-container">

          <asp:ListView ID="lvReport"
    runat="server">

    <LayoutTemplate>

        <div class="report-list">

            <div id="itemPlaceholder" runat="server"></div>

        </div>

    </LayoutTemplate>


    <ItemTemplate>

        <div class="report-card">

            <div class="report-row">

                <span class="report-label">
                    Date
                </span>

                <span class="report-value">
                    <%# Eval("BusinessDate", "{0:dd-MM-yyyy}") %>
                </span>

            </div>


            <div class="report-row">

                <span class="report-label">
                    Amount Type
                </span>

                <span class="report-value">
                    <%# Eval("AmountType") %>
                </span>

            </div>


            <div class="report-row">

                <span class="report-label">
                    Amount
                </span>

                <span class="report-value amount-value">
                    ₹ <%# Eval("Amount", "{0:N2}") %>
                </span>

            </div>


            <div class="report-row">

                <span class="report-label">
                    Collected By
                </span>

                <span class="report-value">
                    <%# Eval("CollectedBy") %>
                </span>

            </div>

        </div>

    </ItemTemplate>


    <EmptyDataTemplate>

        <div class="no-records">
            No records found.
        </div>

    </EmptyDataTemplate>

</asp:ListView>

        </div>

    </div>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>