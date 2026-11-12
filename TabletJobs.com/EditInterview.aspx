<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditInterview.aspx.cs" Inherits="TabletJobs.com.EditInterview" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Edit Interview</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f9ff;
        }

        .container {
            max-width: 700px;
            margin: auto;
            padding: 15px;
        }

        .card {
            background: #eaf4ff;
            padding: 20px;
            border-radius: 12px;
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .btn {
            padding: 10px;
            border: none;
            border-radius: 6px;
            color: white;
            width: 100%;
        }

        .update { background: #22c55e; }
    </style>
</head>

<body>
<form runat="server">

<div class="container">
    <div class="card">

        <h2>Edit Interview</h2>

        <asp:TextBox ID="TxtTitle" runat="server" placeholder="Job Title"></asp:TextBox>
        <asp:TextBox ID="TxtHospital" runat="server" placeholder="Hospital"></asp:TextBox>
        <asp:TextBox ID="TxtCity" runat="server" placeholder="City"></asp:TextBox>
        <asp:TextBox ID="TxtExp" runat="server" placeholder="Experience"></asp:TextBox>
        <asp:TextBox ID="TxtSalary" runat="server" placeholder="Salary"></asp:TextBox>
        <asp:TextBox ID="TxtDate" runat="server" placeholder="Interview Date"></asp:TextBox>
        <asp:TextBox ID="TxtDesc" runat="server" TextMode="MultiLine" placeholder="Description"></asp:TextBox>

        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn update" OnClick="btnUpdate_Click" />

    </div>
</div>

</form>
</body>
</html>