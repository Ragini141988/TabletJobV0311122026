<%@ Page Title="Online Interview Jobs" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="OnlineInterviewJobs.aspx.cs" Inherits="TabletJobs.com.OnlineInterviewJobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .oi-wrap{max-width:520px;margin:0 auto;padding:16px;min-height:100vh;background:#f3f7fc}
        .oi-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}
        .oi-logo{font-size:30px;font-weight:700;color:#1565c0}
        .oi-bell{font-size:22px}
        .oi-search{display:flex;gap:10px;margin-bottom:12px}
        .oi-search input{flex:1;padding:14px;border:1px solid #dbe4f0;border-radius:12px;font-size:16px;background:#fff}
        .oi-menu{width:50px;border:none;border-radius:12px;background:#fff;border:1px solid #dbe4f0;font-size:20px}
        .oi-filters{display:flex;gap:10px;margin-bottom:14px}
        .oi-filters select{flex:1;padding:12px;border-radius:12px;border:1px solid #dbe4f0;background:#fff;font-size:15px}
        .oi-filter-btn{width:100%;margin-bottom:20px;background:#1379BE;border:none;color:#fff;border-radius:12px;padding:10px 12px;font-weight:700}
        .oi-title{font-size:30px;font-weight:700;margin-bottom:8px;color:#111827;line-height:1.1}
        .oi-subtitle{color:#6b7280;margin-bottom:18px;font-size:15px}
        .job-card{background:#fff;border-radius:20px;padding:16px;margin-bottom:16px;box-shadow:0 6px 18px rgba(0,0,0,.06);border:1px solid #e6edf7}
        .job-top{display:flex;justify-content:space-between;align-items:start;margin-bottom:8px;gap:8px}
        .job-title{font-size:28px;font-weight:700;color:#1379BE;line-height:1.2;text-decoration:none}
        .badge{background:#f59e0b;color:#fff;font-size:12px;padding:5px 10px;border-radius:20px;font-weight:600;white-space:nowrap}
        .hospital{font-size:18px;color:#374151;margin-bottom:14px}
        .job-detail-row{background:#f8fbff;border:1px solid #e4edf7;border-radius:14px;padding:12px;margin-bottom:10px;font-size:17px;color:#374151}
        .detail-flex{display:flex;justify-content:space-between;gap:10px;align-items:center;flex-wrap:wrap}
        .detail-left{display:flex;gap:10px;flex-wrap:wrap;font-size:16px}
        .attend-btn{background:linear-gradient(90deg,#0ea5a4,#1f9d8b);color:#fff;border:none;border-radius:12px;padding:12px 18px;font-size:14px;font-weight:700;cursor:pointer;white-space:nowrap;text-decoration:none;display:inline-block}
        .latest-btn{background:linear-gradient(90deg,#1379BE,#1379BE);color:#fff;border:none;border-radius:12px;padding:12px 18px;font-size:15px;font-weight:700;cursor:pointer;white-space:nowrap;text-decoration:none;display:inline-block}
        .promo-box{background:#fff;border-radius:20px;padding:18px;margin-top:20px;box-shadow:0 6px 18px rgba(0,0,0,.06);border:1px solid #e6edf7}
        .promo-title{font-size:22px;font-weight:700;margin-bottom:10px;color:#1f2937}
        .promo-text{font-size:16px;color:#4b5563;line-height:1.5;margin-bottom:14px}
        .learn-btn{background:linear-gradient(90deg,#0ea5a4,#1f9d8b);color:#fff;border:none;border-radius:12px;padding:12px 20px;font-size:15px;font-weight:700}
        @media (max-width:480px){.job-title{font-size:24px}.oi-title{font-size:26px}.hospital{font-size:16px}.attend-btn{width:100%;margin-top:10px}.detail-flex{flex-direction:column;align-items:stretch}}
        .promo-box {
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-top: 15px;
}

.promo-title {
    font-size: 20px;
    font-weight: bold;
    color: #e65100;
    margin-bottom: 15px;
}

.promo-text {
    font-size: 14px;
    color: #333;
    line-height: 1.6;
}

.promo-highlight {
    margin-top: 15px;
    padding: 10px;
    background: #fff3e0;
    border-left: 4px solid #ff9800;
    font-size: 14px;
    border-radius: 6px;
}
/* Center everything */
.oi-wrap {
    text-align: center;
}

/* Header center */
.oi-header {
    flex-direction: column;
    gap: 5px;
}

/* Center logo + bell */
.oi-logo, .oi-bell {
    text-align: center;
}

/* Today heading */
.oi-today {
    font-size: 24px; /* increased size */
    font-weight: 800;
    text-align: center;
    margin-bottom: 16px;
}

/* Red Highlight */
.today-text {
    color: #dc2626; /* red */
}

/* Green Highlight */
.today-date {
    color: #16a34a; /* green */
    font-size: 24px;
}

/* Optional: subtle background highlight */
.oi-today {
    background: #f0f7ff; /* light red bg */
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #c7d7f0;
}
/* Center search + filters */
.oi-search,
.oi-filters {
    display: flex;
    gap: 10px;
    justify-content: center;
}

@media (max-width: 600px) {
    .oi-filters {
        flex-direction: column;
    }
}

/* Center buttons */
.oi-filter-btn,
.attend-btn,
.learn-btn {
    display: inline-block;
    margin: 10px auto;
}

.latest-btn {
    display: inline-block;
    margin: 5px auto;
}

/* Job card content center */
.job-top,
.detail-flex,
.detail-left {
    justify-content: center;
    text-align: center;
}

/* Hospital + subtitle */
.hospital,
.oi-subtitle {
    text-align: center;
}

/* Repeater content center */
.job-detail-row {
    text-align: center;
}
.gender-highlight {
    display: inline-block;
    margin-top: 6px;
    padding: 3px 10px;
    font-size: 24px;
    font-weight: 600;
    color: #065f46; /* dark green text */
    background-color: #d1fae5; /* light green background */
    border-radius: 12px;
}
            .hospital-logo-wrap{text-align:center;margin-bottom:10px}
        .hospital-logo{width:100%;height:220px;object-fit:cover;border-radius:14px;border:1px solid #e4edf7;background:#fff}
        .share-row{text-align:center;margin-top:8px}
        .share-link{display:inline-block;color:#1379BE;font-weight:700;text-decoration:none;border-bottom:1px dashed #1379BE;padding-bottom:2px}
        .share-link:hover{color:#0f5f96}
        .social-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 42px;
    height: 42px;
    margin: 2px;
    border-radius: 50%;
    background: #f1f5f9;
    color: #1379BE;
    font-size: 18px;
    transition: all 0.3s ease;
    text-decoration: none;
}
       .share-social .d-flex {
    flex-wrap: nowrap !important;
}


.social-icon:hover {
    background: #1379BE;
    color: #fff;
    transform: scale(1.1);
}

/* Mobile optimization */
@media (max-width: 480px) {
    .social-icon {
        width: 48px;
        height: 48px;
        font-size: 20px;
    }
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
        .hire-btn {
    display: inline-block;
    padding: 14px 28px;
    font-size: 18px;
    font-weight: bold;
    color: #fff;
    background: linear-gradient(45deg, #28a745, #20c997);
    border-radius: 30px;
    text-decoration: none;
    transition: 0.3s ease;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}

.hire-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(0,0,0,0.3);
}
.interview-info ul {
    text-align: left;
    padding-left: 20px;
    margin: 0;
}

.interview-info ul li {
    text-align: left;
    margin-bottom: 10px;
}

.interview-schedule {
    margin: 12px 0;
    padding: 12px 14px;
    background: #f8fafc;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    font-family: Arial, Helvetica, sans-serif;
}

.schedule-label {
    font-size: 13px;
    font-weight: 700;
    color: #374151;
    margin-bottom: 8px;
}

.schedule-details {
    display: flex;
    flex-wrap: wrap;
    gap: 8px 18px;
    font-size: 13px;
    color: #4b5563;
    line-height: 1.5;
}

@media (max-width: 480px) {
    .schedule-details {
        flex-direction: column;
        gap: 5px;
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="oi-wrap">
        <div class="oi-header">
            <div class="oi-logo">TabletJobs</div>
            <div class="oi-bell">&#128276;</div>
        </div>
        <div class="oi-title">Latest Hospital Job Vacancies</div>
        <div class="oi-subtitle">Direct Hospital Jobs With Instant Online Interview</div>
      
        <div class="oi-search">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search job vacancies..." />
            <button type="button" class="oi-menu">&#9776;</button>
        </div>

        <div class="oi-filters">
            <asp:DropDownList ID="ddlLocation" runat="server" />
            <asp:DropDownList ID="ddlJobCategory" runat="server" />
        </div>
        <asp:Button ID="btnSearch" runat="server" Text="Search Online Interviews" CssClass="oi-filter-btn" OnClick="btnSearch_Click" />

        <div class="oi-today">
   <%-- <span class="today-text">Today Online Interviews</span><br />--%>
             <span class="today-text">Upcoming Online Interviews</span><br />
    <span class="today-date" style="color:black;">(<%= DateTime.Now.ToString("dd/MM/yyyy") %>)</span>
</div>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

        <asp:Repeater ID="rptJobs" runat="server">
            <ItemTemplate>
                <div class="job-card">
                   <%-- <div class="hospital-logo-wrap">
                        <img class="hospital-logo" src='<%# GetHospitalImageDataUrl(Eval("himages")) %>' alt="Hospital Image" />
                    </div>--%>
                    <div class="job-top">
                        <asp:HyperLink ID="lnkJobTitle" runat="server" CssClass="job-title"
                            NavigateUrl='<%# "~/OnlineInterviewApply.aspx?jobId=" + Eval("JobID") %>'
                            Text='<%# Eval("JTitle") %>' />
                        <asp:PlaceHolder ID="phBadge" runat="server" Visible='<%# ShowBadge(Eval("BadgeText")) %>'>
                            <span class="badge"><%# Eval("BadgeText") %></span>
                        </asp:PlaceHolder>
                    </div>

                    <div class="hospital"><%# FormatHospital(Eval("hname"), Eval("hcity"), Eval("hstat")) %></div>

                
<div class="interview-schedule">
    <div class="schedule-label">Online Interview Date & Time:</div>

    <div class="schedule-details">
        <span>📅 <%# Eval("InterviewDate", "{0:dd MMM yyyy}") %></span>
        <span>⏰ <%# Eval("InterviewStartTime") %> - <%# Eval("InterviewEndTime") %></span>
    </div>
</div>


                       <asp:HyperLink ID="lnkAttend" runat="server" CssClass="attend-btn"
                                NavigateUrl='<%# "~/OnlineInterviewApply.aspx?jobId=" + Eval("JobID") %>'
                                Text="Apply Now For Online Interview"></asp:HyperLink>
                    <%--<div class="job-detail-row">
                        &#128101; <%# FormatVacancies(Eval("Jposi")) %> | <%# Eval("Jsal") %>
                    </div>--%>

                    <div class="job-detail-row">
                        <div class="detail-flex">
                          <%-- <div class="detail-left">
    <span>🎓 <%# Eval("Jqual") %></span>
    <span>💼 <%# Eval("Jexp") %></span>
    <span>📅 <%# Eval("InterviewDate", "{0:dd/MM/yyyy}") %> 
        | ⏰ <%# Eval("InterviewStartTime") %> - <%# Eval("InterviewEndTime") %>
    </span>
   <span class="gender-highlight">
    🚻 <%# Eval("GenderRequirement") %>
</span>
</div>--%>
                         

                             <%--<asp:HyperLink ID="lnklatestonlineinterview" runat="server" CssClass="latest-btn"
                                NavigateUrl='<%# "~/ViewZoomImagesV02.aspx"%>'
                                Text="Latest Online Interviews"></asp:HyperLink>--%>
                       <%--  <div>
<div class="interview-info">
<ul>
    <li>📱 Attend the scheduled interview online from your mobile or computer.</li>
    <li>🏢 Interview with the employer/authorized HR or interview team.</li>
    <li>📅 Interview slots are subject to employer availability.</li>
    <li>🤝 TabletJobs provides interview scheduling and coordination support.</li>
    <li>💳 ₹99 + GST is an Online interview facilitation fee — not a fee for employment.</li>
    <li>✅ Selection, salary and hiring decisions are made solely by the employer.</li>
    <li>🚫 Payment does not guarantee selection or employment.</li>
</ul>
    </div>--%>


</div>
                            <div class="share-social mt-2 border-top pt-1">
                                <div class="share-social-title text-center fw-semibold mb-1 small">Share This Website With Your Friends</div>
                                <div class="d-flex justify-content-center flex-wrap">
                                    <a href='<%# GetFacebookShareUrl(Eval("JobID")) %>' class="social-icon" target="_blank" title="Share on Facebook"><i class="fab fa-facebook-f"></i></a>
                                    <a href='<%# GetWhatsAppShareUrl(Eval("JobID")) %>' class="social-icon" target="_blank" title="Share on WhatsApp"><i class="fab fa-whatsapp"></i></a>
                                    <a href='<%# GetTelegramShareUrl(Eval("JobID")) %>' class="social-icon" target="_blank" title="Share on Telegram"><i class="fab fa-telegram-plane"></i></a>
                                    <a href='https://www.instagram.com/' class="social-icon" target="_blank" title="Share on Instagram"><i class="fab fa-instagram"></i></a>
                                    <a href='<%# GetTwitterShareUrl(Eval("JobID")) %>' class="social-icon" target="_blank" title="Share on Twitter"><i class="fab fa-twitter"></i></a>
                                    <a href='<%# GetLinkedInShareUrl(Eval("JobID")) %>' class="social-icon" target="_blank" title="Share on LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
               
            </ItemTemplate>
        </asp:Repeater>
        <div class="job-pagination">

    <asp:Button
        ID="btnPrevious"
        runat="server"
        Text="← Previous"
        CssClass="pagination-btn"
        OnClick="btnPrevious_Click" />

    <asp:Label
        ID="lblPageInfo"
        runat="server"
        CssClass="page-info" />

    <asp:Button
        ID="btnNext"
        runat="server"
        Text="Next →"
        CssClass="pagination-btn"
        OnClick="btnNext_Click" />

</div>

<div class="promo-box">

    <div class="promo-title">
        Attend Online Interviews with Hiring Companies
    </div>

    <div class="promo-text">

        <p>
            TabletJobs helps candidates discover job opportunities and attend
            scheduled online interviews with employers/authorized HR teams from anywhere.
        </p>

        <p>
            <b>Interview Facilitation Fee: ₹99 + GST per interview</b>
        </p>

        <p>
            The fee is charged for interview scheduling, coordination and candidate support.
            TabletJobs does not charge a recruitment or placement fee and does not guarantee
            employment. Selection, salary, offer letter and joining decisions are made solely
            by the respective employer.
        </p>

        <br />

        <div class="promo-section-title">
         <b>     🚀 Benefits of Online Interviews<</b>
        </div>

        <br />

        <p>
            ⏱️ <b>1. Save Time & Travel</b><br />
            Attend your interview remotely without travelling to the employer's location
            or waiting for walk-in interviews.<br />
            👉 Attend from home or anywhere convenient
        </p>

        <p>
            💰 <b>2. Affordable Interview Facilitation – ₹99 + GST</b><br />
            Online interviews can help reduce travel and related expenses, particularly
            for candidates applying outside their city / interview location.<br />
            👉 Interview facilitation fee: <b>₹99 + GST per interview</b>
        </p>

        <p>
            🏢 <b>3. Interview with the Employer</b><br />
            Attend the scheduled interview with the employer or their authorized
            HR/interview team.<br />
            👉 TabletJobs facilitates interview scheduling and coordination
        </p>

        <p>
            ⚡ <b>4. Faster Interview Process</b><br />
            Online interviews can reduce the time required to travel and attend
            physical walk-ins.<br />
            👉 Selection timelines depend entirely on the employer's recruitment process
        </p>

        <p>
            📱 <b>5. Attend from Anywhere</b><br />
            Candidates from different cities, towns and villages can access participating
            job opportunities without travelling for the initial interview.<br />
            👉 A smartphone/computer and reliable internet connection are generally sufficient
        </p>

        <p>
            🎯 <b>6. Access Multiple Opportunities</b><br />
            Explore available vacancies and, where eligible, book interviews for different
            opportunities.<br />
            👉 Each interview is subject to eligibility, employer requirements and
            slot availability
        </p>

        <p>
            🔒 <b>7. Convenient Interview Process</b><br />
            Attend the initial interview remotely from a suitable location.<br />
            👉 Useful for freshers, experienced professionals and outstation candidates
        </p>

        <p>
            📞 <b>8. Interview Coordination & Support</b><br />
            TabletJobs assists with interview scheduling, communication and coordination
            between candidates and participating employers.<br />
            👉 The final hiring decision always remains with the employer
        </p>

        <br />

        <div class="promo-section-title">
            After Selection – Optional Joining Support
        </div>

        <br />

        <p>
            <b>Joining Coordination Support: ₹1999 + GST</b><br />
            Available only after selection, where applicable.
        </p>

        <p>
            ✔️ HR communication and coordination support<br />
            ✔️ Document submission coordination<br />
            ✔️ Joining and onboarding follow-up
        </p>

        <p>
            <b>Important:</b> This optional service does not influence selection,
            salary, offer letter, joining approval or any other hiring decision
            made by the employer.
        </p>

        <br />

        <div class="promo-section-title">
         <b>     💳 Clear & Transparent Charges</b>  
        </div>

        <br />

        <p>
            We believe candidates should know exactly what they are paying for.
        </p>

        <p>
            👉 Online Interview Facilitation: <b>₹99 + GST per interview</b><br />
            👉 Optional Joining Coordination Support:
            <b>₹1999 + GST after selection, where applicable</b><br />
            👉 No payment guarantees a job or selection<br />
            👉 No hidden charges
        </p>

        <br />

        <div class="promo-section-title">
        <b>    Important Candidate Information</b>
        </div>

        <br />

        <p>
            TabletJobs is an online interview facilitation platform.
            We do not sell jobs or guarantee employment.
        </p>

        <p>
            The ₹99 + GST fee is charged for facilitating a specific online interview,
            including scheduling, coordination and candidate support.
            Paying the fee does not guarantee selection.
        </p>

        <p>
            Candidate eligibility, interview assessment, selection/rejection, salary,
            offer letter and joining are determined solely by the respective employer.
        </p>

        <p>
            Candidates should review the job description, eligibility requirements,
            interview details, applicable fees and terms before booking an interview.
        </p>

    </div>

</div>


        
</asp:Content>



