<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="onlineinterviewresult.aspx.cs" Inherits="TabletJobs.com.onlineinterviewresult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style type="text/css">
    .form-header {
            text-align: center;
            background-color: #1379BE;
            color: white;
            font-size: 24px;
            padding: 5px;
            border-radius: 2px;
            box-shadow: 0 4px 2px rgba(0, 0, 0, 0.2);
            margin-bottom: 2px;
        }

    /* Ensure the container does not scroll horizontally */
    .list-view-container {
        overflow-x: hidden;
        width: 100%;
    }
    .btn.btn-primary.mt-3 {
    background-color: #1379BE !important; /* Override the Bootstrap primary color */
    transition: none !important; /* Disable any transition effects */
}
    .btn.btn-primary.mt-4 {
    background-color: #1379BE !important; /* Override the Bootstrap primary color */
    transition: none !important; /* Disable any transition effects */
}
    /* Make sure each row wraps and does not exceed container width */
    .list-view-row {
        display: block; /* Change from table to block for wrapping */
        width: 100%;
        box-sizing: border-box;
    }

    /* Ensure the items within the row wrap correctly */
    .list-item {
        display: block;
        width: 100%; /* Full width to wrap properly */
        box-sizing: border-box;
        padding: 10px; /* Adjust padding as needed */
    }

    /* Optional: Ensure that long texts wrap */
    .list-item, .header-item {
        word-wrap: break-word;
        overflow-wrap: break-word;
    }

    /* Style adjustments for job seekers section */
    .job-seekers-heading {
        margin-top: 40px;
        font-size: 28px;
        font-weight: bold;
        color: #333;
        text-align: center;
        margin-bottom: 20px;
    }

    .job-card {
        border: 1px solid #e3e3e3;
        border-radius: 8px;
        background-color: #fff;
        margin-bottom: 20px;
        padding: 15px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    /* Adjustments for the job seeker card layout */
    .job-card-header {
        display: block; /* Changed from flex to block for wrapping */
        margin-bottom: 10px;
    }

    .list-view-header, .list-view-row {
        display: table;
        width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
    }

    .list-item, .header-item {
        display: table-cell;
        border: 1px solid #e1e5e8;
        padding: 15px;
        background-color: #fff;
        transition: box-shadow 0.3s ease, transform 0.3s ease;
        word-wrap: break-word;
    }

    .item-title {
        font-weight: bold;
    }

    .header-item {
        background-color: #a8cce9;
        font-weight: bold;
        text-align: center;
        width: 150px;
    }

    .list-item {
        width: 150px;
    }

    .list-view-row:nth-child(even) .list-item {
        background-color: #f2f2f2;
    }

    .pagination {
        margin-top: 20px;
        text-align: center;
    }

    .pagination a {
        color: #4a90e2;
        text-decoration: none;
        margin: 0 5px;
        padding: 5px 10px;
        border-radius: 5px;
        border: 1px solid #4a90e2;
    }

    .pagination a:hover {
        background-color: #e1e5e8;
    }

    .pagination .disabled {
        color: #aaa;
        border: 1px solid #ddd;
    }

.hyperlink {
    color: #4a90e2;
    text-decoration: none;
    margin: 0 5px;
    padding: 5px 10px;
    border-radius: 5px;
    border: 1px solid #4a90e2;
    display: inline-block; /* Makes the link behave like a button */
    transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transition */
}

.hyperlink a:hover {
    background-color: #e1e5e8;
    color: #333; /* Optional: Change text color on hover */
}

.hyperlink a:visited {
    color: #3a6ea5; /* Optional: Different color for visited links */
}

.hyperlink .disabled {
    color: #aaa;
    border: 1px solid #ddd;
    cursor: not-allowed; /* Indicates the link is disabled */
    background-color: #f9f9f9; /* Optional: Background color for disabled link */
}


    .job-card-header .img-fluid {
        margin-right: 10px; /* Adjust the margin as needed */
    }

    .default-icon {
        font-size: 24px; /* Adjust size as needed */
        color: #ccc; /* Set default icon color */
    }

    .hospital-name {
        font-weight: bold; /* Make the text brighter */
        color: #000; /* You can adjust the color for brightness */
    }
 .social-media {
            margin-top: 20px;
            text-align: center;
            background-color:white;
        }
             
               .social-icons {
    display: flex;
    flex-wrap: wrap; /* Allow wrapping to create two lines */
    justify-content: center; /* Center the icons */
    align-items: center;
    margin-top: 10px;
}

        .social-media a {
            margin: 0 10px;
            text-decoration: none;
            color: #fff;
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            border-radius: 50%;
            background-color: #3b5998; /* Default to Facebook blue */
            transition: background-color 0.3s ease-in-out;
        }
        .social-media a i {
            font-size: 18px;
        }
.social-media a.facebook { background-color: #3b5998; }
.social-media a.whatsapp { background-color: #25d366; }
.social-media a.telegram { background-color: #0088cc; }
.social-media a.instagram { background-color: #e4405f; }
.social-media a.twitter { background-color: #1da1f2; }
.social-media a.pinterest { background-color: #bd081c; }
.social-media a.linkedin { background-color: #0077b5; }
.social-media a.reddit { background-color: #ff4500; }
        .social-media a:hover {
            opacity: 0.7;
        }
        @media (max-width: 768px) {
    .pagination {
        overflow-x: auto;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
        display: flex;
        justify-content: flex-start;
        padding: 10px;
        margin-top: 15px;
    }

    .pagination a,
    .pagination span {
        display: inline-block;
        margin: 0 4px;
        padding: 8px 12px;
        font-size: 14px;
        min-width: 36px;
        text-align: center;
        white-space: nowrap;
        flex: 0 0 auto;
    }
}
        @media (min-width: 769px) {
    .pagination {
        justify-content: center;
    }
}



</style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    
    <div id="seamless-replace">
        <div class="container mt-5">
              <div class="col-12">
            <asp:Panel ID="pnlJobSeekers" runat="server" Visible="true">
                <div class="container">
    <div class="row">
        <div class="col-12 text-center">
           <div class="heading-bg">
                <h2 class="form-header" style="color: white; font-size: 24px;margin-bottom: 1px;">
                   Interview Results
                </h2>
            </div>
        </div>
    </div>
</div>
                
                <asp:ListView ID="listview_interviewresult" runat="server" OnItemDataBound="listview_interviewresult_ItemDataBound">
                    <LayoutTemplate>
                        <div class="container px-1" style="padding-top: 10px;">
                            <!-- Reduced gutter between cols -->
                            <div class="row gx-2 gy-2">
                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                            </div>
                        </div>
                    </LayoutTemplate>

                    <ItemTemplate>
                        <div class="col-md-4" style="margin-bottom: 5px;">
                            <div class="job-card shadow-sm bg-white rounded"
                                style="border: 1px solid #ddd; border-radius: 12px; background-color: #fff; padding: 10px; margin-bottom: 0;">

                                <h5 style="font-size: 1.25rem; font-weight: bold; color: #1379BE;">
                                    <%--<i class="fa fa-hospital"></i>--%>
                                    <i class="fa fa-hospital" style="margin-right: 6px;"></i>
                                    <%# Eval("HospitalName") %> | <%# Eval("City") %>
                                </h5>

                                <p style="margin-top: 8px; margin-bottom: 6px;">
                                    <i class="far fa-calendar-alt" style="color: red;"></i>
                                    <strong>Interview Date:</strong>
                                    <%# Convert.ToDateTime(Eval("InterviewDate")).ToString("dd MMM yyyy") %>
                                </p>

                                <p style="margin-bottom: 0;">
                                    <i class="fas fa-users" style="color: rgb(25, 117, 184);"></i>
                                    <strong>Selected Candidates:</strong>
                                  <asp:HyperLink
    ID="lnkSelectedCandidates"
    runat="server"
    Style="color: red; text-decoration: underline; font-weight: bold;">
    <%# Eval("SelectedCount") %>
</asp:HyperLink>
                                </p>
                            </div>
                        </div>
                    </ItemTemplate>

                    <EmptyDataTemplate>
                        <div class="no-data-message">
                            <p style="font-size: 1.25rem; color: red; font-weight: bold;">
                                Presently There Are No Records.
                            </p>
                        </div>
                    </EmptyDataTemplate>
                </asp:ListView>
                <!-- Custom Pagination -->
            </asp:Panel>
        </div></div></div>

    </asp:Content>