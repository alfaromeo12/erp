<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccParipasuRelease.aspx.vb" Inherits="Txn_ParipasuRelease" title="Account Paripasu Release" EnableEventValidation="FALSE" MaintainScrollPositionOnPostback="true"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register src="../UserControl/DataAccountFromParamAccIDOS.ascx" tagname="DataAccountFromParamAccIDOS" tagprefix="uc1" %>
<%@ Register src="../UserControl/DataCustomerInfoFromAppID.ascx" tagname="datacustomerinfofromappid" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollateralDataFromOBJID.ascx" tagname="CollateralDataFromOBJID" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="txtAppDate" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />

    <asp:MultiView ID="MVMain" runat="server">
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
                                <asp:ListItem Value="CUSTOMER.CUSTNO">Cust No.</asp:ListItem>
                                <asp:ListItem Value="CUSTNOX">Cust No. (Formated)</asp:ListItem>
                                <asp:ListItem Value="CUSTOMER.IDNUMBER">ID Number</asp:ListItem>
                                <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
                                <asp:ListItem Value="CUSTOMER.CUSTID">CUST ID</asp:ListItem>
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
                AutoGenerateColumns="False" Caption="Account Paripasu (From) List" 
                DataKeyNames="LOCID,ACCID,LOCIDPARIPASU,ACCIDPARIPASU,PARIPASUID" 
                DataSourceID="sdsGrid" RowHeaderColumn="ACCID" 
                Width="99%">
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                    </asp:CommandField>
                    <asp:BoundField DataField="LOCID" HeaderText="Loc&lt;br&gt;ID" 
                        HtmlEncode="False" SortExpression="LOCID">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACCID" HeaderText="Acc&lt;br&gt;ID" 
                        HtmlEncode="False" SortExpression="ACCID" />
                    <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                        SortExpression="ACCNO">
                        <ItemTemplate>
                            <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ACCNO") %>'></asp:Label>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" HtmlEncode="False" 
                        SortExpression="BRANCHNAME" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                        SortExpression="BOOKINGDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Acc.&lt;br&gt;Status" 
                        HtmlEncode="False" SortExpression="ACCSTATUSNAME" />
                    <asp:BoundField DataField="OSPRINCIPALREAL" DataFormatString="{0:N}" 
                        HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                        SortExpression="OSPRINCIPALREAL">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGrid" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                
                SelectCommand="SELECT TOP (500) ACCOUNT.ACCOUNTNAME, CUSTOMER.CUSTID, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNT.ACCSTATUS, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME, ACCOUNT.APPID, '(' + CAST(ACCOUNT.ACCSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME, PARIPASU.LOCIDPARIPASU, PARIPASU.ACCIDPARIPASU, PARIPASU.PARIPASUID, ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.OSPRINCIPALREAL FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN PARIPASU ON ACCOUNT.LOCID = PARIPASU.LOCIDPARIPASU AND ACCOUNT.ACCID = PARIPASU.ACCIDPARIPASU WHERE (ACCOUNT.ACCSTATUS &lt;&gt; 0) AND (PARIPASU.Deletests = 0) AND (PARIPASU.PARIPASUSTS = 1)">
            </asp:SqlDataSource>
            <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" 
                CollapseControlID="pnlShow" CollapsedImage="~/images/expand.jpg" 
                CollapsedText="(Show Search Criteria...)" Enabled="True" 
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" 
                ExpandedText="(Hide Search Criteria...)" ImageControlID="imgButtonShow" 
                TargetControlID="pnlData" TextLabelID="lblShow">
            </ajaxToolkit:CollapsiblePanelExtender>
        </asp:View>
        <asp:View ID="vEdit" runat="server">
            <asp:HiddenField ID="hidLOCID" runat="server" />
            <asp:HiddenField ID="hidACCID" runat="server" />
            <asp:HiddenField ID="hidLOCIDPARIPASU" runat="server" />
            <asp:HiddenField ID="hidACCIDPARIPASU" runat="server" />
            <asp:HiddenField ID="hidPARIPASUID" runat="server" />
            <asp:Panel ID="pnlCustomerShow" runat="server" CssClass="ShowDetail" 
                Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgCust" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblCust" runat="server" CssClass="required">(Show Customer Info...)</asp:Label>
                </div>
                <input id="Button14" style="background-position: left top; width: 24px; cursor: pointer;
			background-repeat: no-repeat; height: 16px" type="button" noenter />
            </asp:Panel>
            <asp:Panel ID="pnlCustomer" runat="server" Width="100%">
            <uc1:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS" runat="server" />
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECustomer" runat="server" 
                CollapseControlID="pnlCustomerShow" CollapsedImage="~/images/expand.jpg" 
                CollapsedText="(Show Customer Info...)" Enabled="True" 
                ExpandControlID="pnlCustomerShow" ExpandedImage="~/images/collapse.jpg" 
                ExpandedText="(Hide Customer Info...)" ImageControlID="imgCust" 
                TargetControlID="pnlCustomer" TextLabelID="lblCust">
            </ajaxToolkit:CollapsiblePanelExtender>
            <uc1:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS0" 
                runat="server" />
            <asp:Panel ID="pnlCollateralShow" runat="server" CssClass="ShowDetail" 
                Width="99%">
                <div style="float: right; vertical-align: middle">
                    <asp:Image ID="imgCollateral" runat="server" AlternateText="(Show Details...)" 
                        ImageUrl="~/images/expand.jpg" />
                    <asp:Label ID="lblCollateral" runat="server" CssClass="required">(Show Paripasu Data...)</asp:Label>
                </div>
                <input id="Button10" style="background-position: left top; width: 24px; cursor: pointer;
			background-repeat: no-repeat; height: 16px" type="button" noenter />
            </asp:Panel>
            <asp:Panel ID="pnlCollateral" runat="server" Width="100%">
                <asp:GridView ID="gvParipasu" runat="server" AutoGenerateColumns="False" 
                    Caption="ACCOUNT PARIPASU (TO)" DataKeyNames="LOCID,ACCID,PARIPASUID" 
                    DataSourceID="sdsParipasu" Width="100%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkBox" runat="server" 
                                    Visible='<%# Eval("CHECKVISIBLE") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="No.">
                            <ItemTemplate>
                                <asp:Label ID="lblNo" runat="server" style="font-weight: 700" 
                                    Text="<%#Container.DataItemIndex + 1 %>"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="BOOKINGDATE" HeaderText="Book&lt;br&gt;Date" 
                            HtmlEncode="False" SortExpression="BOOKINGDATE" 
                            DataFormatString="{0:dd/MM/yyyy}" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Account&lt;br&gt;No." 
                            SortExpression="ACCNOFORMAT">
                            <ItemTemplate>
                                <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("ACCNOFORMAT") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                        <asp:BoundField DataField="PRINCIPALTOTAL" DataFormatString="{0:N}" 
                            HeaderText="Principal&lt;br&gt;Total" HtmlEncode="False" 
                            SortExpression="PRINCIPALTOTAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OSPRINCIPALREAL" DataFormatString="{0:N}" 
                            HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                            SortExpression="OSPRINCIPALREAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="INSTALLMENT" DataFormatString="{0:N}" 
                            HeaderText="Installment" HtmlEncode="False" SortExpression="INSTALLMENT">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCSTATUSNAME" HeaderText="Account&lt;br&gt;Status" 
                            HtmlEncode="False" SortExpression="ACCSTATUSNAME" />
                        <asp:BoundField DataField="PARIPASUSTSNAME" HeaderText="Paripasu&lt;br&gt;Sts" 
                            HtmlEncode="False" SortExpression="PARIPASUSTSNAME" />
                        <asp:BoundField DataField="RELEASEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Release&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="RELEASEDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound2" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsParipasu" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    
                    
                    
                    SelectCommand="SELECT ACCOUNT.BOOKINGDATE, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNOFORMAT, ACCOUNT.PRINCIPALTOTAL, ACCOUNT.INSTALLMENT, '(' + CAST(ACCOUNT.ACCSTATUS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('ACCSTATUS', ACCOUNT.ACCSTATUS) AS ACCSTATUSNAME, ACCOUNT.ACCSTATUS, ACCOUNT.ACCOUNTNAME, PARIPASU.LOCIDPARIPASU, PARIPASU.ACCIDPARIPASU, ACCOUNT.APPID, '(' + CAST(PARIPASU.PARIPASUSTS AS VARCHAR(20)) + ') ' + dbo.f_getParamGlobalName('PARIPASUSTS', PARIPASU.PARIPASUSTS) AS PARIPASUSTSNAME, CAST(CASE WHEN PARIPASUSTS = 1 THEN 1 ELSE 0 END AS BIT) AS CHECKVISIBLE, PARIPASU.PARIPASUID, PARIPASU.RELEASEDATE, ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.OSPRINCIPALREAL, PARIPASU.PARIPASUSTS FROM ACCOUNT WITH (NOLOCK) INNER JOIN PARIPASU ON ACCOUNT.LOCID = PARIPASU.LOCID AND ACCOUNT.ACCID = PARIPASU.ACCID WHERE (PARIPASU.Deletests = 0) AND (PARIPASU.LOCIDPARIPASU = @LOCID) AND (PARIPASU.ACCIDPARIPASU = @ACCID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidLOCIDPARIPASU" Name="LOCID" 
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="hidACCIDPARIPASU" Name="ACCID" 
                            PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <hr />
                <asp:Button ID="btnRelease" runat="server" 
                    Style="background-position: right; background-image: url(../Images/Released.png); cursor: pointer; background-repeat: no-repeat; text-align: left" 
                    Text="Release" Width="88px" />
            </asp:Panel>
            <br />
            <br />
            <br />
            	<asp:Panel ID="pnlControl" runat="server" CssClass="FooterStyle" 
                style="margin-top: 0px" Width="100%">
                    <asp:Label ID="lblError" runat="server" CssClass="ErrHighLight" 
                        Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                        Visible="False" Width="100%"></asp:Label>
                    <ajaxToolkit:AnimationExtender ID="ajaxAEError" runat="server" 
                        TargetControlID="lblError">
                        <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                    </ajaxToolkit:AnimationExtender>
                    <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                        Style="background-position: right; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat; text-align: left" 
                        Text="Back" Width="88px" />
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                Enabled="True" TargetControlID="pnlControl" VerticalSide="Bottom">                
            </ajaxToolkit:AlwaysVisibleControlExtender>
            	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollateral" runat="server" CollapseControlID="pnlCollateralShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Paripasu Data...)"
		Enabled="True" ExpandControlID="pnlCollateralShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Paripasu Data...)" ImageControlID="imgCollateral" TargetControlID="pnlCollateral"
		TextLabelID="lblCollateral">
	                
	</ajaxToolkit:CollapsiblePanelExtender>

        </asp:View>
    </asp:MultiView>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    FormatTable("<%=gvParipasu.ClientID%>");

function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function ViewDetailAcc(LOCID, APPID){
    var sAction = GetValueTxtByClientID("<%=txtAction.ClientID%>");
    var winref = window.open("../Account/AccInqFrame.aspx?Action=" + sAction + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
    winref.focus();
}

function HighlightRow(chkB) {
    var IsChecked = chkB.checked;
    if (IsChecked) {
        chkB.parentElement.parentElement.className = "SelectedRowStyle";
    }
    else {
        chkB.parentElement.parentElement.className = "";
    }
}

</script>

</asp:Content>

