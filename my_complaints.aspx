<%@ Page Title="My Complaints" Language="vb" AutoEventWireup="false" MasterPageFile="~/ms.Master"
    CodeBehind="my_complaints.aspx.vb" Inherits="cms.my_complaints" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modalPopup
        {
            background-color: #696969;
            filter: alpha(opacity=40);
            opacity: 0.7;
            xindex: -1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sc" runat="server" AsyncPostBackTimeout="3600" EnablePartialRendering="true">
    </asp:ScriptManager>
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        //Raised before processing of an asynchronous postback starts and the postback request is sent to the server.
        prm.add_beginRequest(BeginRequestHandler);
        // Raised after an asynchronous postback is finished and control has been returned to the browser.
        prm.add_endRequest(EndRequestHandler);
        function BeginRequestHandler(sender, args) {
            //Shows the modal popup - the update progress
            var popup = $find('<%= modalPopup.ClientID %>');
            if (popup != null) {
                popup.show();
            }
        }

        function EndRequestHandler(sender, args) {
            //Hide the modal popup - the update progress
            var popup = $find('<%= modalPopup.ClientID %>');
            if (popup != null) {
                popup.hide();
            }
        }
    </script>
    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <div align="center">
                <span style="font-size: 25px; font-family: 'Berlin Sans FB',tahoma; color: #ffffff">
                    Please Wait..</span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <ajax:ModalPopupExtender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
        PopupControlID="UpdateProgress" BackgroundCssClass="modalPopup" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2>
                            My Complaints</h2>
                    </div>
                </div>
                <div class="row">
                    <asp:Repeater ID="rptMyComplaints" runat="server" DataSourceID="sdMyComplaints">
                        <ItemTemplate>
                            <ul class="list-group">
                                <li class="list-group-item active"><b>Complaint # : </b>
                                    <%# Eval("comp_no") %></li>
                                <li class="list-group-item"><b>Employee No : </b>
                                    <%# Eval("empno") %></li>
                                <li class="list-group-item"><b>Category : </b>
                                    <%# Eval("service_name")%></li>
                                <li class="list-group-item"><b>Sub-Category : </b>
                                    <%# Eval("service_cat_name") %></li>
                                <li class="list-group-item"><b>Area : </b>
                                    <%# Eval("area")%></li>
                                <li class="list-group-item"><b>Address : </b>
                                    <%# Eval("address")%></li>
                                <li class="list-group-item"><b>Complaint Date : </b>
                                    <%# Eval("comp_dt")%></li>
                                <li class="list-group-item"><b>Office Phone No : </b>
                                    <%# Eval("ofc_phone")%></li>
                                <li class="list-group-item"><b>Residence Phone No : </b>
                                    <%# Eval("res_phone")%></li>
                                <li class="list-group-item"><b>Mobile No : </b>
                                    <%# Eval("mobile_no")%></li>
                                <li class="list-group-item"><b>Current Status : </b>
                                    <%# Eval("status")%></li>
                                <li class="list-group-item"><b>Complaint : </b>
                                    <%# Eval("complaint_desc")%></li>
                            </ul>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sdMyComplaints" runat="server" ConnectionString="<%$ ConnectionStrings:apphb %>">
    </asp:SqlDataSource>
</asp:Content>
