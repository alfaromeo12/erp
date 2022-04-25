<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="FirstStock.aspx.vb" Inherits="ParamWarehouse_FirstStock" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="FIRSTSTOCKCODE">Stock Code</asp:ListItem>
        <asp:ListItem Value="MATERIALMASTERNAME">Item Name</asp:ListItem>
        <asp:ListItem Value="STOCKTYPENAME">Stock Type</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="FIRSTSTOCKID" Caption="First Stock List" RowHeaderColumn="FIRSTSTOCKID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="FIRSTSTOCKID" HeaderText="ID"
                    SortExpression="FIRSTSTOCKID">
                </asp:BoundField>
                <asp:BoundField DataField="FIRSTSTOCKCODE" HeaderText="Stock&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="FIRSTSTOCKCODE" />
                <asp:BoundField DataField="MATERIALMASTERNAME" HeaderText="Item&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="MATERIALMASTERNAME" />
                <asp:BoundField DataField="STOCKTYPENAME" HeaderText="Stock&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="STOCKTYPENAME" />
                <asp:BoundField DataField="QTY" HeaderText="Qty&lt;br&gt;" HtmlEncode="False"
                    SortExpression="QTY" />
                <asp:BoundField DataField="MASTERUNITCODE" HeaderText="Unit&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="MASTERUNITCODE" />
                <asp:BoundField DataField="STOCKDATE" HeaderText="Stock&lt;br&gt;Date" HtmlEncode="False"
                    SortExpression="STOCKDATE" />
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description&lt;br&gt;" HtmlEncode="False"
                    SortExpression="DESCRIPTION" />
                <asp:BoundField DataField="CREATEDBY" HeaderText="Created&lt;br&gt;By" HtmlEncode="False"
                    SortExpression="CREATEDBY" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                SelectCommand="SELECT FS.FIRSTSTOCKID AS FIRSTSTOCKID
                                              ,FS.FIRSTSTOCKCODE AS FIRSTSTOCKCODE
                                              ,FS.MATERIALMASTERID AS MATERIALMASTERID
	                                          ,MM.MATERIALMASTERNAME AS MATERIALMASTERNAME
	                                          ,MM.MATERIALMASTERCODE AS MATERIALMASTERCODE
                                              ,FS.STOCKTYPEID AS STOCKTYPEID
	                                          ,ST.STOCKTYPENAME AS STOCKTYPENAME
                                              ,FS.QTY AS QTY
                                              ,FS.MASTERUNITID AS MASTERUNITID
	                                          ,MU.MASTERUNITCODE AS MASTERUNITCODE
                                              ,FS.STOCKDATE AS STOCKDATE
                                              ,FS.DESCRIPTION AS DESCRIPTION
                                              ,FS.CREATEDBY AS CREATEDBY
	                                          ,AU.UserName AS UserName
                                            FROM FIRSTSTOCK FS
	                                        LEFT OUTER JOIN MATERIALMASTER MM ON FS.MATERIALMASTERID = MM.MATERIALMASTERID
	                                        LEFT OUTER JOIN STOCKTYPE ST ON FS.STOCKTYPEID = ST.STOCKTYPEID
	                                        LEFT OUTER JOIN MASTERUNIT MU ON FS.MASTERUNITID = MU.MASTERUNITID
	                                        LEFT OUTER JOIN APPUSER AU ON FS.CREATEDBY = AU.UID WHERE (FS.DELETESTS = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="FIRSTSTOCKID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblStockID" runat="server" Text='<%# Eval("FIRSTSTOCKID")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                       Stock Code</td>
                    <td>
                        <asp:TextBox ID="txtStockCode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("FIRSTSTOCKCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqStockCode" runat="server" ControlToValidate="txtStockCode" Display="None" ErrorMessage="Stock Code Must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEStockCode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqStockCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Item Name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlMaterialMaster" runat="server" DataSourceID="sdsDDLMaterialMaster" Width="264px"
                                DataTextField="MATERIALMASTERNAME" DataValueField="MATERIALMASTERID" SelectedValue='<%# Bind("MATERIALMASTERID")%>'>
                            </asp:DropDownList>
                         
                        </td>
                    </tr>
                <tr>
                        <td>Stock Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStockType" runat="server" DataSourceID="sdsDDLStockType" Width="264px"
                                DataTextField="STOCKTYPENAME" DataValueField="STOCKTYPEID" SelectedValue='<%# Bind("STOCKTYPEID")%>'>
                            </asp:DropDownList>
                         
                        </td>
                    </tr>
                <tr>
                    <td>
                       Quantity</td>
                    <td>
                        <asp:TextBox ID="txtQty" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("QTY")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqQty" runat="server" ControlToValidate="txtQty" Display="None" ErrorMessage="Quantity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEQty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqQty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Unit &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="sdsDDLUnit" Width="264px"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("MASTERUNITID")%>'>
                            </asp:DropDownList>
                         
                        </td>
                    </tr>
                 <tr>
                        <td>
                    Stock Date</td>
                        <td>
                        <asp:TextBox ID="txtStockDate" Text='<%# Bind("STOCKDATE")%>' 
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgDateOfIssue" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;                  
                             <ajaxToolkit:CalendarExtender ID="ajaxCEDateOfIssue" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgDateOfIssue"
                        TargetControlID="txtStockDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateOfIssue" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtStockDate">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                    </tr>
                 <tr>
                    <td>
                        Description &nbsp; &nbsp;&nbsp; &nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtDescGarment" runat="server" Text='<%# Bind("DESCRIPTION")%>' Width="262PX" MaxLength="255" TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                 <tr>
                    <td>
                       Stock Code</td>
                    <td>
                        <asp:TextBox ID="txtStockCode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("FIRSTSTOCKCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqStockCode" runat="server" ControlToValidate="txtStockCode" Display="None" ErrorMessage="Stock Code Must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEStockCode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqStockCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Item Name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlMaterialMaster" runat="server" DataSourceID="sdsDDLMaterialMaster" Width="264px"
                                DataTextField="MATERIALMASTERNAME" DataValueField="MATERIALMASTERID" SelectedValue='<%# Bind("MATERIALMASTERID")%>' >
                            </asp:DropDownList>
                         
                        </td>
                    </tr>
                <tr>
                        <td>Stock Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStockType" runat="server" DataSourceID="sdsDDLStockType" Width="264px"
                                DataTextField="STOCKTYPENAME" DataValueField="STOCKTYPEID" SelectedValue='<%# Bind("STOCKTYPEID")%>'>
                            </asp:DropDownList>
                         
                        </td>
                    </tr>
                <tr>
                    <td>
                       Quantity</td>
                    <td>
                        <asp:TextBox ID="txtQty" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("QTY")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqQty" runat="server" ControlToValidate="txtQty" Display="None" ErrorMessage="Quantity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEQty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqQty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Unit &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="sdsDDLUnit" Width="264px"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("MASTERUNITID")%>'>
                            </asp:DropDownList>
                         
                        </td>
                    </tr>
                 <tr>
                        <td>
                    Stock Date</td>
                        <td>
                        <asp:TextBox ID="txtStockDate" Text='<%# Bind("STOCKDATE")%>' 
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgDateOfIssue" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;                  
                             <ajaxToolkit:CalendarExtender ID="ajaxCEDateOfIssue" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgDateOfIssue"
                        TargetControlID="txtStockDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateOfIssue" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtStockDate">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                    </tr>
                 <tr>
                    <td>
                        Description &nbsp; &nbsp;&nbsp; &nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtDescGarment" runat="server" Text='<%# Bind("DESCRIPTION")%>' Width="262PX" MaxLength="255" TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert2" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
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
    
    <asp:SqlDataSource ID="sdsDDLStockType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS STOCKTYPEID, '[ALL]' AS STOCKTYPENAME UNION ALL 
                                        SELECT STOCKTYPEID, STOCKTYPENAME FROM STOCKTYPE WHERE (DELETESTS= 0) ORDER BY STOCKTYPENAME"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsDDLMaterialMaster" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS MATERIALMASTERID, '[ALL]' AS MATERIALMASTERNAME UNION ALL 
                                        SELECT MATERIALMASTERID, MATERIALMASTERNAME FROM MATERIALMASTER WHERE (DELETESTS= 0) ORDER BY MATERIALMASTERNAME"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsDDLUnit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS MASTERUNITID, '[ALL]' AS MASTERUNITCODE UNION ALL 
                                        SELECT MASTERUNITID, MASTERUNITCODE FROM MASTERUNIT WHERE (DELETESTS= 0) ORDER BY MASTERUNITCODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                    SelectCommand="SELECT FS.FIRSTSTOCKID AS FIRSTSTOCKID, FS.FIRSTSTOCKCODE AS FIRSTSTOCKCODE 
                                  ,FS.MATERIALMASTERID AS MATERIALMASTERID
	                              ,MM.MATERIALMASTERNAME AS MATERIALMASTERNAME
	                              ,MM.MATERIALMASTERCODE AS MATERIALMASTERCODE
                                  ,FS.STOCKTYPEID AS STOCKTYPEID
	                              ,ST.STOCKTYPENAME AS STOCKTYPENAME
                                  ,FS.QTY AS QTY
                                  ,FS.MASTERUNITID AS MASTERUNITID
	                              ,MU.MASTERUNITCODE AS MASTERUNITCODE
                                  ,FS.STOCKDATE AS STOCKDATE
                                  ,FS.DESCRIPTION AS DESCRIPTION
                                  ,FS.CREATEDBY AS CREATEDBY
	                              ,AU.UserName AS UserName
                                FROM FIRSTSTOCK FS
	                            LEFT OUTER JOIN MATERIALMASTER MM ON FS.MATERIALMASTERID = MM.MATERIALMASTERID
	                            LEFT OUTER JOIN STOCKTYPE ST ON FS.STOCKTYPEID = ST.STOCKTYPEID
	                            LEFT OUTER JOIN MASTERUNIT MU ON FS.MASTERUNITID = MU.MASTERUNITID
	                            LEFT OUTER JOIN APPUSER AU ON FS.CREATEDBY = AU.UID WHERE (FS.FIRSTSTOCKID = @FIRSTSTOCKID)" DeleteCommand="UPDATE FIRSTSTOCK SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE FIRSTSTOCKID=@FIRSTSTOCKID" UpdateCommand="FIRSTSTOCKUPDATE" InsertCommand="FIRSTSTOCKADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="FIRSTSTOCKID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="FIRSTSTOCKID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FIRSTSTOCKID" Type="Int32" />
            <asp:Parameter Name="FIRSTSTOCKCODE" Type="String" />
            <asp:Parameter Name="MATERIALMASTERID" Type="Int32" />
            <asp:Parameter Name="STOCKTYPEID" Type="Int32" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="MASTERUNITID" Type="Int32" />
            <asp:Parameter Name="STOCKDATE" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="FIRSTSTOCKCODE" Type="String" />
            <asp:Parameter Name="MATERIALMASTERID" Type="Int32" />
            <asp:Parameter Name="STOCKTYPEID" Type="Int32" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="MASTERUNITID" Type="Int32" />
            <asp:Parameter Name="STOCKDATE" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

