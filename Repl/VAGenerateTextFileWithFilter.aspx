<%@ Page Title="VA - Generate Text File VA With  Filter" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="VAGenerateTextFileWithFilter.aspx.vb" Inherits="Repl_GenerateTextFileATMWithFilter" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
 <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server" Width="99%" GroupingText="Generate" >
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <th class="ShowDetail" colspan="4">
                    Replication - Generate Text File for Virtual Account Payment With Filter
                </th>
            </tr>
            <tr>
                <td class="RowStyle">
                    Bank
                </td>
                <td colspan="3" class="RowStyle">
                    <asp:DropDownList ID="ddlBank" CssClass="required" runat="server" 
                        DataSourceID="sdsBankVirtualAccount" DataTextField="BANKNAME" 
                        DataValueField="BANKID">
                    </asp:DropDownList>
                     <asp:SqlDataSource ID="sdsBankVirtualAccount" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS BANKID, '(SELECT BANK )' AS BANKNAME UNION ALL SELECT BANKID, '( ' + BANKCODE + ' ) ' + BANKNAME AS BANKNAME FROM BANK WHERE EXISTS (SELECT 'X' AS Expr1 FROM MOSTextSettingBank WHERE (BankId = BANK.BANKID))">
                    </asp:SqlDataSource>
                     <asp:RequiredFieldValidator ID="regBank" runat="server" 
                        ControlToValidate="ddlBank" Display="None" 
                        ErrorMessage="BANK must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="regVCE_Bank" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="regBank">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td width="10%" class="AlternatingRowStyle">
                    DPD <=
                </td>
                <td class="AlternatingRowStyle">
                    <asp:TextBox ID="txtDPD" CssClass="required" style="text-align:right" 
                        runat="server" MaxLength="5" Width="50px"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqDPD" runat="server" 
                        ControlToValidate="txtDPD" Display="None" 
                        ErrorMessage="DPD must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="regVCE_DPD" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqDPD">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td class="AlternatingRowStyle">
                    OverDue <=
                </td>
                <td class="AlternatingRowStyle">
                    <asp:TextBox ID="txtOverDue" CssClass="required" Width="100px" 
                        style="text-align:right" MaxLength="15" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqOverDue" runat="server" 
                        ControlToValidate="txtOverDue" Display="None" 
                        ErrorMessage="OVERDUE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="regVCE_OverDue" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqOverDue">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td width="10%" class="FooterStyle">
                    <asp:Button ID="btnProcess" runat="server" Text="Process"   
                        Style="background-position: left; background-image: url(../Images/textfile.png);
						cursor: pointer; background-repeat: no-repeat; text-align: right; " 
						Width="88px"/>
                </td>
                <td class="FooterStyle">
                    &nbsp;</td>
                <td class="FooterStyle">
                    &nbsp;</td>
                <td class="FooterStyle">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="10%" colspan="4">
                  <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight"
	    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
	    Visible="False" Width="100%"></asp:Label></td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

