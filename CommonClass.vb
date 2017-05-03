Imports System.Data.SqlClient

Public Class CommonClass
    Dim constr As String = CStr(System.Configuration.ConfigurationManager.ConnectionStrings("apphb").ConnectionString)
#Region "Database Fucntions"
    Public Function GetCatNoFromSubCatNo(ByVal subcat_no As String) As String
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

    Public Function Insert_Complaint(ByVal empno, name, service_no, service_cat_no, complaint_desc, status, area_type, sector, quarter, quarter_public, pb_no, mobile_no, ofc_phone, res_phone) As String()
        Dim msg(2) As String
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            con.Open()
            cmd.Connection = con
            cmd.CommandText = "dbo.Add_Complaint"
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.Clear()
            cmd.Parameters.Add("empno", SqlDbType.Int).Value = empno
            cmd.Parameters.Add("name", SqlDbType.VarChar).Value = name
            cmd.Parameters.Add("service_no", SqlDbType.Int).Value = service_no
            cmd.Parameters.Add("service_cat_no", SqlDbType.Int).Value = service_cat_no
            cmd.Parameters.Add("complaint_desc", SqlDbType.VarChar).Value = complaint_desc
            cmd.Parameters.Add("status", SqlDbType.VarChar).Value = status
            cmd.Parameters.Add("area_type", SqlDbType.VarChar).Value = area_type
            cmd.Parameters.Add("sector", SqlDbType.Int).Value = sector
            cmd.Parameters.Add("quarter", SqlDbType.Int).Value = quarter
            cmd.Parameters.Add("quarter_public", SqlDbType.Char).Value = quarter_public
            cmd.Parameters.Add("pb_no", SqlDbType.Int).Value = pb_no
            cmd.Parameters.Add("mobile_no", SqlDbType.VarChar).Value = mobile_no
            cmd.Parameters.Add("ofc_phone", SqlDbType.VarChar).Value = ofc_phone
            cmd.Parameters.Add("res_phone", SqlDbType.VarChar).Value = res_phone
            cmd.Parameters.Add("error", SqlDbType.VarChar, 1000).Direction = ParameterDirection.Output
            cmd.Parameters.Add("comp_no", SqlDbType.Int, 20).Direction = ParameterDirection.Output
            cmd.ExecuteNonQuery()
            Dim output As String = Convert.ToString(cmd.Parameters("error").Value)
            If String.IsNullOrEmpty(output) Then
                Dim cc As New CommonClass()
                output = Convert.ToString(cmd.Parameters("comp_no").Value)
                msg(0) = String.Empty
                msg(1) = output
            Else
                msg(0) = output
                msg(1) = String.Empty
            End If
        Catch ex As Exception
            'EntryLog("Insert Complaint Procedure " & ex.Message)
            msg(0) = ex.Message
        Finally
            cmd.Dispose()
            con.Close()
        End Try
        Return msg
    End Function
#End Region
End Class
