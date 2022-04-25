<%@ Page Title="Param DOC - Document Apllication" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DocumentApp.aspx.vb" Inherits="Param_DocumentApp" %>
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
                                Document Group
                            </td>
                            <td class="HeaderStyle">
                                 <asp:DropDownList ID="ddlDocGroup" runat="server" DataSourceID="sdsDocGroup"
                                CssClass="required"   DataValueField="CODE" 
                                DataTextField="NAME" AutoPostBack="True" CausesValidation="True"></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqGroup" runat="server" ControlToValidate="ddlDocGroup" 
                                        Display="None" ErrorMessage="[APPLICATION GROUP] must be entry...!" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                                    HighlightCssClass="ErrHighLight"
                                        TargetControlID="reqGroup"></ajaxToolkit:ValidatorCalloutExtender>
                                 <asp:SqlDataSource ID="sdsDocGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                        
                                     SelectCommand="SELECT NULL AS CODE, '[SELECT DOCUMENT GROUP]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'DOCAPPTYPE')" >
                            </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                  
                                    
                                    
                                    
                                    SelectCommand="SELECT DOCID, DOCCODE, DOCNAME, DOCTYPENAME, ORDERNUMBER, REMARK, CHECKED FROM (SELECT AP.DOCID, DC.DOCCODE, DC.DOCNAME, dbo.f_getParamGlobalName('DOCTYPE', DC.DOCTYPE) AS DOCTYPENAME, AP.ORDERNUMBER, AP.REMARK, CAST(1 AS BIT) AS CHECKED FROM DOCUMENTAPP AS AP INNER JOIN [DOCUMENT] AS DC WITH (NOLOCK) ON DC.DOCID = AP.DOCID WHERE (AP.DELETESTS = 0) AND (DC.DELETESTS = 0) AND (AP.DOCAPPTYPE = @DOCAPPTYPE) UNION ALL SELECT DOCID, DOCCODE, DOCNAME, dbo.f_getParamGlobalName('DOCTYPE', DOCTYPE) AS DOCTYPENAME, NULL AS ORDERNUMBER, NULL AS REMARK, CAST(0 AS BIT) AS CHECKED FROM [DOCUMENT] WHERE (NOT EXISTS (SELECT 'X' AS Expr1 FROM DOCUMENTAPP WHERE (DOCID = [DOCUMENT].DOCID) AND (DELETESTS = 0) AND (DOCAPPTYPE = @DOCAPPTYPE)))) AS A ORDER BY CHECKED DESC, ORDERNUMBER" >
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlDocGroup" Name="DOCAPPTYPE" 
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
                                    AutoGenerateColumns="False"  Caption="Document Apllication List" DataKeyNames="DOCID" 
                                    Width="99%" DataSourceID="sdsGrid" PageSize="100" 
                                    style="margin-right: 0px" RowHeaderColumn="DOCCODE" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="No."  >
                                            <ItemTemplate><%# Container.DataItemIndex + 1 %>
                                                <asp:label ID="lblDOCID" runat="server" Visible="false" 
                                                            Text='<% #DataBinder.Eval(Container.DataItem,"DOCID") %>' />
                                                </ItemTemplate>
                                            <ControlStyle Width="2px" />
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </asp:TemplateField>    
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chk" runat="server" onclick="javascript:HighlightRow(this)" Checked='<%# Bind("CHECKED") %>' />
                                            </ItemTemplate>
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
                                        <asp:TemplateField HeaderText="Ordering&lt;BR&gt;Number" ShowHeader="False" ControlStyle-Width="10%" > 
                                            <ControlStyle Width="30px" />
                                            <Itemstyle  HorizontalAlign="Right" Width="30px"/>
                                            <ItemTemplate> 
                                                <asp:TextBox ID="txtOrderNumber" runat="server" style="text-align:right" 
                                                    Width="50px" MaxLength="5" 
                                                    Text='<%# Bind("ORDERNUMBER") %>' ></asp:TextBox> 
                                                
                                            </ItemTemplate> 
                                        </asp:TemplateField>   
                                         <asp:TemplateField HeaderText="Remark" ControlStyle-Width="90%" > 
                                             <ControlStyle Width="90%" />
                                            <Itemstyle  HorizontalAlign="Left"/>
                                            <ItemTemplate > 
                                                <asp:TextBox ID="txtRemark" runat="server" style="text-align:left" Width="100%" MaxLength="50" 
                                                    Text='<%# Bind("REMARK") %>' ></asp:TextBox> 
                                            </ItemTemplate> 
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
                                    Text="Save" ToolTip="Save" Width="55px" 
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

            var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
            var Gvw = getObjectbyClientID('<%=gvData.ClientID%>');
            HighlightRow(Gvw)
        }
        function HighlightRow(chkB) {
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

