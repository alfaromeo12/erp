<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="FTPUpload.aspx.vb" Inherits="Core_FTPUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" style="width:100%;" class="ShowDetail">
        <tr>
            <td>
                    FTP
                    Server Name</td>
            <td>
                <asp:TextBox ID="txtServer" runat="server" CssClass="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqServer" runat="server" ControlToValidate="txtServer"
            Display="None" ErrorMessage="[FTP SERVER NAME] must be entry...!" 
                    SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:validatorcalloutextender
                id="ajaxVCECutDate" runat="server" highlightcssclass="ErrHighLight" 
                    targetcontrolid="reqServer" BehaviorID="ajaxVCEServer">
                </ajaxToolkit:validatorcalloutextender>
            </td>
            <td>
                    &nbsp;</td>
        </tr>
        <tr>
            <td>
                    FTP
                    User Name</td>
            <td>
                <asp:TextBox ID="txtUser" runat="server" CssClass="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqUser" runat="server" ControlToValidate="txtUser"
            Display="None" ErrorMessage="[FTP USER NAME] must be entry...!" 
                    SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:validatorcalloutextender
                id="reqUser_ValidatorCalloutExtender" runat="server" 
                    highlightcssclass="ErrHighLight" targetcontrolid="reqUser" 
                    BehaviorID="ajaxVCEUser"></ajaxToolkit:validatorcalloutextender>
            </td>
            <td>
                    &nbsp;</td>
        </tr>
        <tr>
            <td>
                    FTP User
                    Password</td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                    CssClass="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword"
            Display="None" ErrorMessage="[FTP USER PASSWORD] must be entry...!" 
                    SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:validatorcalloutextender
                id="reqPassword_ValidatorCalloutExtender" runat="server" 
                    highlightcssclass="ErrHighLight" targetcontrolid="reqPassword" 
                    BehaviorID="ajaxVCEPassword"></ajaxToolkit:validatorcalloutextender>
            </td>
            <td>
                    &nbsp;</td>
        </tr>
        <tr>
            <td>
                    File to Upload via FTP</td>
            <td>
                    <asp:FileUpload ID="FileUpload" runat="server" CssClass="required" 
                    Width="100%" />
                    <asp:Label ID="lblMessageFile" runat="server" CssClass="ErrHighLight" 
                        Visible="False"></asp:Label>
                </td>
        </tr>
        <tr>
            <td>
                    File Type</td>
            <td>
                <asp:DropDownList ID="ddlFileType" runat="server" CssClass="required">
                    <asp:ListItem Value="1">TEXT FILE</asp:ListItem>
                    <asp:ListItem Value="2">BINARY</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                    FTP Server Direktory</td>
            <td>
                <asp:TextBox ID="txtFTPDirektory" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                    FTP File Name</td>
            <td>
                <asp:TextBox ID="txtFTPFile" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="FooterStyle">
                <asp:Button ID="btnFTP" runat="server" Text="Send File via FTP" />
            </td>
            <td class="FooterStyle">
                <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                    Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
        <script type="text/javascript">
            function BackPage() {
                window.history.back(-1);
                return false;
            }
            function ShowAlert() {
                alert("FTP UPLOAD ERROR...! Please see the error detail..!");
            }
    </script>
    <%=strScript%>

</asp:Content>

