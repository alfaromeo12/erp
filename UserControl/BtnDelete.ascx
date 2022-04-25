<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BtnDelete.ascx.vb" Inherits="UserControl_BtnDelete" %>
	<style type="text/css">
    .DeleteBackGround
    {
	    background-color: Gray;
	    filter: alpha(opacity=50);
	    opacity: 0.50;
    }
	</style>

<asp:Button ID="btnDelete" runat="server" CausesValidation="False" OnClientClick="return CheckUserSPVDelete();" CommandName="Delete"
    Style="font-size: 8pt; cursor: pointer; background-position: left top; background-image: url(../images/delete.gif); background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete Data" Width="55px" />
<script type="text/javascript">
    function CheckUserSPVDelete() {
        document.body.className = "DeleteBackGround";
        var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
        document.body.className = "";
        if (RetVal.Login == 1)
            return (true);
        else
            return (false);
    }
</script>
