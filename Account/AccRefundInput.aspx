<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccRefundInput.aspx.vb" Inherits="Txn_AccRefundInput" title="Account Refund Input" EnableEventValidation="FALSE" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="nodatafound" tagprefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="dataaccountfromparamaccid" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollateralDataFromAccID.ascx" tagname="CollateralDataFromAccID" tagprefix="uc5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
	<asp:HiddenField ID="hidDisburseSts" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />

    <asp:HiddenField ID="txtAppDate" runat="server" />

    
                            <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Style="text-align: center" Visible="False" Width="100%"></asp:Label>
    <asp:MultiView ID="mvAction" runat="server">
        <asp:View ID="vSearch" runat="server">
            <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
                </div>
                <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" />
            </asp:Panel>
            <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" 
                Width="99%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlCriteria" runat="server">
                                <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
                                <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
                                <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
                                <asp:ListItem Value="DEALER.DEALERNAME">Dealer Name</asp:ListItem>
                                <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
                                <asp:ListItem Value="DEALERPERSON.PERSONNAME">PERSON NAME</asp:ListItem>
                                <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
                                <asp:ListItem Value="COLLATERAL.BPKBNO">Object/BPKB No</asp:ListItem>
                                <asp:ListItem Value="COLLATERAL.POLICENO">Police No.</asp:ListItem>
                                <asp:ListItem Value="COLLATERAL.ENGINENO">Engine No.</asp:ListItem>
                                <asp:ListItem Value="COLLATERAL.CHASSISNO">Chassis No.</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                            <asp:Button ID="btnFunctionSearch" runat="server" CssClass="Search" 
                                Text="Search" />
                            <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" 
                                TargetControlID="txtSearch" WatermarkText="%%">
                            </ajaxToolkit:TextBoxWatermarkExtender>
                        </td>
                    </tr>
                    <tr ID="trPlan">
                        <td>
                            Plan Paid Date</td>
                        <td colspan="3">
                            <asp:RadioButton ID="rbPlanAll" runat="server" GroupName="rbPlan" Text="All" />
                            <asp:RadioButton ID="rbPlanDate" runat="server" GroupName="rbPlan" 
                                Text="From" />
                            <asp:TextBox ID="txtPlanFrom" runat="server" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgPlanFrom" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            To
                            <asp:TextBox ID="txtPlanTo" runat="server" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgPlanTo" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPlanFrom" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgPlanFrom" TargetControlID="txtPlanFrom">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPlanTo" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgPlanTo" TargetControlID="txtPlanTo">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEPlanFrom" runat="server" Mask="99/99/9999" 
                                MaskType="Date" TargetControlID="txtPlanFrom">
                            </ajaxToolkit:MaskedEditExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEPlanTo" runat="server" Mask="99/99/9999" 
                                MaskType="Date" TargetControlID="txtPlanTo">
                            </ajaxToolkit:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr ID="trTxn">
                        <td>
                            Paid Txn Date</td>
                        <td colspan="3">
                            <asp:RadioButton ID="rbTxnAll" runat="server" GroupName="rbTxn" Text="All" />
                            <asp:RadioButton ID="rbTxnDate" runat="server" GroupName="rbTxn" Text="From" />
                            <asp:TextBox ID="txtTxnFrom" runat="server" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgTxnFrom" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            To
                            <asp:TextBox ID="txtTxnTo" runat="server" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgTxnTo" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCETxnFrom" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgTxnFrom" TargetControlID="txtTxnFrom">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:CalendarExtender ID="ajaxCETxnTo" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgTxnTo" TargetControlID="txtTxnTo">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnFrom" runat="server" Mask="99/99/9999" 
                                MaskType="Date" TargetControlID="txtBookFrom">
                            </ajaxToolkit:MaskedEditExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnTo" runat="server" Enabled="True" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtTxnTo">
                            </ajaxToolkit:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Booking Date</td>
                        <td colspan="3">
                            <asp:RadioButton ID="rbBookAll" runat="server" GroupName="rbBook" Text="All" />
                            <asp:RadioButton ID="rbBookFrom" runat="server" GroupName="rbBook" 
                                Text="From" />
                            <asp:TextBox ID="txtBookFrom" runat="server" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp; To
                            <asp:TextBox ID="txtBookTo" runat="server" Width="72px"></asp:TextBox>
                            <asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgBookFrom" TargetControlID="txtBookFrom">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgBookTo" TargetControlID="txtBookTo">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" 
                                MaskType="Date" TargetControlID="txtBookFrom">
                            </ajaxToolkit:MaskedEditExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" 
                                MaskType="Date" TargetControlID="txtBookTo">
                            </ajaxToolkit:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Area</td>
                        <td>
                            <asp:DropDownList ID="ddlAreaSearch" runat="server">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                                Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                                ServiceMethod="GetDropDownAreabyAppUserBranch" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch">
                            </ajaxToolkit:CascadingDropDown>
                        </td>
                        <td>
                            Branch</td>
                        <td>
                            <asp:DropDownList ID="ddlBranchSearch" runat="server">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" 
                                BehaviorID="BehavBranch" Category="BRANCH" LoadingText="[Loading Branch...]" 
                                ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" 
                                ServiceMethod="GetDropDownBranchByAppUserBranch" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch">
                            </ajaxToolkit:CascadingDropDown>
                        </td>
                    </tr>
                    <tr ID="trDealer">
                        <td>
                            Dealer</td>
                        <td>
                            <asp:DropDownList ID="ddlDealer" runat="server" DataSourceID="sdsDealer" 
                                DataTextField="DEALERNAME" DataValueField="DEALERID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsDealer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS DEALERID, NULL AS DEALERCODE, '[DISPLAY ALL]' AS DEALERNAME UNION ALL SELECT DEALERID, DEALERCODE, DEALERNAME + ' (' + DEALERCODE + ')' AS DEALERNAME FROM DEALER WITH (NOLOCK) WHERE EXISTS (SELECT REFUNDTRX.REFUNDTRXID FROM ACCOUNT WITH (NOLOCK) INNER JOIN REFUNDTRX WITH (NOLOCK) ON ACCOUNT.LOCID = REFUNDTRX.LOCID AND ACCOUNT.ACCID = REFUNDTRX.ACCID INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID WHERE (COLLATERAL.DEALERID = DEALER.DEALERID) AND (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (REFUNDTRX.INCLUDEDISBURSE = 0) AND (REFUNDTRX.REFUNDSTS = @REFUNDSTS)) ORDER BY DEALERNAME">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidDisburseSts" Name="REFUNDSTS" 
                                        PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr ID="trCollSts">
                        <td>
                            Collateral Status</td>
                        <td>
                            <asp:RadioButton ID="rbReceive" runat="server" GroupName="rbCollSts" 
                                Text="Receive Only" />
                            &nbsp;<asp:RadioButton ID="rbAll" runat="server" GroupName="rbCollSts" 
                                Text="All Status" />
                        </td>
                        <td>
                            Collateral&nbsp; Condition</td>
                        <td>
                            <asp:DropDownList ID="ddlCondition" runat="server" DataSourceID="sdsCondition" 
                                DataTextField="NAME" DataValueField="CODE">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsCondition" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblStatus" runat="server" Text="Refund Status" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStatusSearch" runat="server" DataSourceID="sdsStatus" 
                                DataTextField="DISBURSESTS" DataValueField="CODE" Visible="False">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsStatus" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS DISBURSESTS UNION ALL SELECT CODE, CODE + ' - ' + NAME AS DISBURSESTS FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'REFUNDSTS')">
                            </asp:SqlDataSource>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Finance Category</td>
                        <td>
                            <asp:DropDownList ID="ddlFinanceCategory" runat="server">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCCDFincat" runat="server" 
                                BehaviorID="BehavFinCat" Category="FINCAT" 
                                LoadingText="[Loading Finance Category ...]" PromptText="[DISPLAY ALL]" 
                                ServiceMethod="GetDropDownFinCatbyAppUserBranch" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinanceCategory">
                            </ajaxToolkit:CascadingDropDown>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="Account Refund List" 
                DataKeyNames="LOCID,ACCID,REFUNDTRXID,DEALERID" DataSourceID="sdsGrid" 
                Width="99%">
                <Columns>
                    <asp:TemplateField HeaderText="CHK">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkBox" runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                    </asp:CommandField>
                    <asp:TemplateField HeaderText="JRN">
                        <ItemTemplate>
                            <img src="../Images/journal.gif" onclick='ShowJournal("<%#eval("JOURNALREFNO")%>")' alt='Show Journal' style='cursor: pointer; visibility:<%#eval("ShowJournal")%>;' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                        SortExpression="ACCNO">
                        <ItemTemplate>
                            <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                            <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" 
                                Text='<%# eval("ACCNO") %>'></asp:Label>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                        SortExpression="BOOKINGDATE" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                        SortExpression="BRANCH" />
                    <asp:BoundField DataField="DEALERNAME" HeaderText="Dealer" 
                        SortExpression="DEALERNAME" />
                    <asp:BoundField DataField="REFUNDSTSNAME" HeaderText="Refund&lt;br&gt;Status" 
                        HtmlEncode="False" SortExpression="REFUNDSTSNAME" />
                    <asp:BoundField DataField="DISBURSESTSNAME" 
                        HeaderText="Disburse&lt;br&gt;Status" HtmlEncode="False" 
                        SortExpression="DISBURSESTSNAME" />
                    <asp:BoundField DataField="REFUNDCATEGORYNAME" 
                        HeaderText="Refund&lt;br&gt;Category" HtmlEncode="False" 
                        SortExpression="REFUNDCATEGORYNAME" />
                    <asp:BoundField DataField="PERSONNAME" HeaderText="Dealer&lt;br&gt;Person" 
                        HtmlEncode="False" SortExpression="PERSONNAME" />
                    <asp:BoundField DataField="PERSONTITLENAME" HeaderText="Person&lt;br&gt;Title" 
                        HtmlEncode="False" SortExpression="PERSONTITLENAME" />
                    <asp:BoundField DataField="REFUND" DataFormatString="{0:N}" 
                        HeaderText="Refund&lt;br&gt;Amount" HtmlEncode="False" SortExpression="REFUND">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BPKBNO" HeaderText="Collateral&lt;br&gt;No." 
                        HtmlEncode="False" SortExpression="BPKBNO" />
                    <asp:BoundField DataField="POLICENO" HeaderText="Police&lt;br&gt;No." 
                        HtmlEncode="False" SortExpression="POLICENO" />
                    <asp:BoundField DataField="BPKBSTATUSNAME" 
                        HeaderText="Collateral&lt;br&gt;Status" HtmlEncode="False" 
                        SortExpression="BPKBSTATUSNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGrid" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                
                
                
                
                SelectCommand="SELECT TOP (500) REFUNDTRX.LOCID, REFUNDTRX.ACCID, REFUNDTRX.REFUNDTRXID, ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + CAST(ACCOUNT.DISBURSESTS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('DISBURSESTS', ACCOUNT.DISBURSESTS) AS DISBURSESTSNAME, ACCOUNT.DISBURSESTS, DEALER.DEALERNAME, COLLATERAL.POLICENO, COLLATERAL.BPKBNO, dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, dbo.f_getREFUNDTRXByAccID(ACCOUNT.LOCID, ACCOUNT.ACCID, 0) AS REFUND, dbo.f_getParamGlobalName('REFUNDSTS', REFUNDTRX.REFUNDSTS) AS REFUNDSTSNAME, REFUNDTRX.REFUNDSTS, dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUNDTRX.REFUNDCATEGORY) AS REFUNDCATEGORYNAME, DEALERPERSON.PERSONNAME, dbo.f_getParamGlobalName('PERSONTITLE', DEALERPERSON.PERSONTITLE) AS PERSONTITLENAME, REFUNDTRX.DEALERID, CAST(ACCOUNT.LOCID AS VARCHAR(20)) + '-' + CAST(ACCOUNT.ACCID AS VARCHAR(30)) + '-' + CAST(REFUNDTRX.REFUNDTRXID AS VARCHAR(20)) AS JOURNALREFNO, CASE WHEN REFUNDSTS = 2 THEN 'visible' ELSE 'hidden' END AS ShowJournal FROM ACCOUNT WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN COLLATERAL WITH (NOLOCK) ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID INNER JOIN DEALER WITH (nolock) ON COLLATERAL.DEALERID = DEALER.DEALERID INNER JOIN REFUNDTRX WITH (NOLOCK) ON ACCOUNT.LOCID = REFUNDTRX.LOCID AND ACCOUNT.ACCID = REFUNDTRX.ACCID INNER JOIN DEALERPERSON WITH (NOLOCK) ON REFUNDTRX.PERSONID = DEALERPERSON.PERSONID WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (REFUNDTRX.Deletests = 0) AND (REFUNDTRX.INCLUDEDISBURSE = 0)">
            </asp:SqlDataSource>
            <asp:Panel ID="pnlProcess" runat="server" Width="100%">
                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td class="HeaderStyle" style="width: 60px" width="30px">
                            <asp:CheckBox ID="chkAll" runat="server" />
                        </td>
                        <td class="ShowDetail" width="100%">
                            Plan Paid Date :
                            <asp:TextBox ID="txtPlanPaidDate" runat="server" CssClass="required" 
                                Width="72px" ValidationGroup="ValSave"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="txtPlanPaidDate_CalendarExtender" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgVisitDateTo" 
                                TargetControlID="txtPlanPaidDate">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="txtPlanPaidDate_MaskedEditExtender" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtPlanPaidDate">
                            </ajaxToolkit:MaskedEditExtender>
                            <asp:Image ID="imgVisitDateTo" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;<asp:RequiredFieldValidator ID="reqPlanPaidDate" runat="server" 
                                ControlToValidate="txtPlanPaidDate" Display="None" 
                                ErrorMessage="[SET PLAN PAID DATE] must be entry...!" 
                                SetFocusOnError="True" ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqPlanPaidDate_ValidatorCalloutExtender" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqPlanPaidDate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            <asp:Button ID="btnSave" runat="server" 
                                Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
                                Text="Save" ValidationGroup="ValSave" Width="88px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxVCEProcess" runat="server" 
                Enabled="True" TargetControlID="pnlProcess" VerticalSide="Bottom">
            </ajaxToolkit:AlwaysVisibleControlExtender>
            <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" 
                CollapseControlID="pnlShow" CollapsedImage="~/images/expand.jpg" 
                CollapsedText="(Show Search Criteria...)" Enabled="True" 
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" 
                ExpandedText="(Hide Search Criteria...)" ImageControlID="imgButtonShow" 
                TargetControlID="pnlData" TextLabelID="lblShow">
            </ajaxToolkit:CollapsiblePanelExtender>
        </asp:View>
        <asp:View ID="vAction" runat="server">
            <asp:HiddenField ID="hidLOCID" runat="server" />
            <asp:HiddenField ID="hidACCID" runat="server" />
            <asp:HiddenField ID="hidDEALERID" runat="server" />
            <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
                </div>
                <input id="Button1" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" />
            </asp:Panel>
            <asp:Panel ID="pnlAccData" runat="server" Width="100%">
                <uc2:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
                    runat="server" />
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAccData" runat="server" 
                CollapseControlID="pnlAccShow" CollapsedImage="~/images/expand.jpg" 
                CollapsedText="(Show Account Data...)" Enabled="True" 
                ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" 
                ExpandedText="(Hide Account Data...)" ImageControlID="imgAccData" 
                TargetControlID="pnlAccData" TextLabelID="lblAccData">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" 
                Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgCollateral" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblCollateral" runat="server" CssClass="required">(Show Collateral Data...)</asp:Label>
                </div>
                <input id="Button6" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" />
            </asp:Panel>
            <asp:Panel ID="pnlCollateral" runat="server" Width="100%">
                <uc5:CollateralDataFromAccID ID="ctlCollateralDataFromAccID" runat="server" />
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnlCollateral_CollapsiblePanelExtender" runat="server" 
                CollapseControlID="pnlCollateralShow" CollapsedImage="~/images/expand.jpg" 
                CollapsedText="(Show Collateral Data...)" Enabled="True" 
                ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg" 
                ExpandedText="(Hide Collateral Data...)" ImageControlID="imgCollateral" 
                TargetControlID="pnlCollateral" TextLabelID="lblLoanData">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel ID="pnlDealerShow" runat="server" CssClass="ShowDetail" Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgDealer" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblDealer" runat="server" CssClass="required">(Show Dealer Info...)</asp:Label>
                </div>
                <input id="Button7" noenter="" style="background-position: left top; width: 24px;
			cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" />
            </asp:Panel>
            <asp:Panel ID="pnlDealer" runat="server"  Width="100%">
                <asp:DataList ID="dlDealerInfo" runat="server" Caption="DEALER INFO" 
                    DataKeyField="DEALERID" DataSourceID="sdsDealerInfo" Width="100%">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                            <tr>
                                <td>
                                    Dealer ID</td>
                                <td>
                                    <asp:Label ID="DEALERIDLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("DEALERID") %>' />
                                </td>
                                <td>
                                    Dealer Code</td>
                                <td>
                                    <asp:Label ID="DEALERCODELabel" runat="server" 
                                        style="text-decoration: underline; font-weight: 700;" 
                                        Text='<%# Eval("DEALERCODE") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Dealer Name</td>
                                <td colspan="3">
                                    <asp:Label ID="DEALERNAMELabel" runat="server" 
                                        style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("DEALERNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Main Dealer</td>
                                <td colspan="3">
                                    (<asp:Label ID="DEALERMAINCODELabel" runat="server" 
                                        style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("DEALERMAINCODE") %>' />)
                                    <asp:Label ID="DEALERMAINNAMELabel" runat="server" 
                                        style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("DEALERMAINNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address</td>
                                <td colspan="3">
                                    <asp:Label ID="ADDRESSLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("ADDRESS") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    City</td>
                                <td>
                                    <asp:Label ID="CITYNAMELabel" runat="server" style="text-decoration: underline; font-weight: 700;" 
                                        Text='<%# Eval("CITYNAME") %>' />
                                </td>
                                <td>
                                    Zip</td>
                                <td>
                                    <asp:Label ID="ZIPLabel" runat="server" style="text-decoration: underline" 
                                        Text='<%# Eval("ZIP") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Phone</td>
                                <td>
                                    <asp:Label ID="PHONEAREALabel" runat="server" 
                                        style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("PHONEAREA") %>' />
                                    &nbsp;<asp:Label ID="PHONELabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("PHONE") %>' />
                                </td>
                                <td>
                                    Fax</td>
                                <td>
                                    <asp:Label ID="FAXAREALabel" runat="server" style="text-decoration: underline" 
                                        Text='<%# Eval("FAXAREA") %>' />
                                    &nbsp;<asp:Label ID="FAXLabel" runat="server" style="text-decoration: underline" 
                                        Text='<%# Eval("FAX") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Email</td>
                                <td>
                                    <asp:Label ID="EMAILLabel" runat="server" style="text-decoration: underline; font-weight: bold;" 
                                        Text='<%# Eval("EMAIL") %>' />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        <asp:SqlDataSource ID="sdsDealerAccount" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            SelectCommand="SELECT BANK.BANKNAME, DEALERACCOUNT.ACCBANKBRANCH, DEALERACCOUNT.ACCNO, DEALERACCOUNT.ACCNAME, dbo.f_getParamGlobalName('BANKACCSTATUS', DEALERACCOUNT.BANKACCSTATUS) AS BANKACCSTATUS FROM DEALERACCOUNT WITH (nolock) INNER JOIN BANK WITH (nolock) ON DEALERACCOUNT.ACCBANKID = BANK.BANKID WHERE (DEALERACCOUNT.Deletests = 0) AND (DEALERACCOUNT.DEALERID = @DEALERID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hidDealerID" Name="DEALERID" 
                                    PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsDealerInfo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT DEALER.DEALERID, DEALER.DEALERCODE, DEALER.DEALERNAME, DEALERMAIN.DEALERMAINCODE, DEALERMAIN.DEALERMAINNAME, DEALER.ADDRESS, CITY.CITYCODE, CITY.CITYNAME, DEALER.ZIP, DEALER.PHONEAREA, DEALER.PHONE, DEALER.FAXAREA, DEALER.FAX, DEALER.EMAIL FROM DEALER WITH (NOLOCK) INNER JOIN DEALERMAIN WITH (NOLOCK) ON DEALER.DEALERMAINID = DEALERMAIN.DEALERMAINID LEFT OUTER JOIN CITY WITH (NOLOCK) ON DEALER.CITYID = CITY.CITYID WHERE (DEALER.DEALERID = @DEALERID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidDealerID" Name="DEALERID" 
                            PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnlDealer_CollapsiblePanelExtender" 
                runat="server" CollapseControlID="pnlDealerShow" 
                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Dealer Info...)" 
                Enabled="True" ExpandControlID="pnlDealerShow" 
                ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Dealer Info...)" 
                ImageControlID="imgDealer" TargetControlID="pnlDealer" TextLabelID="lblDealer">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel ID="pnlINIT" runat="server" Width="100%">
                <asp:GridView ID="gvRefund" runat="server" AutoGenerateColumns="False" 
                    Caption="DEALER REFUND LIST" DataKeyNames="REFUNDTRXID,LOCID,ACCID,PERSONID" 
                    DataSourceID="sdsRefund" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="CHK">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkBox" runat="server" Checked='<%# Eval("CHECKED") %>' 
                                    Enabled='<%# Eval("VISIBLE") %>' />
                                <asp:HiddenField ID="hidREFUNDSTS" runat="server" 
                                    Value='<%# Eval("REFUNDSTS") %>' />
                                <asp:HiddenField ID="hidREFUNDTRXID" runat="server" 
                                    Value='<%# Eval("REFUNDTRXID") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="PERSONNAME" HeaderText="Person&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="PERSONNAME" />
                        <asp:BoundField DataField="PERSONTITLENAME" HeaderText="Person&lt;br&gt;Title" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="PERSONTITLENAME" />
                        <asp:BoundField DataField="REFUNDCATEGORYNAME" 
                            HeaderText="Refund&lt;br&gt;Category" HtmlEncode="False" 
                            SortExpression="REFUNDCATEGORYNAME" />
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" CssClass="required" 
                                    Enabled='<%# Eval("VISIBLE") %>' Style="text-align: right" 
                                    Text='<%# Eval("AMOUNT", "{0:N}") %>' Width="120px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqAmount" runat="server" 
                                    ControlToValidate="txtAmount" Display="None" 
                                    ErrorMessage="[AMOUNT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="reqAmount_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" HighlightCssClass="ErrHighLight" 
                                    TargetControlID="reqAmount">
                                </ajaxToolkit:ValidatorCalloutExtender>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Person&lt;br&gt;Account">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlDealerPersonAccount" runat="server" 
                                    CssClass="required" DataTextField="BANKACCNO" DataValueField="PERSONACCOUNTID">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="REFUNDSTSNAME" HeaderText="Refund&lt;br&gt;Status" 
                            HtmlEncode="False" SortExpression="REFUNDSTSNAME" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc1:nodatafound ID="nodatafound2" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRefund" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT REFUNDTRX.REFUNDTRXID, REFUNDTRX.LOCID, REFUNDTRX.ACCID, REFUNDTRX.PERSONID, DEALERPERSON.PERSONNAME, REFUNDTRX.AMOUNT, dbo.f_getParamGlobalName('PERSONTITLE', DEALERPERSON.PERSONTITLE) AS PERSONTITLENAME, '(' + CAST(REFUNDTRX.REFUNDCATEGORY AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUNDTRX.REFUNDCATEGORY) AS REFUNDCATEGORYNAME, '(' + CAST(REFUNDTRX.REFUNDSTS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('REFUNDSTS', REFUNDTRX.REFUNDSTS) AS REFUNDSTSNAME, CAST(CASE WHEN @REFUNDTRXID = REFUNDTRXID OR REFUNDSTS &lt;&gt; 0 THEN 1 ELSE 0 END AS BIT) AS CHECKED, REFUNDTRX.REFUNDSTS, CAST(CASE WHEN REFUNDSTS = 0 THEN 1 ELSE 0 END AS BIT) AS VISIBLE, (SELECT PERSONACCOUNTID FROM DEALERPERSONACCOUNT WHERE (PERSONACCOUNTID = REFUNDTRX.PERSONACCOUNTID)) AS PERSONACCOUNTID FROM REFUNDTRX INNER JOIN DEALERPERSON ON REFUNDTRX.PERSONID = DEALERPERSON.PERSONID WHERE (REFUNDTRX.LOCID = @LOCID) AND (REFUNDTRX.ACCID = @ACCID) AND (REFUNDTRX.INCLUDEDISBURSE = 0) AND (REFUNDTRX.Deletests = 0)">
                    <SelectParameters>
                        <asp:Parameter Name="REFUNDTRXID" />
                        <asp:Parameter Name="LOCID" />
                        <asp:Parameter Name="ACCID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td class="ShowDetail" width="100%">
                            Plan Paid Date :
                            <asp:TextBox ID="txtPlanPaidDateAcc" runat="server" CssClass="required" 
                                Width="72px" ValidationGroup="ValSave"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPlanPaidAcc" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgPlanPaidDate" 
                                TargetControlID="txtPlanPaidDateAcc">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEPlanPaidAcc" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtPlanPaidDateAcc">
                            </ajaxToolkit:MaskedEditExtender>
                            <asp:Image ID="imgPlanPaidDate" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;<asp:RequiredFieldValidator ID="reqPlanPaidDateAcc" runat="server" 
                                ControlToValidate="txtPlanPaidDateAcc" Display="None" 
                                ErrorMessage="[PLAN PAID DATE] must be entry...!" 
                                SetFocusOnError="True" ValidationGroup="ValSave"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPlanPaidAcc" 
                                runat="server" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqPlanPaidDate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            <asp:Button ID="btnSaveAcc" runat="server" 
                                Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
                                Text="Save" ValidationGroup="ValSave" Width="88px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlApp" runat="server" Width="100%">
                <asp:GridView ID="gvRefundApp" runat="server" AutoGenerateColumns="False" 
                    Caption="APPROVAL DEALER REFUND LIST" 
                    DataKeyNames="REFUNDTRXID,LOCID,ACCID,PERSONID" DataSourceID="sdsRefundApp" 
                    Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="CHK">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkBoxApp" runat="server" Checked='<%# Eval("CHECKED") %>' 
                                    Enabled='<%# Eval("VISIBLE") %>' Visible='<%# Eval("VISIBLE") %>' />
                                <asp:HiddenField ID="hidREFUNDSTSApp" runat="server" 
                                    Value='<%# Eval("REFUNDSTS") %>' />
                                <asp:HiddenField ID="hidREFUNDTRXIDApp" runat="server" 
                                    Value='<%# Eval("REFUNDTRXID") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="PLANPAIDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Plan&lt;br&gt;Paid Date" HtmlEncode="False" 
                            SortExpression="PLANPAIDDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PERSONNAME" HeaderText="Person&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="PERSONNAME" />
                        <asp:BoundField DataField="PERSONTITLENAME" HeaderText="Person&lt;br&gt;Title" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="PERSONTITLENAME" />
                        <asp:BoundField DataField="REFUNDCATEGORYNAME" 
                            HeaderText="Refund&lt;br&gt;Category" HtmlEncode="False" 
                            SortExpression="REFUNDCATEGORYNAME" />
                        <asp:BoundField DataField="AMOUNT" DataFormatString="{0:N}" 
                            HeaderText="Refund&lt;br&gt;Amount" HtmlEncode="False" SortExpression="AMOUNT">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Person&lt;br&gt;Account">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlDealerPersonAccountApp" runat="server" 
                                    CssClass="required" DataTextField="BANKACCNO" DataValueField="PERSONACCOUNTID">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="REFUNDSTSNAME" HeaderText="Refund&lt;br&gt;Status" 
                            HtmlEncode="False" SortExpression="REFUNDSTSNAME" />
                        <asp:BoundField DataField="PAIDSTSNAME" HeaderText="Paid&lt;br&gt;Sts" 
                            HtmlEncode="False" SortExpression="PAIDSTSNAME">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc1:nodatafound ID="nodatafound4" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRefundApp" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    SelectCommand="SELECT REFUNDTRX.REFUNDTRXID, REFUNDTRX.LOCID, REFUNDTRX.ACCID, REFUNDTRX.PERSONID, DEALERPERSON.PERSONNAME, REFUNDTRX.AMOUNT, dbo.f_getParamGlobalName('PERSONTITLE', DEALERPERSON.PERSONTITLE) AS PERSONTITLENAME, '(' + CAST(REFUNDTRX.REFUNDCATEGORY AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUNDTRX.REFUNDCATEGORY) AS REFUNDCATEGORYNAME, '(' + CAST(REFUNDTRX.REFUNDSTS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('REFUNDSTS', REFUNDTRX.REFUNDSTS) AS REFUNDSTSNAME, CAST(CASE WHEN @REFUNDTRXID = REFUNDTRXID OR REFUNDSTS NOT IN (0 , 1) THEN 1 ELSE 0 END AS BIT) AS CHECKED, REFUNDTRX.REFUNDSTS, CAST(CASE WHEN REFUNDSTS = 1 THEN 1 ELSE 0 END AS BIT) AS VISIBLE, (SELECT PERSONACCOUNTID FROM DEALERPERSONACCOUNT WHERE (PERSONACCOUNTID = REFUNDTRX.PERSONACCOUNTID)) AS PERSONACCOUNTID, REFUNDTRX.PLANPAIDDATE, CASE WHEN REFUNDTRX.PAIDSTS = 1 THEN 'YES' ELSE 'NO' END AS PAIDSTSNAME FROM REFUNDTRX INNER JOIN DEALERPERSON ON REFUNDTRX.PERSONID = DEALERPERSON.PERSONID WHERE (REFUNDTRX.LOCID = @LOCID) AND (REFUNDTRX.ACCID = @ACCID) AND (REFUNDTRX.INCLUDEDISBURSE = 0) AND (REFUNDTRX.Deletests = 0)">
                    <SelectParameters>
                        <asp:Parameter Name="REFUNDTRXID" />
                        <asp:Parameter Name="LOCID" />
                        <asp:Parameter Name="ACCID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td width="100%">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail" width="100%">
                            Bank Account No :
                            <asp:DropDownList ID="ddlAccountNo" runat="server" CssClass="required" 
                                ValidationGroup="ValApp">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCCDBankAcc" runat="server" 
                                BehaviorID="BehavBankAccNo" Category="BankAccNo" 
                                LoadingText="[Loading Bank Account ...]" PromptText="[BANK ACCOUNT NO.]" 
                                ServiceMethod="GetDropDownBankAccountByUIDAndFinCat" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAccountNo">
                            </ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqAccountNO" runat="server" 
                                ControlToValidate="ddlAccountNo" Display="None" 
                                ErrorMessage="[BANK ACCOUNT NO] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail" width="100%">
                            Paid Date :
                            <asp:TextBox ID="txtPaidDate" runat="server" CssClass="required" 
                                ValidationGroup="ValApp" Width="72px"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPaidDate" runat="server" 
                                Format="dd/MM/yyyy" PopupButtonID="imgPaidDate" TargetControlID="txtPaidDate">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEPaidDate" runat="server" 
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtPaidDate">
                            </ajaxToolkit:MaskedEditExtender>
                            <asp:Image ID="imgPaidDate" runat="server" ImageUrl="~/images/grid.gif" 
                                style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;<asp:RequiredFieldValidator ID="reqPaidDate" runat="server" 
                                ControlToValidate="txtPaidDate" Display="None" 
                                ErrorMessage="[PAID DATE] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="ValApp"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPlanPaidAcc0" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqPlanPaidDate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            <asp:Button ID="btnApprove" runat="server" 
                                Style="background-position: right; background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat; text-align: left;" 
                                Text="Approve" ValidationGroup="ValApp" Width="88px" />
                            <asp:Button ID="btnReject" runat="server" CausesValidation="False" 
                                Style="background-position: right; background-image: url(../Images/reject.png); cursor: pointer; background-repeat: no-repeat; text-align: left;" 
                                Text="Reject" ValidationGroup="ValApp" Width="88px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlINQ" runat="server" Width="100%">
                <asp:GridView ID="gvRefundInq" runat="server" AutoGenerateColumns="False" 
                    Caption="INQUIRY DEALER REFUND LIST" 
                    DataKeyNames="REFUNDTRXID,LOCID,ACCID,PERSONID" DataSourceID="sdsRefundInq" 
                    Width="100%">
                    <Columns>
                        <asp:BoundField DataField="PAIDSTSNAME" HeaderText="Paid&lt;br&gt;Sts" 
                            HtmlEncode="False" SortExpression="PAIDSTSNAME">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PLANPAIDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Plan&lt;br&gt;Paid Date" HtmlEncode="False" 
                            SortExpression="PLANPAIDDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PAIDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Paid&lt;br&gt;Date" HtmlEncode="False" SortExpression="PAIDDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Paid&lt;br&gt;Txn Date" HtmlEncode="False" 
                            SortExpression="PAIDTXNDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PERSONNAME" HeaderText="Person&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="PERSONNAME" />
                        <asp:BoundField DataField="PERSONTITLENAME" HeaderText="Person&lt;br&gt;Title" 
                            HtmlEncode="False" ReadOnly="True" SortExpression="PERSONTITLENAME" />
                        <asp:BoundField DataField="REFUNDCATEGORYNAME" 
                            HeaderText="Refund&lt;br&gt;Category" HtmlEncode="False" 
                            SortExpression="REFUNDCATEGORYNAME" />
                        <asp:BoundField DataField="AMOUNT" DataFormatString="{0:N}" 
                            HeaderText="Refund&lt;br&gt;Amount" HtmlEncode="False" SortExpression="AMOUNT">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REFUNDSTSNAME" HeaderText="Refund&lt;br&gt;Status" 
                            HtmlEncode="False" SortExpression="REFUNDSTSNAME" />
                        <asp:BoundField DataField="ACCOUNTNO" HeaderText="Person&lt;br&gt;Account No." 
                            HtmlEncode="False" SortExpression="ACCOUNTNO" />
                        <asp:BoundField DataField="ACCOUNTNAME" 
                            HeaderText="Person&lt;br&gt;Account Name" HtmlEncode="False" 
                            SortExpression="ACCOUNTNAME" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc1:nodatafound ID="nodatafound5" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRefundInq" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    
                    SelectCommand="SELECT REFUNDTRX.REFUNDTRXID, REFUNDTRX.LOCID, REFUNDTRX.ACCID, REFUNDTRX.PERSONID, DEALERPERSON.PERSONNAME, REFUNDTRX.AMOUNT, '(' + DEALERPERSON.PERSONTITLE + ')' + dbo.f_getParamGlobalName('PERSONTITLE', DEALERPERSON.PERSONTITLE) AS PERSONTITLENAME, '(' + CAST(REFUNDTRX.REFUNDCATEGORY AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUNDTRX.REFUNDCATEGORY) AS REFUNDCATEGORYNAME, '(' + CAST(REFUNDTRX.REFUNDSTS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('REFUNDSTS', REFUNDTRX.REFUNDSTS) AS REFUNDSTSNAME, CAST(CASE WHEN @REFUNDTRXID = REFUNDTRXID OR REFUNDSTS NOT IN (0 , 1) THEN 1 ELSE 0 END AS BIT) AS CHECKED, REFUNDTRX.REFUNDSTS, CAST(CASE WHEN REFUNDSTS = 1 THEN 1 ELSE 0 END AS BIT) AS VISIBLE, (SELECT PERSONACCOUNTID FROM DEALERPERSONACCOUNT WHERE (PERSONACCOUNTID = REFUNDTRX.PERSONACCOUNTID)) AS PERSONACCOUNTID, REFUNDTRX.PLANPAIDDATE, CASE WHEN REFUNDTRX.PAIDSTS = 1 THEN 'YES' ELSE 'NO' END AS PAIDSTSNAME, REFUNDTRX.PAIDDATE, REFUNDTRX.PAIDTXNDATE, DEALERPERSONACCOUNT_1.ACCOUNTNO, DEALERPERSONACCOUNT_1.ACCOUNTNAME, DEALERPERSONACCOUNT_1.ACCOUNTBRANCH FROM REFUNDTRX INNER JOIN DEALERPERSON ON REFUNDTRX.PERSONID = DEALERPERSON.PERSONID LEFT OUTER JOIN DEALERPERSONACCOUNT AS DEALERPERSONACCOUNT_1 ON REFUNDTRX.PERSONACCOUNTID = DEALERPERSONACCOUNT_1.PERSONACCOUNTID WHERE (REFUNDTRX.LOCID = @LOCID) AND (REFUNDTRX.ACCID = @ACCID) AND (REFUNDTRX.INCLUDEDISBURSE = 0) AND (REFUNDTRX.Deletests = 0)">
                    <SelectParameters>
                        <asp:Parameter Name="REFUNDTRXID" />
                        <asp:Parameter Name="LOCID" />
                        <asp:Parameter Name="ACCID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <asp:Button ID="btnBack" runat="server" CausesValidation="False" Text="Back" />
        </asp:View>
    </asp:MultiView>
        <br />
        <br />
        <br />
        <br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    FormatTable("<%=gvRefund.ClientID%>");
    FormatTable("<%=gvRefundApp.ClientID%>");
    FormatTable("<%=gvRefundInq.ClientID%>");
function getObjectbyClientID(ClientID) {
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
/*
function EditAcc(LOCID, ACCID){
    window.location="AccDisbDisplay.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&ACCID=" + ACCID
}
*/
window.onload = function () {
    var Act = GetValueTxtByClientID("<%=txtAction.ClientID%>");
    if (Act == "INIT") {
        SetTrNone("trPlan");
        SetTrNone("trTxn");
    } else if (Act == "APP") {
        SetTrNone("trTxn");
        SetTrNone("trCollSts");
    } else if (Act == "INQ") {
        SetTrNone("trCollSts");
        SetTrNone("trDealer");
    }
}
function ViewDetailAcc(LOCID, APPID){
    var winref = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}

function SetTrNone(TrID) {
    var oDiv = getObjectbyClientID(TrID);
    if (oDiv) oDiv.style.display = "none";
}

function CheckAll() {
    var chk = getObjectbyClientID("<%=chkAll.ClientID%>");
    var sCheck = "<%=strCheckBox%>";
    var arrCheck = sCheck.split(",");
    var nLen = arrCheck.length - 1;
    if (nLen > 0) {
        for (var i = 0; i < nLen; i++) {
            var oCheck = getObjectbyClientID(arrCheck[i].toString());
            if (oCheck) {
                oCheck.checked = chk.checked;
                SelectRow(oCheck);
            }
            
        }
    }
}
function ShowJournal(RefNo) {
    var WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=PR2", "RefJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    WinRef.focus();
    return (false);
}
function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}

</script>

</asp:Content>

