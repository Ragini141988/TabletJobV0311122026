<%@ Page Title=""  ValidateRequest="false" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="AddGlobalHealthNews.aspx.cs" Inherits="TabletJobs.com.AddGlobalHealthNews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
         .heading-bg {
        background-color: rgb(25, 117, 184);
        padding: 8px 12px;
        border-radius: 6px;
        margin-bottom: 5px;
        color: white;
        font-weight: bold;
        text-align: center;
    }

        .spinner {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            border: 6px dashed #0078d4;
            border-top-color: transparent;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        .job-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeInUp 0.5s ease-in-out;
        }

            .job-card:hover {
                transform: scale(1.02);
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
            }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .job-card-title {
            transition: color 0.3s ease;
        }

            .job-card-title:hover {
                color: #1379BE !important;
            }

        .job-meta i {
            color: #1379BE;
        }

        .social-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            color: white;
            font-size: 18px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

            /* Individual platform colors */
            .social-icon.facebook {
                background-color: #1877f2;
            }

            .social-icon.instagram {
                background: linear-gradient(45deg, #405de6, #5851db, #833ab4, #c13584, #e1306c, #fd1d1d);
            }

            .social-icon.twitter {
                background-color: #1da1f2;
            }

            .social-icon.youtube {
                background-color: #ff0000;
            }

            .social-icon.telegram {
                background-color: #0088cc;
            }

            .social-icon.whatsapp {
                background-color: #25d366;
            }

            .social-icon.linkedin {
                background-color: #0077b5;
            }

            .social-icon:hover {
                background-color: #0d6efd; /* Bootstrap primary */
            }


        .info-banner-section {
            background-color: #f5faff;
            padding: 60px 20px;
            text-align: center;
        }

            .info-banner-section h2 {
                font-size: 2rem;
                font-weight: 700;
                color: #0d47a1;
                margin-bottom: 15px;
                line-height: 1.4;
            }

            .info-banner-section p {
                font-size: 1.1rem;
                color: #444;
                max-width: 720px;
                margin: 0 auto 30px;
            }

            .info-banner-section .banner-img {
                max-width: 100%;
                height: auto;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

        .feature-box {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

       /* .carousel-inner img {
            height: 400px;
            object-fit: cover;
        }
        /* Floating Icons Positioning 
        .floating-icons {
            position: fixed;
            bottom: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            z-index: 1000;
        }*/

        .phone-icon {
            background-color: #007bff;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            text-decoration: none;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

            .phone-icon:hover {
                background-color: #0056b3;
                color: white;
            }

        .phone-icon {
            background-color: #007bff;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            cursor: pointer;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .whatsapp-icon {
            background-color: #25D366;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            cursor: pointer;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

            .whatsapp-icon:hover {
                background-color: #1EBE5D;
                transform: scale(1.1);
            }
.custom-primary {
    background-color: rgb(25, 117, 184) !important;
    border-color: rgb(25, 117, 184) !important;
    color: white !important;
}

.custom-primary:hover {
    background-color: rgb(20, 100, 160) !important; /* darker shade for hover */
    border-color: rgb(20, 100, 160) !important;
}



        /* Mobile Responsive */
        @media (max-width: 768px) {
            .social-icons-header {
                gap: 10px;
            }

                .social-icons-header a {
                    width: 40px;
                    height: 40px;
                    font-size: 18px;
                }

            .floating-icons {
                bottom: 15px;
                right: 15px;
            }

            .phone-icon, .whatsapp-icon {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }

            .results-container {
                max-width: 900px;
                margin: 40px auto;
                padding: 0 15px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .result-card {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 120, 212, 0.15);
                padding: 25px 30px;
                margin-bottom: 25px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                cursor: pointer;
            }

                .result-card:hover {
                    transform: translateY(-6px);
                    box-shadow: 0 8px 20px rgba(0, 120, 212, 0.3);
                }

            .result-info {
                flex: 1;
            }

                .result-info h3 {
                    margin: 0 0 10px;
                    font-weight: 700;
                    color: #0078d4;
                    font-size: 1.3rem;
                    letter-spacing: 0.02em;
                }

                .result-info p {
                    margin: 4px 0;
                    color: #555;
                    font-size: 0.95rem;
                }

            .badge {
                padding: 8px 20px;
                border-radius: 25px;
                font-weight: 700;
                font-size: 0.95rem;
                text-align: center;
                min-width: 100px;
                color: white;
                user-select: none;
                box-shadow: 0 2px 8px rgba(0,0,0,0.12);
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }

                .badge.passed {
                    background: linear-gradient(45deg, #28a745, #2ecc71);
                    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.5);
                }

                .badge.failed {
                    background: linear-gradient(45deg, #dc3545, #e74c3c);
                    box-shadow: 0 4px 12px rgba(220, 53, 69, 0.5);
                }

                .badge.pending {
                    background: linear-gradient(45deg, #ffc107, #f1c40f);
                    color: #333;
                    box-shadow: 0 4px 12px rgba(255, 193, 7, 0.5);
                }

            .interview-result-bar {
                background: linear-gradient(90deg, #0078d4, #005a9e);
                color: white;
                font-weight: 600;
                padding: 12px 20px;
                overflow: hidden;
                white-space: nowrap;
                box-shadow: 0 3px 8px rgba(0,0,0,0.2);
                border-radius: 0 0 10px 10px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                position: relative;
            }

            .interview-result-scroll {
                display: inline-block;
                padding-left: 100%;
                animation: scrollLeft 20s linear infinite;
            }

            .interview-result-item {
                display: inline-block;
                margin-right: 50px;
            }

            @media(min-width: 992px) {
                .navbar-nav {
                    gap: 0.5rem;
                    flex-wrap: nowrap;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                    .navbar-nav .nav-link {
                        padding-left: 0.5rem !important;
                        padding-right: 0.5rem !important;
                        font-size: 0.95rem;
                        white-space: nowrap;
                    }
            }
            /* On smaller screens, stack the nav links with spacing */
            @media (max-width: 991px) {
                .navbar-nav {
                    flex-direction: column !important;
                    gap: 0.75rem !important;
                    margin-top: 0.5rem;
                }

                    .navbar-nav .nav-link {
                        padding-left: 0 !important;
                        padding-right: 0 !important;
                        font-size: 1.1rem;
                    }
            }

            /* Scroll animation */
            @keyframes scrollLeft {
                0% {
                    transform: translateX(0%);
                }

                100% {
                    transform: translateX(-100%);
                }
            }

            /* Pause animation on hover */
            .interview-result-bar:hover .interview-result-scroll {
                animation-play-state: paused;
            }

            /* Responsive font size */
            @media (max-width: 600px) {
                .interview-result-bar {
                    font-size: 14px;
                    padding: 10px 15px;
                }
            }
            /* Responsive */
            @media (max-width: 600px) {
                .result-card {
                    flex-direction: column;
                    align-items: flex-start;
                    padding: 20px;
                }

                .badge {
                    margin-top: 15px;
                    min-width: auto;
                    padding: 8px 25px;
                    font-size: 1rem;
                }
            }
        }

        @media (max-width: 576px) {
            .social-icons-header a {
                width: 35px;
                height: 35px;
                font-size: 16px;
            }

            .phone-icon, .whatsapp-icon {
                width: 45px;
                height: 45px;
                font-size: 18px;
            }
        }

        .card:hover {
            transform: translateY(-5px);
            transition: 0.3s ease-in-out;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
    </style>

    <style>
        .text-brand {
    color: rgb(25, 117, 184);
}

.job-heading {
    transition: all 0.3s ease;
    display: inline-block;
}

.job-heading:hover {
    color: rgb(220, 53, 69); /* Red tone on hover */
    transform: translateY(-2px);
}
        .job-card {
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px 25px;
            margin-bottom: 25px;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
            transition: all 0.3s ease-in-out;
            text-align: left;
        }

            .job-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            }

        .job-logo {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        .job-card-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #1379BE;
            margin-bottom: 8px;
            text-decoration: none;
            display: block;
        }

        .job-meta {
            color: #555;
            font-size: 0.95rem;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
        }

            .job-meta i {
                margin-right: 7px;
                color: #1379BE;
                font-size: 1rem;
            }

        .job-actions {
            margin-top: 18px;
        }

            .job-actions .btn {
                font-size: 0.92rem;
                padding: 7px 16px;
                background-color: #1379BE;
                border: none;
                color: white;
                border-radius: 6px;
            }

                .job-actions .btn:hover {
                    background-color: #0f65a5;
                }

        .center-social {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }

            .center-social a {
                width: 45px;
                height: 45px;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                background-color: #f0f0f0;
                text-decoration: none;
                font-size: 20px;
                color: white;
                transition: transform 0.2s;
            }

                .center-social a:hover {
                    transform: scale(1.1);
                }

        @media (max-width: 768px) {
            .job-card {
                padding: 15px;
            }

            .job-actions {
                display: flex;
                flex-direction: column;
            }

                .job-actions .btn {
                    margin-bottom: 10px;
                }
        }
    </style>
    <style>
      #carouselExampleAutoplay .carousel-item img {
            width: 100%;
            height: 250%;
            object-fit: cover;
            margin-bottom: 0 !important;
        }

        @media (max-width: 768px) {
            #carouselExampleAutoplay .carousel-item img {
                width: 100%;
                height: 280px;
                object-fit: cover;
                 margin-bottom: 0 !important;
            }
        }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <div class="container mt-4">
  
         <h3 class="text-primary fw-bold mb-4" style="font-size: 1.75rem;">
            <span style="font-size: 20px;">Daily Global Health Care News</span>
        </h3>
    <div class="mb-3">
        <label>Topic</label>
        <asp:TextBox ID="txtTopic" runat="server" CssClass="form-control" />
    </div>

    <div class="mb-3">
        <label>Main Content</label>
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

    <div class="mb-3">
        <label>Date</label>
        <asp:TextBox ID="txtDate" runat="server"
            CssClass="form-control" ReadOnly="true" />
    </div>

    <div class="mb-3">
        <label>Category</label>
        <asp:DropDownList ID="ddlCategory" runat="server"
            CssClass="form-control" />
    </div>

    <asp:Button ID="btnSubmit" runat="server"
        Text="Submit"
        CssClass="btn btn-primary custom-primary"
        OnClick="btnSubmit_Click" />
        <asp:Label ID="lblMessage" runat="server"
    CssClass="alert alert-success mt-3"
    Visible="false" />

</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
