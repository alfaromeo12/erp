<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Logout.aspx.vb" Inherits="Logout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>logout</title>
    <script language="javascript" type="text/javascript">
    function Logout() {
            parent.window.location = "Login.aspx";
    }
    </script>
</head>
<body onload="Logout()">
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
