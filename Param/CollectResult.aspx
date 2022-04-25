<%@ Page Title="Collect Result" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectResult.aspx.vb" Inherits="Param_CollectResult" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:textboxwatermarkextender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
            WatermarkText="%%"></ajaxToolkit:textboxwatermarkextender>
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
                            <td style="width: 115px">
                                <asp:DropDownList ID="ddlCriteria" runat="server">
                                    <asp:ListItem Value="RESULTNAME">Collector Result Name</asp:ListItem>
                                    <asp:ListItem Value="COLLECTRESULTID">Collector Result Id</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                                    ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
                                    border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
                                    Text="Search" CausesValidation="False" CssClass="Search" />
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                Collector Type
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCollectTypeSearch" runat="server" AutoPostBack="True" 
                                    DataSourceID="sdsTitleTypeSearch" DataTextField="NAMETYPE" 
                                    DataValueField="CODE" />
                                <asp:SqlDataSource ID="sdsTitleTypeSearch" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT NULL AS CODE, '[SELECT TYPE]' AS NAMETYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (nolock) WHERE (TYPE = 'COLLECTORTYPE') ORDER BY CODE">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px">
                                &nbsp;</td>
                            <td>
                                     
                            </td>
                        </tr>
                    </table>
                        <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                CommandName="New" CausesValidation="False" Height="19px" />
                    </asp:Panel>
                    <asp:Panel ID="pnlData" runat="server">
                    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="COLLECTRESULTID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Collector Result List" RowHeaderColumn="COLLECTRESULTID">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:CommandField>
                            <asp:BoundField DataField="COLLECTRESULTID" HeaderText="ID" ReadOnly="True" 
                                SortExpression="COLLECTRESULTID" />
                            <asp:BoundField DataField="COLLECTORTYPE" HeaderText="Result Type" SortExpression="COLLECTORTYPE" />
                            <asp:BoundField DataField="RESULTNAME" HeaderText="Result Name"  SortExpression="RESULTNAME" />
                            <asp:BoundField DataField="URL" HeaderText="Result Url"  SortExpression="URL" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT CT.COLLECTRESULTID,PR.COLLECTORTYPE,CT.RESULTNAME,CT.URL FROM dbo.COLLECTRESULT CT WITH(NOLOCK) INNER JOIN (SELECT CODE,'(' + CODE + ')' + NAME AS COLLECTORTYPE FROM PARAMGLOBAL WITH(NOLOCK) WHERE TYPE='COLLECTORTYPE')AS PR ON PR.CODE=CT.COLLECTORTYPE ">
        </asp:SqlDataSource>
        <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvCollectResult" runat="server" DataSourceID="sdsCollResult"
        DefaultMode="Edit" Width="100%" DataKeyNames="COLLECTRESULTID">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Collector Result. Id</td>
                    <td>
                        <asp:Label ID="lblCollResultID" runat="server" Text='<%# Eval("COLLECTRESULTID") %>'></asp:Label></td>
                </tr>
                                   
                <tr>
                    <td width="20%">
                        Collector Result. Type</td>
                    <td>
                        <asp:DropDownList ID="ddlColResultType" runat="server" CssClass="required" Width="250px" 
                            DataValueField="CODE" DataTextField="NAMETYPE"    DataSourceID="sdsResultType"
                             SelectedValue='<%# Bind("CODE") %>' >
                        </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="ddlColResultType" 
                                Display="None" ErrorMessage="[COLLECTOR RESULT. TYPE] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        Collector Result. Name</td>
                    <td>
                        <asp:TextBox ID="txtCollResultName" runat="server" Width="250px" MaxLength="100" 
                            Text='<%# Bind("RESULTNAME") %>' CssClass="required"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollResultName" 
                                Display="None" ErrorMessage="[COLLECTOR RESULT. NAME] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Collector Result. URL</td>
                    <td>
                        <asp:TextBox ID="txtCollResultURL" runat="server" Width="350px" MaxLength="200" 
                            Text='<%# Bind("URL") %>' ></asp:TextBox>
                         
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                    <tr>
                    <td class="FooterStyle" colspan="2">
                        &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
            <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                   <tr>
                    <td width="20%">
                        Collector Result. Type</td>
                    <td>
                        <asp:DropDownList ID="ddlColResultType" runat="server" CssClass="required" Width="250px" 
                            DataValueField="CODE" DataTextField="NAMETYPE"    DataSourceID="sdsResultType"
                             SelectedValue='<%# Bind("CODE") %>' >
                        </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="ddlColResultType" 
                                Display="None" ErrorMessage="[COLLECTOR RESULT. TYPE] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        Collector Result. Name</td>
                    <td>
                        <asp:TextBox ID="txtCollResultName" runat="server" Width="250px" MaxLength="100" 
                            Text='<%# Bind("RESULTNAME") %>' CssClass="required"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollResultName" 
                                Display="None" ErrorMessage="[COLLECTOR RESULT. NAME] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Collector Result. URL</td>
                    <td>
                        <asp:TextBox ID="txtCollResultURL" runat="server" Width="350px" MaxLength="200" 
                            Text='<%# Bind("URL") %>' ></asp:TextBox>
                         
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                    <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsResultType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[SELECT TYPE]' AS NAMETYPE UNION ALL  SELECT CODE, '(' + CODE + ') ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (nolock) WHERE TYPE='COLLECTORTYPE' ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollResult" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                SelectCommand="SELECT CT.COLLECTRESULTID,CT.COLLECTORTYPE AS CODE ,PR.COLLECTORTYPENAME,CT.RESULTNAME,CT.URL FROM dbo.COLLECTRESULT CT WITH(NOLOCK) INNER JOIN (SELECT CODE,'(' + CODE + ')' + NAME AS COLLECTORTYPENAME FROM PARAMGLOBAL WITH(NOLOCK) WHERE TYPE='COLLECTORTYPE')AS PR ON PR.CODE=CT.COLLECTORTYPE WHERE (CT.COLLECTRESULTID=@COLLECTRESULTID)" 
                DeleteCommand="DELETE COLLECTRESULT WHERE (COLLECTRESULTID=@COLLECTRESULTID)" 
                UpdateCommand="COLLECTORRESULTUpdate" InsertCommand="COLLECTORRESULTAdd" 
                InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTRESULTID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:CookieParameter CookieName="UID" Name="UserID" />
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTRESULTID" 
                        PropertyName="SelectedValue" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTRESULTID" 
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="CODE" Type="Int16" />
                    <asp:Parameter Name="RESULTNAME" Type="String" />
                    <asp:Parameter Name="URL" Type="String" />
                    <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                    <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="CODE" Type="Int16" />
                    <asp:Parameter Name="RESULTNAME" Type="String" />
                    <asp:Parameter Name="URL" Type="String" />
                    <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                    <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                </InsertParameters>
    </asp:SqlDataSource>
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
        </script>                
</asp:Content>

