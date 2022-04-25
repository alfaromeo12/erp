<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InventoryRecieve.aspx.vb" Inherits="ParamWarehouse_InventoryRecieve" %>


<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="~/UserControl/BtnDelete.ascx" TagPrefix="uc1" TagName="BtnDelete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="INVENTORYRECVCODE">INVENTORY Name</asp:ListItem>
        <asp:ListItem Value="PURCHASINGORDERCODE">PO Number</asp:ListItem>
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
            DataKeyNames="INVENTORYRECVID" Caption="Inventory Receive" RowHeaderColumn="INVENTORYRECVID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="INVENTORYRECVID" HeaderText="ID" Visible="false"
                    SortExpression="INVENTORYRECVID">
                </asp:BoundField>
                <asp:BoundField DataField="INVENTORYRECVCODE" HeaderText="Inventory&lt;br&gt;Receive&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="INVENTORYRECVCODE" />
                <asp:BoundField DataField="DELIVERYORDER" HeaderText="Delivery&lt;br&gt;Order" HtmlEncode="False"
                    SortExpression="DELIVERYORDER" />
                <asp:BoundField DataField="MATERIALMASTERNAME" HeaderText="Item&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="MATERIALMASTERNAME" />
                <asp:BoundField DataField="STOCKTYPENAME" HeaderText="Stock&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="STOCKTYPENAME" />
                <asp:BoundField DataField="MATERIALGROUPNAME" HeaderText="Item Group&lt;br&gt;Order&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="MATERIALGROUPNAME" />
                <asp:BoundField DataField="TOTALQTY" HeaderText="QTY&lt;br&gt;Order" HtmlEncode="False"
                    SortExpression="TOTALQTY" />
                <asp:BoundField DataField="MASTERUNITCODE" HeaderText="Unit&lt;br&gt;" HtmlEncode="False"
                    SortExpression="MASTERUNITCODE" />
                <asp:BoundField DataField="DELIVERYORDER" HeaderText="Delivery&lt;br&gt;Order" HtmlEncode="False"
                    SortExpression="DELIVERYORDER" />
                <asp:BoundField DataField="NOTES" HeaderText="Notes&lt;br&gt;" HtmlEncode="False"
                    SortExpression="NOTES" />
                <%--<asp:BoundField DataField="POBUYER" HeaderText="PO&lt;br&gt;Buyer" HtmlEncode="False"
                    SortExpression="POBUYER" />
                <asp:BoundField DataField="SALESORDERCODE" HeaderText="SO&lt;br&gt;Number" HtmlEncode="False"
                    SortExpression="SALESORDERCODE" />--%>
                <asp:BoundField DataField="INPUTDATE" HeaderText="Inpute&lt;br&gt;Date" HtmlEncode="False"
                    SortExpression="INPUTDATE" />
                <asp:BoundField DataField="USERNAME" HeaderText="Receive&lt;br&gt;By" HtmlEncode="False"
                    SortExpression="USERNAME" />
                <asp:BoundField DataField="STATUS" HeaderText="Status&lt;br&gt;" HtmlEncode="False"
                    SortExpression="STATUS" />                
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                    SelectCommand="SELECT IH.INVENTORYRECVID AS INVENTORYRECVID
                                  ,IH.INVENTORYRECVCODE AS INVENTORYRECVCODE
	                              ,IH.MATERIALMASTERID AS MATERIALMASTERID
                                  ,IH.DELIVERYORDER AS DELIVERYORDER
	                              ,MM.MATERIALMASTERNAME AS MATERIALMASTERNAME
                                  ,IH.STOCKTYPEID AS STOCKTYPEID
                                  ,ST.STOCKTYPENAME AS STOCKTYPENAME
                                  ,IH.MATERIALGROUPID AS MATERIALGROUPID
                                  ,MG.MATERIALGROUPNAME AS MATERIALGROUPNAME  	  
                                  ,IH.TOTALQTY AS TOTALQTY
                                  ,IH.MASTERUNITID AS MASTERUNITID
	                              ,MU.MASTERUNITCODE AS MASTERUNITCODE
	                              ,IHD.POBUYER AS POBUYER
	                              ,IHD.SALESORDERID AS SALESORDERID
	                              ,SO.SALESORDERCODE AS SALESORDERCODE
                                  ,IH.INPUTDATE AS INPUTDATE
                                  ,IH.RECEIVEBY AS RECEIVEBY 
                                  ,AU.UserName AS USERNAME
                                  ,PG.NAME AS STATUS
                                  ,IH.NOTES AS NOTES      
                            FROM INVENTORYRECV IH
                            LEFT OUTER JOIN INVENTORYRECVDTL IHD ON IH.INVENTORYRECVID = IHD.INVENTORYRECVDTLID
                            LEFT OUTER JOIN MASTERUNIT MU ON IH.MASTERUNITID = MU.MASTERUNITID
                            LEFT OUTER JOIN SALESORDER SO ON IHD.SALESORDERID = SO.SALESORDERID
                            LEFT OUTER JOIN WORKSHEETHDR WS ON IHD.WORKSHEETHDRID = WS.WORKSHEETHDRID
                            LEFT OUTER JOIN MASTERBUYER MB ON IHD.BUYERID = MB.BUYERID
                            LEFT OUTER JOIN MASTERSUPPLIER MS ON IHD.SUPPLIERID = MS.SUPPLIERID
                            LEFT OUTER JOIN MASTERRACK MR ON IHD.MASTERRACKID = MR.MASTERRACKID
                            LEFT OUTER JOIN APPUSER AU ON IH.RECEIVEBY = AU.UID
                            INNER JOIN PARAMGLOBAL PG ON IH.STATUS = PG.CODE
                            LEFT OUTER JOIN MATERIALMASTER MM ON IH.MATERIALMASTERID = MM.MATERIALMASTERID 
                            LEFT OUTER JOIN STOCKTYPE ST ON IH.STOCKTYPEID = ST.STOCKTYPEID 
                            LEFT OUTER JOIN MATERIALGROUP MG ON IH.MATERIALGROUPID = MG.MATERIALGROUPID WHERE (IH.DELETESTS = 0) AND PG.TYPE='INVSTS'"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="INVENTORYRECVID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        </td>
                    <td>
                        <asp:Label ID="lblInventoryRecvID" runat="server" Text='<%# Eval("INVENTORYRECVID")%>' Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtInvRecvCode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("INVENTORYRECVCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtInvRecvCode" Display="None" ErrorMessage="Inventory Receive Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Delivery Order</td>
                    <td>
                        <asp:TextBox ID="txtDeliOrder" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("DELIVERYORDER")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDelOrder" runat="server" ControlToValidate="txtDeliOrder" Display="None" ErrorMessage="Delivery Order must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDelOrder" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDelOrder">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Stock Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStockType" runat="server" Width="264px" DataSourceID="sdsStockType" AutoPostBack="true"
                                DataTextField="STOCKTYPENAME" DataValueField="STOCKTYPEID" SelectedValue='<%# Bind("STOCKTYPEID")%>'>
                            </asp:DropDownList>
                             </td>
                    </tr>
                <tr>
                        <td>Group &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtGroup" runat="server" MaxLength="50" 
							Text='<%# Eval("MATERIALGROUPNAME")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button7" noenter onclick="GroupFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button8" onclick="GroupClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidGroup" runat="server" Value='<%# Bind("MATERIALGROUPID")%>' />
                            </td>
                    </tr>
                 <tr>
                        <td>Item&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtItemMaster" runat="server" MaxLength="150" 
							Text='<%# Eval("MATERIALMASTERNAME")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button11" noenter onclick="ItemFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button12" onclick="ItemClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidItem" runat="server" Value='<%# Bind("MATERIALMASTERID")%>' />
                            </td>
                    </tr>
                <tr>
                    <td>
                       QTY</td>
                    <td>
                        <asp:TextBox ID="txtQTYHDR" runat="server" Font-Bold="True"  Width="160"
                            Text='<%# Bind("TOTALQTY")%>'></asp:TextBox>
                           <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="sdsUnit" Width="100px"
                                DataTextField="MASTERUNITNAME" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("MASTERUNITID")%>'>
                            </asp:DropDownList></td>
               <tr>
                        <td>
                    Input Date</td>
                        <td>
                        <asp:TextBox ID="txtdateOfIssue" Text='<%# Bind("INPUTDATE")%>' 
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgDateOfIssue" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;                  
                             <ajaxToolkit:CalendarExtender ID="ajaxCEDateOfIssue" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgDateOfIssue"
                        TargetControlID="txtdateOfIssue">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateOfIssue" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtdateOfIssue">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                    </tr>
                 <tr>
                    <td>
                        Notes &nbsp; &nbsp;&nbsp; &nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtDesc" runat="server" Text='<%# Bind("NOTES")%>' MaxLength="255" width="264px"  TextMode="MultiLine"></asp:TextBox></td>
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
                         <asp:Button ID="btnApprove" runat="server" CausesValidation="False" CommandName="Approve"
                            OnClientClick='return(confirm("Are you sure want to Approve data ?"))' 
                            Style="font-size: 8pt;
                            cursor: pointer; background-position: left top; background-image: url(../images/approve.gif); background-repeat: no-repeat; text-align: right;" 
                            Text="Approve" ToolTip="Approve Data" Width="55px" OnClick="btnApprove_Click" />
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
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtInvRecvCode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("INVENTORYRECVCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtInvRecvCode" Display="None" ErrorMessage="Inventory Receive Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Delivery Order</td>
                    <td>
                        <asp:TextBox ID="txtDeliOrder" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("DELIVERYORDER")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDelOrder" runat="server" ControlToValidate="txtDeliOrder" Display="None" ErrorMessage="Delivery Order must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDelOrder" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDelOrder">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Stock Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStockType" runat="server" Width="264px" DataSourceID="sdsStockType" AutoPostBack="true"
                                DataTextField="STOCKTYPENAME" DataValueField="STOCKTYPEID" SelectedValue='<%# Bind("STOCKTYPEID")%>'>
                            </asp:DropDownList>
                             </td>
                    </tr>
                <tr>
                        <td>Group &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtGroup" runat="server" MaxLength="50" 
							Text='<%# Eval("MATERIALGROUPCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button7" noenter onclick="GroupFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button8" onclick="GroupClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidGroup" runat="server" Value='<%# Bind("MATERIALGROUPID")%>' />
                            </td>
                    </tr>
                 <tr>
                        <td>Item&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtItemMaster" runat="server" MaxLength="150" 
							Text='<%# Eval("MATERIALMASTERCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button11" noenter onclick="ItemFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button12" onclick="ItemClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidItem" runat="server" Value='<%# Bind("MATERIALMASTERID")%>' />
                            </td>
                    </tr>
                <tr>
                    <td>
                       QTY</td>
                    <td>
                        <asp:TextBox ID="txtQTYHDR" runat="server" Font-Bold="True"  Width="160"
                            Text='<%# Bind("TOTALQTY")%>'></asp:TextBox>
                           <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="sdsUnit" Width="100px"
                                DataTextField="MASTERUNITNAME" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("MASTERUNITID")%>'>
                            </asp:DropDownList></td>
               <tr>
                        <td>
                    Input Date</td>
                        <td>
                        <asp:TextBox ID="txtdateOfIssue" Text='<%# Bind("INPUTDATE")%>' 
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgDateOfIssue" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            &nbsp;                  
                             <ajaxToolkit:CalendarExtender ID="ajaxCEDateOfIssue" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgDateOfIssue"
                        TargetControlID="txtdateOfIssue">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateOfIssue" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtdateOfIssue">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                    </tr>
                 <tr>
                    <td>
                        Notes &nbsp; &nbsp;&nbsp; &nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtDesc" runat="server" Text='<%# Bind("NOTES")%>' MaxLength="255" width="264px" TextMode="MultiLine"></asp:TextBox></td>
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
    <asp:SqlDataSource ID="sdsUnit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS MASTERUNITID, '[DISPLAY ALL]' AS MASTERUNITNAME UNION ALL 
                                        SELECT MASTERUNITID, MASTERUNITNAME FROM MASTERUNIT WHERE (DELETESTS= 0) ORDER BY MASTERUNITNAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStockType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS STOCKTYPEID, '[DISPLAY ALL]' AS STOCKTYPENAME UNION ALL 
                                            SELECT STOCKTYPEID, STOCKTYPENAME FROM STOCKTYPE WHERE (DELETESTS= 0) ORDER BY STOCKTYPENAME"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
                                                        SelectCommand=" SELECT IH.INVENTORYRECVID AS INVENTORYRECVID
                                                                              ,IH.INVENTORYRECVCODE AS INVENTORYRECVCODE
                                                                              ,IH.DELIVERYORDER AS DELIVERYORDER
	                                                                          ,IH.MATERIALMASTERID AS MATERIALMASTERID
	                                                                          ,MM.MATERIALMASTERNAME AS MATERIALMASTERNAME
	                                                                          ,MM.MATERIALMASTERCODE AS MATERIALMASTERCODE
                                                                              ,IH.STOCKTYPEID AS STOCKTYPEID
	                                                                          ,ST.STOCKTYPENAME AS STOCKTYPENAME
	                                                                          ,ST.STOCKTYPECODE AS STOCKTYPECODE
                                                                              ,IH.MATERIALGROUPID AS MATERIALGROUPID
	                                                                          ,MG.MATERIALGROUPNAME AS MATERIALGROUPNAME
	                                                                          ,MG.MATERIALGROUPCODE AS MATERIALGROUPCODE
                                                                              ,IH.MATERIALMASTERID AS MATERIALMASTERID	  	  
                                                                              ,IH.TOTALQTY AS TOTALQTY
	                                                                          ,IH.MASTERUNITID AS MASTERUNITID
	                                                                          ,MU.MASTERUNITCODE AS MASTERUNITCODE
	                                                                          ,IHD.POBUYER AS POBUYER
	                                                                          ,IHD.SALESORDERID AS SALESORDERID
	                                                                          ,SO.SALESORDERCODE AS SALESORDERCODE      
                                                                              ,IH.INPUTDATE AS INPUTDATE
                                                                              ,IH.RECEIVEBY AS RECEIVEBY 
	                                                                          ,AU.UserName AS USERNAME
                                                                              ,IH.STATUS AS STATUS  
	                                                                          ,IH.NOTES AS NOTES    
                                                                        FROM INVENTORYRECV IH
                                                                        LEFT OUTER JOIN INVENTORYRECVDTL IHD ON IH.INVENTORYRECVID = IHD.INVENTORYRECVDTLID
                                                                        LEFT OUTER JOIN MASTERUNIT MU ON IHD.MASTERUNITID = MU.MASTERUNITID
                                                                        LEFT OUTER JOIN SALESORDER SO ON IHD.SALESORDERID = SO.SALESORDERID
                                                                        LEFT OUTER JOIN WORKSHEETHDR WS ON IHD.WORKSHEETHDRID = WS.WORKSHEETHDRID
                                                                        LEFT OUTER JOIN MASTERBUYER MB ON IHD.BUYERID = MB.BUYERID
                                                                        LEFT OUTER JOIN MASTERSUPPLIER MS ON IHD.SUPPLIERID = MS.SUPPLIERID
                                                                        LEFT OUTER JOIN MASTERRACK MR ON IHD.MASTERRACKID = MR.MASTERRACKID
                                                                        LEFT OUTER JOIN APPUSER AU ON IH.RECEIVEBY = AU.UID
                                                                        INNER JOIN PARAMGLOBAL PG ON IH.STATUS = PG.CODE
                                                                        LEFT OUTER JOIN MATERIALMASTER MM ON IH.MATERIALMASTERID = MM.MATERIALMASTERID
                                                                        LEFT OUTER JOIN STOCKTYPE ST ON IH.STOCKTYPEID = ST.STOCKTYPEID
                                                                        LEFT OUTER JOIN MATERIALGROUP MG ON IH.MATERIALGROUPID = MG.MATERIALGROUPID WHERE (IH.INVENTORYRECVID = @INVENTORYRECVID)" DeleteCommand="UPDATE INVENTORYRECV SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE INVENTORYRECVID=@INVENTORYRECVID" UpdateCommand="INVENTORYRECVUPDATE" InsertCommand="INVENTORYRECVADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="INVENTORYRECVID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="INVENTORYRECVID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="INVENTORYRECVID" Type="Int32" />
            <asp:Parameter Name="INVENTORYRECVCODE" Type="String" />
            <asp:Parameter Name="DELIVERYORDER" Type="String" />
            <asp:Parameter Name="STOCKTYPEID" Type="Int32" />
            <asp:Parameter Name="MATERIALGROUPID" Type="Int32" />
            <asp:Parameter Name="MATERIALMASTERID" Type="Int32" />
            <asp:Parameter Name="TOTALQTY" Type="Decimal" />
            <asp:Parameter Name="MASTERUNITID" Type="Int32" />
            <asp:Parameter Name="INPUTDATE" Type="String" />
            <asp:Parameter Name="NOTES" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
             <asp:Parameter Name="INVENTORYRECVCODE" Type="String" />
            <asp:Parameter Name="DELIVERYORDER" Type="String" />
            <asp:Parameter Name="STOCKTYPEID" Type="Int32" />
            <asp:Parameter Name="MATERIALGROUPID" Type="Int32" />
            <asp:Parameter Name="MATERIALMASTERID" Type="Int32" />
            <asp:Parameter Name="TOTALQTY" Type="Decimal" />
            <asp:Parameter Name="MASTERUNITID" Type="Int32" />
            <asp:Parameter Name="INPUTDATE" Type="String" />
            <asp:Parameter Name="NOTES" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    
     <asp:DropDownList ID="ddlCriteriaDtl" runat="server">
        <asp:ListItem Value="INVENTORYRECVCODE">Item Name</asp:ListItem>
        <asp:ListItem Value="PURCHASINGORDERCODE">PO Number</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearchDtl" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearchDtl" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />
    <asp:ImageButton ID="imgBtnNewDetail" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearchDtl" runat="server" TargetControlID="txtSearchDtl"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    
        <asp:GridView ID="gvDataDtl" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGridDtl" Width="100%" 
            DataKeyNames="INVENTORYRECVDTLID,INVENTORYRECVID" Caption="Inventory Receive Detail" RowHeaderColumn="INVENTORYRECVDTLID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="INVENTORYRECVDTLID" HeaderText="ID" Visible="false"
                    SortExpression="INVENTORYRECVDTLID">
                </asp:BoundField>
                <asp:BoundField DataField="INVENTORYRECVDTLCODE" HeaderText="Inventory&lt;br&gt;Receive&lt;br&gt;Detail Code" HtmlEncode="False"
                    SortExpression="INVENTORYRECVDTLCODE" />
                <asp:BoundField DataField="INVENTORYRECVCODE" HeaderText="Header&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="INVENTORYRECVCODE" />
                <asp:BoundField DataField="SECTIONNO" HeaderText="Section&lt;br&gt;No" HtmlEncode="False"
                    SortExpression="SECTIONNO" />
                <asp:BoundField DataField="DETAILUNIT" HeaderText="Detail&lt;br&gt;Unit" HtmlEncode="False"
                    SortExpression="DETAILUNIT" />
                <asp:BoundField DataField="MASTERUNITCODE" HeaderText="Unit&lt;br&gt;Order&lt;br&gt;" HtmlEncode="False"
                    SortExpression="MASTERUNITCODE" />
                <asp:BoundField DataField="LOTNUMBER" HeaderText="Lot&lt;br&gt;Number" HtmlEncode="False"
                    SortExpression="LOTNUMBER" />
                <asp:BoundField DataField="POBUYER" HeaderText="PO&lt;br&gt;Buyer" HtmlEncode="False"
                    SortExpression="POBUYER" />
                <asp:BoundField DataField="SALESORDERCODE" HeaderText="SO&lt;br&gt;Number" HtmlEncode="False"
                    SortExpression="SALESORDERCODE" />
                <asp:BoundField DataField="WORKSHEETHDRNUMBER" HeaderText="WS&lt;br&gt;Number" HtmlEncode="False"
                    SortExpression="WORKSHEETHDRNUMBER" />
                <asp:BoundField DataField="BUYERNAME" HeaderText="Buyer&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="BUYERNAME" />
                <asp:BoundField DataField="SUPPLIERNAME" HeaderText="Supplier&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="SUPPLIERNAME" />
                <asp:BoundField DataField="MASTERRACKCODE" HeaderText="Rack&lt;br&gt;Position" HtmlEncode="False"
                    SortExpression="MASTERRACKCODE" />
                <asp:BoundField DataField="STATUS" HeaderText="Status&lt;br&gt;" HtmlEncode="False"
                    SortExpression="STATUS" /> 
                <asp:BoundField DataField="NOTES" HeaderText="Notes&lt;br&gt;" HtmlEncode="False"
                    SortExpression="NOTES" />                
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    
    <asp:SqlDataSource ID="sdsGridDtl" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                    SelectCommand="SELECT IHD.INVENTORYRECVDTLID AS INVENTORYRECVDTLID
                                                  ,IHD.INVENTORYRECVDTLCODE AS INVENTORYRECVDTLCODE
                                                  ,IHD.INVENTORYRECVID AS INVENTORYRECVID
	                                              ,IH.INVENTORYRECVCODE AS INVENTORYRECVCODE
                                                  ,IHD.SECTIONNO AS SECTIONNO
                                                  ,IHD.DETAILUNIT AS DETAILUNIT
                                                  ,IHD.MASTERUNITID AS MASTERUNITID
	                                              ,MU.MASTERUNITNAME AS MASTERUNITNAME
	                                              ,MU.MASTERUNITCODE AS MASTERUNITCODE
                                                  ,IHD.LOTNUMBER AS LOTNUMBER
                                                  ,IHD.POBUYER AS POBUYER
                                                  ,IHD.SALESORDERID AS SALESORDERID
	                                              ,SO.SALESORDERCODE AS SALESORDERCODE
                                                  ,IHD.WORKSHEETHDRID AS WORKSHEETHDRID
	                                              ,WS.WORKSHEETHDRNUMBER AS WORKSHEETHDRNUMBER
                                                  ,IHD.BUYERID AS BUYERID
	                                              ,MB.BUYERCODE AS BUYERCODE
	                                              ,MB.BUYERNAME AS BUYERNAME
                                                  ,IHD.SUPPLIERID AS SUPPLIERID
	                                              ,MS.SUPPLIERCODE AS SUPPLIERCODE
	                                              ,MS.SUPPLIERNAME AS SUPPLIERNAME
                                                  ,IHD.MASTERRACKID AS MASTERRACKID
	                                              ,MR.MASTERRACKCODE AS MASTERRACKCODE
	                                              ,PG.NAME AS STATUS
                                                  ,IHD.NOTES AS NOTES      
                                              FROM INVENTORYRECVDTL IHD
                                              LEFT OUTER JOIN INVENTORYRECV IH ON IHD.INVENTORYRECVID = IH.INVENTORYRECVID
                                              LEFT OUTER JOIN MASTERUNIT MU ON IHD.MASTERUNITID = MU.MASTERUNITID
                                              LEFT OUTER JOIN SALESORDER SO ON IHD.SALESORDERID = SO.SALESORDERID
                                              LEFT OUTER JOIN WORKSHEETHDR WS ON IHD.WORKSHEETHDRID = WS.WORKSHEETHDRID
                                              LEFT OUTER JOIN MASTERBUYER MB ON IHD.BUYERID = MB.BUYERID
                                              LEFT OUTER JOIN MASTERSUPPLIER MS ON IHD.SUPPLIERID = MS.SUPPLIERID
                                              INNER JOIN PARAMGLOBAL PG ON IHD.STATUS = PG.CODE
                                              LEFT OUTER JOIN MASTERRACK MR ON IHD.MASTERRACKID = MR.MASTERRACKID WHERE (IHD.DELETESTS = 0) AND IH.INVENTORYRECVID=@INVENTORYRECVID AND PG.TYPE='INVSTS'">
         <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="INVENTORYRECVID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:FormView ID="fvDataDtl" runat="server" DataSourceID="sdsFormDtl"
        DefaultMode="Edit" Width="100%" DataKeyNames="INVENTORYRECVDTLID,INVENTORYRECVID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                   
                    <td>
                        <asp:TextBox ID="lblInventoryRecvDtlID" runat="server" Text='<%# Eval("INVENTORYRECVDTLID")%>' Visible="false"></asp:TextBox></td>
                </tr>
                 <tr>
                   
                    <td>
                        <asp:Label ID="lblInventoryRecvHdrID" runat="server"  Text='<%# DirectCast(fvData.FindControl("lblInventoryRecvID"), Label).Text%>' Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtInvRecvCodeDtl" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("INVENTORYRECVDTLCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCodeDtl" runat="server" ControlToValidate="txtInvRecvCodeDtl" Display="None" ErrorMessage="Inventory Receive Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECodeDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCodeDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Section Number</td>
                    <td>
                        <asp:TextBox ID="txtSectionNo" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("SECTIONNO")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqSectionDtl" runat="server" ControlToValidate="txtSectionNo" Display="None" ErrorMessage="Section Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCESectionDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSectionDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Detail Unit</td>
                    <td>
                        <asp:TextBox ID="txtDetailUnit" runat="server" Width="160px" MaxLength="100" Text='<%# Bind("DETAILUNIT")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDetailUnit" runat="server" ControlToValidate="txtDetailUnit" Display="None" ErrorMessage="Detail Unit must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDetailUnit" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDetailUnit">
                            </ajaxToolkit:ValidatorCalloutExtender> <asp:DropDownList ID="ddlUnitDetail" runat="server" DataSourceID="sdsUnit" Width="100px"
                                DataTextField="MASTERUNITNAME" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("MASTERUNITID")%>'>
                            </asp:DropDownList>
                    </td>
                </tr>
                 <tr>
                    <td>
                       Lot Number</td>
                    <td>
                        <asp:TextBox ID="txtLotNumber" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("LOTNUMBER")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqLotNumber" runat="server" ControlToValidate="txtLotNumber" Display="None" ErrorMessage="Lot Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCELotNumber" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqLotNumber">
                            </ajaxToolkit:ValidatorCalloutExtender> 
                    </td>
                </tr>
                <tr>
                    <td>
                       PO Buyer</td>
                    <td>
                        <asp:TextBox ID="txtPOBuyer" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("POBUYER")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqPOBuyer" runat="server" ControlToValidate="txtPOBuyer" Display="None" ErrorMessage="PO Buyer must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPOBuyer" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPOBuyer">
                            </ajaxToolkit:ValidatorCalloutExtender> 
                    </td>
                </tr>
                <tr>
                        <td>Sales Order &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtSO" runat="server" MaxLength="50" 
							Text='<%# Eval("SALESORDERCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="btnSO" noenter onclick="SOFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="btnSoClear" onclick="SOClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidSO" runat="server" Value='<%# Bind("SALESORDERID")%>' />
                            </td>
                    </tr>
                 <tr>
                        <td>WS Number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtWS" runat="server" MaxLength="150" 
							Text='<%# Eval("WORKSHEETHDRNUMBER")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="btnWS" noenter onclick="WSFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="btnWSClear" onclick="WSClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidWS" runat="server" Value='<%# Bind("WORKSHEETHDRID")%>' />
                            </td>
                    </tr>
                 <tr>
                        <td>Buyer&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtBuyer" runat="server" MaxLength="150" 
							Text='<%# Eval("BUYERNAME")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button13" noenter onclick="BuyerFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button14" onclick="BuyerClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidBuyer" runat="server" Value='<%# Bind("BUYERID")%>' />
                            </td>
                    </tr>
                          <tr>
                            <td>Supplier&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            </td>
                            <td>
						    <asp:TextBox ID="txtSupplier" runat="server" MaxLength="50" 
							    Text='<%# Eval("SUPPLIERNAME")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                                <input
						        id="Button5" noenter onclick="SupplierFind();" style="background-position: left;
						        background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						         text-align: right" type="button" value="Find" />
                                <input
							    id="Button6" onclick="SupplierClear();" style="background-position: left;
							    background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							     text-align: right" type="button" noenter value="Clear" />
						    <asp:HiddenField ID="hidSupplier" runat="server" Value='<%# Bind("SUPPLIERID")%>' />
                                </td>
                        </tr>
                      <tr>
                        <td>Rack Position&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtRack" runat="server" MaxLength="150" 
							Text='<%# Eval("MASTERRACKNAME")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="btnRackFind" noenter onclick="RackFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="btnRackClear" onclick="RackClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidRack" runat="server" Value='<%# Bind("MASTERRACKID")%>' />
                            </td>
                    </tr>
               
                
                        <tr>
                            <td>Notes &nbsp; &nbsp;&nbsp; &nbsp;</td>
                            <td>
                                <asp:TextBox ID="txtDesc" runat="server" MaxLength="255" Text='<%# Bind("NOTES")%>' TextMode="MultiLine" width="264px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="FooterStyle" colspan="2">
                                <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                                &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                <asp:Button ID="btnApproveDtl" runat="server" CausesValidation="False" CommandName="Approve" OnClick="btnApproveDtl_Click" OnClientClick="return(confirm(&quot;Are you sure want to Approve data ?&quot;))" Style="font-size: 8pt; cursor: pointer; background-position: left top; background-image: url(../images/approve.gif); background-repeat: no-repeat; text-align: right;" Text="Approve" ToolTip="Approve Data" Width="55px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <hr />
                            </td>
                        </tr>
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
                        </td>
                    <td>
                        <asp:Label ID="lblInventoryRecvHdrID" runat="server"  Text='<%# DirectCast(fvData.FindControl("lblInventoryRecvID"), Label).Text%>' Visible="true"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtInvRecvCodeDtl" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("INVENTORYRECVDTLCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCodeDtl" runat="server" ControlToValidate="txtInvRecvCodeDtl" Display="None" ErrorMessage="Inventory Receive Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECodeDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCodeDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Section Number</td>
                    <td>
                        <asp:TextBox ID="txtSectionNo" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("SECTIONNO")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqSectionDtl" runat="server" ControlToValidate="txtSectionNo" Display="None" ErrorMessage="Section Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCESectionDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSectionDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Detail Unit</td>
                    <td>
                        <asp:TextBox ID="txtDetailUnit" runat="server" Width="160px" MaxLength="100" Text='<%# Bind("DETAILUNIT")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDetailUnit" runat="server" ControlToValidate="txtDetailUnit" Display="None" ErrorMessage="Detail Unit must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDetailUnit" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDetailUnit">
                            </ajaxToolkit:ValidatorCalloutExtender> <asp:DropDownList ID="ddlUnitDetail" runat="server" DataSourceID="sdsUnit" Width="100px"
                                DataTextField="MASTERUNITNAME" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("MASTERUNITID")%>'>
                            </asp:DropDownList>
                    </td>
                </tr>
                 <tr>
                    <td>
                       Lot Number</td>
                    <td>
                        <asp:TextBox ID="txtLotNumber" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("LOTNUMBER")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqLotNumber" runat="server" ControlToValidate="txtLotNumber" Display="None" ErrorMessage="Lot Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCELotNumber" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqLotNumber">
                            </ajaxToolkit:ValidatorCalloutExtender> 
                    </td>
                </tr>
                <tr>
                    <td>
                       PO Buyer</td>
                    <td>
                        <asp:TextBox ID="txtPOBuyer" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("POBUYER")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqPOBuyer" runat="server" ControlToValidate="txtPOBuyer" Display="None" ErrorMessage="PO Buyer must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPOBuyer" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPOBuyer">
                            </ajaxToolkit:ValidatorCalloutExtender> 
                    </td>
                </tr>
                <tr>
                        <td>Sales Order &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtSO" runat="server" MaxLength="50" 
							Text='<%# Eval("SALESORDERCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="btnSO" noenter onclick="SOFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="btnSoClear" onclick="SOClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidSO" runat="server" Value='<%# Bind("SALESORDERID")%>' />
                            </td>
                    </tr>
                 <tr>
                        <td>WS Number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtWS" runat="server" MaxLength="150" 
							Text='<%# Eval("WORKSHEETHDRNUMBER")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="btnWS" noenter onclick="WSFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="btnWSClear" onclick="WSClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidWS" runat="server" Value='<%# Bind("WORKSHEETHDRID")%>' />
                            </td>
                    </tr>
                  <tr>
                        <td>Buyer&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtBuyer" runat="server" MaxLength="150" 
							Text='<%# Eval("BUYERCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button13" noenter onclick="BuyerFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button14" onclick="BuyerClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidBuyer" runat="server" Value='<%# Bind("BUYERID")%>' />
                            </td>
                    </tr>
                 <tr>
                            <td>Supplier&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            </td>
                            <td>
						    <asp:TextBox ID="txtSupplier" runat="server" MaxLength="50" 
							    Text='<%# Eval("SUPPLIERCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                                <input
						        id="Button5" noenter onclick="SupplierFind();" style="background-position: left;
						        background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						         text-align: right" type="button" value="Find" />
                                <input
							    id="Button6" onclick="SupplierClear();" style="background-position: left;
							    background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							     text-align: right" type="button" noenter value="Clear" />
						    <asp:HiddenField ID="hidSupplier" runat="server" Value='<%# Bind("SUPPLIERID")%>' />
                                </td>
                        </tr>
                 <tr>
                        <td>Rack Position&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
						<asp:TextBox ID="txtRack" runat="server" MaxLength="150" 
							Text='<%# Eval("MASTERRACKCODE")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="btnRackFind" noenter onclick="RackFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="btnRackClear" onclick="RackClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidRack" runat="server" Value='<%# Bind("MASTERRACKID")%>' />
                            </td>
                    </tr>
                <tr>
                    <td>
                        Notes &nbsp; &nbsp;&nbsp; &nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtDescDtl" runat="server" Text='<%# Bind("NOTES")%>' MaxLength="255" width="264px"  TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                 <tr>
                    <td colspan="2" class="FooterStyle">
                       <tr>
                    <td class="FooterStyle" colspan="2">
                        <asp:Button ID="btnSaveInvDtl" runat="server"
                            Style="background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" OnClick="btnSaveInvDtl_Click"/>
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                         
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
    <asp:SqlDataSource ID="sdsFormDtl" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
                                                                SelectCommand=" SELECT IHD.INVENTORYRECVDTLID AS INVENTORYRECVDTLID
                                                                                  ,IHD.INVENTORYRECVDTLCODE AS INVENTORYRECVDTLCODE
                                                                                  ,IHD.INVENTORYRECVID AS INVENTORYRECVID
	                                                                              ,IH.INVENTORYRECVCODE AS INVENTORYRECVCODE
                                                                                  ,IHD.SECTIONNO AS SECTIONNO
                                                                                  ,IHD.DETAILUNIT AS DETAILUNIT
                                                                                  ,IHD.MASTERUNITID AS MASTERUNITID
	                                                                              ,MU.MASTERUNITNAME AS MASTERUNITNAME
	                                                                              ,MU.MASTERUNITCODE AS MASTERUNITCODE
                                                                                  ,IHD.LOTNUMBER AS LOTNUMBER
                                                                                  ,IHD.POBUYER AS POBUYER
                                                                                  ,IHD.SALESORDERID AS SALESORDERID
	                                                                              ,SO.SALESORDERCODE AS SALESORDERCODE
                                                                                  ,IHD.WORKSHEETHDRID AS WORKSHEETHDRID
	                                                                              ,WS.WORKSHEETHDRNUMBER AS WORKSHEETHDRNUMBER
                                                                                  ,IHD.BUYERID AS BUYERID
	                                                                              ,MB.BUYERCODE AS BUYERCODE
	                                                                              ,MB.BUYERNAME AS BUYERNAME
                                                                                  ,IHD.SUPPLIERID AS SUPPLIERID
	                                                                              ,MS.SUPPLIERCODE AS SUPPLIERCODE
	                                                                              ,MS.SUPPLIERNAME AS SUPPLIERNAME
                                                                                  ,IHD.MASTERRACKID AS MASTERRACKID
                                                                                  ,MR.MASTERRACKNAME AS MASTERRACKNAME
	                                                                              ,MR.MASTERRACKCODE AS MASTERRACKCODE
	                                                                              ,PG.NAME AS STATUS
                                                                                  ,IHD.NOTES AS NOTES      
                                                                              FROM INVENTORYRECVDTL IHD
                                                                              LEFT OUTER JOIN INVENTORYRECV IH ON IHD.INVENTORYRECVID = IH.INVENTORYRECVID
                                                                              LEFT OUTER JOIN MASTERUNIT MU ON IHD.MASTERUNITID = MU.MASTERUNITID
                                                                              LEFT OUTER JOIN SALESORDER SO ON IHD.SALESORDERID = SO.SALESORDERID
                                                                              LEFT OUTER JOIN WORKSHEETHDR WS ON IHD.WORKSHEETHDRID = WS.WORKSHEETHDRID
                                                                              LEFT OUTER JOIN MASTERBUYER MB ON IHD.BUYERID = MB.BUYERID
                                                                              LEFT OUTER JOIN MASTERSUPPLIER MS ON IHD.SUPPLIERID = MS.SUPPLIERID
                                                                              INNER JOIN PARAMGLOBAL PG ON IHD.STATUS = PG.CODE
                                                                              LEFT OUTER JOIN MASTERRACK MR ON IHD.MASTERRACKID = MR.MASTERRACKID
                                                                               WHERE (IHD.INVENTORYRECVDTLID=@INVENTORYRECVDTLID AND PG.TYPE='INVSTS') " DeleteCommand="UPDATE INVENTORYRECVDTL SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE INVENTORYRECVDTLID=@INVENTORYRECVDTLID" UpdateCommand="INVENTORYRECVDTLUPDATE" InsertCommand="INVENTORYRECVDTLADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvDataDtl" Name="INVENTORYRECVDTLID" PropertyName="SelectedValue" />
           
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="INVENTORYRECVDTLID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="INVENTORYRECVDTLID" Type="Int32" />
            <asp:Parameter Name="INVENTORYRECVDTLCODE" Type="String" />
            <asp:Parameter Name="INVENTORYRECVID" Type="Int32" />
            <asp:Parameter Name="SECTIONNO" Type="String" />
            <asp:Parameter Name="DETAILUNIT" Type="Decimal" />
            <asp:Parameter Name="MASTERUNITID" Type="Int32" />          
            <asp:Parameter Name="LOTNUMBER" Type="String" />  
            <asp:Parameter Name="POBUYER" Type="String" />
            <asp:Parameter Name="SALESORDERID" Type="Int32" />
            <asp:Parameter Name="WORKSHEETHDRID" Type="Int32" />
            <asp:Parameter Name="BUYERID" Type="Int32" />
            <asp:Parameter Name="SUPPLIERID" Type="Int32" />
            <asp:Parameter Name="MASTERRACKID" Type="Int32" />
            <asp:Parameter Name="NOTES" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="INVENTORYRECVDTLCODE" Type="String" />
            <asp:Parameter Name="INVENTORYRECVID" Type="Int32" />
            <asp:Parameter Name="SECTIONNO" Type="String" />
            <asp:Parameter Name="DETAILUNIT" Type="Decimal" />
            <asp:Parameter Name="MASTERUNITID" Type="Int32" />
            <asp:Parameter Name="LOTNUMBER" Type="String" />             
            <asp:Parameter Name="POBUYER" Type="String" />
            <asp:Parameter Name="SALESORDERID" Type="Int32" />
            <asp:Parameter Name="WORKSHEETHDRID" Type="Int32" />
            <asp:Parameter Name="BUYERID" Type="Int32" />
            <asp:Parameter Name="SUPPLIERID" Type="Int32" />
            <asp:Parameter Name="MASTERRACKID" Type="Int32" />
            <asp:Parameter Name="STATUS" Type="String" />
            <asp:Parameter Name="NOTES" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>


<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
    FormatTable("<%=gvDataDtl.ClientID%>")
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    function GroupFind() {
        WinRef = window.open("../ParamGlobal/GroupSearch.aspx?Action=Find", "GroupFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetGroup(MATERIALGROUPID, MATERIALGROUP) {
        SetValueTxtByClientID("<%=strGroupID%>", MATERIALGROUPID);
        SetValueTxtByClientID("<%=strGroup%>", MATERIALGROUP);
    }

    function GroupClear() {
        SetValueTxtByClientID("<%=strGroupID%>", "");
        SetValueTxtByClientID("<%=strGroup%>", "");
    }
    //MASTERITEM
    function ItemFind() {
        WinRef = window.open("../ParamGlobal/MasterMaterialSearch.aspx?Action=Find", "ItemFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetItem(MATERIALMASTERID, MATERIALMASTER) {
        SetValueTxtByClientID("<%=strItemID%>", MATERIALMASTERID);
        SetValueTxtByClientID("<%=strItem%>", MATERIALMASTER);
    }

    function ItemClear() {
        SetValueTxtByClientID("<%=strItemID%>", "");
        SetValueTxtByClientID("<%=strItem%>", "");
    }
    //WS
    function WSFind() {
        WinRef = window.open("../Worksheet/WorkSheetSearch.aspx?Action=Find", "WSFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetWS(WORKSHEETHDRID, WORKSHEETHDR) {
        SetValueTxtByClientID("<%=strWSID%>", WORKSHEETHDRID);
        SetValueTxtByClientID("<%=strWS%>", WORKSHEETHDR);
    }

    function WSClear() {
        SetValueTxtByClientID("<%=strWSID%>", "");
        SetValueTxtByClientID("<%=strWS%>", "");
    }
    //Supplier
    function SupplierFind() {
        WinRef = window.open("../ParamGlobal/MasterSupplierSearch.aspx?Action=Find", "SupplierFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetSupplierFind(SUPPLIERID, MASTERSUPPLIER) {
        SetValueTxtByClientID("<%=strSupplierID%>", SUPPLIERID);
        SetValueTxtByClientID("<%=strSupplier%>", MASTERSUPPLIER);
    }

    function SupplierClear() {
        SetValueTxtByClientID("<%=strSupplierID%>", "");
        SetValueTxtByClientID("<%=strSupplier%>", "");
    }
    //buyer
    function BuyerFind() {
        WinRef = window.open("../ParamGlobal/MasterBuyerSearch.aspx?Action=Find", "BuyerFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetBuyer(BUYERID, MASTERBUYER) {
        SetValueTxtByClientID("<%=strBuyerID%>", BUYERID);
        SetValueTxtByClientID("<%=strBuyer%>", MASTERBUYER);
    }

    function BuyerClear() {
        SetValueTxtByClientID("<%=strBuyerID%>", "");
            SetValueTxtByClientID("<%=strBuyer%>", "");
    }
    function UnitFind() {
        WinRef = window.open("../ParamGlobal/UnitSearch.aspx?Action=Find", "UnitFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetUnitFind(MASTERUNITID, MASTERUNIT) {
        SetValueTxtByClientID("<%=strUnitID%>", MASTERUNITID);
        SetValueTxtByClientID("<%=strUnit%>", MASTERUNIT);
    }

    function UnitClear() {
        SetValueTxtByClientID("<%=strUnitID%>", "");
        SetValueTxtByClientID("<%=strUnit%>", "");
    }

    //so
    function SOFind() {
        WinRef = window.open("../Sales/SalesOrderSearch.aspx?Action=Find", "SOFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetSalesOrder(SALESORDERID, SALESORDER) {
        SetValueTxtByClientID("<%=strSOID%>", SALESORDERID);
        SetValueTxtByClientID("<%=strSO%>", SALESORDER);
    }

    function SOClear() {
        SetValueTxtByClientID("<%=strSOID%>", "");
        SetValueTxtByClientID("<%=strSO%>", "");
    }
    //rack
    function RackFind() {
        WinRef = window.open("../ParamGlobal/MasterRackSearch.aspx?Action=Find", "RackFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetMasterRack(MASTERRACKID, MASTERRACK) {
        SetValueTxtByClientID("<%=strRackID%>", MASTERRACKID);
        SetValueTxtByClientID("<%=strRack%>", MASTERRACK);
    }

    function RackClear() {
        SetValueTxtByClientID("<%=strRackID%>", "");
        SetValueTxtByClientID("<%=strRack%>", "");
    }
</script>

</asp:Content>

