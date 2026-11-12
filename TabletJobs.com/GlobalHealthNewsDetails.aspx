<%@ Page Language="C#" MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="GlobalHealthNewsDetails.aspx.cs"
    Inherits="TabletJobs.com.GlobalHealthNewsDetails" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
        }
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

      

        .healthcare-news-section {
            background: #f0f8ff;
            padding: 50px 20px;
            margin: 30px auto;
            border-radius: 16px;
            max-width: 1100px;
        }

        /* ===== HEADER ===== */
        .news-section-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .news-section-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1379BE;
        }

        /* ===== ARTICLE HEADER ===== */
        .article-header-card {
            background: #fff;
            border-radius: 14px;
            margin-bottom: 25px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .article-meta-bar {
            background: #1379BE;
            color: #fff;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .article-title-section {
            padding: 30px;
        }

        .article-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2c3e50;
            margin: 0;
        }

        /* ===== CONTENT ===== */
        .article-content-card {
            background: #fff;
            border-radius: 14px;
            padding: 40px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        }

        .article-content {
            font-size: 1.05rem;
            line-height: 1.6;
            color: #444;
        }

        .article-content p {
            margin-bottom: 10px;
        }

        .article-content ul {
            margin: 10px 0;
            padding-left: 22px;
        }

        .article-content li {
            margin-bottom: 6px;
        }

        /* ===== SOCIAL SHARE ===== */
     
        /* Social Icons Base Style */


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
   .social-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
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
    filter: brightness(1.1);
    transform: scale(1.05);
}

        /* ===== BUTTON ===== */
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
        /* ===============================
   ARTICLE CONTENT FONT CONTROL
   =============================== */

.article-text {
    font-size: 18px;      /* Desktop size */
    line-height: 1.8;
    color: #333;
}

/* Paragraph spacing */
.article-text p {
    margin-bottom: 16px;
}

/* Headings inside DB content */
.article-text h1,
.article-text h2,
.article-text h3 {
    font-weight: 700;
    margin-top: 24px;
    margin-bottom: 12px;
}

/* Lists */
.article-text ul,
.article-text ol {
    padding-left: 22px;
}

.article-text li {
    margin-bottom: 8px;
}

/* 📱 Mobile optimization */
@media (max-width: 576px) {
    .article-text {
        font-size: 19px;   /* Bigger on mobile */
        line-height: 1.9;
    }
}

.cta-box {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 25px;
    border: 1px solid #e3e3e3;
}

.employer-cta {
    background: linear-gradient(135deg, #eaf4ff, #ffffff);
}

.professional-cta {
    background: linear-gradient(135deg, #eafff2, #ffffff);
}

.cta-box h4 {
    color: #1379BE;
}

.cta-box p {
    color: #444;
    font-size: 15px;
}

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">

    <div class="healthcare-news-section">

        <!-- PAGE TITLE -->
        
 <section style="background:#1379BE; padding:40px 15px; margin-bottom:0; color:#ffffff;">
    <div class="container text-center">
        <h1 class="fw-bold mb-2" style="font-size:32px; color:#ffffff;">
           <asp:Label ID="lblTopic" runat="server" />
                </h1>
       

           

           
        </div>
    </section>

    <!-- WHITE CONTENT SECTION (NO GAP + BLACK TEXT) -->
    <section style="background:#ffffff; padding:35px 15px; margin-top:0;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10 article-text">

                     <asp:Literal ID="lblContent" runat="server"></asp:Literal>

                </div>
            </div>
        </div>
    </section>

   

    <!-- FINAL TAGLINE -->
               <div class="mt-2 border-top pt-1">
<div class="text-center fw-semibold mb-1 fs-6">
    If you found this article valuable, we invite you to share it with your friends, colleagues and professional network.
</div>
               <div class="d-flex justify-content-center gap-2 flex-wrap">

    <a class="social-icon facebook" target="_blank"
       href='<%= "https://www.facebook.com/sharer/sharer.php?u=" +
       HttpUtility.UrlEncode("https://www.tabletjobs.com/GlobalHealthNewsDetails.aspx?NewsID=" +
       Request.QueryString["NewsID"]) %>'>
        <i class="fab fa-facebook-f"></i>
    </a>

    <a class="social-icon whatsapp" target="_blank"
       href='<%= "https://api.whatsapp.com/send?text=" +
       HttpUtility.UrlEncode(lblTopic.Text + " - https://www.tabletjobs.com/GlobalHealthNewsDetails.aspx?NewsID=" +
       Request.QueryString["NewsID"]) %>'>
        <i class="fab fa-whatsapp"></i>
    </a>

    <a class="social-icon telegram" target="_blank"
       href='<%= "https://telegram.me/share/url?url=" +
       HttpUtility.UrlEncode("https://www.tabletjobs.com/GlobalHealthNewsDetails.aspx?NewsID=" +
       Request.QueryString["NewsID"]) +
       "&text=" + HttpUtility.UrlEncode(lblTopic.Text) %>'>
        <i class="fab fa-telegram-plane"></i>
    </a>

    <a class="social-icon twitter" target="_blank"
       href='<%= "https://twitter.com/intent/tweet?url=" +
       HttpUtility.UrlEncode("https://www.tabletjobs.com/GlobalHealthNewsDetails.aspx?NewsID=" +
       Request.QueryString["NewsID"]) +
       "&text=" + HttpUtility.UrlEncode(lblTopic.Text) %>'>
        <i class="fab fa-twitter"></i>
    </a>

    <a class="social-icon linkedin" target="_blank"
       href='<%= "https://www.linkedin.com/shareArticle?mini=true&url=" +
       HttpUtility.UrlEncode("https://www.tabletjobs.com/GlobalHealthNewsDetails.aspx?NewsID=" +
       Request.QueryString["NewsID"]) +
       "&title=" + HttpUtility.UrlEncode(lblTopic.Text) %>'>
        <i class="fab fa-linkedin-in"></i>
    </a>

</div>

            </div>
        <!-- VIEW ALL -->
        <div class="text-center mt-4">
            <a href="ViewAllHealthcareNews.aspx" class="view-all-news-btn">
                View All Healthcare News
            </a>
        </div>
        
       

    </div>
     <div class="cta-box employer-cta mt-5 text-center">
    <h4 class="fw-bold mb-2">
        Are you an employer or hospital?
    </h4>

    <p class="mb-3">
        Post your healthcare jobs here — <strong>FREE</strong>, anywhere in the world.<br />
        Access our free healthcare candidate database.
    </p>

    <a href="HospitalRegistrationV03.aspx" class="btn btn-primary rounded-pill px-4" style="background:#1379BE;color:#fff;border:2px solid #1379BE;">
        👉 Register Free
    </a>
</div>

        <div class="cta-box professional-cta mt-4 text-center">
    <p class="fw-semibold mb-3">
        Healthcare professionals and hospital staff anywhere in the world —
        Register free for local & overseas jobs, licensing support,
        interview alerts, and career updates.
    </p>

    <a href="CandidateRegistrationV03.aspx" class="btn btn-success rounded-pill px-4" style="color:#fff;">
        Register Free
    </a>
</div>
</asp:Content>
