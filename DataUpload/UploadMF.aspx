<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="UploadMF.aspx.vb" Inherits="DataUpload_UploadMF" title="MF UPLOAD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td>
                <asp:Panel ID="pnlBranch" runat="server" Width="100%" 
                    GroupingText="FILE BRANCH" CssClass="FooterStyle" Font-Bold="True" 
                    Visible="False">
                <asp:FileUpload ID="FileBranch" runat="server" CssClass="required" Width="100%" Font-Size="Large" size="75" />
                <asp:Label ID="lblMessageBranch" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label></asp:Panel>
                <asp:Panel ID="pnlInsurance" runat="server" Width="100%" 
                    GroupingText="FILE INSURANCE COMPANY" CssClass="FooterStyle" Font-Bold="True" 
                    Visible="False">
                    <asp:FileUpload ID="FileInsurance" runat="server" CssClass="required" 
                        Width="100%" Font-Size="Medium" size="75" />
                    <asp:Label ID="lblMessageInsurance" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label></asp:Panel>
                <asp:Panel ID="pnlCustomer" runat="server" Width="100%" GroupingText="FILE CUSTOMER/ACCOUNT" CssClass="FooterStyle" Font-Bold="True">
                    <asp:FileUpload ID="FileCustomer" runat="server" CssClass="required" 
                        Width="100%" Font-Size="Medium" size="75" />
                    <asp:Label ID="lblMessageCustomer" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label></asp:Panel>
                <asp:Panel ID="pnlLoan" runat="server" Width="100%" GroupingText="FILE LOAN DATA" CssClass="FooterStyle" Font-Bold="True">
                    <asp:FileUpload ID="FileLoan" runat="server" CssClass="required" Width="100%" 
                        Font-Size="Medium" size="75"  />
                    <asp:Label ID="lblMessageLoan" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label></asp:Panel>
                <asp:Panel ID="pnlCollateral" runat="server" Width="100%" GroupingText="FILE COLLATERAL" CssClass="FooterStyle" Font-Bold="True">
                    <asp:FileUpload ID="FileCollateral" runat="server" CssClass="required" 
                        Width="100%" Font-Size="Medium" size="75" />
                    <asp:Label ID="lblMessageCollateral" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label></asp:Panel>
                <asp:Panel ID="pnlInstallment" runat="server" Width="100%" 
                    GroupingText="FILE INSTALLMENT" CssClass="FooterStyle" Font-Bold="True">
                    <asp:FileUpload ID="FileInstallment" runat="server" CssClass="required" 
                        Width="100%" Font-Size="Medium" size="75" />
                    <asp:Label ID="lblMessageInstallment" runat="server" CssClass="ErrHighLight" 
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
        alert("UPLOAD DATA ERROR...! Please see the error detail..!");
    }
    </script>
    <%=strScript%>
    
</asp:Content>

