Public Class my_complaints
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindMyComplaints("503412")
            rptMyComplaints.DataBind()
        End If
    End Sub

#Region "Data Source"
    Protected Sub BindMyComplaints(ByVal empno As String)
        Dim str As String = String.Empty
        str = " SELECT DISTINCT a.comp_no, a.empno, a.name, b.Service_Name, b.Service_cat_name, a.complaint_desc, a.status, CASE WHEN a.area_type = 'TOWN' THEN 'TOWNSHIP' ELSE a.area_type END AS area, CONVERT(varchar(10), " & _
              "  a.sector) + '/' + CONVERT(varchar(10), a.quarter) AS address, CONVERT(VARCHAR(10), a.xdate, 103) AS comp_dt, a.mobile_no, a.ofc_phone, a.res_phone " & _
              " FROM x_complaints_hdr AS a INNER JOIN  m_services AS b ON a.service_cat_no = b.Service_cat_no AND a.service_no = b.Service_No WHERE  a.empno = " & empno & " AND a.area_type LIKE '%TOWN%' UNION " & _
              " Select DISTINCT  a.comp_no, a.empno, a.name, b.Service_Name, b.Service_cat_name, a.complaint_desc, a.status, CASE WHEN a.area_type = 'TOWN' THEN 'TOWNSHIP' ELSE a.area_type END AS area, c.pb_name AS address, " & _
              " CONVERT(VARCHAR(10), a.xdate, 103) AS comp_dt, a.mobile_no, a.ofc_phone, a.res_phone FROM  x_complaints_hdr AS a INNER JOIN m_services AS b ON a.service_cat_no = b.Service_cat_no AND a.service_no = b.Service_No INNER JOIN " & _
              " m_public_buildings AS c ON a.pb_no = c.pb_no WHERE a.empno = " & empno & " ORDER BY a.comp_no desc"
        sdMyComplaints.SelectCommand = str
    End Sub
#End Region
End Class