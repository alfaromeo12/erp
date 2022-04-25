<%@ Page Title="Collector Activity" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectActivity.aspx.vb" Inherits="Param_CollectActivity" %>
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
                                    <asp:ListItem Value="ACTIVITYNAME">Coll. Activity Name</asp:ListItem>
                                    <asp:ListItem Value="COLLECTORACTIVITYID">Coll. Activity Id</asp:ListItem>
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
                        AutoGenerateColumns="False" DataKeyNames="COLLECTORACTIVITYID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Collector Activity List" RowHeaderColumn="COLLECTORACTIVITYID">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:CommandField>
                            <asp:BoundField DataField="COLLECTORACTIVITYID" HeaderText="ID" ReadOnly="True" 
                                SortExpression="COLLECTORACTIVITYID" />
                            <asp:BoundField DataField="COLLECTORTYPE" HeaderText="Collector&lt;br&gt;Type" 
                                SortExpression="COLLECTORTYPE" HtmlEncode="False" />
                            <asp:BoundField DataField="ACTIVITYNAME" HeaderText="Activity&lt;br&gt;Name"  
                                SortExpression="ACTIVITYNAME" HtmlEncode="False" />
                            <asp:BoundField DataField="DESCRIPTION" 
                                HeaderText="Activity&lt;br&gt;Description"  SortExpression="DESCRIPTION" 
                                HtmlEncode="False" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
        SelectCommand="SELECT CV.COLLECTORACTIVITYID, PR.COLLECTORTYPE, CV.ACTIVITYNAME, CV.DESCRIPTION FROM COLLECTORACTIVITY AS CV WITH (NOLOCK) INNER JOIN (SELECT CODE, '(' + CODE + ')' + NAME AS COLLECTORTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'COLLECTORTYPE')) AS PR ON PR.CODE = CV.COLLECTORTYPE WHERE (CV.Deletests = 0)">
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
    <asp:FormView ID="fvCollectActivity" runat="server" DataSourceID="sdsCollActiv"
        DefaultMode="Edit" Width="100%" DataKeyNames="COLLECTORACTIVITYID">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td width="20%" style="height: 19px">
                        Activity. ID</td>
                    <td style="height: 19px">
                        <asp:Label ID="lblCollActivID" runat="server" Text='<%# Eval("COLLECTORACTIVITYID") %>'></asp:Label></td>
                </tr>
                                   
                <tr>
                    <td width="20%">
                        Collector&nbsp; Type</td>
                    <td>
                        <asp:DropDownList ID="ddlColActivType" runat="server" CssClass="required" Width="250px" 
                            DataValueField="CODE" DataTextField="NAMETYPE"    DataSourceID="sdsActivType"
                             SelectedValue='<%# Bind("CODE") %>' >
                        </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="ddlColActivType" 
                                Display="None" ErrorMessage="[COLLECTOR ACTIVITY. TYPE] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        Activity. Name</td>
                    <td>
                        <asp:TextBox ID="txtCollActivName" runat="server" Width="250px" MaxLength="100" 
                            Text='<%# Bind("ACTIVITYNAME") %>' CssClass="required"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollActivName" 
                                Display="None" ErrorMessage="[COLLECTOR ACTIVITY. NAME] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Activity. Desc</td>
                    <td>
                        <asp:TextBox ID="txtCollActivDesc" runat="server" Width="350px" MaxLength="200" 
                            Text='<%# Bind("DESCRIPTION") %>' ></asp:TextBox>
                         
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
                        Collector Type</td>
                    <td>
                         <asp:DropDownList ID="ddlColActivType" runat="server" CssClass="required" Width="250px" 
                            DataValueField="CODE" DataTextField="NAMETYPE"    DataSourceID="sdsActivType"
                             SelectedValue='<%# Bind("CODE") %>'>
                        </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="ddlColActivType" 
                                Display="None" ErrorMessage="[COLLECTOR ACTIVITY. TYPE] must be entry...!" 
                                SetFocusOnError="True">

                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        Activity. Name</td>
                    <td>
                        <asp:TextBox ID="txtCollActivName" runat="server" Width="250px" MaxLength="100" 
                            Text='<%# Bind("ACTIVITYNAME") %>' CssClass="required"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollActivName" 
                                Display="None" ErrorMessage="[COLLECTOR ACTIVITY. NAME] must be entry...!" 
                                SetFocusOnError="True">

                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName1" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Activity. Desc</td>
                    <td>
                        <asp:TextBox ID="txtCollActivDesc" runat="server" Width="350px" MaxLength="200" 
                            Text='<%# Bind("DESCRIPTION") %>' ></asp:TextBox>
                            
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
    <asp:SqlDataSource ID="sdsActivType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[SELECT TYPE]' AS NAMETYPE UNION ALL  SELECT CODE, '(' + CODE + ') ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (nolock) WHERE TYPE='COLLECTORTYPE' ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollActiv" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                SelectCommand="SELECT COLLECTORACTIVITYID,CV.COLLECTORTYPE AS CODE ,PR.COLLECTORTYPENAME,CV.ACTIVITYNAME,CV.DESCRIPTION FROM dbo.COLLECTORACTIVITY CV WITH(NOLOCK) INNER JOIN (SELECT CODE,'(' + CODE + ')' + NAME AS COLLECTORTYPENAME FROM PARAMGLOBAL WITH(NOLOCK) WHERE TYPE='COLLECTORTYPE')AS PR ON PR.CODE=CV.COLLECTORTYPE WHERE (CV.DELETESTS = 0) AND (COLLECTORACTIVITYID=@COLLECTORACTIVITYID)" 
                DeleteCommand="UPDATE COLLECTORACTIVITY SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (COLLECTORACTIVITYID=@COLLECTORACTIVITYID)" 
                UpdateCommand="COLLECTORACTIVITYUpdate" InsertCommand="COLLECTORACTIVITYAdd" 
                InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTORACTIVITYID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:CookieParameter CookieName="UID" Name="UserID" />
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTORACTIVITYID" 
                        PropertyName="SelectedValue" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTORACTIVITYID" 
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="CODE" Type="Int16" />
                    <asp:Parameter Name="ACTIVITYNAME" Type="String" />
                    <asp:Parameter Name="DESCRIPTION" Type="String" />
                    <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                    <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="CODE" Type="Int16" />
                    <asp:Parameter Name="ACTIVITYNAME" Type="String" />
                    <asp:Parameter Name="DESCRIPTION" Type="String" />
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

