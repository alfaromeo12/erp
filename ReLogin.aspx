<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReLogin.aspx.vb" Inherits="ReLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Re Login</title>
</head>
<script type="text/javascript">
function ReLogin(){
    if (parent.parent)
	    parent.parent.window.location = 'Login.aspx';
    else
	    parent.window.location = 'Login.aspx';
	return false;
}
</script>
<body  >
    <form id="form1" runat="server">
    <div><h2>
        <span class="required">Session Has Expired
            <br />
        </span></h2>
            <hr />
        <h3>
        Your login session has expired.<br />
        Why does your session expire ?<br /></h3>
        <h5>
        For your security, if you did not do anything during your session time that has
        been set to specified amount of time (<%=intTimeOut%>
        minutes), your session will expire. And you will be prompted for a password once
        again. Or If There is same User ID log in another computer, your session will expire.
            Or if the application date has changed, your sessions will be expired too.<br /></h5>
        <a href="#" target="_parent" onclick="return ReLogin()"><font face="Arial,verdana,Haettenschweiler"
            class="HeaderStyle" size="4" ><b>Click here to re-Login</b></font></a>
    
    </div>
    </form>
</body>
</html>
