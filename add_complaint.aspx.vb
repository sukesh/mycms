Imports System.Data.SqlClient

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

#Region "Database Fucntions"
    Protected Function GetCatNoFromSubCatNo(ByVal subcat_no As String) As String
        Dim cat_no As String = String.Empty
        Dim sqlcon As SqlConnection = New SqlConnection()
        Dim dr As SqlDataReader = Nothing
        Try
            sqlcon.ConnectionString = constr
            sqlcon.Open()
            Using cmd As New SqlCommand
                cmd.Connection = sqlcon
                cmd.CommandText = "select distinct service_no from m_services where service_cat_no=" & subcat_no
                dr = cmd.ExecuteReader()
                If dr.Read() Then
                    cat_no = Convert.ToString(dr.GetValue(0))
                End If
            End Using
        Catch ex As Exception

        Finally
            If sqlcon.State = ConnectionState.Open Then
                sqlcon.Close()
            End If
        End Try
        Return cat_no
    End Function
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
                Dim cat_no As String = GetCatNoFromSubCatNo(subcat_no)
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
#End Region

End Class