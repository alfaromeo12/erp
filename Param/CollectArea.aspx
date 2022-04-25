<%@ Page Title="Collector Area" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectArea.aspx.vb" Inherits="Param_CollectArea" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
     <asp:MultiView ID="MultiView_Utama" runat="server"> 
            <asp:View ID="View_Area" runat="server">   
                                 <asp:Label ID="lblCommand" runat="server" Text="Label" Visible="False"></asp:Label>     
                                <asp:Label ID="lblIndex" runat="server" Text="Label" Visible="False"></asp:Label>           
                                <asp:Label ID="lblKey" runat="server" Text="Label" Visible="False"></asp:Label>  
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
                                                        <asp:ListItem Value="COLLECTORAREANAME">Collector Area Name</asp:ListItem>
                                                        <asp:ListItem Value="COLLECTORAREAID">Collector Area ID</asp:ListItem>
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
                                                    &nbsp;</td>
                                                <td>
                                        <%--<asp:DropDownList ID="ddlCollectSearch" runat="server" DataSourceID="sdsCollectSearch"
                                            DataTextField="COLLECTORAREANAME" DataValueField="COLLECTORAREAID" AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsCollectSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                            SelectCommand="SELECT NULL AS COLLECTORAREAID, 'ALL COLLECTOR' AS COLLECTORAREANAME UNION ALL SELECT COLLECTORAREAID, '(' + CAST(COLLECTORAREAID AS VARCHAR) + ') ' + COLLECTORAREANAME AS COLLECTORAREANAME FROM COLLECTORAREA WHERE (DELETESTS = 0)">
                                        </asp:SqlDataSource>--%>
                                                </td>
                                            </tr>
                                        </table>
                                            <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                                 CommandName="New" CausesValidation="False" Height="19px" />
                                                 </asp:Panel>
                                        <asp:Panel ID="pnlData" runat="server">
                                        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                                            AutoGenerateColumns="False" DataKeyNames="COLLECTORAREAID" DataSourceID="sdsGrid" Width="100%" 
                                            Caption="Collector Area List" RowHeaderColumn="COLLECTORAREAID">
                                            <Columns>
                                                  <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                    </asp:CommandField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnViewDtl" runat="server" 
                                                                CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                                                 CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/area.png" 
                                                                 OnCommand="btnViewDtl_Command" Enabled="True" />
                                                </ItemTemplate><ItemStyle HorizontalAlign="Center" Width="20px" />
                                                </asp:TemplateField>
                                                  <asp:BoundField DataField="COLLECTORAREAID" HeaderText="ID" ReadOnly="True" 
                                                      SortExpression="COLLECTORAREAID" />
                                                <asp:BoundField DataField="COLLECTORAREANAME" 
                                                      HeaderText="Collector&lt;br&gt;Area Name" SortExpression="COLLECTORAREANAME" 
                                                      HtmlEncode="False" />
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                </asp:Panel>
                            <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                
                                     SelectCommand="SELECT COLLECTORAREAID, COLLECTORAREANAME AS COLLECTORAREANAME FROM COLLECTORAREA WITH (nolock) WHERE (Deletests = 0)">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

                    
                        <script type="text/javascript" src="../include/TableHighLight.js"></script>
                            <script type="text/javascript">
                                FormatTable("<%=gvData.ClientID%>")
                            </script>
                     <asp:FormView ID="fvCollect" runat="server" DataSourceID="sdsCollectArea"
                            DefaultMode="Edit" Width="100%" DataKeyNames="COLLECTORAREAID">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            Collector Area. Id</td>
                                        <td>
                                            <asp:Label ID="lblCOLLECTORAREAID" runat="server" Text='<%# Eval("COLLECTORAREAID") %>'></asp:Label></td>
                                    </tr>
                                   
                                    <tr>
                                        <td width="20%">
                                            Collector Area. Name</td>
                                        <td>
                                            <asp:TextBox ID="txtCollname" runat="server" Width="300px" MaxLength="50" 
                                                Text='<%# Bind("COLLECTORAREANAME") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator
                                                ID="reqName" runat="server" ControlToValidate="txtCollname" Display="None" ErrorMessage="[COLLECTOR AREA. NAME] must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <hr />
                                                </td>
                                            </tr>
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
                                            Collector Area. Name</td>
                                        <td>
                                            <asp:TextBox ID="txtCollname" runat="server" Width="300px" MaxLength="50" 
                                                Text='<%# Bind("COLLECTORAREANAME") %>' CssClass="required"></asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ID="reqName" runat="server" ControlToValidate="txtCollname" Display="None" ErrorMessage="[COLLECTOR AREA. NAME] must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
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
                    <asp:SqlDataSource ID="sdsCollectArea" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT COLLECTORAREAID, COLLECTORAREANAME FROM COLLECTORAREA WHERE (Deletests = 0) AND (COLLECTORAREAID = @COLLECTORAREAID)" 
                    DeleteCommand="UPDATE COLLECTORAREA SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  (COLLECTORAREAID = @COLLECTORAREAID)" 
                    UpdateCommand="COLLECTORAREAUpdate" InsertCommand="COLLECTORAREAAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="COLLECTORAREANAME" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="COLLECTORAREANAME" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </asp:View>
            <asp:View ID="View_Area_Detail" runat="server">   
                 <asp:FormView ID="fvCollectorInfo" runat="server" DataSourceID="sdsCollectorInfo" 
                    Width="100%" DataKeyNames="COLLECTORAREAID" Caption="Collector Area Info">
                         <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 20%">
                                   ID Collector :
                                </td>
                                <td style="width: 80%">
                                    <asp:Label ID="lblCollector" runat="server"  
                                        Text='<%# Eval("COLLECTORAREAID") %>' Font-Bold="True" Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Collector Name:
                                </td>
                                <td style="width: 80%">
                                    <asp:Label ID="lblNmCollector" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("COLLECTORAREANAME") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                 </asp:FormView>           
                    <asp:SqlDataSource ID="sdsCollectorInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT COLLECTORAREAID, '(' + CAST(COLLECTORAREAID AS VARCHAR) + ') ' + COLLECTORAREANAME AS COLLECTORAREANAME 
                                                FROM COLLECTORAREA WHERE (DELETESTS = 0) AND COLLECTORAREAID=@COLLECTORAREAID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:ImageButton ID="btnNewDtl" runat="server" ImageUrl="~/images/add.gif" 
                  CommandName="New" CausesValidation="False" Height="19px" />
                  <asp:GridView ID="GvCollectorDtl" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="DETAILID" 
                     DataSourceID="sdsCollDtlGrid" Width="100%" Caption="Collector Area Detail List" 
                     RowHeaderColumn="DETAILID">
                    <Columns>
                        <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="DETAILID" HeaderText="ID" SortExpression="DETAILID" >
                        <ItemStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="STARTZIP" HeaderText="Start Zip" 
                            SortExpression="STARTZIP" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ENDZIP" HeaderText="End Zip" 
                            SortExpression="ENDZIP" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="COLLECTORAREANAME" HeaderText="Collector Area" SortExpression="COLLECTORAREANAME" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                  <script type="text/javascript" src="../include/TableHighLight.js"></script>
                    <script type="text/javascript">
                        FormatTable("<%=GvCollectorDtl.ClientID%>")
                    </script>
                 <asp:Label ID="lblErrorDetail" runat="server" Width="100%" Font-Bold="False" 
                     style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                 <asp:FormView ID="fvCollectDtl" runat="server" DataSourceID="sdsCollDtl"
                    DefaultMode="Edit" Width="100%" DataKeyNames="DETAILID">
                    <EditItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Detail Id</td>
                                <td>
                                    <asp:Label ID="lblDetailID" runat="server" Text='<%# Eval("DETAILID") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    Start Zip</td>
                                <td>
                                    <asp:TextBox ID="txtStartZip" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("STARTZIP") %>' CssClass="required"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqStartZip" runat="server" ControlToValidate="txtStartZip" 
                                        Display="None" ErrorMessage="[START ZIP] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEStartZip" runat="server" HighlightCssClass="ErrHighLight" 
                                        TargetControlID="reqStartZip"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    End Zip</td>
                                <td>
                                    <asp:TextBox ID="txtEndZip" runat="server" Width="264px" MaxLength="10" Text='<%# Bind("ENDZIP") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqEndZip" runat="server" ControlToValidate="txtEndZip" Display="None" ErrorMessage="[END ZIP] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEEndZip" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEndZip"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="FooterStyle" colspan="2">
                                        &nbsp;<uc8:BtnUpdate ID="BtnUpdate3" runat="server" />
                                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <hr />
                                    </td>
                                </tr>
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
                                <td>
                                    Start Zip</td>
                                <td>
                                    <asp:TextBox ID="txtStartZip" runat="server" Width="100px" MaxLength="10" Text='<%# Bind("STARTZIP") %>' CssClass="required"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqStartZip" runat="server" ControlToValidate="txtStartZip" 
                                        Display="None" ErrorMessage="[START ZIP] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEStartZip" runat="server" HighlightCssClass="ErrHighLight" 
                                        TargetControlID="reqStartZip"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    End Zip</td>
                                <td>
                                    <asp:TextBox ID="txtEndZip" runat="server" Width="100px" MaxLength="10" Text='<%# Bind("ENDZIP") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqEndZip" runat="server" ControlToValidate="txtEndZip" Display="None" ErrorMessage="[END ZIP] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEEndZip" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEndZip"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2" class="FooterStyle">
                                    <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                    <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                        </table>
                    </InsertItemTemplate>
                </asp:FormView>   

                <asp:SqlDataSource ID="sdsCollDtlGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT CD.DETAILID, CD.STARTZIP, CD.ENDZIP, 
                                    (SELECT '(' + CAST(COLLECTORAREAID AS VARCHAR) + ') ' + COLLECTORAREANAME AS Expr1 
                                        FROM COLLECTORAREA WHERE (COLLECTORAREAID = CD.COLLECTORAREAID) 
                                        AND (Deletests = 0)) AS COLLECTORAREANAME
                                FROM COLLECTORAREA AS CR WITH(NOLOCK)
                                INNER JOIN COLLECTORAREADTL AS CD WITH(NOLOCK) ON CD.COLLECTORAREAID = CR.COLLECTORAREAID
                                WHERE (CD.Deletests = 0) AND (CR.COLLECTORAREAID = @COLLECTORAREAID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:SqlDataSource ID="sdsCollDtl" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT CD.DETAILID, CD.STARTZIP, CD.ENDZIP, 
                                    (SELECT '(' + CAST(COLLECTORAREAID AS VARCHAR) + ') ' + COLLECTORAREANAME AS Expr1 
                                        FROM COLLECTORAREA WHERE (COLLECTORAREAID = CD.COLLECTORAREAID) 
                                        AND (Deletests = 0)) AS COLLECTORAREANAME
                                FROM COLLECTORAREA AS CR WITH(NOLOCK)
                                INNER JOIN COLLECTORAREADTL AS CD WITH(NOLOCK) ON CD.COLLECTORAREAID = CR.COLLECTORAREAID
                                WHERE (CD.Deletests = 0) AND (CR.COLLECTORAREAID = @COLLECTORAREAID) AND (CD.DETAILID=@DETAILID)" 
                    DeleteCommand="UPDATE COLLECTORAREADTL SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (COLLECTORAREAID=@COLLECTORAREAID) AND (DETAILID = @DETAILID)" 
                    UpdateCommand="COLLECTORAREADTLUpdate" InsertCommand="COLLECTORAREADTLAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                                <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                        <asp:ControlParameter ControlID="GvCollectorDtl" Name="DETAILID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                        <asp:ControlParameter ControlID="GvCollectorDtl" Name="DETAILID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                          <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="DETAILID" Type="Int32" />
                        <asp:Parameter Name="STARTZIP" Type="String" />
                        <asp:Parameter Name="ENDZIP" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                         <asp:ControlParameter ControlID="gvData" Name="COLLECTORAREAID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="STARTZIP" Type="String" />
                        <asp:Parameter Name="ENDZIP" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </asp:View>
     </asp:MultiView>
</asp:Content>

