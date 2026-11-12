<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master" AutoEventWireup="true" CodeBehind="SelectedCandidatePageV02.aspx.cs" Inherits="TabletJobs.com.SelectedCandidatePageV02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        .form-header {
            text-align: center;
            background-color: #1379BE;
            color: white;
            font-size: 20px;
            padding: 5px;
            margin-bottom: 2px;
        }
         .btn.btn-primary.mt-3 {
    background-color: #1379BE !important; /* Override the Bootstrap primary color */
    transition: none !important; /* Disable any transition effects */
}
        .form-group {
            margin-bottom: 15px;
        }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-size: 12px; /* Adjusted font size for labels */
            }

            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }

        .form-footer {
            text-align: center;
            margin-top: 20px;
        }

            .form-footer button {
                background-color: darkslategrey; /* Brighter blue */
                color: white;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-weight: bold; /* Makes the text slightly bolder */
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* Adds a slight shadow for better visibility */
            }

                .form-footer button:hover {
                    background-color: #0056b3; /* Darker blue on hover */
                }

        .form-group img {
            max-width: 100px;
            height: auto;
            margin-top: 10px;
        }

        .social-media {
            margin-top: 20px;
            text-align: center;
            background-color: white;
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

            .social-media a.facebook {
                background-color: #3b5998;
            }

            .social-media a.whatsapp {
                background-color: #25d366;
            }

            .social-media a.telegram {
                background-color: #0088cc;
            }

            .social-media a.instagram {
                background-color: #e4405f;
            }

            .social-media a.twitter {
                background-color: #1da1f2;
            }

            .social-media a.pinterest {
                background-color: #bd081c;
            }

            .social-media a.linkedin {
                background-color: #0077b5;
            }

            .social-media a.reddit {
                background-color: #ff4500;
            }

            .social-media a:hover {
                opacity: 0.7;
            }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
     <div class="container mt-5">
        <div class="row">
            <div class="col-12 text-center mb-4">
                <h2 class="form-header">Selected Candidate Details</h2>
            </div>
        </div>
       
            <div class="row mb-3">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="d-flex align-items-center">
                            <span class="required-lbl" style="color: red;">* </span>
                            <asp:Label ID="Label1" runat="server" Text="Serial No:" AssociatedControlID="Txtsrno" CssClass="form-label ml-1"></asp:Label>
                        </div>
                        <div class="mt-1">
                            <asp:TextBox ID="Txtsrno" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvTxtnm" runat="server" ControlToValidate="Txtsrno" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter Job Title" CssClass="mt-1" Style="color: #dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="d-flex align-items-center">
                            <span class="required-lbl" style="color: red;">* </span>
                            <asp:Label ID="Label10" runat="server" Text="HospitalName" AssociatedControlID="Txtnm" CssClass="form-label"></asp:Label>
                        </div>
                          <div class="mt-1">
                            <asp:TextBox ID="Txtnm" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Txtnm" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter Job Title" CssClass="mt-1" Style="color: #dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
                        </div>
                       
                           
                        </div>
                    </div>
                </div>
           
          <div class="row mb-3">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="d-flex align-items-center">
         <span style="color: red; font-size: larger;">* </span>
        <asp:Label ID="lblBookingStation" runat="server" Text="City:" CssClass="form-label"></asp:Label>
                            </div>
                          <div class="mt-1">
        <asp:DropDownList ID="ddlCities" runat="server" CssClass="form-select">
  
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvBookingStation" runat="server" ControlToValidate="ddlCities" InitialValue="Select City" ErrorMessage="City is required" ForeColor="Red" />
    </div>  </div>
                    </div>
                </div>

            <div class="row mb-3">
                <div class="col-md-12">
                    <div class="form-group">
                         <div class="d-flex align-items-center">
                            <span class="required-lbl" style="color: red;">* </span>

                        <asp:Label ID="Label2" runat="server" Text="Interview Date" AssociatedControlID="InterviewDate" CssClass="form-label"></asp:Label>
                             </div>
                        <div class="mt-1">
                <asp:TextBox ID="InterviewDate" runat="server" CssClass="form-control date-picker"  TextMode="Date" />
               <asp:RequiredFieldValidator ID="rfvInterviewDate" runat="server" ControlToValidate="InterviewDate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Select Interview Date" CssClass="mt-1" Style="color:#dc3545; font-size: 15px; font-weight: normal;"></asp:RequiredFieldValidator>
            </div>
                    </div>
                </div>
            </div>




            <div class="row mb-3">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="d-flex align-items-center">
                            <span class="required-lbl" style="color: red;">* </span>
                            <asp:Label ID="Label12" runat="server" Text="Candidate Name" AssociatedControlID="Txtcname" CssClass="form-label"></asp:Label>
                        </div>
                        <div class="mt-1">
                                <asp:TextBox ID="Txtcname" runat="server" CssClass="form-control" />
                          
                            <asp:RequiredFieldValidator
                                ID="rfvDrpQual"
                                runat="server"
                                ControlToValidate="Txtcname"
                                InitialValue=""
                                SetFocusOnError="true"
                                Display="Dynamic"
                                ErrorMessage="Please select a candidate name"
                                CssClass="mt-1"
                                Style="color: #dc3545; font-size: 15px; font-weight: normal;">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>

             <div class="row mb-3">
     <div class="col-md-12">
         <div class="form-group">
             <div class="d-flex align-items-center">
                 <span class="required-lbl" style="color: red;">* </span>
                 <asp:Label ID="Label18" runat="server" Text="Gender:" AssociatedControlID="Drpgen" CssClass="form-label"></asp:Label>
             </div>
             <asp:DropDownList ID="Drpgen" runat="server" CssClass="form-control">
                 <asp:ListItem Value="">Select Gender</asp:ListItem>
                                  <asp:ListItem>Female</asp:ListItem>
                 <asp:ListItem>Male</asp:ListItem>
             </asp:DropDownList>
             <asp:RequiredFieldValidator ID="rqvgender" runat="server" ControlToValidate="Drpgen" InitialValue=""
                 SetFocusOnError="true"
                 Display="Dynamic" ErrorMessage="select Your Gender" CssClass="mt-1" Style="color: #dc3545; font-size: 15px; font-weight: normal;" ForeColor="Red"></asp:RequiredFieldValidator>
         </div>
     </div>
                     <div class="col-md-12">
         <div class="form-group">
             <div class="d-flex align-items-center">
                 <span class="required-lbl" style="color: red;">* </span>
                 <asp:Label ID="Label3" runat="server" Text="Coordinator:" AssociatedControlID="drpcoordinator" CssClass="form-label"></asp:Label>
             </div>
             <asp:DropDownList ID="drpcoordinator" runat="server" CssClass="form-control">
                 <asp:ListItem>Select Coordinator</asp:ListItem>
                                  <asp:ListItem>Rashida: 7349068797</asp:ListItem>

                                    <asp:ListItem>Ayesha: 9652039241</asp:ListItem>

                                    <asp:ListItem>Divya: 9913879238</asp:ListItem>

                                    <asp:ListItem>Vismaya: 9778791037 </asp:ListItem>

                                    <asp:ListItem>Roopa: 7338322596</asp:ListItem>

                                    <asp:ListItem>Helna: 9746583931</asp:ListItem>
                                                     <asp:ListItem>Dheepika: 8310711034</asp:ListItem>
                                                     <asp:ListItem>Nidhi: 9873960913</asp:ListItem>
                 <asp:ListItem>Neeharika: 9391181595</asp:ListItem>
                                                     <asp:ListItem>Dheepthi: 7780104214</asp:ListItem>
                                                     <asp:ListItem>Amani: 7569550233</asp:ListItem>
                   <asp:ListItem>Pinaki: 8073631650</asp:ListItem>
                 <asp:ListItem>Kalyani: 9390929906</asp:ListItem>
                 <asp:ListItem>Loheena: 9059724821</asp:ListItem>
                 <asp:ListItem>kaushik neha: 9220913372</asp:ListItem>
                 <asp:ListItem>Sajitha: 9446436405</asp:ListItem>
                 <asp:ListItem>Bhanu : 9390932216</asp:ListItem>
                 <asp:ListItem>K.Keerthi : 7075915691</asp:ListItem>
                 
             </asp:DropDownList>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="drpcoordinator" InitialValue="Select Coordinator"
                 SetFocusOnError="true"
                 Display="Dynamic" ErrorMessage="select Your Coordinator" CssClass="mt-1" Style="color: #dc3545; font-size: 15px; font-weight: normal;" ForeColor="Red"></asp:RequiredFieldValidator>
         </div>
     </div>
 </div>
   <div class="form-footer">
        <asp:Button ID="btnSubmit" runat="server" CausesValidation="true" Text="Submit" CssClass="btn btn-primary mt-3" OnClick="btnSubmit_Click" />
       <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    </div>
   

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:hospi2yp_tabletjobssConnectionString %>" SelectCommand="SELECT * FROM [Candidates]"></asp:SqlDataSource>
        </div>

      
       
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
