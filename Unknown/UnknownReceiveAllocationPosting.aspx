<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="UnknownReceiveAllocationPosting.aspx.vb" Inherits="Unknown_UnknownReceiveAllocationPosting" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:MultiView ID="MultiView_Utama" runat="server"> 
        <asp:view ID="View_View" runat="server" >
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
                    &nbsp;&nbsp;
                </td>
            </tr>
          
            <tr>
                <td style="width: 115px" class="AlternatingRowStyle">
                    Received Txn Date</td>
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
                    <asp:HiddenField ID="hidLocidUN" runat="server" />
                    <asp:HiddenField ID="hidIDUnReceive" runat="server" />
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
                    <hr />
                    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
                </td>
            </tr>
            
        </table>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="UNKNOWNID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Unknown Transaction List for Posting" RowHeaderColumn="UNKNOWNID" 
            AllowSorting="True">
                        <Columns>
                             <asp:TemplateField ShowHeader="False"><ItemTemplate><asp:ImageButton ID="btnView" runat="server" 
                                            CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                                CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/Edit.gif" 
                                                OnCommand="btnView_Command" Enabled="True" /></ItemTemplate><ItemStyle HorizontalAlign="Center" Width="25px" /></asp:TemplateField>
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
            
            
            
            
            
            
            SelectCommand="SELECT PAYUNKNOWN.LOCIDUN, PAYUNKNOWN.UNKNOWNID, PAYUNKNOWN.REFNO, PAYUNKNOWN.TXNDATE, PAYUNKNOWN.VALUEDATE, PAYUNKNOWN.ACCOUNTID, PAYUNKNOWN.AMOUNT, PAYUNKNOWN.REMARK, dbo.f_getParamGlobalName('UNKNOWNSTS', PAYUNKNOWN.UNKNOWNSTS) AS STATUS, BANK.BANKNAME + '-' + BANKACCOUNT.ACCOUNTNO AS BANKNAME, '(' + BRANCH.BRANCHCODE + ')' + BRANCH.BRANCHNAME AS BRANCHNAME, '(' + CURRENCY.CURRENCYCODE + ') ' + CURRENCY.CURRENCYNAME AS CURRENCYNAME FROM PAYUNKNOWN INNER JOIN BANKACCOUNT WITH (NOLOCK) ON PAYUNKNOWN.ACCOUNTID = BANKACCOUNT.ACCOUNTID INNER JOIN BANK WITH (NOLOCK) ON BANKACCOUNT.BANKID = BANK.BANKID LEFT OUTER JOIN CURRENCY WITH (NOLOCK) ON PAYUNKNOWN.CURRENCYID = CURRENCY.CURRENCYID LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON PAYUNKNOWN.BRANCHID = BRANCH.BRANCHID WHERE (PAYUNKNOWN.UNKNOWNSTS = 1) AND EXISTS (SELECT 'X' AS Expr1 FROM PAYUNKNOWNALLOCATE WHERE (PAYUNKNOWN.LOCIDUN = LOCIDUN) AND (PAYUNKNOWN.UNKNOWNID = UNKNOWNID) AND (POSTINGSTS = 0))"></asp:SqlDataSource>
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
            </asp:view>
        <asp:view ID="View_Receive" runat="server" >

                <asp:SqlDataSource ID="sdsUnknownRecApp" runat="server" 
                   ConnectionString="<%$ ConnectionStrings:connection %>" 
                   SelectCommand="SELECT BANKACCOUNT.ACCOUNTID, PAYUNKNOWN.LOCIDUN, PAYUNKNOWN.UNKNOWNID, PAYUNKNOWN.REFNO, PAYUNKNOWN.TXNDATE, PAYUNKNOWN.VALUEDATE, PAYUNKNOWN.AMOUNT, PAYUNKNOWN.REMARK, PAYUNKNOWN.STATUSDATE, BANKACCOUNT.ACCOUNTNO, BANKACCOUNT.ACCOUNTNAME, BANK.BANKNAME, BANKACCOUNT.BANKBRANCH, PAYUNKNOWN.UNKNOWNSTS, (SELECT '(' + CURRENCYCODE + ') ' + CURRENCYNAME AS Expr1 FROM CURRENCY WITH (NOLOCK) WHERE (CURRENCYID = PAYUNKNOWN.CURRENCYID)) AS CURRENCYNM, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, PAYUNKNOWN.BRANCHID FROM BANKACCOUNT WITH (NOLOCK) INNER JOIN BANK WITH (NOLOCK) ON BANKACCOUNT.BANKID = BANK.BANKID INNER JOIN PAYUNKNOWN WITH (NOLOCK) ON BANKACCOUNT.ACCOUNTID = PAYUNKNOWN.ACCOUNTID INNER JOIN BRANCH ON PAYUNKNOWN.BRANCHID = BRANCH.BRANCHID WHERE (PAYUNKNOWN.UNKNOWNID = @UNKNOWNID) AND (PAYUNKNOWN.LOCIDUN = @LOCIDUN)">
                   <SelectParameters>
                       <asp:ControlParameter ControlID="hidIDUnReceive" Name="UNKNOWNID" 
                           PropertyName="Value" />
                       <asp:ControlParameter ControlID="hidLocidUN" Name="LOCIDUN" 
                           PropertyName="Value" />
                   </SelectParameters>
               </asp:SqlDataSource>
               <asp:DataList ID="dlUnReceive" runat="server" Caption="UNKNOWN RECEIVED INFO" 
                   DataKeyField="UNKNOWNID" DataSourceID="sdsUnknownRecApp" Width="100%">
                   <ItemTemplate>
                       <table cellpadding="0" cellspacing="0" width="100%">
                           <tr>
                               <td class="HeaderStyle">
                                   TRANSACTION INFO</td>
                               <td class="FooterStyle" colspan="3">
                                   <hr />
                               </td>
                           </tr>
                           <tr style="display: none">
                               <td class="DetailStyle" width="20%">
                                   Unknown ID</td>
                               <td colspan="3">
                                   <asp:Label ID="lblLocidUn" runat="server" Font-Bold="True" 
                                       Font-Underline="True" Text='<%# Bind("LOCIDUN") %>'></asp:Label>
                                   &nbsp;-
                                   <asp:Label ID="lblUnknownId" runat="server" Font-Bold="True" 
                                       Font-Underline="True" Text='<%# Eval("UNKNOWNID") %>'></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" width="20%">
                                   Transaction Date</td>
                               <td>
                                   <asp:Label ID="lblTransDate" runat="server" Font-Bold="True" 
                                       Font-Underline="True" Text='<%# Bind("TXNDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                               </td>
                               <td>
                                   Value Date</td>
                               <td>
                                   <asp:Label ID="txtDateReceive" runat="server" Font-Bold="True" 
                                       Font-Underline="True" Text='<%# Eval("VALUEDATE", "{0:dd/MM/yyyy}") %>' 
                                       Width="72px"></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" width="20%">
                                   Ref No</td>
                               <td colspan="3">
                                   <asp:Label ID="txtRefNo" runat="server" Font-Bold="True" Font-Underline="True" 
                                       MaxLength="50" Text='<%# Eval("REFNO") %>' ValidationGroup="Receive"></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" width="20%">
                                   Amount</td>
                               <td>
                                   <asp:Label ID="txtAmount" runat="server" Font-Bold="True" Font-Underline="True" 
                                       MaxLength="15" style="text-align:right" Text='<%# Eval("AMOUNT", "{0:N}") %>' 
                                       ValidationGroup="Receive"></asp:Label>
                               </td>
                               <td>
                                   Currency</td>
                               <td>
                                   <asp:Label ID="txtCurrency" runat="server" Font-Bold="True" 
                                       Font-Underline="True" MaxLength="50" Text='<%# Eval("CURRENCYNM") %>' 
                                       ValidationGroup="Receive"></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" valign="top" width="20%">
                                   Description</td>
                               <td colspan="3">
                                   <asp:Label ID="txtDescription" runat="server" Font-Bold="True" 
                                       Font-Underline="True" MaxLength="200" Text='<%# Eval("REMARK") %>' 
                                       Width="300px"></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" valign="top" width="20%">
                                   Branch Entry</td>
                               <td colspan="3">
                                   (<asp:Label ID="Label1" runat="server" 
                                       style="font-weight: 700; text-decoration: underline" 
                                       Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)
                                   <asp:Label ID="Label2" runat="server" 
                                       style="font-weight: 700; text-decoration: underline" 
                                       Text='<%# Eval("BRANCHNAME") %>'></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="HeaderStyle" valign="top" width="20%">
                                   BANK RECEIVED</td>
                               <td class="FooterStyle" colspan="3">
                                   <hr />
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" valign="top" width="20%">
                                   Bank Name</td>
                               <td>
                                   <asp:Label ID="lblBankName" runat="server" Font-Bold="True" 
                                       Font-Underline="True" MaxLength="50" Text='<%# Eval("BANKNAME") %>' 
                                       ValidationGroup="Receive"></asp:Label>
                               </td>
                               <td>
                                   Bank Branch</td>
                               <td>
                                   <asp:Label ID="lblBankBranch" runat="server" Font-Bold="True" 
                                       Font-Underline="True" MaxLength="50" Text='<%# Eval("BANKBRANCH") %>' 
                                       ValidationGroup="Receive"></asp:Label>
                               </td>
                           </tr>
                           <tr>
                               <td class="DetailStyle" valign="top" width="20%">
                                   Account No</td>
                               <td>
                                   <asp:Label ID="lblAccountNo" runat="server" Font-Bold="True" 
                                       Font-Underline="True" MaxLength="50" Text='<%# Eval("ACCOUNTNO") %>' 
                                       ValidationGroup="Receive"></asp:Label>
                               </td>
                               <td>
                                   Account Name</td>
                               <td>
                                   <asp:Label ID="lblAccountName" runat="server" Font-Bold="True" 
                                       Font-Underline="True" MaxLength="50" Text='<%# Eval("ACCOUNTNAME") %>' 
                                       ValidationGroup="Receive"></asp:Label>
                               </td>
                           </tr>
                       </table>
                   </ItemTemplate>
               </asp:DataList>
               <asp:ImageButton ID="btnBack" runat="server" CausesValidation="False" 
                   CommandName="Back" Height="19px" ImageUrl="~/Images/back.png" />
                <br />
               <asp:GridView ID="gvAllocation" runat="server"
                        AutoGenerateColumns="False" DataKeyNames="UNKNOWNID,ALLOCATEID" 
                            DataSourceID="sdsAllocation" Width="100%" ShowFooter="True"
                        Caption="UNKNOWN TRANSACTION LIST" 
                             RowHeaderColumn="UNKNOWNID">
                        <Columns>
                             <asp:TemplateField HeaderText="No.">
                                 <ItemTemplate>
                                     <asp:Label ID="lblNo" runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                 </ItemTemplate>
                                 <ItemStyle HorizontalAlign="Center" Width="25px" />
                             </asp:TemplateField>
                             <asp:TemplateField ShowHeader="False" HeaderText="CHK">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkPosting" runat="server" CausesValidation="False" 
                                        CommandName="Select"
                                         CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                         Visible='<%# Eval("POSTING") %>' />
                                       </ItemTemplate>
                                 <ItemStyle HorizontalAlign="Center" Width="30px" />
                             </asp:TemplateField>
                        
                            <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(formated)" SortExpression="ACCOUNTNO">
                                    <ItemTemplate>
                                        <a href="#" onclick='ViewDetailAcc(<%#eval("LOCID")%>, <%#eval("APPID")%>)'>
                                            <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" Text='<%# eval("ACCOUNTNO") %>'>
                                            </asp:Label>
                                        </a>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="ACCOUNTNAME" 
                                HeaderText="Account Name" SortExpression="ACCOUNTNAME">
                            </asp:BoundField>
                            <asp:BoundField DataField="BTNAME" FooterText="Total"
                                HeaderText="Payment&lt;br&gt;For" SortExpression="BTNAME" 
                                 HtmlEncode="False">
                            </asp:BoundField>
                            <asp:BoundField DataField="AMOUNTALLOCATE" HeaderText="Amount Allocate" 
                                SortExpression="AMOUNTALLOCATE" DataFormatString="{0:n}" >
                            <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POSTINGSTSNAME" HeaderText="Status" 
                                SortExpression="POSTINGSTSNAME" />
                        </Columns>
                           <FooterStyle  Font-Bold="True" HorizontalAlign="Right" />
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsAllocation" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                   
                   
                   
                   
                   
                    SelectCommand="SELECT PAYUNKNOWNALLOCATE.LOCIDUN, PAYUNKNOWNALLOCATE.UNKNOWNID, PAYUNKNOWNALLOCATE.ALLOCATEID, PAYUNKNOWNALLOCATE.LOCID, PAYUNKNOWNALLOCATE.ACCID, PAYUNKNOWNALLOCATE.AMOUNTALLOCATE, PAYUNKNOWNALLOCATE.LOCIDPAY, PAYUNKNOWNALLOCATE.PAYID, PAYUNKNOWNALLOCATE.BTID, dbo.f_getParamGlobalName('POSTINGSTS', PAYUNKNOWNALLOCATE.POSTINGSTS) AS POSTINGSTSNAME, ACCOUNT.ACCOUNTNAME, '(' + BOOKTYPE.BTCODE + ') ' + BOOKTYPE.BTNAME AS BTNAME, BOOKTYPE.BTCODE, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNO, ACCOUNT.APPID, CAST(CASE WHEN PAYUNKNOWNALLOCATE.POSTINGSTS = 1 THEN 0 ELSE 1 END AS BIT) AS POSTING, PAYUNKNOWNALLOCATE.POSTINGSTS FROM PAYUNKNOWNALLOCATE WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON PAYUNKNOWNALLOCATE.LOCID = ACCOUNT.LOCID AND PAYUNKNOWNALLOCATE.ACCID = ACCOUNT.ACCID INNER JOIN BOOKTYPE WITH (NOLOCK) ON PAYUNKNOWNALLOCATE.BTID = BOOKTYPE.BTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (PAYUNKNOWNALLOCATE.LOCIDUN = @LOCIDUN) AND (PAYUNKNOWNALLOCATE.UNKNOWNID = @UNKNOWNID)" >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidLocidUN" Name="LOCIDUN" 
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="hidIDUnReceive" Name="UNKNOWNID" 
                            PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
               
   
               <asp:Label ID="lblMessageDtl" runat="server" CssClass="ErrHighLight" 
                   Font-Bold="False" style="text-align: center" Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessageDtl" runat="server" TargetControlID="lblMessageDtl">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
               
   
          <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="100%" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                        
                            <asp:Button ID="btnPosting" runat="server"
                            Style="font-size: 8pt; cursor: pointer;  
                            background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Posting" ToolTip="Posting" 
                                Width="70px" ValidationGroup="Receive" />
                                                         
                            &nbsp;&nbsp;
                            <br />
                           
                        </td>
			        </tr>
                </table>
            </asp:Panel>
            	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" TargetControlID="pnlControl"
		            VerticalSide="Bottom">
	            </ajaxToolkit:AlwaysVisibleControlExtender>
         </asp:view>
</asp:MultiView>
 <script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">

    FormatTable("<%=gvData.ClientID%>");
    FormatTable("<%=gvAllocation.ClientID%>");

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

    /*
    window.onload = function () {
        Load();
    }
    */
    function ViewDetailAcc(LOCID, APPID) {
        WinRef = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable")
        WinRef.focus();
    }

    function pageLoad(sender, args) {
        if ($find("BehavArea"))
            $find("BehavArea").add_populated(onPopulatedArea);
        if ($find("BehavBranch"))
            $find("BehavBranch").add_populated(onPopulatedBranch);
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


  
</script>
</asp:Content>

