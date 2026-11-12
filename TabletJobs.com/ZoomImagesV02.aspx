<%@ Page Title="" Language="C#" MasterPageFile="~/FirstMasterPAge.Master"
    AutoEventWireup="true"
    CodeBehind="ZoomImagesV02.aspx.cs"
    Inherits="TabletJobs.com.ZoomImagesV02" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        rel="stylesheet" />

    <style type="text/css">

        .form-header {
            text-align: center;
            background-color: #1379BE;
            color: white;
            font-size: 20px;
            padding: 8px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 13px;
        }

        .date-picker {
            width: 180px;
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 30px;
        }

        .form-footer .btn {
            min-width: 120px;
            font-weight: bold;
        }

        .current-image {
            max-width: 180px;
            max-height: 120px;
            margin-top: 10px;
            border: 1px solid #ddd;
            padding: 3px;
            border-radius: 4px;
        }

        .list-header {
            text-align: center;
            background-color: #1379BE;
            color: white;
            font-size: 20px;
            padding: 8px;
            border-radius: 4px;
            margin-top: 35px;
            margin-bottom: 15px;
        }

        .zoom-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,.08);
        }

        .zoom-card img {
            max-width: 100%;
            max-height: 180px;
            object-fit: contain;
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 3px;
        }

        .zoom-description {
            font-size: 15px;
            margin-top: 10px;
            color: #333;
        }

        .zoom-date {
            color: #666;
            font-size: 13px;
            margin-top: 5px;
        }

        .action-buttons {
            margin-top: 12px;
        }

        .action-buttons .btn {
            margin-right: 5px;
            min-width: 75px;
        }

        .no-records {
            text-align: center;
            padding: 20px;
            color: #777;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        @media (max-width: 767px) {

            .container {
                padding-left: 10px;
                padding-right: 10px;
            }

            .form-header,
            .list-header {
                font-size: 18px;
            }

            .date-picker {
                width: 100%;
            }

            .zoom-card {
                padding: 12px;
            }

            .zoom-card img {
                max-height: 150px;
            }

            .action-buttons .btn {
                width: 100%;
                margin-bottom: 8px;
                margin-right: 0;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">

    <div class="container mt-5">

        <!-- FORM HEADER -->
        <div class="form-header">
            <asp:Label ID="lblFormTitle" runat="server"
                Text="Live Online Interview">
            </asp:Label>
        </div>

        <!-- HIDDEN ID FOR EDIT -->
        <asp:HiddenField ID="hdnId" runat="server" Value="0" />

        <!-- IMAGE -->
        <div class="row mb-3">
            <div class="col-md-12">
                <div class="form-group">

                    <asp:Label ID="Label16"
                        runat="server"
                        Text="Upload Image:"
                        AssociatedControlID="FileUpload2"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:FileUpload ID="FileUpload2"
                        runat="server"
                        CssClass="form-control-file" />

                    <!-- Existing image while editing -->
                    <asp:Panel ID="pnlExistingImage"
                        runat="server"
                        Visible="false">

                        <div class="mt-2">
                            <span>Current Image:</span>
                            <br />

                            <asp:Image ID="imgExisting"
                                runat="server"
                                CssClass="current-image" />

                        </div>

                    </asp:Panel>

                </div>
            </div>
        </div>

        <!-- DESCRIPTION -->
        <div class="row mb-3">

            <div class="col-md-12">

                <div class="form-group">

                    <div class="d-flex align-items-center">

                        <span style="color:red;">* </span>

                        <asp:Label ID="Label17"
                            runat="server"
                            Text="Description:"
                            AssociatedControlID="txtDescription"
                            CssClass="form-label ml-1">
                        </asp:Label>

                    </div>

                    <asp:TextBox ID="txtDescription"
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvTxthnm"
                        runat="server"
                        ControlToValidate="txtDescription"
                        ErrorMessage="Description is required."
                        CssClass="text-danger"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                </div>

            </div>

        </div>

        <!-- INTERVIEW DATE -->
        <div class="row mb-3">

            <div class="col-md-4">

                <div class="form-group">

                    <div class="d-flex align-items-center">

                        <span style="color:red;">* </span>

                        <asp:Label ID="LabelInterviewDate"
                            runat="server"
                            Text="Interview Date:"
                            AssociatedControlID="calInterviewDate"
                            CssClass="form-label ml-1">
                        </asp:Label>

                    </div>

                    <asp:TextBox ID="calInterviewDate"
                        runat="server"
                        CssClass="form-control date-picker"
                        TextMode="Date">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvInterviewDate"
                        runat="server"
                        ControlToValidate="calInterviewDate"
                        ErrorMessage="Select Interview Date"
                        CssClass="text-danger"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                </div>

            </div>

        </div>

        <!-- BUTTONS -->
        <div class="form-footer">

            <asp:Button ID="Button1"
                runat="server"
                Text="Submit"
                CssClass="btn btn-primary"
               OnClick="Button1_Click" />

            <asp:Button ID="btnCancel"
                runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary ml-2"
                CausesValidation="false"
                Visible="false"
                OnClick="btnCancel_Click" />

        </div>

        <!-- RECORD LIST -->
        <div class="list-header">
            Existing Live Online Interviews
        </div>

        <asp:ListView ID="lvZoomImages"
            runat="server"
            OnItemCommand="lvZoomImages_ItemCommand">

            <LayoutTemplate>

                <div id="itemPlaceholder" runat="server">
                </div>

            </LayoutTemplate>

            <ItemTemplate>

                <div class="zoom-card">

                    <div class="row">

                        <!-- IMAGE -->
                        <div class="col-md-3 text-center">

                            <asp:Image ID="imgZoom"
                                runat="server"
                                CssClass="img-fluid"
                                ImageUrl='<%# "ZoomImageHandler.ashx?id=" + Eval("Id") %>'
                                AlternateText='<%# Eval("ImageName") %>' />

                        </div>

                        <!-- DETAILS -->
                        <div class="col-md-9">

                            <div class="zoom-description">

                                <strong>Description:</strong>

                                <%# Eval("Description") %>

                            </div>

                            <div class="zoom-date">

                                <strong>Interview Date:</strong>

                                <%# Convert.ToDateTime(Eval("InterviewDate")).ToString("dd-MM-yyyy") %>

                            </div>

                            <div class="zoom-date">

                                <strong>Created Date:</strong>

                                <%# Eval("CreatedDate") == DBNull.Value
                                    ? ""
                                    : Convert.ToDateTime(Eval("CreatedDate")).ToString("dd-MM-yyyy hh:mm tt") %>

                            </div>

                            <!-- BUTTONS -->
                            <div class="action-buttons">

                                <asp:Button ID="btnEdit"
                                    runat="server"
                                    Text="Edit"
                                    CssClass="btn btn-warning btn-sm"
                                    CommandName="EditRecord"
                                    CommandArgument='<%# Eval("Id") %>'
                                    CausesValidation="false" />

                                <asp:Button ID="btnDelete"
                                    runat="server"
                                    Text="Delete"
                                    CssClass="btn btn-danger btn-sm"
                                    CommandName="DeleteRecord"
                                    CommandArgument='<%# Eval("Id") %>'
                                    CausesValidation="false"
                                    OnClientClick="return confirm('Are you sure you want to delete this interview record?');" />

                            </div>

                        </div>

                    </div>

                </div>

            </ItemTemplate>

            <EmptyDataTemplate>

                <div class="no-records">
                    No interview records found.
                </div>

            </EmptyDataTemplate>

        </asp:ListView>

    </div>

</asp:Content>

<asp:Content ID="Content4"
    ContentPlaceHolderID="MainContent"
    runat="server">
</asp:Content>

