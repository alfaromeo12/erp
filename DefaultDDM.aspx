<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DefaultDDM.aspx.vb" Inherits="DefaultDDM"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<link rel="shortcut icon" href="images/app.ico">
<link rel="stylesheet" href="include/TB.css" type="text/css" />
<title>..::PPI DeStart::..</title>
<script type="text/javascript" language="javascript" src="include/menuG5IEFSX.js"></script>
<script type="text/javascript" language="javascript" src="include/menuLoaderG5FSX.js"></script>
<%Response.Write (strTemp)%>

<script type="text/javascript" language="javascript">
//Menu style

addStylePad('pad', 'holder-css:subholder; pad-css:bar;');
addStylePad("padSub", "holder-css:subholder; pad-css:bar;");
addStyleItem("Main", "css:itemNormal MainLeft, itemOn MainLeft, itemDown MainLeft; ")
addStyleItem("Sub", "css:itemNormal itemSub, itemOn itemSub, itemDown itemSub; ");
addStyleFont("fontTop", "css:fontNormal, fontOn,fontDown;");
addStyleFont("fontSub", "css:fontNormal, fontOn,fontDown;");

addStyleTag("tag", "css:tagNormal, tagOn, tagDown;");

addStyleMenu("menu", "pad", "Main", "fontTop", "tag", "", "");
addStyleMenu("sub", "padsub", "Sub", "fontSub", "tag", "", "");
addStyleMenu("sub2", "padSub", "Sub", "fontSub", "tag", "", "");
addStyleGroup("group", "sub2", "top");

<%
'//dim objDBHelper
'//set objDBHelper=Server.CreateObject("ConnectDB.DBHelper")
'//set rst=objDBHelper.CreateRSfromView("prfMenu", "MenuId", "MenuType=1")
'//'Response.Write "<script language='JavaScript'>" & Chr(13)
'//strStyleGroup="addStyleGroup('group', 'sub2',"
'//do while not rst.eof
'//	strStyleGroup = strStyleGroup &   "'" & rst("MenuId") & "', "
'//	rst.moveNext
'//loop
'//strStyleGroup = strStyleGroup & "'');" & Chr(13)
'//Response.Write strStyleGroup
'//set objDBHelper=nothing


%>


//create one of this menu
addInstance("Demo", "Demo", "position:slot 6; menu-form:bar; align:left; valign:bottom; style:group;");
//addInstance("Demo2", "Demo", "position:slot 1; align:right; style:group;");
<%Response.Write(strStyleGroup)%>


</script>
</head>
<script  type="text/javascript" language="JavaScript">
	self.defaultStatus = "PSAK";	
    var thePage = "MainDDM.aspx";

  	self.document.writeln('<frameset rows="77,*" border=0 onResize="">');
	//self.document.writeln('	<frame name="title" src="include/TopFrame.asp" scrolling="no" noresize marginwidth="0" marginheight="0" APPLICATION="yes">');
	self.document.writeln('	<frame name="title" src="TopFrameDDM.aspx" scrolling="no" noresize marginwidth="0" marginheight="0" APPLICATION="yes">');
	self.document.writeln('	<frame name="main" src="' + thePage +'" scrolling="auto" APPLICATION="yes">');
	self.document.writeln('	<noframes>');
	self.document.writeln('	<body>');
	self.document.writeln('	</body>');
	self.document.writeln('	</noframes>');
	self.document.writeln('</frameset>');
</script>
<body></body>
</html>

