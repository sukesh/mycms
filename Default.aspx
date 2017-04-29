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
            font-weight:bold;         
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="portfolio">
        <div class="container">            
            <div class="row">
                <div class="col-sm-4 portfolio-item">
                    <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal">
                        <div class="caption">
                            <div class="caption-content">
                                <span class="glyphicon glyphicon-plus-sign"></span> Add Complaint
                            </div>
                        </div>
                        <img src="img/portfolio/add.png" class="img-responsive" alt="Add">
                    </a>
                </div>
                <div class="col-sm-4 portfolio-item">
                    <a href="#portfolioModal2" class="portfolio-link" data-toggle="modal">
                        <div class="caption">
                            <div class="caption-content">
                                <span class="glyphicon glyphicon-search"></span> Track Complaint
                            </div>
                        </div>
                        <img src="img/portfolio/track.png" class="img-responsive" alt="Track">
                    </a>
                </div>
                <div class="col-sm-4 portfolio-item">
                    <a href="#portfolioModal3" class="portfolio-link" data-toggle="modal">
                        <div class="caption">
                            <div class="caption-content">
                               <span class="glyphicon glyphicon-th-list"></span> All Complaints
                            </div>
                        </div>
                        <img src="img/portfolio/all.png" class="img-responsive" alt="List">
                    </a>
                </div>                
            </div>
        </div>
</section>
</asp:Content>
