Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports cms.CommonClass

Public Class add_complaint
    Inherits System.Web.UI.Page
    Dim constr As String = CStr(System.Configuration.ConfigurationManager.ConnectionStrings("apphb").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindServices()
            ddlServiceType.DataBind()
            BindSubCategories(String.Empty)
            ddlSubCategory.DataBind()
        End If
    End Sub


#Region "Data Sources"
    Protected Sub BindServices()
        Try
            Dim str As String = String.Empty
            str = "select '-- Select Complaint Category --' txt , 0 val  union select distinct service_name txt,service_no val from m_services order by val"
            sdServices.SelectCommand = str
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

    Protected Sub BindSubCategories(ByVal service_no As String)
        Try
            Dim str As String = String.Empty
            If String.IsNullOrEmpty(service_no) Then
                str = "select '-- Select Sub Category --' txt , 0 val  union select distinct service_cat_name txt,service_cat_no val from m_services order by val"
            Else
                str = "select '-- Select Sub Category --' txt , 0 val  union select distinct service_cat_name txt,service_cat_no val from m_services where service_no=" & service_no & "order by val"
            End If
            sdSubCategory.SelectCommand = str
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

    Protected Sub BindPublicBuildings()
        Try
            Dim str As String = String.Empty
            str = "select '-- Select Public Building --' txt , 0 val  union select distinct pb_name txt,pb_no val from m_public_buildings order by val"
            sdPublicBuildings.SelectCommand = str
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub
#End Region

#Region "Postback"
    Protected Sub ddlService_oNchange(ByVal sender As Object, ByVal e As EventArgs) Handles ddlServiceType.SelectedIndexChanged
        Try
            If ddlServiceType.SelectedIndex > 0 Then
                BindSubCategories(ddlServiceType.SelectedValue)
            Else
                Throw New Exception("Please Select Complaint Category !!")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub
    Protected Sub ddlSubCategory_oNchange(ByVal sender As Object, ByVal e As EventArgs) Handles ddlSubCategory.SelectedIndexChanged
        Try
            If ddlSubCategory.SelectedIndex > 0 Then
                Dim subcat_no As String = ddlSubCategory.SelectedValue
                Dim cc As CommonClass = New CommonClass()
                Dim cat_no As String = cc.GetCatNoFromSubCatNo(subcat_no)
                If Not String.IsNullOrEmpty(cat_no) Then
                    If ddlServiceType.Items.FindByValue(cat_no) IsNot Nothing Then
                        ddlServiceType.SelectedValue = cat_no
                    End If
                End If
            Else
                Throw New Exception("Please Select Complaint Category !!")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

    Protected Sub ddlAreaType_oNchange(ByVal sender As Object, ByVal e As EventArgs) Handles ddlAreaType.SelectedIndexChanged
        Try
            If ddlAreaType.SelectedIndex > 0 Then
                If ddlAreaType.SelectedValue = "TOWNSHIP" Then
                    rblPublicQuarter.Items(0).Selected = True
                    div_quarter_address.Visible = True
                    div_publicbuilding.Visible = False
                Else
                    rblPublicQuarter.ClearSelection()
                    rblPublicQuarter.Items(0).Selected = False
                    rblPublicQuarter.Items(1).Selected = True
                    div_quarter_address.Visible = False
                    div_publicbuilding.Visible = True
                    BindPublicBuildings()
                    ddlPublicBuilding.DataBind()
                End If
            Else
                Throw New Exception("Please Select Complaint Area Type !!")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

    Protected Sub rblPublicQuarter_oNchange(ByVal sender As Object, ByVal e As EventArgs) Handles rblPublicQuarter.SelectedIndexChanged
        Try
            If rblPublicQuarter.Items(0).Selected Then
                div_quarter_address.Visible = True
                div_publicbuilding.Visible = False
            Else
                div_quarter_address.Visible = False
                div_publicbuilding.Visible = True
                BindPublicBuildings()
                ddlPublicBuilding.DataBind()
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

    Protected Sub btnAddComplaint_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubmit.Click
        Dim empno, name, service_no, service_cat_no, complaint_desc, status, area_type, sector, quarter, quarter_public, pb_no, mobile_no, ofc_phone, res_phone
        Try
            If String.IsNullOrEmpty(txtEmpno.Value) Then
                Throw New Exception("Please Enter Employee No")
            Else
                If IsNumeric(txtEmpno.Value) Then
                    empno = txtEmpno.Value.Trim()
                    name = IIf(String.IsNullOrEmpty(txtName.Value), SqlString.Null, txtName.Value.Trim())
                    If ddlServiceType.SelectedIndex > 0 Then
                        service_no = ddlServiceType.SelectedValue
                        If ddlSubCategory.SelectedIndex > 0 Then
                            service_cat_no = ddlSubCategory.SelectedValue
                            If ddlAreaType.SelectedIndex > 0 Then
                                area_type = ddlAreaType.SelectedValue
                                If rblPublicQuarter.SelectedIndex > -1 Then
                                    quarter_public = rblPublicQuarter.SelectedValue
                                    If quarter_public = "Q" Then
                                        If String.IsNullOrEmpty(txtSector.Text.Trim()) Then
                                            Throw New Exception("Please Enter Sector No")
                                        Else
                                            If IsNumeric(txtSector.Text.Trim()) Then
                                                sector = txtSector.Text.Trim()
                                                If String.IsNullOrEmpty(txtQuarter.Text.Trim()) Then
                                                    Throw New Exception("Please Enter Quarter No")
                                                Else
                                                    If IsNumeric(txtQuarter.Text.Trim()) Then
                                                        quarter = txtQuarter.Text.Trim()
                                                    Else
                                                        Throw New Exception("Please Enter Valid Quarter No")
                                                    End If
                                                End If
                                            Else
                                                Throw New Exception("Please Enter Valid Sector No")
                                            End If
                                        End If
                                    End If
                                    If quarter_public = "P" Then
                                        If ddlPublicBuilding.SelectedIndex > 0 Then
                                            pb_no = ddlPublicBuilding.SelectedValue
                                        Else
                                            Throw New Exception("Please Select Public Building")
                                        End If
                                    End If
                                    status = "SUBMITTED"
                                    ofc_phone = IIf(String.IsNullOrEmpty(txtOfcNo.Value), SqlString.Null, txtOfcNo.Value.Trim())
                                    res_phone = IIf(String.IsNullOrEmpty(txtResNo.Value), SqlString.Null, txtResNo.Value.Trim())
                                    mobile_no = IIf(String.IsNullOrEmpty(txtMobileNo.Value), SqlString.Null, txtMobileNo.Value.Trim())
                                    complaint_desc = IIf(String.IsNullOrEmpty(txtComplaint.Value), ddlSubCategory.SelectedItem.Text, txtComplaint.Value.Trim())
                                    sector = IIf(String.IsNullOrEmpty(txtSector.Text.Trim()), SqlString.Null, txtSector.Text.Trim())
                                    quarter = IIf(String.IsNullOrEmpty(txtQuarter.Text.Trim()), SqlString.Null, txtQuarter.Text.Trim())
                                    pb_no = IIf(ddlPublicBuilding.SelectedIndex > 0, ddlPublicBuilding.SelectedValue, SqlString.Null)
                                    Dim cc As CommonClass = New CommonClass()
                                    Dim str(2) As String
                                    str = cc.Insert_Complaint(empno, name, service_no, service_cat_no, complaint_desc, status, area_type, sector, quarter, quarter_public, pb_no, mobile_no, ofc_phone, res_phone)
                                    If String.IsNullOrEmpty(str(0)) Then
                                        If IsNumeric(str(1)) Then
                                            Session("ms_view_comp_no") = str(1)
                                            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), DateTime.Now.Ticks.ToString(), "alert('Your Complaint No : " & str(1) & " Added Successfully!!');window.location.href='view_complaint.aspx'", True)
                                        End If
                                    Else
                                        ScriptManager.RegisterStartupScript(Me, Page.[GetType](), DateTime.Now.Ticks.ToString(), "alert('Oops! Something went wrong..')", True)
                                    End If
                                Else
                                    Throw New Exception("Please Choose Quarters / Public Area")
                                End If
                            Else
                                Throw New Exception("Please Select Complaint Area")
                            End If
                        Else
                            Throw New Exception("Please Select Complaint Sub Category")
                        End If
                    Else
                        Throw New Exception("Please Select Complaint Category")
                    End If
                Else
                    Throw New Exception("Please Enter Valid Employee No")
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub
#End Region

End Class