<%@ Page Language="C#" MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="ManageGlobalHealthNews.aspx.cs"
    Inherits="TabletJobs.com.ManageGlobalHealthNews" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .news-card {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .news-title {
            color: #1379BE;
            font-weight: 700;
            font-size: 20px;
        }
        .news-content {
            color: #444;
            margin-top: 10px;
            line-height: 1.6;
        }
        .action-btns a,
        .action-btns button {
            margin-left: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- PAGE HEADER -->
    <div class="text-center mb-4">
        <h2 class="fw-bold text-primary">Manage Global Healthcare News</h2>
        <p class="text-muted">Search, edit or delete healthcare news</p>
    </div>

    <!-- SEARCH -->
    <div class="row mb-4 justify-content-center">
        <div class="col-md-6">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control rounded-pill"
                placeholder="Search by topic..."
                AutoPostBack="true"
                OnTextChanged="txtSearch_TextChanged" />
        </div>
    </div>

    <!-- NEWS LIST -->
    <asp:ListView ID="lvNews" runat="server">
        <ItemTemplate>
            <div class="news-card">

                <div class="news-title">
                    <%# Eval("Topic") %>
                </div>

               

                <div class="d-flex justify-content-end action-btns mt-3">

                    <!-- EDIT -->
                    <a href='EditGlobalHealthNews.aspx?NewsID=<%# Eval("NewsID") %>'
                       class="btn btn-sm btn-outline-primary rounded-pill">
                        <i class="fas fa-edit"></i> Edit
                    </a>

                    <!-- DELETE -->
                    <asp:LinkButton ID="btnDelete"
                        runat="server"
                        CssClass="btn btn-sm btn-outline-danger rounded-pill"
                        CommandArgument='<%# Eval("NewsID") %>'
                        OnClick="btnDelete_Click"
                        OnClientClick="return confirm('Are you sure you want to delete this news?');">
                        <i class="fas fa-trash"></i> Delete
                    </asp:LinkButton>

                </div>
            </div>
        </ItemTemplate>
    </asp:ListView>

    <!-- PAGINATION -->
    <div class="text-center mt-4">
        <asp:Button ID="btnPrev" runat="server"
            Text="Previous"
            CssClass="btn btn-outline-secondary rounded-pill px-4"
            OnClick="btnPrev_Click" />

        <asp:Button ID="btnNext" runat="server"
            Text="Next"
            CssClass="btn btn-outline-secondary rounded-pill px-4 ms-2"
            OnClick="btnNext_Click" />
    </div>
    <!-- SUCCESS / INFO MESSAGE -->
<asp:Label ID="lblMessage" runat="server"
    Visible="false"
    CssClass="alert alert-success text-center mb-4 d-block">
</asp:Label>

    
</asp:Content>
