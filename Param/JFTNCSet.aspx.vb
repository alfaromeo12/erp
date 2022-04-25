
Partial Class Param_JFTNCSet
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            hidJFID.Value = Request.QueryString("JFID")
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub




    Protected Sub btnMoveTNC_Click(sender As Object, e As System.EventArgs) Handles btnMoveTNC.Click
        For i As Integer = lvbTNCSrc.Items.Count - 1 To 0 Step -1
            If lvbTNCSrc.Items(i).Selected Then
                lvbTNCDest.Items.Add(lvbTNCSrc.Items(i))
                lvbTNCDest.ClearSelection()
                lvbTNCSrc.Items.Remove(lvbTNCSrc.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnBackTNC_Click(sender As Object, e As System.EventArgs) Handles btnBackTNC.Click
        For i As Integer = lvbTNCDest.Items.Count - 1 To 0 Step -1
            If lvbTNCDest.Items(i).Selected Then
                lvbTNCSrc.Items.Add(lvbTNCDest.Items(i))
                lvbTNCSrc.ClearSelection()
                lvbTNCDest.Items.Remove(lvbTNCDest.Items(i))
            End If
        Next
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        lblError.Visible = False
        Dim objDB As New DBX
        Try
            objDB.ExecSQLWithParam("UPDATE JFREQUESTTNC SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE JFID=@JFID",
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value),
                    objDB.MP("@JFID", Data.SqlDbType.Int, hidJFID.Value)
                    )

            Dim iRow As Integer
            Dim iRows As Integer

            iRows = lvbTNCDest.Items.Count.ToString - 1
            For iRow = 0 To iRows
                objDB.ExecSP("JFREQUESTTNCSave",
                    objDB.MP("@JFID", Data.SqlDbType.Int, hidJFID.Value),
                    objDB.MP("@JFTNCID", Data.SqlDbType.Int, lvbTNCDest.Items.Item(iRow).Value),
                    objDB.MP("@USERID", Data.SqlDbType.Int, Request.Cookies("UID").Value)
                    )
            Next
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = "Error Save JF TNC Setting..!<br>Please Check Detail Error message : " & ex.Message
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub
End Class
