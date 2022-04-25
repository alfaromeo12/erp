<%@ Page Title="FTP DOCUMENT" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="FTPDoc.aspx.vb" Inherits="Home_FTPDoc" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

 <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ftpServer">FTP Server</asp:ListItem>
        <asp:ListItem Value="FTPCode">FTP Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="FTPCODE" Caption="FTP Document List" 
            RowHeaderColumn="AREACODE">
            <Columns>
              <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True">
                    <HeaderStyle CssClass="FooterStyle" />
                    <ItemStyle HorizontalAlign="Center" Width="30px" /></asp:CommandField>
                <asp:BoundField DataField="FTPCODE" HeaderText="FTP&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="FTPCODE" >
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="FTPSERVER" HeaderText="FTP&lt;br&gt;Server" HtmlEncode="False"
                    SortExpression="FTPSERVER" />
                <asp:BoundField DataField="FTPFOLDER" HeaderText="FTP&lt;br&gt;Folder" 
                    HtmlEncode="False" SortExpression="FTPFOLDER" />
                <asp:BoundField DataField="FTPUSERID" HeaderText="FTP&lt;br&gt;UserID" 
                    HtmlEncode="False" SortExpression="FTPUSERID" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT [FTPCODE], [FTPSERVER], [FTPFOLDER], [FTPUSERID] FROM [FTPDOC]"></asp:SqlDataSource>
   <asp:Panel ID="pnlFTPDocument" runat="server">
             <table id="ftp" width="100%" cellpadding="0" cellspacing="0">
           
            <tr>
                <th colspan="2" class="title">
                    FTP User and Password</th>
            </tr>
       
            <tr>
                <td style="width: 160px" class="FooterStyle">FTP Code</td>
                <td>
                    <asp:TextBox ID="txtCodeFTP" runat="server" CssClass="required" MaxLength="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqFTPCode" runat="server" 
                        ControlToValidate="txtCodeFTP" Display="None" 
                        ErrorMessage="[FTP CODE] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqFTPCode_ValidatorCalloutExtender" 
                        runat="server"
                        HighlightCssClass="ErrHighLight" TargetControlID="reqFTPCode">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                 <tr>
                     <td class="FooterStyle" style="width: 160px">
                         FTP Server</td>
                     <td>
                         <asp:TextBox ID="txtServer" runat="server" CssClass="required"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="reqServer" runat="server" 
                             ControlToValidate="txtServer" Display="None" 
                             ErrorMessage="[FTP SERVER] must be entry..." ForeColor="Red" 
                             SetFocusOnError="True"></asp:RequiredFieldValidator>
                         <ajaxToolkit:ValidatorCalloutExtender ID="reqServer_ValidatorCalloutExtender" 
                             runat="server" 
                             HighlightCssClass="ErrHighLight" TargetControlID="reqServer">
                         </ajaxToolkit:ValidatorCalloutExtender>
                     </td>
                 </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">FTP Folder</td>
                <td>
                    <asp:TextBox ID="txtFolder" runat="server" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqFolder" runat="server"
                        ControlToValidate="txtFolder" Display="None" 
                        ErrorMessage="[FTP FOLDER] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqFolder_ValidatorCalloutExtender" 
                        runat="server" TargetControlID="reqFolder" 
                        HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                 <tr>
                <td style="width: 160px" class="FooterStyle">FTP User ID</td>
                <td>
                    <asp:TextBox ID="txtUser" runat="server" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqUser" runat="server" 
                        ControlToValidate="txtUser" Display="None" 
                        ErrorMessage="[FTP USER NAME] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqUser_ValidatorCalloutExtender" 
                        runat="server" TargetControlID="reqUser" 
                        HighlightCssClass="ErrHighLight"  
                        CssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">FTP User Password</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPassword" runat="server" 
                        ControlToValidate="txtPassword" Display="None" 
                        ErrorMessage="[FTP USER PASSWORD] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqPassword_ValidatorCalloutExtender" 
                        runat="server" TargetControlID="reqPassword" 
                        HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblMessage" runat="server" style="text-align: center" CssClass="ErrHighLight" Font-Bold="True" Width="100%" Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                    </td>
            </tr>
            <tr>
                <td colspan="2" class="HeaderStyle">
                            <asp:Button ID="btnSave" runat="server"
                            Style="font-size: 8pt; cursor: pointer; 
                            background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" ValidationGroup="Collector" />
                            &nbsp;<asp:Button ID="btnCancel" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Cancel" Width="55px" CausesValidation="False" 
                                ValidationGroup="Collector" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        </asp:Panel>
        <br />
        <br />
   
   <script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
        FormatTable("<%=gvData.ClientID%>");
      
    </script>
</asp:Content>
