<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewInterview.aspx.cs" Inherits="TabletJobs.com.ViewInterview" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>View Interview</title>

    <style>
        body {
            font-family: Arial;
            background: #f3f8ff;
        }

        .container {
            max-width: 800px;
            margin: auto;
            padding: 15px;
        }

        .card {
            background: #eaf4ff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }

        h2 {
            margin-top: 0;
            color: #0f172a;
        }

        .row {
            margin-bottom: 10px;
            font-size: 15px;
        }

        .label {
            font-weight: bold;
            color: #333;
        }

        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 15px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
        }

        .edit { background: #22c55e; }
        .back { background: #64748b; }

    </style>
</head>

<body>
<form runat="server">

<div class="container">

    <div class="card">

        <h2><asp:Label ID="lblTitle" runat="server" /></h2>

        <div class="row"><span class="label">Hospital:</span> <asp:Label ID="lblHospital" runat="server" /></div>
        <div class="row"><span class="label">City:</span> <asp:Label ID="lblCity" runat="server" /></div>
        <div class="row"><span class="label">Experience:</span> <asp:Label ID="lblExp" runat="server" /></div>
        <div class="row"><span class="label">Salary:</span> <asp:Label ID="lblSalary" runat="server" /></div>
        <div class="row"><span class="label">Interview Date:</span> <asp:Label ID="lblDate" runat="server" /></div>
        <div class="row"><span class="label">Description:</span> <asp:Label ID="lblDesc" runat="server" /></div>

        <a href="ManageInterview.aspx" class="btn back">Back</a>

    </div>

</div>

</form>
</body>
</html>