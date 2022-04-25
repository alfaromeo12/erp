<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="UnknownReceive.aspx.vb" Inherits="Unknown_UnknownReceive" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:TextBoxWatermarkExtender ID="TXTWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
      <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="Button1" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" />
    </asp:Panel>
            <asp:CheckBox ID="chkAdd" runat="server" style="display:none" />
    <ajaxToolkit:CollapsiblePanelExtender ID="AjaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px" class="RowStyle">
                    <asp:DropDownList ID="ddlCriteria" runat="server">
                        <asp:ListItem Value="REFNO">Ref No</asp:ListItem>
                        <asp:ListItem Value="BANK.BANKNAME">Bank Name</asp:ListItem>
                        <asp:ListItem Value="BANKACCOUNT.ACCOUNTNO">Account No</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="RowStyle" colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
                    <asp:Button ID="btnFunction" runat="server" CausesValidation="False" 
                        CssClass="Search" 
                        Style="font-size: 8pt; border-top-style: outset; border-right-style: outset; border-left-style: outset; border-bottom-style: outset;" 
                        Text="Search" />
                    &nbsp;&nbsp;&nbsp;</td>
            </tr>
          
            <tr>
                <td style="width: 115px" class="AlternatingRowStyle">
                    Transaction Date</td>
                <td class="AlternatingRowStyle" colspan="3">
                    <asp:RadioButton ID="rdbAllUnknownDate" runat="server" Text="All" 
                        GroupName="AssetDate" Checked="True" />
                    &nbsp;
                    <asp:RadioButton ID="rdbFromUnknownDate" runat="server" Text="From" 
                        GroupName="AssetDate" />
                    &nbsp;
                    <asp:TextBox ID="txtDateStart" runat="server" Width="72px" CssClass="required"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEDateStart" runat="server" Format="dd/MM/yyyy"
                        Enabled="True" PopupButtonID="imgDateStart" TargetControlID="txtDateStart">
                    </ajaxToolkit:CalendarExtender>
                     <ajaxToolkit:MaskedEditExtender ID="MaskedEditStart" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtDateStart">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgDateStart" runat="server" ImageUrl="~/images/grid.gif" 
                        style="cursor: pointer" ToolTip="Calendar" />
                    To
                    &nbsp;
                     <asp:TextBox ID="txtDateEnd" runat="server" Width="72px" CssClass="required"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEDateEnd" runat="server" Format="dd/MM/yyyy"
                        Enabled="True" PopupButtonID="imgDateEnd" TargetControlID="txtDateEnd">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditEnd" runat="server" 
                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                        CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtDateEnd">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgDateEnd" runat="server" ImageUrl="~/images/grid.gif" 
                        style="cursor: pointer" ToolTip="Calendar" />
                    <asp:HiddenField ID="hidAction" runat="server" />
                </td>
            </tr>
            
            <tr>
                <td class="RowStyle">
                    Area</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                        Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownArea" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td class="RowStyle">
                    Branch</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" 
                        BehaviorID="BehavBranch" Category="BRANCH" LoadingText="[Loading Branch...]" 
                        ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownBranchByArea" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlBranchSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle" colspan="4">
                    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
                    <hr />
                </td>
            </tr>
            
        </table>
          <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                CommandName="New" CausesValidation="False" Height="19px" />
                <asp:GridView ID="gvData" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="UNKNOWNID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Unknown Transaction List" RowHeaderColumn="PLEDGEID" 
            AllowSorting="True">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                <ItemStyle HorizontalAlign="Center" Width="2px" />
                            </asp:CommandField>
                            <asp:TemplateField Visible="False"><ItemTemplate><asp:label ID="lblKeyLocid" runat="server" Font-Size="Smaller" Font-Names="Lucida Sans" Visible="false" 
                                                Text='<% #DataBinder.Eval(Container.DataItem,"LOCIDUN") %>' /></ItemTemplate></asp:TemplateField>
                            <asp:BoundField DataField="BANKNAME" HeaderText="Bank ACC.No" 
                                SortExpression="BANKNAME" />
                            <asp:BoundField DataField="REFNO" HeaderText="Ref No" 
                                SortExpression="REFNO" />
                            <asp:BoundField DataField="TXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="Txn&lt;br&gt;Date" HtmlEncode="False" SortExpression="TXNDATE">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VALUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="Receive&lt;br&gt;Date" HtmlEncode="False" 
                                SortExpression="VALUEDATE">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AMOUNT" HeaderText="Amount" 
                                SortExpression="AMOUNT" DataFormatString="{0:n}" >
                            <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENCYNAME" HeaderText="Currency" 
                                SortExpression="CURRENCYNAME" />
                            <asp:BoundField DataField="STATUS" HeaderText="Status" 
                                SortExpression="STATUS" />
                            <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" 
                                SortExpression="BRANCHNAME" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                </asp:GridView>
             <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            
            
            
            
            SelectCommand="SELECT PAYUNKNOWN.LOCIDUN, PAYUNKNOWN.UNKNOWNID, PAYUNKNOWN.REFNO, PAYUNKNOWN.TXNDATE, PAYUNKNOWN.VALUEDATE, PAYUNKNOWN.ACCOUNTID, PAYUNKNOWN.AMOUNT, PAYUNKNOWN.REMARK, dbo.f_getParamGlobalName('UNKNOWNSTS', PAYUNKNOWN.UNKNOWNSTS) AS STATUS, BANK.BANKNAME + '-' + BANKACCOUNT.ACCOUNTNO AS BANKNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME, '(' + CURRENCY.CURRENCYCODE + ') ' + CURRENCY.CURRENCYNAME AS CURRENCYNAME FROM CURRENCY WITH (NOLOCK) RIGHT OUTER JOIN PAYUNKNOWN INNER JOIN BANKACCOUNT WITH (nolock) ON PAYUNKNOWN.ACCOUNTID = BANKACCOUNT.ACCOUNTID INNER JOIN BANK WITH (nolock) ON BANKACCOUNT.BANKID = BANK.BANKID ON CURRENCY.CURRENCYID = PAYUNKNOWN.CURRENCYID RIGHT OUTER JOIN BRANCH WITH (nolock) ON PAYUNKNOWN.BRANCHID = BRANCH.BRANCHID WHERE (PAYUNKNOWN.UNKNOWNSTS = 0)"></asp:SqlDataSource>
    </asp:Panel>
              <asp:Label ID="lblMessage" runat="server" Width="100%" Font-Bold="False" 
            style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
       <asp:Panel ID="pnlUnknownData" runat="server"  
                Width="100%" >
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                 <tr  id="rowReqlocid" style="display:none">
                    <td width="20%" class="HeaderStyle">
                        Unkown ID</td>
                    <td class="HeaderStyle" >
                        <asp:Label ID="lbllocidUn" runat="server" Font-Bold="True" 
                            Font-Underline="True"></asp:Label>
                        &nbsp;-
                        <asp:Label ID="lblUnknownId" runat="server" Font-Bold="True" 
                            Font-Underline="True"></asp:Label>
                    </td>
                </tr>  
                <tr>
                    <td width="20%" class="ErrHighLight">
                        Transaction Date</td>
                    <td class="ErrHighLight">
                        <asp:Label ID="lblTransDate" runat="server" 
                            Text='<%# Bind("TXNDATE", "{0:d}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="FooterStyle">
                        Value/Receive Date</td>
                    <td class="FooterStyle">
                        <asp:TextBox ID="txtDateReceive" runat="server"  CssClass="required"
                            Width="72px" ValidationGroup="Receive" ></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="ajaxCEDateReceive" runat="server" Enabled="True" 
                            Format="dd/MM/yyyy" PopupButtonID="imgDateReceive" TargetControlID="txtDateReceive">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditReceived" runat="server" 
                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtDateReceive">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgDateReceive" runat="server" ImageUrl="~/images/grid.gif" 
                            style="cursor: pointer" ToolTip="Calendar" Width="16px" />
                        <asp:RequiredFieldValidator ID="reqReceiveDt" runat="server" 
                            ControlToValidate="txtDateReceive" Display="None" 
                            ErrorMessage="[RECEIVE DATE] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Receive"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqReceiveDt_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqReceiveDt">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="FooterStyle">
                        Account No</td>
                    <td class="FooterStyle">
                      
                          <asp:DropDownList ID="ddlAccountNo" runat="server" CssClass="required">
                          </asp:DropDownList>
                          <ajaxToolkit:CascadingDropDown ID="ajaxCCDBankAcc" runat="server" 
                              BehaviorID="BehavBankAccNo" Category="BankAccNo" 
                              LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                              ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                              ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountNo">
                          </ajaxToolkit:CascadingDropDown>
                        <asp:RequiredFieldValidator ID="reqAccountNo" runat="server" 
                            ControlToValidate="ddlAccountNo" Display="None" 
                            ErrorMessage="[RECEIVE DATE] must be entry...!" SetFocusOnError="True" 
                              ValidationGroup="Receive"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqAccountNo_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccountNo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle" width="20%">
                        Currency</td>
                    <td class="FooterStyle">
                        <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="required" 
                            DataSourceID="sdsCurrency" DataTextField="CURRENCYNAME" 
                            DataValueField="CURRENCYID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCurrency" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            SelectCommand="SELECT CURRENCYID, CURRENCYCODE, CURRENCYCODE + ' - ' + CURRENCYNAME AS CURRENCYNAME FROM CURRENCY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CURRENCYCODE">
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="reqCurrency" runat="server" 
                            ControlToValidate="ddlCurrency" Display="None" 
                            ErrorMessage="[CURRENCY] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCurrency_ValidatorCalloutExtender" 
                            runat="server" Enabled="True" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqCurrency">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="FooterStyle">
                        Ref No</td>
                    <td class="FooterStyle">
                        <asp:TextBox ID="txtRefNo" runat="server" CssClass="required" 
                             MaxLength="50" ValidationGroup="Receive" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqRefNo" runat="server" 
                            ControlToValidate="txtRefNo" Display="None" 
                            ErrorMessage="[REFNO] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Receive"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName0" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqRefNo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="FooterStyle">
                        Amount</td>
                    <td class="FooterStyle">
                        <asp:TextBox ID="txtAmount"  runat="server" CssClass="required" style="text-align:right"
                             MaxLength="15" ValidationGroup="Receive"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqAmount" runat="server" 
                            ControlToValidate="txtAmount" Display="None" 
                            ErrorMessage="[AMOUNT] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Receive"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqAmount_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAmount">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td valign="top" width="20%" class="FooterStyle">
                        Description</td>
                    <td class="FooterStyle">
                        <asp:TextBox ID="txtDescription" runat="server" Rows="3" TextMode="MultiLine" 
                            Width="300px" MaxLength="200"></asp:TextBox>
                    </td>
                </tr>
                                 
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                    <tr>
                    <td colspan="2" class="FooterStyle">
                                          
                    </td>
                </tr>
            </table>
    </asp:Panel>
      <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="100%" Visible="false" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                        
                            <asp:Button ID="btnSave" runat="server"
                            Style="font-size: 8pt; cursor: pointer;  
                            background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="70px" ValidationGroup="Receive" />
                            &nbsp;&nbsp;
                             <asp:Button ID="btnDelete" runat="server"
                            Style="font-size: 8pt; cursor: pointer;  
                            background-position: left; background-image: url(../images/Delete.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete" 
                                Width="70px" />
                            &nbsp;&nbsp;
                            <asp:Button ID="btnCancel" runat="server"
                            Style="font-size: 8pt; cursor: pointer;  
                            background-position: left; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Cancel" Width="70px" ToolTip="Cancel" />
                            <br />
                           
                        </td>
			        </tr>
                </table>
            </asp:Panel>
            	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" TargetControlID="pnlControl"
		            VerticalSide="Bottom">
	            </ajaxToolkit:AlwaysVisibleControlExtender>
 <script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">

    FormatTable("<%=gvData.ClientID%>");
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }

    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }

    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }


    function pageLoad(sender, args) {
        $find("BehavArea").add_populated(onPopulatedArea);
        $find("BehavBranch").add_populated(onPopulatedBranch);
        Load();
    }

    function onPopulatedArea() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlAreaSearch.ClientID%>").disabled = true;
        }
    }

    function onPopulatedBranch() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlBranchSearch.ClientID%>").disabled = true;
        }
    }

    /*
    window.onload = function () {
        $find("BehavArea").add_populated(onPopulatedArea);
        $find("BehavBranch").add_populated(onPopulatedBranch);
        Load();
    }
    */
    function Load() {
        var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
        var rowLocid = getObjectbyClientID("rowReqlocid");

        if (Action == "NEW") {
            if (rowLocid)
                rowLocid.style.display = "none";
        }
        if (Action == "EDIT") {
            if (rowLocid)
                rowLocid.style.display = "";
        }

    }
</script>
</asp:Content>

