<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BtnUpdate.ascx.vb" Inherits="UserControl_BtnUpdate" %>
	<style type="text/css">
    .UpdateBackGround
    {
	    background-color: Gray;
	    filter: alpha(opacity=50);
	    opacity: 0.50;
    }
	</style>
<asp:Button ID="btnUpdate" runat="server" CommandName="Update" OnClientClick="return CheckUserSPVUpdate();" Style="font-size: 8pt;
    cursor: pointer; background-image: url(../images/Save.gif); background-repeat: no-repeat;  background-position: left top; text-align: right;" Text="Update" ToolTip="Update Data" Width="55px" />
<script type="text/javascript">
    function CheckUserSPVUpdate() {
        document.body.className = "UpdateBackGround";
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