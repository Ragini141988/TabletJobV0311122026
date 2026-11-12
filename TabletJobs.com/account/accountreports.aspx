<%@ Page Title="Account Reports" Language="C#"
    MasterPageFile="~/account/AccountsMasterPAge.Master"
    AutoEventWireup="true"

    CodeBehind="accountreports.aspx.cs"
    Inherits="TabletJobs.com.account.accountreports" %>

<asp:Content ID="Content9" ContentPlaceHolderID="head" runat="server">

    <style>
        .report-container {
            max-width: 1200px;
            margin: 25px auto;
            padding: 15px;
        }

        .report-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .user-info {
            text-align: center;
            margin-bottom: 20px;
            font-size: 16px;
            font-weight: 600;
        }

        .delivery-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 18px;
        }

        .delivery-card {
            background: white;
            border-radius: 10px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.10);
        }

        .delivery-card h3 {
            margin-top: 0;
            margin-bottom: 12px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            padding: 6px 0;
            border-bottom: 1px solid #eee;
        }

        .detail-label {
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            margin-top: 15px;
        }

        .btn-edit,
        .btn-delete {
            flex: 1;
            padding: 9px;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            color: white;
        }

        .btn-edit {
            background: #007bff;
        }

        .btn-delete {
            background: #dc3545;
        }

        .no-records {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 10px;
        }

        @media(max-width:600px) {
            .report-container {
                padding: 10px;
            }

            .report-title {
                font-size: 23px;
            }

            .detail-row {
                font-size: 14px;
            }
        }
      
/* ================================
   DELIVERY CARD
   ================================ */

.delivery-card {
    width: 100%;
    max-width: 700px;
    margin: 15px auto;
    background: #ffffff;
    border-radius: 14px;
    padding: 18px;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.10);
    border: 1px solid #e5e7eb;
    box-sizing: border-box;
}


/* ================================
   HEADER
   ================================ */

.delivery-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    margin-bottom: 15px;
    padding-bottom: 14px;
    border-bottom: 1px solid #eeeeee;
}

.delivery-header h3 {
    margin: 0;
    font-size: 21px;
    font-weight: 700;
    color: #222222;
    word-break: break-word;
}

.lr-badge {
    flex-shrink: 0;
    background: #f1f5f9;
    color: #334155;
    padding: 6px 10px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
}


/* ================================
   SECTIONS
   ================================ */

.delivery-section {
    margin-bottom: 14px;
}

.section-title {
    font-size: 14px;
    font-weight: 700;
    color: #555555;
    margin-bottom: 6px;
    padding-bottom: 5px;
    border-bottom: 1px solid #f0f0f0;
}


/* ================================
   DETAIL ROW
   ================================ */

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    padding: 9px 0;
    border-bottom: 1px solid #f5f5f5;
}

.detail-label {
    color: #666666;
    font-size: 14px;
    font-weight: 500;
    flex: 0 0 45%;
}

.detail-value {
    color: #222222;
    font-size: 15px;
    font-weight: 600;
    text-align: right;
    flex: 1;
    word-break: break-word;
}

.highlight {
    font-weight: 700;
}

.amount {
    font-weight: 700;
}


/* ================================
   PHONE
   ================================ */

.phone-link {
    color: #2563eb;
    text-decoration: none;
    font-weight: 600;
}

.phone-link:hover {
    text-decoration: underline;
}


/* ================================
   FOOTER
   ================================ */

.delivery-footer {
    margin-top: 12px;
    padding-top: 10px;
    color: #777777;
    font-size: 12px;
    text-align: right;
}


/* ================================
   ACTION BUTTONS
   ================================ */

.action-buttons {
    display: flex;
    gap: 10px;
    margin-top: 16px;
}

.btn-edit,
.btn-delete {
    flex: 1;
    min-height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 9px;
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    box-sizing: border-box;
    transition: 0.2s ease;
}

.btn-edit {
    background: #2563eb;
    color: #ffffff;
}

.btn-edit:hover {
    background: #1d4ed8;
    color: #ffffff;
}

.btn-delete {
    background: #dc2626;
    color: #ffffff;
}

.btn-delete:hover {
    background: #b91c1c;
    color: #ffffff;
}


/* ================================
   MOBILE
   ================================ */

@media (max-width: 600px) {

    .delivery-card {
        width: calc(100% - 20px);
        margin: 10px auto;
        padding: 15px;
        border-radius: 12px;
    }

    .delivery-header {
        align-items: flex-start;
        flex-direction: column;
        gap: 8px;
    }

    .delivery-header h3 {
        font-size: 19px;
    }

    .lr-badge {
        font-size: 12px;
        padding: 5px 9px;
    }

    .detail-row {
        align-items: flex-start;
        gap: 10px;
        padding: 10px 0;
    }

    .detail-label {
        font-size: 13px;
        flex: 0 0 42%;
    }

    .detail-value {
        font-size: 14px;
    }

    .delivery-footer {
        text-align: left;
        font-size: 11px;
    }

    .action-buttons {
        gap: 8px;
    }

    .btn-edit,
    .btn-delete {
        min-height: 46px;
        font-size: 14px;
    }
}


