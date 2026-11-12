<%@ Page Title="About" Language="C#" MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TabletJobs.com.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5">

        <!-- Header -->
        <div class="text-center mb-5">
            <h1 class="fw-bold" style="color:#1379BE;">
                About TabletJobs
            </h1>
            <p class="lead text-muted">
                Connecting Job Seekers and Employers with Fresh Opportunities
            </p>
        </div>

        <!-- Main Card -->
        <div class="card shadow border-0">
            <div class="card-body p-4 p-md-5">

                <p class="fs-5">
                    Welcome to <strong>TabletJobs.com</strong>, a platform designed to connect
                    job seekers and employers through fresh, verified, and easily accessible
                    job opportunities.
                </p>

                <p>
                    At <strong>TabletJobs</strong>, we believe that finding the right job or
                    hiring the right candidate should be simple, fast, and transparent.
                    Our platform brings together job opportunities from various industries
                    and helps employers reach qualified candidates efficiently.
                </p>

                <p>
                    What makes TabletJobs unique is our focus on fresh job listings.
                    Jobs are regularly updated, and many listings remain active for a
                    limited period, ensuring that candidates always have access to current
                    opportunities while employers receive timely applications.
                </p>

                <p>
                    Whether you are a fresher looking for your first job, an experienced
                    professional seeking career growth, or an employer searching for talented
                    candidates, TabletJobs provides a reliable platform to help you achieve
                    your goals.
                </p>

                <p>
                    Currently, TabletJobs focuses on providing daily fresh job opportunities
                    in <strong>Bangalore</strong>. As we continue to grow, we plan to expand
                    our services to <strong>Hyderabad, Chennai, Mumbai, Delhi, Pune</strong>
                    and other major cities across India, creating a larger network that
                    connects employers and job seekers nationwide.
                </p>

                <p>
                    Our vision is to build one of India's most trusted job platforms by
                    making recruitment faster, simpler, and more accessible for everyone.
                    We are committed to helping employers find the right talent and enabling
                    job seekers to discover new career opportunities every day.
                </p>

            </div>
        </div>

        <!-- Features -->
        <div class="row mt-5">

            <div class="col-md-4 mb-3">
                <div class="card h-100 shadow-sm text-center">
                    <div class="card-body">
                        <h4>🚀 Fresh Jobs</h4>
                        <p class="mb-0">
                            New opportunities added regularly for active job seekers.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card h-100 shadow-sm text-center">
                    <div class="card-body">
                        <h4>🏢 Employers</h4>
                        <p class="mb-0">
                            Connect with qualified candidates quickly and efficiently.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card h-100 shadow-sm text-center">
                    <div class="card-body">
                        <h4>📍 Expanding Across India</h4>
                        <p class="mb-0">
                            Starting with Bangalore and growing to major cities nationwide.
                        </p>
                    </div>
                </div>
            </div>

        </div>

        <!-- Footer Quote -->
        <div class="alert alert-success text-center mt-5 shadow-sm">
            <h5 class="mb-0 fw-bold">
                TabletJobs.com – Daily Fresh Jobs. Updated Every 24 Hours.
            </h5>
        </div>

    </div>

</asp:Content>