<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="EmailSetting.aspx.vb" Inherits="Home_EmailSetting" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="EMAILCODE">Email Code</asp:ListItem>
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
            DataKeyNames="EMAILCODE" Caption="Email Document List">
            <Columns>
            <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/images/edit.gif" >
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="EMAILCODE" HeaderText="EMAILCODE"
                    SortExpression="EMAILCODE" ReadOnly="True" >
                </asp:BoundField>
                <asp:BoundField DataField="USERID" HeaderText="USERID"
                    SortExpression="USERID" />
                <asp:BoundField DataField="SMTP" HeaderText="SMTP" SortExpression="SMTP" />
                <asp:BoundField DataField="POP3" HeaderText="POP3" SortExpression="POP3" />
                <asp:BoundField DataField="PORTSMTP" HeaderText="PORT SMTP" SortExpression="PORTSMTP" />
                <asp:BoundField DataField="PORTPOP3" HeaderText="PORT POP3" SortExpression="PORTPOP3" />
                <asp:BoundField DataField="SSL" HeaderText="SSL" SortExpression="SSL" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT [EMAILCODE], [USERID], [PASSWORD], [SMTP], [POP3], [PORTSMTP], [PORTPOP3], [SSL] FROM [EMAILSETTING]"></asp:SqlDataSource>
   <asp:Panel ID="pnlEmailSetting" runat="server">
             <table id="ftp" width="100%" cellpadding="0" cellspacing="0">
           
            <tr>
                <th colspan="4" class="title">
                    Email Setting and Password</th>
            </tr>
       
            <tr>
                <td style="width: 160px" class="FooterStyle">Email Code</td>
                <td colspan="3">
                    <asp:TextBox ID="txtEmailCode" runat="server" CssClass="required" MaxLength="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqEmailCode" runat="server" 
                        ControlToValidate="txtEmailCode" Display="None" 
                        ErrorMessage="[Email CODE] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqEmailCode_ValidatorCalloutExtender" 
                        runat="server"
                        HighlightCssClass="ErrHighLight" TargetControlID="reqEmailCode">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
                 <tr>
                     <td class="FooterStyle" style="width: 160px">
                         User ID</td>
                     <td colspan="3">
                         <asp:TextBox ID="txtUserID" runat="server" CssClass="required"></asp:TextBox>
                         <asp:RegularExpressionValidator ID="reqUserID" runat="server" 
                        ControlToValidate="txtUserID" Display="None" 
                        ErrorMessage="Invalid Email Address Format" SetFocusOnError="True" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                         <ajaxToolkit:ValidatorCalloutExtender ID="reqUserID_ValidatorCalloutExtender" 
                             runat="server" 
                             HighlightCssClass="ErrHighLight" TargetControlID="reqUserID">
                         </ajaxToolkit:ValidatorCalloutExtender>
                     </td>
                 </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">SMTP</td>
                <td>
                    <asp:TextBox ID="txtSMTP" runat="server" CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqSMTP" runat="server"
                        ControlToValidate="txtSMTP" Display="None" 
                        ErrorMessage="[SMPT] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqSMTP_ValidatorCalloutExtender" 
                        runat="server" TargetControlID="reqSMTP" 
                        HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td style="width: 160px" class="FooterStyle">Port SMTP</td>
                <td>
                    <asp:TextBox ID="txtPortSMTP" runat="server"></asp:TextBox>
                </td>
            </tr>
                 <tr>
                <td style="width: 160px" class="FooterStyle">POP3</td>
                <td>
                    <asp:TextBox ID="txtPop3" runat="server"></asp:TextBox>
                </td>
                <td style="width: 160px" class="FooterStyle">Port POP3</td>
                <td>
                    <asp:TextBox ID="txtPortPOP3" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="RowStyle" width="30%">
                    SSL</td>
                <td class="RowStyle" colspan="3">
                    <asp:RadioButton ID="rbYes" runat="server" Text="Yes" Checked="True" 
                        GroupName="Status" />
                    <asp:RadioButton ID="rbNo" runat="server" Text="No" GroupName="Status"/>
                </td>
            </tr>
            <tr>
                <td style="width: 160px" class="FooterStyle">Email Password</td>
                <td colspan="3">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPassword" runat="server" 
                        ControlToValidate="txtPassword" Display="None" 
                        ErrorMessage="[Email PASSWORD] must be entry..." ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqPassword_ValidatorCalloutExtender" 
                        runat="server" TargetControlID="reqPassword" 
                        HighlightCssClass="ErrHighLight">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:PasswordStrength ID="ajaxPSPassword" runat="server" TargetControlID="txtPassword"  PreferredPasswordLength=7 MinimumNumericCharacters="1" MinimumSymbolCharacters="1">
                    </ajaxToolkit:PasswordStrength>
                </td>
            </tr>
            <tr>
                <td colspan="4">
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
                <td colspan="4" class="HeaderStyle">
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
                <td colspan="4">
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

