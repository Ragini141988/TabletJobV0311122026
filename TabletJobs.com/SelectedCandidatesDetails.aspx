<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="SelectedCandidatesDetails.aspx.cs" Inherits="TabletJobs.com.SelectedCandidatesDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
 
   <style type="text/css">
    body {
        font-family: 'Roboto', sans-serif;
        background-color: #f5f5f5;
    }
    
    .page-title {
        text-align: center;
        background-color: #0078d7;
        color: white;
        font-size: 20px;
        font-weight: 400;
        padding: 5px;
        border-radius: 2px;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .page-title i {
        margin-right: 10px;
    }
    
    .table-card {
        background-color: white;
        border-radius: 6px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        margin-bottom: 25px;
    }
    
    .interview-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 0;
    }
    
    .interview-table thead th {
        background-color: #f8f9fa;
        color: #333;
        font-weight: 600;
        padding: 15px;
        border-bottom: 2px solid #dee2e6;
        text-align: left;
        font-size: 14px;
    }
    
    .interview-table tbody tr {
        transition: background-color 0.2s;
    }
    
    .interview-table tbody tr:hover {
        background-color: #f0f7ff;
    }
    
    .interview-table tbody td {
        padding: 15px;
        border-bottom: 1px solid #e9ecef;
        vertical-align: middle;
    }
    
    .interview-table tbody tr:last-child td {
        border-bottom: none;
    }
    
    .serial-col {
        width: 70px;
        text-align: center;
        color: #666;
        font-weight: 500;
    }
    
    .hospital-col {
        font-weight: 500;
    }
    
    .hospital-icon {
        color: #0078d7;
        margin-right: 8px;
    }
    
    .date-col {
        color: #666;
    }
    
    .date-icon {
        color: #666;
        margin-right: 8px;
    }
    
    .candidates-btn {
        background-color: #0078d7;
        color: white;
        border: none;
        border-radius: 50px;
        padding: 6px 16px;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s;
        text-decoration: none;
        font-size: 13px;
    }
    
    .candidates-btn:hover {
        background-color: #005a9e;
        text-decoration: none;
        color: white;
    }
    
    .candidates-btn i {
        margin-right: 6px;
    }
    
    .pagination-container {
        display: flex;
        justify-content: center;
        padding: 15px;
        border-top: 1px solid #eee;
    }
    
    .pagination-btn {
        width: 36px;
        height: 36px;
        margin: 0 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #dee2e6;
        border-radius: 4px;
        color: #0078d7;
        background-color: white;
        transition: all 0.2s;
    }
    
    .pagination-btn:hover {
        background-color: #f0f7ff;
        border-color: #0078d7;
    }
    
    .pagination-btn.active {
        background-color: #0078d7;
        border-color: #0078d7;
        color: white;
        font-weight: 500;
    }
    
    .pagination-btn.disabled {
        color: #aaa;
        cursor: not-allowed;
    }
    
    .no-data {
        padding: 40px 20px;
        text-align: center;
        color: #666;
    }
    
    .no-data i {
        font-size: 48px;
        color: #ddd;
        margin-bottom: 15px;
        display: block;
    }
    
    /* Mobile Responsiveness */
    @media (max-width: 767px) {
        .page-title {
            font-size: 18px;
            padding: 12px;
        }
        
        .interview-table thead {
            display: none;
        }
        
        .interview-table tbody tr {
            display: block;
            border-bottom: 1px solid #dee2e6;
            padding: 10px 0;
        }
        
        .interview-table tbody tr:last-child {
            border-bottom: none;
        }
        
        .interview-table tbody td {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 15px;
            border: none;
            text-align: right;
        }
        
        .interview-table tbody td:before {
            content: attr(data-label);
            font-weight: 600;
            text-align: left;
            color: #333;
        }
        
        .serial-col {
            width: 100%;
            text-align: right;
        }
        
        .candidates-btn {
            margin-left: auto;
        }
        
        .pagination-container {
            padding: 10px;
        }
        
        .pagination-btn {
            width: 32px;
            height: 32px;
            margin: 0 2px;
        }
    }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                  
            <asp:Panel ID="pnlJobSeekers" runat="server" Visible="true">
    <div class="page-title">
        <i class="fas fa-clipboard-check"></i> Selected Candidates
    </div>
    
  <div style="margin-top: 20px;text-align:center;">
        <asp:Label ID="lblheaderMessage" runat="server" 
            CssClass="footer-message"
            Style="margin-top: 20px; font-size: 1.25rem; margin-top:20px; font-weight: bold; color: #1379BE; text-align: center;">
        </asp:Label>
</div>
        <asp:ListView ID="ListView4" runat="server"  OnDataBound="ListView4_DataBound">
            <LayoutTemplate>
        <div id="job-cards-container">
            <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
        </div>
         <!-- Footer Label for Coordinator Message -->
                 <div style="margin-top: 20px;">
        <asp:Label ID="lblFooterMessage" runat="server" 
            CssClass="footer-message"
            Style="margin-top: 20px; font-size: 1.25rem; margin-top:20px; font-weight: bold; color: #1379BE; text-align: center;">
        </asp:Label>
</div>
    </LayoutTemplate>
            <ItemTemplate>
               <asp:HiddenField ID="hfCoordinator" runat="server" Value='<%# Eval("coordinator") %>' />
                <div class="job-card">
                    <div class="row">
                       
                         <div class="col-md-12" style="margin-top: 10pt;">
                                            <span class="job-title" style="font-size: 1 rem; font-weight: bold; color: black; text-decoration: none;">
                                               <i class="fa fa-user"></i> <%# Eval("CandidateName") %> | <%# Eval("Gender") %> </span></div>
                                          
                       
                                                
                </div>
                <div style="border-top: 1px solid #ccc; margin: 10px 0;"></div></div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <div class="no-data-message">
                    <p style="font-size: 1.25rem; color: red; font-weight: bold;">
                        Presently There Are No Records.
                    </p>
                </div>
            </EmptyDataTemplate>
        </asp:ListView>
                <br />
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary mt-3" OnClick="btnBack_Click" style="color: white;">
    <i class="fa fa-home"></i> Back To Home Page
</asp:LinkButton>
        <!-- Custom Pagination -->
      
</asp:Panel>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Responsive support script -->
    
</asp:Content>