/* ================================
   VERY SMALL PHONES
   ================================ */

@media (max-width: 380px) {

    .delivery-card {
        width: calc(100% - 12px);
        padding: 12px;
    }

    .detail-row {
        display: block;
    }

    .detail-label {
        display: block;
        margin-bottom: 3px;
    }

    .detail-value {
        display: block;
        text-align: left;
    }

    .action-buttons {
        flex-direction: column;
    }

    .btn-edit,
    .btn-delete {
        width: 100%;
    }
}


    </style>

</asp:Content>

<asp:Content ID="Content10" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="report-container">

       <div class="report-title">
    Daily Delivery Report
</div>

<asp:Panel ID="pnlSummaryLink"
    runat="server"
    Visible="false"
    style="text-align:center; margin-bottom:20px;">

    <a href="accountsummary.aspx"
       style="font-weight:bold; font-size:16px; color:#007bff; text-decoration:none;">
        📊 View Summary Report
    </a>

      <a href="ExpensesReport.aspx"
       style="font-weight:bold; font-size:16px; color:#007bff; text-decoration:none;">
        📋 View Expenses Report
    </a>


</asp:Panel>
        <div class="user-info">
            <asp:Label ID="lblLoggedInUser" runat="server"></asp:Label>
        </div>

        <asp:ListView ID="lvDelivery"
            runat="server">

            <LayoutTemplate>

                <div class="delivery-list">

                    <asp:PlaceHolder
                        ID="itemPlaceholder"
                        runat="server">
                    </asp:PlaceHolder>

                </div>

            </LayoutTemplate>

    
<ItemTemplate>

    <div class="delivery-card">

        <!-- Header -->
        <div class="delivery-header">
            <h3>
                <%# Eval("CustomerName") %>
            </h3>

            <span class="lr-badge">
                LR: <%# Eval("LRNumber") %>
            </span>
        </div>


        <!-- Customer Details -->
        <div class="delivery-section">

            <div class="detail-row">
                <span class="detail-label">Customer City</span>
                <span class="detail-value">
                    <%# Eval("CustomerCity") %>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Contact</span>
                <span class="detail-value">
                    <a href='tel:<%# Eval("CustomerContactNumber") %>' class="phone-link">
                        <%# Eval("CustomerContactNumber") %>
                    </a>
                </span>
            </div>

        </div>


        <!-- Transport Details -->
        <div class="delivery-section">

            <div class="section-title">
                Transport Details
            </div>

            <div class="detail-row">
                <span class="detail-label">Transport</span>
                <span class="detail-value">
                    <%# Eval("TransportName") %>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Transport City</span>
                <span class="detail-value">
                    <%# Eval("TransportCity") %>
                </span>
            </div>

        </div>


        <!-- LR Details -->
        <div class="delivery-section">

            <div class="section-title">
                LR Details
            </div>

            <div class="detail-row">
                <span class="detail-label">Articles</span>
                <span class="detail-value highlight">
                    <%# Eval("TotalArticles") %>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">LR Amount</span>
                <span class="detail-value amount">
                    ₹ <%# Eval("TotalLRAmount", "{0:N2}") %>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">LR Type</span>
                <span class="detail-value">
                    <%# Eval("LRType") %>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Delivery Charges</span>
                <span class="detail-value amount">
                    ₹ <%# Eval("DeliveryCharges", "{0:N2}") %>
                </span>
            </div>

        </div>


        <!-- Date -->
        <div class="delivery-footer">

            <span>
                Created:
                <%# Eval("CreatedDate", "{0:dd-MM-yyyy hh:mm tt}") %>
            </span>

        </div>


        <!-- Admin Actions -->
        <asp:Panel
            ID="pnlAdminActions"
            runat="server"
            Visible='<%# IsAdmin %>'>

            <div class="action-buttons">

                <a class="btn-edit"
                   href='accountdeliveryedit.aspx?id=<%# Eval("DeliveryID") %>'>
                    ✏️ Edit
                </a>

                  <asp:LinkButton
        ID="btnDelete"
        runat="server"
        CssClass="btn-delete"
        CommandArgument='<%# Eval("DeliveryID") %>'
        OnClick="btnDelete_Click"
        OnClientClick="return confirm('Are you sure you want to delete this delivery record?');">
        🗑️ Delete
    </asp:LinkButton>

            </div>

        </asp:Panel>


        <asp:HiddenField
            ID="HiddenAccountID"
            runat="server"
            Value='<%# Eval("AccountID") %>' />

    </div>

</ItemTemplate>



            <EmptyDataTemplate>

                <div class="no-records">
                    No delivery records found.
                </div>

            </EmptyDataTemplate>

        </asp:ListView>

    </div>

</asp:Content>

<asp:Content ID="Content11" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content12" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>


