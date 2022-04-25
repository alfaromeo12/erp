<%@ Page Title="Param DOC - Document Collateral" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DocumentColl.aspx.vb" Inherits="Param_DocumentColl" EnableEventValidation="false" %>
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
                            <td style="width: 115px" class="HeaderStyle">
                                Product
                                <asp:ScriptManagerProxy ID="SMPCollDoc" runat="server">
                                    <Services>
                                        <asp:ServiceReference Path="GHWService.asmx" />
                                    </Services>
                                </asp:ScriptManagerProxy>
                            </td>
                            <td class="HeaderStyle">
                                 <asp:DropDownList ID="ddlProduct" runat="server" 
                                CssClass="required"                                   CausesValidation="True" 
                                     AutoPostBack="True"></asp:DropDownList>
					<ajaxToolkit:cascadingdropdown ID="ajaxCCDProduct" runat="server" Category="PRODUCT" 
						Enabled="True" LoadingText="[Loading Product..]" PromptText="[SELECT PRODUCT]" 
						ServiceMethod="GetDropDownProduct" TargetControlID="ddlProduct" 
                        ServicePath="~\Param\WebService.asmx">
					</ajaxToolkit:cascadingdropdown>
                                      
                                    <asp:RequiredFieldValidator ID="reqProduct" runat="server" ControlToValidate="ddlProduct" 
                                        Display="None" ErrorMessage="[PRODUCT] must be entry...!" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEProduct" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqProduct"></ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px" class="FooterStyle">
                                Item Condition
                            </td>
                            <td class="FooterStyle">
                                 <asp:DropDownList ID="ddlItemCondition" runat="server" DataSourceID="sdsItemCondition"
                                CssClass="required"   DataValueField="CODE" 
                                DataTextField="NAME" AutoPostBack="True" CausesValidation="True"></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqItemCondition" runat="server" ControlToValidate="ddlItemCondition" 
                                        Display="None" ErrorMessage="[ITEM CONDITION] must be entry...!" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEItemCondition" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqItemCondition"></ajaxToolkit:ValidatorCalloutExtender>
                                 <asp:SqlDataSource ID="sdsItemCondition" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                        
                                     SelectCommand="SELECT NULL AS CODE, '[SELECT CONDITION]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')" >
                            </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr  >
                            <td style="width: 115px" class="AlternatingRowStyle">
                                Purpose</td>
                            <td class="AlternatingRowStyle">
                                 <asp:DropDownList ID="ddlPurpose" runat="server" 
                                CssClass="required"   
                                AutoPostBack="True" CausesValidation="True"></asp:DropDownList> 
					<ajaxToolkit:cascadingdropdown ID="ajaxCCDObjPurpose" runat="server" Enabled="True" 
						Category="ObjPurpose"
						LoadingText="[Loading Object Purpose]" PromptText="[SELECT PURPOSE]" 
						TargetControlID="ddlPurpose" ServiceMethod="GetDropDownObjPurposeByProduct" ServicePath="~\Param\WebService.asmx" 
						ParentControlID="ddlProduct">
					</ajaxToolkit:cascadingdropdown>

                                    <asp:RequiredFieldValidator ID="reqPurpose" runat="server" ControlToValidate="ddlPurpose" 
                                        Display="None" ErrorMessage="[PURPOSE] must be entry...!" 
                                        SetFocusOnError="True" Width="200px"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPurpose" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqPurpose"></ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    
                                    
                                    
                                    SelectCommand="SELECT DOCCOLLID, DOCID, DOCCODE, DOCNAME, DOCTYPENAME, CHECKED, MANDATORY FROM (SELECT DT.DOCCOLLID, AP.DOCID, DC.DOCCODE, DC.DOCNAME, dbo.f_getParamGlobalName('DOCTYPE', DC.DOCTYPE) AS DOCTYPENAME, CAST(1 AS BIT) AS CHECKED, DT.MANDATORY FROM DOCUMENTCOLLATERAL AS DT INNER JOIN DOCUMENTAPP AS AP WITH (NOLOCK) ON AP.DOCID = DT.DOCID INNER JOIN [DOCUMENT] AS DC WITH (NOLOCK) ON DC.DOCID = AP.DOCID AND DC.DOCTYPE = 5 WHERE (AP.DELETESTS = 0) AND (DC.DELETESTS = 0) AND (DT.DELETESTS = 0) AND (AP.DOCAPPTYPE = 0) AND (DT.CONDITION = @CONDITION) AND (DT.PRODUCTID = @PRODUCTID) AND (DT.PURPOSEID = @PURPOSEID) UNION ALL SELECT NULL AS DOCCOLLID, AP.DOCID, DC.DOCCODE, DC.DOCNAME, dbo.f_getParamGlobalName('DOCTYPE', DC.DOCTYPE) AS DOCTYPENAME, CAST(0 AS BIT) AS CHECKED, CAST(0 AS BIT) AS MANDATORY FROM DOCUMENTAPP AS AP WITH (NOLOCK) INNER JOIN [DOCUMENT] AS DC WITH (NOLOCK) ON DC.DOCID = AP.DOCID AND DC.DOCTYPE = 5 WHERE (AP.DELETESTS = 0) AND (DC.DELETESTS = 0) AND (AP.DOCAPPTYPE = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DOCUMENTCOLLATERAL WHERE (DOCID = AP.DOCID) AND (CONDITION = @CONDITION) AND (PURPOSEID = @PURPOSEID) AND (PRODUCTID = @PRODUCTID) AND (DELETESTS = 0)))) AS A ORDER BY MANDATORY DESC, CHECKED DESC" >
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlItemCondition" Name="CONDITION" 
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="ddlProduct" Name="PRODUCTID" 
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="ddlPurpose" Name="PURPOSEID" 
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
                                    AutoGenerateColumns="False"  Caption="Document Collateral List" DataKeyNames="DOCCOLLID" 
                                    Width="99%" DataSourceID="sdsGrid" PageSize="100" 
                                    style="margin-right: 0px" RowHeaderColumn="DOCCODE" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="No."  >
                                            <ItemTemplate><%# Container.DataItemIndex + 1 %>
                                                <asp:label ID="lblDOCCOLLID" runat="server" Visible="false" 
                                                            Text='<% #DataBinder.Eval(Container.DataItem,"DOCCOLLID") %>' />
                                                <asp:HiddenField ID="hidDOCID" runat="server" Value='<%# Eval("DOCID") %>' />
                                                </ItemTemplate>
                                            <ControlStyle Width="2px" />
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </asp:TemplateField>   
                                          
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chk" runat="server" onclick="javascript:HighlightRow(this)" Checked='<%# Bind("CHECKED") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
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
                                                <asp:CheckBox ID="chkmandatory" Enabled="false" runat="server" Checked='<%# Bind("MANDATORY") %>' />
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
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="99%">
                           <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                Visible="False" Width="100%"></asp:Label>
		              <asp:Button ID="btnSave" runat="server" 
                                    Style="font-size: 8pt; cursor: pointer;  background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                    Text="Save" ToolTip="Save" Width="55px" 
                               onclientclick="return CheckUserSPVSaveDoc();" />
		            </asp:Panel>
	            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" TargetControlID="pnlControl"
		            VerticalSide="Bottom">
	            </ajaxToolkit:AlwaysVisibleControlExtender>  
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">
        FormatTable("<%=gvData.ClientID%>")
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
            HighlightRow(Gvw);
        }



        function StatusMandatory(CheckMandatory) {
            document.getElementById(CheckMandatory).disabled = !document.getElementById(CheckMandatory).disabled;
            //document.getElementById(CheckMandatory).checked = !document.getElementById(CheckMandatory).checked;
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
                if (Page_ClientValidate("")) {
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

