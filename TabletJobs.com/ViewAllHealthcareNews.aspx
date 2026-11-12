<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="ViewAllHealthcareNews.aspx.cs" Inherits="TabletJobs.com.ViewAllHealthcareNews" %>
<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
   <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }

        /* Healthcare News Section Styling */
        .healthcare-news-section {
            background: linear-gradient(135deg, #f0f8ff 0%, #e8f4f8 100%);
            padding: 60px 20px;
            margin: 40px auto;
            border-radius: 20px;
            max-width: 1200px;
        }

        .news-section-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .news-section-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1379BE;
            margin-bottom: 10px;
            display: inline-flex;
            align-items: center;
            gap: 15px;
        }

        .news-section-title i {
            color: #dc3545;
            animation: pulse 2s infinite;
        }

        .header-underline {
            height: 4px;
            width: 120px;
            background: linear-gradient(to right, rgb(25, 117, 184), rgb(220, 53, 69));
            margin: 10px auto;
            border-radius: 2px;
        }

        .news-section-subtitle {
            color: #555;
            font-size: 1.1rem;
            font-weight: 400;
            margin-top: 10px;
        }

        /* News Row Card Styling */
        .news-row {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(19, 121, 190, 0.1);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
        }

        .news-row::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background: linear-gradient(to bottom, #1379BE, #dc3545);
            transform: scaleY(0);
            transition: transform 0.4s ease;
        }

        .news-row:hover {
            background: #ffffff;
            box-shadow: 0 8px 25px rgba(19, 121, 190, 0.2);
            transform: translateY(-5px);
            border-color: #1379BE;
        }

        .news-row:hover::before {
            transform: scaleY(1);
        }

        /* Date Styling */
        .news-date {
            color: #6c757d;
            font-size: 0.9rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            min-width: 140px;
        }

        .news-date i {
            color: #1379BE;
            font-size: 1rem;
        }

        /* Title Styling */
        .news-title {
            flex: 1;
            padding: 0 20px;
        }

        .news-title a {
            color: #2c3e50;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-decoration: none;
            line-height: 1.5;
        }

        .news-title a:hover {
            color: #dc3545;
            padding-left: 5px;
        }

        /* Read More Button */
        .news-action a {
            background: linear-gradient(135deg, #1379BE 0%, #0f65a5 100%);
            color: white !important;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            box-shadow: 0 4px 10px rgba(19, 121, 190, 0.3);
        }

        .news-action a:hover {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            transform: translateX(5px);
            box-shadow: 0 6px 15px rgba(220, 53, 69, 0.4);
        }

        .news-action a i {
            transition: transform 0.3s ease;
        }

        .news-action a:hover i {
            transform: translateX(3px);
        }

        /* View All Button */
        .view-all-news-btn {
            background: linear-gradient(135deg, #1379BE 0%, #0f65a5 100%);
            color: white !important;
            padding: 15px 45px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            border: none;
            box-shadow: 0 6px 20px rgba(19, 121, 190, 0.4);
            transition: all 0.4s ease;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            cursor: pointer;
        }

        .view-all-news-btn:hover {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(220, 53, 69, 0.5);
            color: white !important;
        }

        .view-all-news-btn i {
            font-size: 1.3rem;
            transition: transform 0.3s ease;
        }

        .view-all-news-btn:hover i {
            transform: scale(1.2) rotate(5deg);
        }

        .text-center {
            text-align: center;
        }

        .mt-5 {
            margin-top: 3rem;
        }

        /* Animation */
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .news-section-title {
                font-size: 1.5rem;
                flex-direction: column;
                gap: 10px;
            }
            
            .news-row {
                padding: 20px 15px;
            }
            
            .news-title {
                padding: 10px 0;
            }
            
            .news-date {
                min-width: 120px;
                font-size: 0.85rem;
            }
        }

        @media (max-width: 576px) {
            .healthcare-news-section {
                padding: 40px 15px;
                border-radius: 15px;
            }
            
            .news-row {
                flex-direction: column;
                align-items: flex-start !important;
                gap: 15px;
                padding: 15px;
            }
            
            .news-date {
                width: 100%;
            }
            
            .news-title {
                width: 100%;
                padding: 0;
            }
            
            .news-action {
                width: 100%;
            }
            
            .news-action a {
                width: 100%;
                justify-content: center;
                text-align: center;
            }
            
            .view-all-news-btn {
                width: 100%;
                justify-content: center;
                padding: 12px 30px;
                font-size: 1rem;
            }
        }
        .news-content {
    white-space: pre-line;
    font-size: 16px;
    line-height: 1.7;
}
      /* ===== ASP.NET DataPager FIX ===== */

.pager-wrapper {
    display: flex;
    justify-content: center;
}

/* Force DataPager children inline */
.pager-wrapper span,
.pager-wrapper a {
    display: inline-flex !important;
}

/* Pager container */
.pager-wrapper > * {
    display: flex;
    gap: 8px;
    align-items: center;
}

/* Pager button */
.pager-link {
    min-width: 42px;
    height: 38px;
    padding: 6px 14px;
    border-radius: 8px;
    border: 1px solid #dee2e6;
    background: #fff;
    color: #0d6efd;
    font-weight: 500;
    text-decoration: none;
    align-items: center;
    justify-content: center;
}

/* Hover */
.pager-link:hover {
    background: #0d6efd;
    color: #fff;
}

/* Active page */
.pager-link.active {
    background: #0d6efd;
    color: #fff;
    border-color: #0d6efd;
}



    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
       <!-- Daily Global Health Care News -->
<!-- Enhanced Global Health Care News Section with Database Integration -->
<div class="container mt-5 mb-5 highlight-soft">
    <!-- Section Header -->
     <div class="news-section-header">
                <h2 class="news-section-title">
                    <i class="fas fa-newspaper"></i>
                    Global Healthcare News
                </h2>
                <div class="header-underline"></div>
                <p class="news-section-subtitle">Stay informed with the latest healthcare industry updates</p>
            </div>

    <!-- Data Source -->
    <asp:SqlDataSource ID="SqlDataSourceHealthNews" runat="server"
        ConnectionString="<%$ ConnectionStrings:hospi2yp_tabletjobssConnectionString_V02 %>"
        SelectCommand="SELECT   [NewsID], [Topic], [NewsContent], [CategoryID], [NewsDate], [IsActive] 
                       FROM [dbo].[GlobalHealthNews] 
                       WHERE [IsActive] = 1 
                       ORDER BY [CreatedOn] DESC">
    </asp:SqlDataSource>

    <!-- News ListView -->
<asp:ListView ID="ListView_HealthNews" runat="server"
    DataSourceID="SqlDataSourceHealthNews"
    EnableViewState="true">

    <LayoutTemplate>
        <div class="row g-4">
            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
        </div>

        <!-- PAGINATION -->
       <!-- PAGINATION -->
<div class="pager-wrapper mt-4">
    <asp:DataPager ID="DataPager1" runat="server" PageSize="10">
        <Fields>

            <asp:NextPreviousPagerField
                ShowFirstPageButton="true"
                ShowPreviousPageButton="true"
                ShowNextPageButton="false"
                ShowLastPageButton="false"
                FirstPageText="«"
                PreviousPageText="Previous"
                ButtonCssClass="pager-link" />

            <asp:NumericPagerField
                ButtonType="Link"
                NumericButtonCssClass="pager-link"
                CurrentPageLabelCssClass="pager-link active"
                RenderNonBreakingSpacesBetweenControls="false" />

            <asp:NextPreviousPagerField
                ShowNextPageButton="true"
                ShowLastPageButton="true"
                ShowPreviousPageButton="false"
                ShowFirstPageButton="false"
                NextPageText="Next"
                LastPageText="»"
                ButtonCssClass="pager-link" />

        </Fields>
    </asp:DataPager>
</div>




        <!-- Back to Home -->
        <div class="text-center mt-5">
            <a href="OnlineInterviewJobs.aspx" class="view-all-news-btn">
                <i class="fas fa-newspaper"></i>
                Back to HomePage
            </a>
        </div>

    </LayoutTemplate>


   <ItemTemplate>
    <div class="col-12">
        <div class="news-row d-flex align-items-center justify-content-between flex-wrap p-3">

            <!-- DATE -->
            <div class="news-date text-muted small me-3">
                <i class="fas fa-calendar-alt me-1"></i>
                <%# Convert.ToDateTime(Eval("NewsDate")).ToString("MMM dd, yyyy") %>
            </div>

            <!-- TITLE / TOPIC -->
            <div class="news-title flex-grow-1 me-3">
                <a href='<%# "GlobalHealthNewsDetails.aspx?NewsID=" + Eval("NewsID") %>'
                   class="fw-semibold text-decoration-none text-dark">
                    <%# Eval("Topic") %>
                </a>
            </div>

            <!-- READ MORE -->
            <div class="news-action">
                <a href='<%# "GlobalHealthNewsDetails.aspx?NewsID=" + Eval("NewsID") %>'
                   class="text-primary small fw-semibold text-decoration-none">
                    Read More <i class="fas fa-arrow-right ms-1"></i>
                </a>
            </div>

        </div>
    </div>
</ItemTemplate>


    <EmptyDataTemplate>
        <div class="col-12">
            <div class="alert alert-info text-center py-5">
                <i class="fas fa-info-circle fa-3x mb-3 text-primary"></i>
                <h4>No News Available</h4>
                <p>Please check back later for updates.</p>
            </div>
        </div>
    </EmptyDataTemplate>

</asp:ListView>

</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
