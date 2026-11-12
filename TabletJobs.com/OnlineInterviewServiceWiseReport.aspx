<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="OnlineInterviewServiceWiseReport.aspx.cs" Inherits="TabletJobs.com.OnlineInterviewServiceWiseReport" %>

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
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- HEADER -->
        <div class="header">
            📊 Online Payment Report
        </div>

       

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

        <!-- DATA -->
        <asp:Repeater ID="rptData" runat="server">
            <ItemTemplate>

                <div class="card">

                   

                    <div class="row">👤 <%# Eval("CandidateName") %></div>
                    <div class="row">📞 <%# Eval("Mobile") %></div>
                    <div class="row">📧 <%# Eval("Email") %></div>
                    <div class="row">
    💰 Amount: ₹ <%# Eval("Amount", "{0:0.00}") %>
</div>

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
        <div style="text-align:center; margin:15px;">
    <asp:Button ID="btnLoadMore" runat="server"
        Text="⬇ Load More"
        OnClick="btnLoadMore_Click"
        style="padding:10px 20px; border:none; border-radius:8px; background:#0ea5e9; color:white; font-weight:600;" />
</div>
    </form>
</body>
</html>