<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="VAUploadBRIExcel.aspx.vb" Inherits="Repl_VABRIExcel" title="Upload VA BRI Excel " aspcompat="true"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlUpload" runat="server" CssClass="RowStyle" GroupingText="Choose file to be uploaded...!">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="HeaderStyle">
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
        <asp:FileUpload ID="FileUploadRepl" runat="server" Width="100%" CssClass="required" 
                        Font-Size="Medium" /></td>
            </tr>
            <tr>
                <td class="HeaderStyle">
        <asp:Button ID="btnUpload" runat="server" Style="cursor: pointer; background-position: left; background-image: url(../Images/Upload.gif); background-repeat: no-repeat; text-align: right;" Text="Upload" ToolTip="Click here to upload file...!" Width="64px" /></td>
            </tr>
        </table>
        <asp:Label ID="lblMessage" runat="server" CssClass="required" Visible="False"></asp:Label></asp:Panel>
<script type="text/javascript">
function ShowAlert(){
    alert("UPLOAD DATA ERROR...! Please see the error detail..!");
}
</script>

<%=strScript%>
</asp:Content>

