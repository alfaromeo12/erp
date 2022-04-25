<%@ Page Title="Param DOC - Document Required" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DocumentReq.aspx.vb" Inherits="Param_DocumentReq" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
 <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
            <div style="float: right; vertical-align: middle">
                <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
                <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
            </div>
            <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
                    background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
            <ajaxToolkit:collapsiblepanelextender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
                ImageControlID="imgButtonShow" TargetControlID="pnlSearchMaintenance" 
                TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
                <asp:Panel ID="pnlSearchMaintenance" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 115px" class="AlternatingRowStyle">
                                Product
                            </td>
                            <td class="AlternatingRowStyle">
                                 <asp:DropDownList ID="ddlProduct" Width="200px" runat="server" DataSourceID="sdsProduct"
                                CssClass="required"   DataValueField="PRODUCTID" 
                                DataTextField="PRODUCTNAME" CausesValidation="True" 
                                     ValidationGroup="Application" AutoPostBack="True"></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqProduct" runat="server" ControlToValidate="ddlProduct" 
                                        Display="None" ErrorMessage="[PRODUCT] must be entry...!" 
                                        SetFocusOnError="True" ValidationGroup="Application"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEProduct" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqProduct"></ajaxToolkit:ValidatorCalloutExtender>
                                 <asp:SqlDataSource ID="sdsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                        
                                     SelectCommand="SELECT NULL AS PRODUCTID, NULL AS PRODUCTCODE, '[SELECT PRODUCT]' AS PRODUCTNAME UNION ALL SELECT PRODUCTID, PRODUCTCODE, PRODUCTCODE + ' - ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY PRODUCTCODE" >
                            </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px" class="RowStyle">
                                Customer Type
                            </td>
                            <td class="RowStyle">
                                 <asp:DropDownList ID="ddlDocGroup" Width="200px" runat="server" DataSourceID="sdsDocGroup"
                                CssClass="required"   DataValueField="CODE" 
                                DataTextField="NAME" AutoPostBack="True" CausesValidation="True" 
                                     ValidationGroup="Application"></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqGroup" runat="server" ControlToValidate="ddlDocGroup" 
                                        Display="None" ErrorMessage="[CUSTOMER TYPE] must be entry...!" 
                                        SetFocusOnError="True" ValidationGroup="Application"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqGroup"></ajaxToolkit:ValidatorCalloutExtender>
                                 <asp:SqlDataSource ID="sdsDocGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                        
                                     SelectCommand="SELECT NULL AS CODE, '[SELECT CUST TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CUSTTYPE')" >
                            </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr id="rowPersonal" style="display:none;" >
                            <td style="width: 115px" class="AlternatingRowStyle">
                                Marital Status
                            </td>
                            <td class="AlternatingRowStyle">
                                 <asp:DropDownList ID="ddlMarital" Width="200px" runat="server" DataSourceID="sdsMaritalSts"
                                CssClass="required"   DataValueField="CODE" 
                                DataTextField="NAME" AutoPostBack="True" CausesValidation="True" 
                                     ValidationGroup="Application"></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqMarital" runat="server" ControlToValidate="ddlMarital" 
                                        Display="None" ErrorMessage="[MARITAL STATUS] must be entry...!" 
                                        SetFocusOnError="True" ValidationGroup="Application"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEMarital" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqMarital"></ajaxToolkit:ValidatorCalloutExtender>
                                 <asp:SqlDataSource ID="sdsMaritalSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                        
                                     SelectCommand="SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'MARITALSTS')" >
                            </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    
                                    
                                    
                                    
                                    SelectCommand="SELECT DOCREQID, DOCID, DOCCODE, DOCNAME, DOCTYPENAME, CHECKED, MANDATORY FROM (SELECT DR.DOCREQID, AP.DOCID, DC.DOCCODE, DC.DOCNAME, dbo.f_getParamGlobalName('DOCTYPE', DC.DOCTYPE) AS DOCTYPENAME, CAST(1 AS BIT) AS CHECKED, DR.MANDATORY FROM DOCUMENTREQUIRED AS DR INNER JOIN DOCUMENTAPP AS AP WITH (NOLOCK) ON AP.DOCID = DR.DOCID INNER JOIN [DOCUMENT] AS DC WITH (NOLOCK) ON DC.DOCID = AP.DOCID AND DC.DOCTYPE = 1 WHERE (AP.DELETESTS = 0) AND (DC.DELETESTS = 0) AND (DR.DELETESTS = 0) AND (AP.DOCAPPTYPE = 0) AND (DR.CUSTTYPE = @CUSTTYPE) AND (DR.PRODUCTID = @PRODUCTID) AND (DR.MARITALSTATUS = @MARITALSTATUS) UNION ALL SELECT NULL AS DOCREQID, AP.DOCID, DC.DOCCODE, DC.DOCNAME, dbo.f_getParamGlobalName('DOCTYPE', DC.DOCTYPE) AS DOCTYPENAME, CAST(0 AS BIT) AS CHECKED, CAST(0 AS BIT) AS MANDATORY FROM DOCUMENTAPP AS AP WITH (NOLOCK) INNER JOIN [DOCUMENT] AS DC WITH (NOLOCK) ON DC.DOCID = AP.DOCID AND DC.DOCTYPE = 1 WHERE (AP.DELETESTS = 0) AND (DC.DELETESTS = 0) AND (AP.DOCAPPTYPE = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DOCUMENTREQUIRED WHERE (DOCID = AP.DOCID) AND (CUSTTYPE = @CUSTTYPE) AND (MARITALSTATUS = @MARITALSTATUS) AND (DELETESTS = 0)))) AS A ORDER BY MANDATORY DESC, CHECKED DESC" >
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlDocGroup" Name="CUSTTYPE" 
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="ddlProduct" Name="PRODUCTID" 
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="ddlMarital" Name="MARITALSTATUS" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                            </tr>
                            </table>
                            </asp:Panel>
                            <asp:Panel ID="pnlData" runat="server">
                               <asp:GridView ID="gvData" runat="server" AllowPaging="True" 
                                    AutoGenerateColumns="False"  Caption="Document Required List" DataKeyNames="DOCREQID" 
                                    Width="99%" DataSourceID="sdsGrid" PageSize="100" 
                                    style="margin-right: 0px" RowHeaderColumn="DOCCODE" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="No."  >
                                            <ItemTemplate><%# Container.DataItemIndex + 1 %>
                                                <asp:HiddenField ID="hidDOCREQID" runat="server" 
                                                    Value='<%# Eval("DOCREQID") %>' />
                                                <asp:HiddenField ID="hidDOCID" runat="server" Value='<%# Eval("DOCID") %>' />
                                                </ItemTemplate>
                                            <ControlStyle Width="2px" />
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </asp:TemplateField>   
                                          
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chk" runat="server" Checked='<%# Bind("CHECKED") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                                        </asp:TemplateField>
                                          <asp:BoundField DataField="DOCCODE" HeaderText="Doc&lt;BR&gt;Code"  ControlStyle-Width="5%"
                                            SortExpression="DOCCODE" HtmlEncode="False" >
                                        <ControlStyle Width="5%" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DOCNAME" ControlStyle-Width="5%" HeaderText="Document" 
                                            SortExpression="DOCCODE" >
                                        <ControlStyle Width="5%" />
                                        <ItemStyle Width="350px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DOCTYPENAME" HeaderText="Document&lt;BR&gt;Type"  ControlStyle-Width="5%"
                                            SortExpression="DOCTYPENAME" HtmlEncode="False" >
                                        <ControlStyle Width="5%" />
                                        <ItemStyle Width="150px" />
                                        </asp:BoundField>
                                         <asp:TemplateField  HeaderText="Mandatory">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkmandatory" runat="server" Enabled="false" Checked='<%# Bind("MANDATORY") %>' />
                                            </ItemTemplate>
                                             <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                      <EmptyDataTemplate>
                                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                    </EmptyDataTemplate>  
                                </asp:GridView>
                          <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:HiddenField ID="hidAction" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                        
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="99%">
                           <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                Visible="False" Width="100%"></asp:Label>
		              <asp:Button ID="btnSave" runat="server" 
                                    Style="font-size: 8pt; cursor: pointer;  background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                    Text="Save" ToolTip="Save" ValidationGroup="Application" Width="55px" 
                               onclientclick="return CheckUserSPVSaveDoc();" />
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
        window.onload = function () {
            Load();
        }
        function Load() {
            var row = getObjectbyClientID("rowPersonal");
            var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
            var Gvw = getObjectbyClientID('<%=gvData.ClientID%>');
            var chkMandatory = getObjectbyClientID("<%=oStrChkDocReq%>");
            checkEntryCustType();
            HighlightRow(Gvw);
        }


        function StatusMandatory(CheckMandatory) {
            document.getElementById(CheckMandatory).disabled = !document.getElementById(CheckMandatory).disabled;
            //document.getElementById(CheckMandatory).checked = !document.getElementById(CheckMandatory).checked;
        }
             
        function checkEntryCustType() {
            var CustType = GetValueTxtByClientID("<%=ddlDocGroup.ClientID%>");
            var row = getObjectbyClientID("rowPersonal");
            if (CustType == "1") {
                row.style.display = "";
            }
            else {
                row.style.display = "none";
            }
        }

        function HighlightRow(chkB) {
            var chkmandatory = getObjectbyClientID("<%=oStrChkDocReq%>");
            var IsChecked = chkB.checked;
            if (IsChecked) {
                
                chkB.parentElement.parentElement.style.backgroundColor = 'YellowGreen';
                chkB.parentElement.parentElement.style.color = 'black';
            }
            else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';
            }
        }

        function CheckUserSPVSaveDoc() {
            if (Page_ClientValidate) {
                if (Page_ClientValidate("Application")) {
                    var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
                    if (RetVal.Login == 1)
                        return (true);
                    else
                        return (false);
                } else {
                    return (false);
                }
            }
        }
        </script> 
</asp:Content>

