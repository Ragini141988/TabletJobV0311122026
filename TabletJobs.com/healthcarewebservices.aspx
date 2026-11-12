<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="healthcarewebservices.aspx.cs" Inherits="TabletJobs.comhealthcarewebservices" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .healthcare-section {
            background: #ffffff;
            padding: 50px 0;
        }
        .hero-section {
            background: linear-gradient(135deg, #1379BE 0%, #0d5a8f 100%);
            color: white;
            padding: 10px 10px;
            text-align: center;
            border-radius: 10px;
            margin-bottom: 40px;
        }
        .hero-section h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .hero-section p {
            font-size: 1.2rem;
            opacity: 0.95;
        }
        .section-title {
            color: #1379BE;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #1379BE;
        }
        .content-card {
            background: #f8f9fa;
            padding: 35px;
            border-radius: 10px;
            margin-bottom: 30px;
            border-left: 5px solid #1379BE;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        .content-card h3 {
            color: #1379BE;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .feature-list {
            list-style: none;
            padding: 0;
        }
        .feature-list li {
            padding: 10px 0;
            padding-left: 30px;
            position: relative;
            line-height: 1.6;
        }
        .feature-list li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #1379BE;
            font-weight: bold;
            font-size: 1.2rem;
        }
        .pricing-box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            border: 2px solid #1379BE;
            text-align: center;
            margin: 30px 0;
        }
        .pricing-box .price {
            font-size: 2.5rem;
            color: #1379BE;
            font-weight: 700;
            margin: 20px 0;
        }
        .pricing-box .delivery {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .info-box {
            background: white;
            padding: 25px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            text-align: center;
        }
        .info-box h4 {
            color: #1379BE;
            margin-bottom: 10px;
        }
        .highlight-box {
            background: #e8f4f8;
            padding: 25px;
            border-radius: 8px;
            border-left: 4px solid #1379BE;
            margin: 20px 0;
        }
        .cta-section {
            background: #1379BE;
            color: white;
            padding: 50px;
            border-radius: 10px;
            text-align: center;
            margin-top: 40px;
        }
        .cta-section h2 {
            font-size: 2rem;
            margin-bottom: 20px;
        }
        .cta-section a {
    color: white;
    font-size: 1.2rem;
    text-decoration: none;
    padding: 15px 40px;
    background: rgba(255,255,255,0.2);
    border-radius: 5px;
    display: inline-block;
    margin-top: 20px;
    transition: all 0.3s;

    /* ✅ FIX for mobile */
    word-break: break-all;
    overflow-wrap: anywhere;
    max-width: 100%;
}

        .cta-section a:hover {
            background: rgba(255,255,255,0.3);
        }
        .page-numbers {
            background: white;
            padding: 15px;
            border-radius: 5px;
            display: inline-block;
            margin: 5px 0;
        }
        @media (max-width: 576px) {
    .cta-section {
        padding: 30px 20px;
    }

    .cta-section a {
        font-size: 1rem;
        padding: 12px 15px;
        word-break: break-all;
        overflow-wrap: anywhere;
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="healthcare-section">
        <div class="container">
            
            <div class="hero-section">
                <h1>Healthcare Web Services</h1>
                <p>For Doctors, Clinics & Hospitals Worldwide</p>
                <p style="font-size: 1rem; margin-top: 10px;">By TabletJobs – Global Healthcare Platform</p>
            </div>

            <div class="content-card">
                <h3>Build Trust. Go Digital. Grow Professionally.</h3>
                <p>In today's digital-first world, a clinic or hospital website is often the <strong>first point of contact</strong> for patients.</p>
                <p>At <strong>TabletJobs</strong>, we design <strong>modern, professional, and healthcare-focused websites</strong> that help doctors and clinics establish a strong online presence.</p>
                <p>We specialize exclusively in <strong>healthcare website design</strong>, understanding the unique needs of medical practices worldwide.</p>
            </div>

            <h2 class="section-title">Who We Design For</h2>
            <div class="info-grid">
                <div class="info-box">
                    <h4>Doctors & Physicians</h4>
                </div>
                <div class="info-box">
                    <h4>Private Clinics</h4>
                </div>
                <div class="info-box">
                    <h4>Diagnostic Centers</h4>
                </div>
                <div class="info-box">
                    <h4>Multi-specialty Clinics</h4>
                </div>
                <div class="info-box">
                    <h4>Hospitals & Healthcare Groups</h4>
                </div>
            </div>
            <p style="text-align: center; color: #666; margin-top: 20px;">
                Serving clients across <strong>USA, UK, Europe, Australia, Gulf, India, and other countries</strong>.
            </p>

            <h2 class="section-title" style="margin-top: 50px;">Standard Website Package</h2>
            <div class="highlight-box">
                <p style="margin: 0; font-weight: 600;">Ideal for solo doctors & small clinics</p>
            </div>

            <div class="content-card">
                <h3>Pages Included (Up to 5 Pages)</h3>
                <div class="page-numbers">
                    <strong>1.</strong> Home | 
                    <strong>2.</strong> About Doctor / Clinic | 
                    <strong>3.</strong> Services | 
                    <strong>4.</strong> Contact (with enquiry form & map) | 
                    <strong>5.</strong> Privacy Policy
                </div>
            </div>

            <div class="content-card">
                <h3>What's Included</h3>
                <ul class="feature-list">
                    <li>Professional & modern design</li>
                    <li>Mobile-friendly (responsive) layout</li>
                    <li>Secure website structure (SSL-ready)</li>
                    <li>HIPAA-aware design approach (design-focused)</li>
                    <li>Contact & enquiry form integration</li>
                    <li>Google Maps integration</li>
                    <li>Basic on-page SEO</li>
                    <li>Fast loading performance</li>
                    <li>Hosting & domain guidance</li>
                    <li>1 round of revisions</li>
                </ul>
            </div>

            <div class="pricing-box">
                <div class="delivery">⏱ Delivery: 7–10 business days</div>
                <div class="price">$99 - $199</div>
                <p>(one-time design fee)</p>
            </div>

            <h2 class="section-title">Optional Add-On Services</h2>
            <div class="content-card">
                <p style="margin-bottom: 20px; font-style: italic;">Customizable based on clinic needs</p>
                <ul class="feature-list">
                    <li>Online appointment booking</li>
                    <li>WhatsApp chat integration</li>
                    <li>Blog / Articles section</li>
                    <li>Additional pages</li>
                    <li>Multi-doctor profiles</li>
                    <li>Monthly maintenance & updates</li>
                    <li>SEO & Google visibility support</li>
                </ul>
                <p style="margin-top: 20px; color: #1379BE; font-weight: 600;">👉 Pricing provided on request</p>
            </div>

            <h2 class="section-title">For Hospitals & Large Clinics</h2>
            <div class="content-card">
                <p style="margin-bottom: 20px;">We also design <strong>custom hospital websites</strong> with:</p>
                <ul class="feature-list">
                    <li>10+ pages</li>
                    <li>Departments & services</li>
                    <li>Multiple doctors</li>
                    <li>Advanced enquiry & appointment systems</li>
                </ul>
                <p style="margin-top: 20px; color: #1379BE; font-weight: 600;">Pricing provided on request</p>
            </div>

            <h2 class="section-title">Hosting & Domain Policy</h2>
            <div class="content-card">
                <p style="margin-bottom: 20px;"><strong>For transparency and ownership:</strong></p>
                <ul class="feature-list">
                    <li><strong>Domain & hosting are purchased in the client's name</strong></li>
                    <li>TabletJobs provides <strong>complete guidance & setup support</strong></li>
                    <li>Typical annual cost: <strong>$70 – $135</strong> (paid directly by client)</li>
                </ul>
                <p style="margin-top: 20px; font-style: italic;">Optional <strong>managed hosting support</strong> available.</p>
            </div>

            <h2 class="section-title">Why Choose TabletJobs?</h2>
            <div class="content-card">
                <ul class="feature-list">
                    <li>Healthcare-focused design expertise</li>
                    <li>Global experience with medical professionals</li>
                    <li>Transparent pricing</li>
                    <li>No false promises or guarantees</li>
                    <li>Trusted healthcare career & technology platform</li>
                </ul>
            </div>

            <div class="cta-section">
                <h2>Get a Free Consultation</h2>
                <p style="font-size: 1.1rem;">Thinking of building or upgrading your clinic website?</p>
                <a href="mailto:karimullah.sultan@tabletjobs.com">
    📩 karimullah.sultan@tabletjobs.com
</a>

                <p style="margin-top: 20px;">Our team will understand your requirements and suggest the best solution.</p>
            </div>

            <div class="highlight-box" style="margin-top: 40px;">
                <h3 style="color: #1379BE; margin-bottom: 10px;">About TabletJobs</h3>
                <p style="margin: 0;"><strong>TabletJobs</strong> is a global healthcare platform connecting healthcare professionals, hospitals, and digital solutions under one ecosystem — careers, recruitment, and technology.</p>
            </div>

        </div>
    </div>
</asp:Content>