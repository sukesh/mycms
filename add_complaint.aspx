<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ms.Master"
    CodeBehind="add_complaint.aspx.vb" Inherits="cms.add_complaint" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        if (typeof ($) === 'function')
            $(document).ready(function () {
                $('#<%=txtEmpNo.ClientID%>').change(function (e) {
                    if ($(this).val().length < 5) {
                        $(this).css({
                            //"border": "1px solid red",
                            "background": "#FFCECE"
                        });
                    }
                    else {
                        $(this).css({
                            "border": "",
                            "background": ""
                        });
                    }
                });
                $('#<%=txtEmpNo.ClientID%>').keydown(function (e) {
                    if (e.shiftKey) e.preventDefault();
                    else {
                        var nKeyCode = e.keyCode;
                        //Ignore Backspace and Tab keys
                        if (nKeyCode == 8 || nKeyCode == 9) return;
                        if (nKeyCode < 95) {
                            if (nKeyCode != 13 && (nKeyCode < 48 || nKeyCode > 57)) {
                                e.preventDefault();
                                $(this).css({
                                    //"border": "1px solid red",
                                    "background": "#FFCECE"
                                });
                            }
                            else {
                                $(this).css({
                                    "border": "",
                                    "background": ""
                                });
                                //alert($(this).val());
                                /*if ($(this).val.length < 8) {
                                alert($(this).val);
                                if ($(this).val.length = 5) $(this).val('000' + $(this).val);
                                if ($(this).val.length = 6) $(this).val('00' + $(this).val);
                                }*/
                            }
                        } else {
                            if (nKeyCode != 13 && (nKeyCode < 96 || nKeyCode > 105)) {
                                e.preventDefault();
                                $(this).css({
                                    //"border": "1px solid red",
                                    "background": "#FFCECE"
                                });
                            }
                            else {
                                $(this).css({
                                    "border": "",
                                    "background": ""
                                });
                            }
                        }
                    }
                });
            });        
    </script>
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
                            Add Complaint</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="employee no">
                                    Employee No</label>
                                <input type="text" class="form-control" runat="server" placeholder="Employee No"
                                    id="txtEmpno" required data-validation-required-message="Enter Employee No">
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="name">
                                    Name</label>
                                <input type="text" class="form-control" runat="server" placeholder="Name" id="txtName">
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="Category">
                                </label>
                                <asp:DropDownList runat="server" ID="ddlServiceType" AutoPostBack="true" Style="margin-top: 20px;
                                    line-height: 3em; text-transform: lowercase" required data-validation-required-message="Select Complaint Category"
                                    DataTextField="TXT" DataValueField="VAL" CssClass="form-control" DataSourceID="sdServices">
                                </asp:DropDownList>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="Sub-Category">
                                </label>
                                <asp:DropDownList runat="server" ID="ddlSubCategory" AutoPostBack="true" Style="margin-top: 20px;
                                    line-height: 3em; text-transform: lowercase" required data-validation-required-message="Select Complaint Sub Category"
                                    DataTextField="TXT" DataValueField="VAL" CssClass="form-control" DataSourceID="sdSubCategory">
                                </asp:DropDownList>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="phone">
                                    Phone Number</label>
                                <input type="tel" class="form-control" placeholder="Phone Number" id="phone" required
                                    data-validation-required-message="Please enter your phone number.">
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="complaint">
                                    Complaint Details</label>
                                <textarea rows="3" class="form-control" placeholder="Complaint" id="txtComplaint"
                                    required data-validation-required-message="Enter Complaint Details"></textarea>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <br>
                        <div id="success">
                        </div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <button type="submit" style="font-size: 14px !important; width: 200px" class="btn btn-success btn-lg">
                                    Add Complaint</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sdServices" runat="server" ConnectionString="<%$ ConnectionStrings:apphb %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdSubCategory" runat="server" ConnectionString="<%$ ConnectionStrings:apphb %>">
    </asp:SqlDataSource>
</asp:Content>
