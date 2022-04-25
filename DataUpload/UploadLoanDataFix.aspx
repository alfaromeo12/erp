<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="UploadLoanDataFix.aspx.vb" Inherits="DataUpload_UploadLoanDataFix" title="LOAN DATA FIX UPLOAD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td>
                <asp:Panel ID="pnlLoanData" runat="server" Width="100%" 
                    GroupingText="FILE LOAN DATA FIX" CssClass="FooterStyle" Font-Bold="True">
                <asp:FileUpload ID="FileBranch" runat="server" CssClass="required" Width="100%" 
                        Font-Size="Medium" size="75" />
                <asp:Label ID="lblMessageLoanData" runat="server" CssClass="ErrHighLight" 
                        Visible="False"></asp:Label></asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                </td>
        </tr>
        <tr>
            <td>
                </td>
        </tr>
        <tr>
            <td class="HeaderStyle" >
                <asp:Button ID="btnUpload" runat="server" Style="cursor: pointer; background-position: left; background-image: url(../Images/Upload.gif); background-repeat: no-repeat; text-align: right;" Text="Upload" ToolTip="Click here to upload file...!" Width="72px" />
                <asp:Button ID="btnBack" runat="server" OnClientClick="return BackPage();" Style="cursor: pointer; background-position: left; background-image: url(../Images/back.png); background-repeat: no-repeat; text-align: right;"
                    Text="Back" Visible="False" Width="64px" /></td>
        </tr>
    </table>
    <script type="text/javascript">
    function BackPage(){
        window.history.back(-1);
        return false;
    }
    function ShowAlert(){
        alert("UPLOAD LOAN DATA FIX File ERROR...! Please see the error detail..!");
    }
    </script>
    <%=strScript%>

</asp:Content>

