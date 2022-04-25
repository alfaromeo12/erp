
Partial Class DefaultDDM
    Inherits System.Web.UI.Page
    Dim sTmp As String = ""
    Public strTemp As String = ""
    Public strStyleGroup As String = ""



    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("select APPVALUE from appsetting  WITH(NOLOCK) where appcode='APPNAME'")
            If oSDR.Read Then
                Page.Title = oSDR("APPVALUE")
                'Title = oSDR("APPVALUE")
            End If
            oSDR.Close()
            oSDR = Nothing
        Catch ex As Exception
            Throw
        Finally
            objDB.Close()
            objDB = Nothing
        End Try
        GenerateMenu()
    End Sub


    Sub GenerateMenu()
        Dim xmain As String = ""
        Dim xsub As String = ""
        Dim xxmain As String = ""
        Dim rc As Integer = 0
        Dim intMain As Integer = 0

        Dim xxsub As String = ""
        Dim xxmenu As String = ""
        Dim xxxsubold As String = ""

        Dim xxxmain As String = ""
        Dim xxxsub As String = ""
        Dim xxxmenu As String = ""
        Dim x As Integer = 0



        'obj = Server.CreateObject("GLUserProfile.clsList")
        'rs = Server.CreateObject("ADODB.Recordset")
        'rMenu = Server.CreateObject("ADODB.Recordset")
        Dim obj As New DBX
        Dim rs As System.Data.SqlClient.SqlDataReader
        'Dim rMenu As System.Data.SqlClient.SqlDataReader

        Try


            'rs = obj.UserGetMenu(Request.Cookies("UID"))
            rs = obj.CreateSDRFromSP("APPUserMenu", _
                obj.MP("@UID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
            'If Not IsObject(rs) Then
            'Response.Write("error")
            'End If
            intMain = 0

            'rc = rs.RecordCount
            While rs.Read()
                rc = rc + 1
            End While
            rs.Close()
            rs = Nothing

            rs = obj.CreateSDRFromSP("APPUserMenu", _
                obj.MP("@UID", Data.SqlDbType.Int, Request.Cookies("UID").Value))
            If rs.HasRows() Then
                rs.Read()
            End If




            For x = 1 To rc
                'Response.Write(rc.ToString & "<br>")
                'Response.Write(x.ToString & "<br>")
                xmain = rs("mainmenu").ToString()
                xsub = rs("submenu").ToString()
                If xmain <> xxmain Then
                    'sTmp= sTmp & "addSubMenu('top','" & rs("maintitle") & "','','','" & xmain & "','');" & chr(13)
                    sTmp = sTmp & "addSubMenu('top','File','','','xFile','');" & Chr(13)
                    sTmp = sTmp & "addLink('xFile','Home','','MainDDM.aspx','');" & Chr(13)
                    sTmp = sTmp & "addLink('xFile','User Info','','./Home/UserInfo.aspx','');" & Chr(13)
                    sTmp = sTmp & "addLink('xFile','Change Password','','./Home/ChangePassword.aspx','');" & Chr(13)
                    sTmp = sTmp & "addLink('xFile','Change Display Theme','','./Home/ChangeTheme.aspx','');" & Chr(13)
                    'sTmp = sTmp & "addLink('xFile','Logout User ID : " & Request.Cookies("UID").Value & "','','GLlogout.asp?LogUID=" & Request.Cookies("UID").Value & "','');" & Chr(13)
                    sTmp = sTmp & "addLink('xFile','Logout User','','logout.aspx?LogUID=" & Request.Cookies("UID").Value & "','');" & Chr(13)
                    sTmp = sTmp & "addSubMenu('top','Activity','','','" & xmain & "','');" & Chr(13)
                    intMain = intMain + 1
                End If

                'While Not rs.EOF And rs("mainmenu") = xmain And rs("submenu") = xsub
                While rs("mainmenu").ToString() = xmain And _
                        rs("submenu").ToString() = xsub
                    xxmain = rs("mainmenu").ToString()
                    xxsub = rs("submenu").ToString()
                    xxmenu = rs("menu").ToString()
                    xxxsubold = ""
                    If xxmain <> xxsub Then ' Sub yg punya anak
                        sTmp = sTmp & "addSubMenu('" & xmain & "','" & rs("subtitle") & "','','','" & xxsub & "','');" & Chr(13)
                    End If
                    'While Not rs.EOF And rs("mainmenu") = xmain And rs("mainmenu") = xxmain And rs("submenu") = xxsub
                    While rs("mainmenu").ToString() = xmain And _
                            rs("mainmenu").ToString() = xxmain And _
                            rs("submenu").ToString() = xxsub
                        xxxmain = rs("mainmenu").ToString()
                        xxxsub = rs("submenu").ToString()
                        xxxmenu = rs("menu").ToString()
                        'While Not rs.EOF And rs("mainmenu") = xmain And rs("mainmenu") = xxmain And rs("submenu") = xxxsub And xxxmenu = rs("menu")
                        While rs("mainmenu").ToString() = xmain And _
                            rs("mainmenu").ToString() = xxmain And _
                            rs("submenu").ToString() = xxxsub And xxxmenu = rs("menu").ToString()
                            If InStr(1, rs("URL"), "?", 1) <= 0 Then
                                sTmp = sTmp & "addLink('" & xxxsub & "','" & rs("Title") & "','','" & rs("URL") & "?MenuId=" & rs("Menu") & "','');" & Chr(13)
                            Else
                                sTmp = sTmp & "addLink('" & xxxsub & "','" & rs("Title") & "','','" & rs("URL") & "&MenuId=" & rs("Menu") & "','');" & Chr(13)
                            End If
                            'rs.MoveNext()
                            'If rs.EOF Then
                            If Not rs.Read Then
                                strTemp = "<script type='text/javascript'>" & Chr(13)
                                strTemp = strTemp & "addMenu('Demo', 'top');" & Chr(13)
                                strTemp = strTemp & sTmp & Chr(13)
                                strTemp = strTemp & "endMenu();" & Chr(13)
                                strTemp = strTemp & " var intMain=" & intMain & ";" & Chr(13)
                                strTemp = strTemp & "</script>" & Chr(13)
                                'Response.Write(strTemp)
                                Exit Sub
                            End If
                        End While
                    End While
                    xxxsubold = xxsub
                End While
            Next
            rs.Close()
            rs = Nothing
            'Catch ex As Exception
        Finally
            obj.Close()
            obj = Nothing

        End Try

    End Sub

    Public Sub AddStyle()
        Dim objDBHelper As New DBX
        Try
            Dim rst As Data.SqlClient.SqlDataReader

            rst = objDBHelper.CreateSDRFromSQLSelect("select MenuID from AppMenu where MenuType=1")
            strStyleGroup = "addStyleGroup('group', 'sub2',"
            While rst.Read
                strStyleGroup = strStyleGroup & "'" & rst("MenuId") & "', "
            End While
            strStyleGroup = strStyleGroup & "'');" & Chr(13)
            Response.Write(strStyleGroup)
            rst.Close()
            rst = Nothing
        Finally
            objDBHelper.Close()
            objDBHelper = Nothing
        End Try

    End Sub


End Class
