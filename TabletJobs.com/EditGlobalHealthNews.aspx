<%@ Page Title="" Language="C#"  ValidateRequest="false" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="EditGlobalHealthNews.aspx.cs" Inherits="TabletJobs.com.EditGlobalHealthNews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .edit-box {
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            border: 1px solid #e0e0e0;
            max-width: 900px;
            margin: auto;
        }
        .page-title {
            color: #1379BE;
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="edit-box mt-4">
        <h3 class="page-title">Edit Global Healthcare News</h3>

        <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

        <div class="mb-3">
            <label class="form-label fw-semibold">News Topic</label>
            <asp:TextBox ID="txtTopic" runat="server"
                CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server"
                CssClass="form-select"></asp:DropDownList>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">News Content</label>
           <textarea id="txtContent" runat="server" ClientIDMode="Static"></textarea>


<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>

<script>
window.onload = function () {
    if (CKEDITOR.instances.txtContent) {
        CKEDITOR.instances.txtContent.destroy(true);
    }

    CKEDITOR.replace('txtContent', {
        height: 250,

        // 🔥 CLEAN WORD CONTENT
        pasteFromWordRemoveStyles: true,
        pasteFromWordRemoveFontStyles: true,
        forcePasteAsPlainText: false,

        // Allow only safe tags
        allowedContent: 'p strong ul ol li br',

        toolbar: [
            { name: 'clipboard', items: ['PasteFromWord'] },
            { name: 'basicstyles', items: ['Bold'] },
            { name: 'paragraph', items: ['BulletedList', 'NumberedList'] }
        ]
    });
};
</script>
        </div>

        <div class="text-center mt-4">
            <asp:Button ID="btnUpdate" runat="server"
                Text="Update News"
                CssClass="btn btn-primary rounded-pill px-5"
                OnClick="btnUpdate_Click" />
        </div>
         <div class="text-center mt-5">
                <a href="ManageGlobalHealthNews.aspx" class="view-all-news-btn">
                    <i class="fas fa-newspaper"></i>
                   Back
                </a>
            </div>
    </div>

</asp:Content>
