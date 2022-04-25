Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration


Partial Class Menu
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        'Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strUID As String = Request.Cookies("UID").Value
        Dim strMenuStyle As String = "1"
        Dim objDBX As New DBX


        Try
            If Len(Trim(strUID)) > 0 Then

                'get menustyle
                Dim sdrMenu As SqlDataReader
                Dim strUserName As String = ""
                sdrMenu = objDBX.CreateSDRFromSQLSelect("SELECT UserId, UserName, MenuStyle FROM APPUser  WITH(NOLOCK) WHERE UID='" & strUID & "'")
                If sdrMenu.Read Then
                    strMenuStyle = sdrMenu("MenuStyle").ToString()
                    strUserName = sdrMenu("UserName")
                End If
                sdrMenu.Close()
                sdrMenu = Nothing


                If strMenuStyle = "1" Then
                    MenuX.Visible = False
                    Dim sdrUserMenu As SqlDataReader
                    sdrUserMenu = objDBX.CreateSDRFromSP("APPUserMenu", _
                        objDBX.MP("@UID", SqlDbType.Int, strUID))

                    Dim oTreemain As TreeNode = New TreeNode()
                    oTreemain.Text = "Logout User: " & strUserName
                    oTreemain.NavigateUrl = "Logout.aspx?LogUserID=" & Request.Cookies("UID").Value
                    oTreemain.Target = "main"
                    oTreemain.ImageUrl = "./images/person.gif"

                    tvMenu.Nodes.Add(oTreemain)

                    oTreemain = New TreeNode()
                    oTreemain.Text = "File"
                    oTreemain.ImageUrl = "./images/primary.png"
                    oTreemain.NavigateUrl = "main.aspx"
                    oTreemain.Target = "main"

                    Dim oTreeExe As TreeNode
                    oTreeExe = New TreeNode()
                    oTreeExe.Text = "User Info"
                    oTreeExe.ToolTip = "User Info : " & strUserName
                    oTreeExe.NavigateUrl = "./Home/UserInfo.aspx"
                    oTreeExe.ImageUrl = "./images/user.gif"
                    oTreeExe.Target = "main"
                    oTreemain.ChildNodes.Add(oTreeExe)

                    oTreeExe = New TreeNode()
                    oTreeExe.Text = "Change Password"
                    oTreeExe.ToolTip = "Change Password for User " & strUserName
                    oTreeExe.NavigateUrl = "./Home/ChangePassword.aspx"
                    oTreeExe.ImageUrl = "./images/unlock.gif"
                    oTreeExe.Target = "main"
                    oTreemain.ChildNodes.Add(oTreeExe)

                    oTreeExe = New TreeNode()
                    oTreeExe.Text = "Change Theme"
                    oTreeExe.ToolTip = "Change Theme for User " & strUserName
                    oTreeExe.NavigateUrl = "./Home/ChangeTheme.aspx"
                    oTreeExe.ImageUrl = "./images/display.gif"
                    oTreeExe.Target = "main"
                    oTreemain.ChildNodes.Add(oTreeExe)


                    oTreeExe = New TreeNode()
                    oTreeExe.Text = "Logout User: " & strUserName
                    oTreeExe.NavigateUrl = "Logout.aspx?LogUserID=" & Request.Cookies("UID").Value
                    oTreeExe.ToolTip = "Logout for User " & strUserName
                    oTreeExe.ImageUrl = "./images/person.gif"
                    oTreeExe.Target = "main"
                    oTreemain.ChildNodes.Add(oTreeExe)

                    oTreeExe = New TreeNode()
                    oTreeExe.Text = "Home"
                    oTreeExe.ToolTip = "Go to Home"
                    oTreeExe.NavigateUrl = "main.aspx"
                    oTreeExe.ImageUrl = "./images/home.gif"
                    oTreeExe.Target = "main"
                    oTreemain.ChildNodes.Add(oTreeExe)

                    tvMenu.Nodes.Add(oTreemain)


                    oTreemain = New TreeNode()
                    oTreemain.Text = "Activity"
                    oTreemain.SelectAction = TreeNodeSelectAction.Expand
                    Dim strMainTitle As String = ""
                    Dim strOldmainTitle As String = ""

                    While sdrUserMenu.Read
                        strMainTitle = sdrUserMenu("mainTitle")
                        If strMainTitle <> strOldmainTitle Then
                            oTreemain = New TreeNode(sdrUserMenu("mainTitle"))
                            oTreemain.NavigateUrl = "#"
                            oTreemain.ImageUrl = "./images/menu.gif"

                            Me.tvMenu.Nodes.Add(oTreemain)

                            oTreeExe = New TreeNode(sdrUserMenu("Title"))
                            oTreemain.ChildNodes.Add(oTreeExe)
                        Else

                            oTreeExe = New TreeNode(sdrUserMenu("Title"))
                            oTreemain.ChildNodes.Add(oTreeExe)

                        End If
                        If InStr(1, sdrUserMenu("URL"), "?", 1) <= 0 Then
                            oTreeExe.NavigateUrl = sdrUserMenu("URL") & "?MenuID=" & sdrUserMenu("Menu")
                        Else
                            oTreeExe.NavigateUrl = sdrUserMenu("URL") & "&MenuID=" & sdrUserMenu("Menu")
                        End If

                        oTreeExe.Target = "main"
                        oTreeExe.Text = sdrUserMenu("Title")
                        oTreeExe.ToolTip = sdrUserMenu("FuncDesc")
                        strOldmainTitle = strMainTitle
                        oTreemain.CollapseAll()

                    End While
                    sdrUserMenu.Close()
                    sdrUserMenu = Nothing

                ElseIf strMenuStyle = "2" Then
                    tvMenu.Visible = False

                    Dim sdrUserMenu As SqlDataReader
                    sdrUserMenu = objDBX.CreateSDRFromSP("APPUserMenu", _
                        objDBX.MP("@UID", SqlDbType.Int, strUID))

                    Dim mnRoot As MenuItem = New MenuItem()
                    'mnRoot.Selectable = False
                    mnRoot.Text = "Logout User: " & strUserName
                    mnRoot.ToolTip = "Logout for User " & strUserName
                    mnRoot.NavigateUrl = "Logout.aspx?LogUserID=" & Request.Cookies("UID").Value
                    mnRoot.ImageUrl = "./images/person.gif"
                    mnRoot.Target = "main"
                    MenuX.Items.Add(mnRoot)

                    mnRoot = New MenuItem()
                    mnRoot.Text = "File"
                    mnRoot.NavigateUrl = "main.aspx"
                    mnRoot.ImageUrl = "./images/primary.png"
                    mnRoot.Target = "main"
                    Dim mnChild As MenuItem
                    mnChild = New MenuItem()
                    mnChild.Text = "User Info"
                    mnChild.NavigateUrl = "./Home/UserInfo.aspx"
                    mnChild.ImageUrl = "./images/user.gif"
                    mnChild.ToolTip = "User Info : " & strUserName
                    mnChild.Target = "main"
                    mnRoot.ChildItems.Add(mnChild)

                    mnChild = New MenuItem()
                    mnChild.Text = "Logout User : " & strUserName
                    mnChild.ToolTip = "Logout for User " & strUserName
                    mnChild.ImageUrl = "./images/person.gif"
                    mnChild.NavigateUrl = "Logout.aspx?LogUserID=" & Request.Cookies("UID").Value
                    mnChild.Target = "main"
                    mnRoot.ChildItems.Add(mnChild)


                    mnChild = New MenuItem()
                    mnChild.Text = "Change Password "
                    mnChild.ToolTip = "Change Password User : " & strUserName
                    mnChild.NavigateUrl = "./Home/ChangePassword.aspx"
                    mnChild.ImageUrl = "./images/unlock.gif"
                    mnChild.Target = "main"
                    mnRoot.ChildItems.Add(mnChild)

                    mnChild = New MenuItem()
                    mnChild.Text = "Change Theme"
                    mnChild.ToolTip = "Change Theme"
                    mnChild.NavigateUrl = "./Home/ChangeTheme.aspx"
                    mnChild.ImageUrl = "./images/display.gif"
                    mnChild.Target = "main"
                    mnRoot.ChildItems.Add(mnChild)


                    mnChild = New MenuItem()
                    mnChild.Text = "Home"
                    mnChild.ToolTip = "Go to Home"
                    mnChild.NavigateUrl = "main.aspx"
                    mnChild.ImageUrl = "./images/home.gif"
                    mnChild.Target = "main"
                    mnRoot.ChildItems.Add(mnChild)

                    MenuX.Items.Add(mnRoot)
                    Dim strmainTitle As String = ""
                    Dim strOldmainTitle As String = ""
                    While sdrUserMenu.Read
                        strmainTitle = sdrUserMenu("mainTitle")
                        If strmainTitle <> strOldmainTitle Then
                            mnRoot = New MenuItem(sdrUserMenu("mainTitle"))
                            mnRoot.NavigateUrl = "#"
                            mnRoot.ImageUrl = "./images/menu.gif"
                            'mnRoot.Selectable = False
                            MenuX.Items.Add(mnRoot)

                            'mnChild = New TreeNode(sdrUserMenu("Title"))
                            mnChild = New MenuItem(sdrUserMenu("Title"))
                            mnRoot.ChildItems.Add(mnChild)
                        Else

                            'mnChild = New TreeNode(sdrUserMenu("Title"))
                            mnChild = New MenuItem(sdrUserMenu("Title"))
                            mnChild.Selectable = True
                            mnRoot.ChildItems.Add(mnChild)

                        End If
                        If InStr(1, sdrUserMenu("URL"), "?", 1) <= 0 Then
                            mnChild.NavigateUrl = sdrUserMenu("URL") & "?MenuID=" & sdrUserMenu("Menu")
                        Else
                            mnChild.NavigateUrl = sdrUserMenu("URL") & "&MenuID=" & sdrUserMenu("Menu")
                        End If

                        mnChild.Target = "main"
                        mnChild.Text = sdrUserMenu("Title")
                        'mnChild.Text = "<div onmouseover='SetWinStatus(""" & Server.HtmlEncode(sdrUserMenu("Title")) & """);'>" & sdrUserMenu("Title") & "</div>"

                        mnChild.ToolTip = sdrUserMenu("FuncDesc")

                        strOldmainTitle = strmainTitle
                        'mnRoot.CollapseAll()


                    End While

                    sdrUserMenu.Close()
                    sdrUserMenu = Nothing
                End If

                'Catch ex As Exception
                '   Throw
            Else
                Response.Redirect("Logout.aspx")
            End If
        Finally
            objDBX.Close()
            objDBX = Nothing
        End Try
    End Sub

End Class
