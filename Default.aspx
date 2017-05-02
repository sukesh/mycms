<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ms.Master"
    CodeBehind="Default.aspx.vb" Inherits="cms._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #portfolio
        {
            padding-top: 0px;
            padding-bottom: 0px;
        }
        .caption-content
        {
            font-size: 10pt !important;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="portfolio">
        <div class="container">            
            <div class="row">
                <div class="col-sm-4 portfolio-item">
                    <a href="add_complaint.aspx" class="portfolio-link">
                        <div class="caption">
                            <div class="caption-content">
                                Add Complaint
                            </div>
                        </div>
                        <img src="img/portfolio/add.png" class="img-responsive" alt="Add">
                    </a>
                </div>
                <div class="col-sm-4 portfolio-item">
                    <a href="#portfolioModal2" class="portfolio-link" data-toggle="modal">
                        <div class="caption">
                            <div class="caption-content">
                                Track Complaint
                            </div>
                        </div>
                        <img src="img/portfolio/track.png" class="img-responsive" alt="Track">
                    </a>
                </div>
                <div class="col-sm-4 portfolio-item">
                    <a href="#portfolioModal3" class="portfolio-link" data-toggle="modal">
                        <div class="caption">
                            <div class="caption-content">
                               All Complaints
                            </div>
                        </div>
                        <img src="img/portfolio/all.png" class="img-responsive" alt="List">
                    </a>
                </div>                
            </div>
        </div>
</section>
    <!-- Modals -->
    <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog"
        aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal" style="background: #f2f2f2; border-radius: 10px;
                text-align: right">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <hr />
                    <div class="col-lg-12 text-center">
                        <h2>
                            Add Complaint</h2>
                    </div>
                </div>
                <br />
                <br />
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
                                <input type="text" class="form-control" runat="server" placeholder="Name" id="txtName"
                                    required data-validation-required-message="Enter Your Name">
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
        </div>
    </div>
</asp:Content>