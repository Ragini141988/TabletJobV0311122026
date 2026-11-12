<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OnlineInterviewJobWiseReport.aspx.cs" Inherits="TabletJobs.com.OnlineInterviewJobWiseReport" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Online Interview Report</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f1f5f9;
        }

        /* HEADER */
        .header {
            background: #0f172a;
            color: white;
            padding: 14px;
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        /* FILTER BOX */
        .filter-box {
            background: #ffffff;
            padding: 12px;
            margin: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .filter-box select,
        .filter-box button {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .filter-box button {
            background: #2563eb;
            color: white;
            border: none;
            font-weight: 600;
        }

        /* CARD LIST */
        .card {
            background: white;
            margin: 10px;
            padding: 12px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        .title {
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
        }

        .sub {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 6px;
        }

        .row {
            font-size: 13px;
            margin: 4px 0;
        }

        .status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .paid {
            background: #dcfce7;
            color: #15803d;
        }

        .unpaid {
            background: #fee2e2;
            color: #b91c1c;
        }

        .msg {
            color: red;
            text-align: center;
            margin: 10px;
        }
        .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 12px;
    margin: 25px 0;
}

.page-btn {
    padding: 9px 18px;
    border: none;
    border-radius: 6px;
    background: #007bff;
    color: white;
    cursor: pointer;
    font-size: 14px;
}

.page-btn:hover {
    background: #0056b3;
}

.page-btn:disabled {
    background: #cccccc;
    cursor: not-allowed;
}

.page-number {
    font-weight: bold;
    font-size: 15px;
    padding: 8px 12px;
}
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- HEADER -->
        <div class="header">
            📊 Online Interview Report
        </div>

        <!-- FILTER -->
        <div class="filter-box">
            <asp:DropDownList ID="ddlJobs" runat="server"></asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="🔍 Search" OnClick="btnSearch_Click" />
        </div>

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

        <!-- DATA -->
    <asp:Repeater ID="rptData" runat="server">
    <ItemTemplate>

        <div class="card">

            <div class="title">
                <%# Eval("JTitle") %>
            </div>

            <div class="sub">
                🏥 <%# Eval("Hospital") %>
            </div>

            <div class="row">👤 <%# Eval("CandidateName") %></div>
            <div class="row">📞 <%# Eval("Mobile") %></div>
            <div class="row">📧 <%# Eval("Email") %></div>

            <div class="row">
                📌 Status: <%# Eval("ApplicationStatus") %>
            </div>

            <div class="row">
                💳 Payment:
                <span class='status <%# Eval("PaymentStatus").ToString() == "Success" ? "paid" : "unpaid" %>'>
                    <%# Eval("PaymentStatus") %>
                </span>
            </div>

            <div class="row">
                🕒 <%# Eval("CreatedAtText") %>
            </div>

        </div>

    </ItemTemplate>
</asp:Repeater>


<!-- Pagination -->
<div class="pagination">

    <asp:Button ID="btnPrevious"
        runat="server"
        Text="« Previous"
        CssClass="page-btn"
        OnClick="btnPrevious_Click" />

    <asp:Label ID="lblPageNumber"
        runat="server"
        CssClass="page-number">
    </asp:Label>

    <asp:Button ID="btnNext"
        runat="server"
        Text="Next »"
        CssClass="page-btn"
        OnClick="btnNext_Click" />

</div>
      
    </form>
</body>
</html>