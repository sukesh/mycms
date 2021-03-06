﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ms.Master"
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
        .rbl td
        {
            padding: 4px 20px;
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
                                <input type="text" pattern="\d*" class="form-control" runat="server" placeholder="Employee No"
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
                                <label for="area_type">
                                </label>
                                <asp:DropDownList runat="server" ID="ddlAreaType" CssClass="form-control" AutoPostBack="true"
                                    Style="margin-top: 20px; line-height: 3em;" required data-validation-required-message="Select Complaint Area">
                                    <asp:ListItem Text="-- Select Complaint Area --" Value="X"></asp:ListItem>
                                    <asp:ListItem Text="Township Area" Value="TOWNSHIP"></asp:ListItem>
                                    <asp:ListItem Text="Battery Area" Value="BA"></asp:ListItem>
                                    <asp:ListItem Text="Admin Building" Value="ADMIN"></asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="radio radiobuttonlist form-group col-xs-12 controls">
                                <asp:RadioButtonList ID="rblPublicQuarter" CssClass="rbl" AutoPostBack="true" runat="server"
                                    RepeatDirection="Vertical" required data-validation-required-message="Select Quarters / Public Area"
                                    RepeatLayout="Table">
                                    <asp:ListItem Text="Quarter" Value="Q"></asp:ListItem>
                                    <asp:ListItem Text="Public Building" Value="P"></asp:ListItem>
                                </asp:RadioButtonList>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <hr style="margin: 4px" />
                        <div runat="server" id="div_quarter_address" visible="false" class="row control-group">
                            <div class="form-group col-xs-6 floating-label-form-group controls">
                                <label for="Sector">
                                    Sector</label>
                                <asp:TextBox runat="server" CssClass="form-control" placeholder="Sector" ID="txtSector"></asp:TextBox>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                            <div class="form-group col-xs-6 floating-label-form-group controls">
                                <label for="Quarter">
                                    Quarter</label>
                                <asp:TextBox runat="server" CssClass="form-control" placeholder="Quarter" ID="txtQuarter"></asp:TextBox>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div runat="server" id="div_publicbuilding" visible="false" class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">                                
                                <asp:DropDownList runat="server" ID="ddlPublicBuilding" Style="margin-top: 20px;
                                    line-height: 3em; text-transform: lowercase" 
                                    DataTextField="TXT" DataValueField="VAL" CssClass="form-control" DataSourceID="sdPublicBuildings">
                                </asp:DropDownList>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="ophone">
                                    Office Phone No</label>
                                <input type="text" class="form-control" placeholder="Office Phone No" id="txtOfcNo" runat="server">
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="rphone">
                                    Residence Phone No</label>
                                <input type="text" class="form-control" placeholder="Residence Phone No" runat="server" id="txtResNo">
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="phone">
                                    Mobile Number</label>
                                <input type="text" class="form-control" placeholder="Mobile Number" runat="server" id="txtMobileNo">
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label for="complaint">
                                    Complaint Details</label>
                                <textarea rows="3" class="form-control" placeholder="Complaint" id="txtComplaint" runat="server"></textarea>
                                <p class="help-block text-danger">
                                </p>
                            </div>
                        </div>
                        <br>
                        <div id="success">
                        </div>
                        <div class="row">
                            <div class="form-group col-xs-12" align="center">
                                <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-success btn-lg" Text="Add Complaint" Style="font-size:14px !important;width:200px"/>                                
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
    <asp:SqlDataSource ID="sdPublicBuildings" runat="server" ConnectionString="<%$ ConnectionStrings:apphb %>">
    </asp:SqlDataSource>
</asp:Content>
