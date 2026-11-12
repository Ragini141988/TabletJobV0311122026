<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageInterview.aspx.cs" Inherits="TabletJobs.com.ManageInterview" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manage Interviews</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f9ff;
        }

        .container {
            max-width: 900px;
            margin: auto;
            padding: 15px;
        }

        h2 {
            text-align: center;
        }

        /* SEARCH */
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }

        .search-box input, .search-box select {
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            flex: 1;
        }

        .search-box button {
            background: #0ea5e9;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
        }

        /* CARD */
        .job-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #eaf4ff;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .job-left h3 {
            margin: 0;
            color: #0f172a;
        }

        .job-left p {
            margin: 3px 0;
            font-size: 14px;
        }

        .job-right {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .btn {
            padding: 6px;
            border-radius: 5px;
            text-align: center;
            color: white;
            text-decoration: none;
            font-size: 13px;
        }

        .view { background: #0ea5e9; }
        .edit { background: #22c55e; }
        .delete { background: #ef4444; }

        /* PAGINATION */
        .pagination {
            text-align: center;
            margin-top: 15px;
        }

        .pagination a {
            margin: 5px;
            padding: 6px 10px;
            background: #ddd;
            text-decoration: none;
            border-radius: 5px;
        }

        /* MOBILE */
        @media(max-width:600px) {
            .job-card {
                flex-direction: column;
                align-items: flex-start;
            }

            .job-right {
                flex-direction: row;
                width: 100%;
                margin-top: 10px;
            }

            .btn {
                flex: 1;
            }
        }
        .btn-add.premium {
    background: linear-gradient(135deg, #0ea5e9, #2563eb);
    box-shadow: 0 4px 12px rgba(37,99,235,0.3);
}
        .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

/* MAIN BUTTON */
.btn-add {
    background: linear-gradient(135deg, #22c55e, #16a34a);
    color: white !important;
    border: none;
    padding: 10px 18px;
    font-size: 15px;
    border-radius: 8px;
    cursor: pointer;

    box-shadow: 0 4px 10px rgba(34,197,94,0.3);
    transition: all 0.3s ease;
}

/* HOVER EFFECT */
.btn-add:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(34,197,94,0.4);
}

/* CLICK EFFECT */
.btn-add:active {
    transform: scale(0.96);
}

/* MOBILE */
@media(max-width:600px){
    .top-bar {
        flex-direction: column;
        gap: 10px;
    }

    .btn-add {
        width: 100%;
        text-align: center;
    }
}
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <h2>📋 Manage Interviews</h2>

    <!-- SEARCH FILTER -->

<div class="top-bar">
    <asp:Button 
    ID="Button1" 
    runat="server" 
    Text="🚀 Post New Interview Job" 
    PostBackUrl="~/PostOnlineInterviewDetails.aspx" 
    CssClass="btn-add premium" />
</div>
    <div class="search-box">
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Job Title"></asp:TextBox>

        <asp:TextBox ID="txtCity" runat="server" placeholder="City"></asp:TextBox>

        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    </div>

    <!-- LIST -->
    <asp:ListView ID="lvJobs" runat="server">

        <ItemTemplate>
            <div class="job-card">

                <div class="job-left">
                    <h3><%# Eval("JTitle") %></h3>
                    <p>🏥 <%# Eval("hname") %> | 📍 <%# Eval("hcity") %></p>
                    <p>💼 <%# Eval("Jexp") %> | 💰 <%# Eval("Jsal") %></p>
                    <p>📅 <%# Eval("InterviewDate","{0:dd MMM yyyy}") %></p>
                </div>

                <div class="job-right">

                    <a href='ViewInterview.aspx?id=<%# Eval("JOBID") %>' class="btn view">View</a>

                    <a href='PostOnlineInterviewDetails.aspx?id=<%# Eval("JOBID") %>' class="btn edit">Edit</a>

                    <asp:LinkButton ID="btnDelete" runat="server"
                        CommandArgument='<%# Eval("JOBID") %>'
                        OnCommand="DeleteRecord"
                        CssClass="btn delete"
                        OnClientClick="return confirm('Delete this record?');">
                        Delete
                    </asp:LinkButton>

                </div>

            </div>
        </ItemTemplate>

    </asp:ListView>

    <!-- PAGINATION -->
    <div class="pagination">
        <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
            <ItemTemplate>
                <asp:LinkButton runat="server"
                    CommandName="Page"
                    CommandArgument='<%# Eval("PageIndex") %>'
                    Text='<%# Eval("Text") %>' />
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

</form>
</body>
</html>