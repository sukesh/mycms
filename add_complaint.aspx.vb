﻿Imports System.Data.SqlClient

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
            str = "select '-- Select Complaint Category --' txt , 0 val  union select service_name txt,service_no val from m_services order by val"
            sdServices.SelectCommand = str
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

    Protected Sub BindSubCategories(ByVal service_no As String)
        Try
            Dim str As String = String.Empty
            If String.IsNullOrEmpty(service_no) Then
                str = "select '-- Select Sub Category --' txt , 0 val  union select service_cat_name txt,service_cat_no val from m_services order by val"
            Else
                str = "select '-- Select Sub Category --' txt , 0 val  union select service_cat_name txt,service_cat_no val from m_services where service_no=" & service_no & "order by val"
            End If
            sdSubCategory.SelectCommand = str
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
#End Region

End Class