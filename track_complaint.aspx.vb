Public Class track_complaint
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtCompNo.Value = String.Empty
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubmit.Click
        Try
            If Not String.IsNullOrEmpty(txtCompNo.Value.Trim()) Then
                If IsNumeric(txtCompNo.Value.Trim()) Then
                    Session("ms_view_comp_no") = txtCompNo.Value.Trim()
                    Response.Redirect("~/view_complaint.aspx")
                Else
                    Throw New Exception("Please Enter Valid Complaint No")
                End If
            Else
                Throw New Exception("Please Enter Complaint No")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Page.[GetType](), "201402190959", "alert('" & ex.Message & "')", True)
        End Try
    End Sub

End Class