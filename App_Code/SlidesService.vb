Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<System.Web.Script.Services.ScriptService()> _
Public Class SlidesService
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetSlidesMain() As AjaxControlToolkit.Slide()
        Dim MySlides(15) As AjaxControlToolkit.Slide
        MySlides(0) = New AjaxControlToolkit.Slide("images/j0439348.jpg", "GoldenBoy1", "Golden Boy 1")
        MySlides(1) = New AjaxControlToolkit.Slide("images/j0439344.jpg", "GoldenBoy2", "Golden Boy 2")
        MySlides(2) = New AjaxControlToolkit.Slide("images/j0439328.jpg", "GoldenBoy3", "Golden Boy 3")
        MySlides(3) = New AjaxControlToolkit.Slide("images/j0439308.jpg", "GoldenBoy4", "Golden Boy 4")
        MySlides(4) = New AjaxControlToolkit.Slide("images/j0439262.jpg", "GoldenBoy5", "Golden Boy 5")
        MySlides(5) = New AjaxControlToolkit.Slide("images/j0439261.jpg", "GoldenBoy6", "Golden Boy 6")
        MySlides(6) = New AjaxControlToolkit.Slide("images/j0439258.jpg", "GoldenBoy7", "Golden Boy 7")
        MySlides(7) = New AjaxControlToolkit.Slide("images/j0439242.jpg", "GoldenBoy8", "Golden Boy 8")
        MySlides(8) = New AjaxControlToolkit.Slide("images/j0439239.jpg", "GoldenBoy9", "Golden Boy 9")
        MySlides(9) = New AjaxControlToolkit.Slide("images/j0435725.jpg", "GoldenBoy10", "Golden Boy 10")
        MySlides(10) = New AjaxControlToolkit.Slide("images/j0439318.jpg", "GoldenBoy11", "Golden Boy 11")
        MySlides(11) = New AjaxControlToolkit.Slide("images/j0439328.jpg", "GoldenBoy12", "Golden Boy 12")
        MySlides(12) = New AjaxControlToolkit.Slide("images/j0439329.jpg", "GoldenBoy13", "Golden Boy 13")
        MySlides(13) = New AjaxControlToolkit.Slide("images/j0439343.jpg", "GoldenBoy14", "Golden Boy 14")
        MySlides(14) = New AjaxControlToolkit.Slide("images/j0439344.jpg", "GoldenBoy15", "Golden Boy 15")
        MySlides(15) = New AjaxControlToolkit.Slide("images/j0439347.jpg", "GoldenBoy16", "Golden Boy 16")
        Return MySlides
    End Function

End Class
