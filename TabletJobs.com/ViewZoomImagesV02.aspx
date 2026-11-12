<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="ViewZoomImagesV02.aspx.cs" Inherits="TabletJobs.com.ViewZoomImagesV02" %>
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
            <div class="row">
                  <div class="row">
                <div class="col-12 text-center mb-4">
                    <h2 class="form-header">Latest Online Interviews</h2>
                </div>
            </div>
            <div id="liveInterview1">
                <asp:SqlDataSource ID="SqlDataSource11" runat="server"
                    ConnectionString="<%$ ConnectionStrings:hospi2yp_tabletjobssConnectionString_V02 %>"
                    SelectCommand="SELECT  *  FROM ZoomImages ORDER BY InterviewDate DESC"></asp:SqlDataSource>

                <asp:ListView ID="listview11" runat="server" DataSourceID="SqlDataSource11" OnPagePropertiesChanging="ListView11_PagePropertiesChanging">
                    <LayoutTemplate>
                        <div class="list-view-container">
                            <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                        </div>
                        <div class="pagination">
                                <asp:DataPager ID="DataPager1" runat="server" PageSize="7" PagedControlID="listview11">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="true" ShowLastPageButton="true" />
                                        <asp:NumericPagerField ButtonType="Link" />
                                    </Fields>
                                </asp:DataPager>
                    </LayoutTemplate>
                    <EmptyDataTemplate>

    <div class="interview-coming-soon">
       <center><h3>🎥 Interview Images Coming Soon</h3></center> 
        
    </div>

</EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="job-card">
                            <div class="job-card-header">
                                <div class="row">
                                    <div class="col-md-2">
                                        <asp:Image ID="InterviewImage" runat="server"   ImageUrl='<%# "Handler5V02.ashx?JobID=" + Eval("Id") %>'  CssClass="img-fluid" />
                                    </div>
                                    <div class="col-md-12" style="margin-top: 10pt;">
                                        <div class="job-description">
                                            <%# Eval("Description") %>
                                        </div>
                                    </div>
                                    <div class="col-md-12" style="margin-top: 10pt;">
                                        <div>
                                            <i class="fa fa-calendar-check"></i>Interview Date : <%# 
    (Eval("InterviewDate") != null ? string.Format("{0:dddd, MMMM d yyyy}", Eval("InterviewDate")) : "") %>
                                        </div>
                                                
                                    </div>

                                    





                                </div>


                            </div>
                        </div>
                    </ItemTemplate>



                </asp:ListView>

                </div>
                </div>
            </div></div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
