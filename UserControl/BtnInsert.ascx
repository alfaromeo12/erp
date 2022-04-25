<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BtnInsert.ascx.vb" Inherits="UserControl_BtnInsert" %>
	<style type="text/css">
    .InsertBackGround
    {
	    background-color: Gray;
	    filter: alpha(opacity=50);
	    opacity: 0.50;
    }
	</style>
<asp:Button ID="btnInsert" runat="server" CommandName="Insert" OnClientClick="return CheckUserSPVInsert();" Style="font-size: 8pt;
    cursor: pointer; background-position: left top; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" Text="Insert" ToolTip="Insert New Data" Width="55px" />
<script type="text/javascript">
    function CheckUserSPVInsert() {
        document.body.className = "InsertBackGround";
        if (Page_ClientValidate) {
            if (Page_ClientValidate("")) {
                var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
                document.body.className = "";
                if (RetVal.Login == 1)
                    return (true);
                else
                    return (false);
            } else {
                return (false);
            }
        } else {
            var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
            document.body.className = "";
            if (RetVal.Login == 1)
                return (true);
            else
                return (false);
        }
    }
</script>
