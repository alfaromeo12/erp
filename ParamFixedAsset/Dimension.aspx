<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Dimension.aspx.vb" Inherits="ParamFixedAsset_Dimension" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="DIMENSIONCODE">Dimension Code</asp:ListItem>
        <asp:ListItem Value="DIMENSIONNAME">Dimension Name</asp:ListItem>
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
    <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="DIMENSIONID" Caption="Dimension" RowHeaderColumn="DIMENSIONID" PageSize="30">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="DIMENSIONID" HeaderText="ID" Visible="false"
                    SortExpression="DIMENSIONID">
                </asp:BoundField>
                <asp:BoundField DataField="DIMENSIONCODE" HeaderText="Dimension&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="DIMENSIONCODE" />
                <asp:BoundField DataField="DIMENSIONAME" HeaderText="Dimension&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="DIMENSIONAME" />
                <asp:BoundField DataField="DIMTYPEID" HeaderText="Type&lt;br&gt;" HtmlEncode="False"
                    SortExpression="DIMTYPEID" />
                <asp:BoundField DataField="STARTDATE" HeaderText="Start&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="STARTDATE" />
                <asp:BoundField DataField="DATEREQUIRED" HeaderText="Date&lt;br&gt;Required" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="DATEREQUIRED" />
                <asp:BoundField DataField="TAGS" HeaderText="Tags&lt;br&gt;" HtmlEncode="False"
                    SortExpression="TAGS" /> 
                <asp:BoundField DataField="MEMO" HeaderText="Memo&lt;br&gt;" HtmlEncode="False"
                    SortExpression="MEMO" />    
                 </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT DIM.DIMENSIONID AS DIMENSIONID
                      ,DIM.DIMENSIONCODE AS DIMENSIONCODE
                      ,DIM.DIMENSIONNAME AS DIMENSIONNAME
					  ,DIM.STARTDATE AS STARTDATE
					  ,DIM.DATEREQUIRED AS DATEREQUIRED
					  ,DIM.TAGS AS TAGS
					  ,DIM.MEMO AS MEMO
	                  ,DT.DIMTYPEID AS DIMTYPEID
	                  ,DT.DIMTYPELEVEL AS DIMTYPELEVEL
                FROM DIMENSION DIM
				LEFT OUTER JOIN DIMTYPE DT ON DIM.DIMTYPEID = DT.DIMTYPEID WHERE (DIM.DELETESTS = 0)"></asp:SqlDataSource>
 <asp:Label ID="Label1" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="DIMTYPEID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Dimension ID</td>
                    <td>
                        <asp:Label ID="lblDimId" runat="server" Text='<%# Eval("DIMENSIONID")%>'></asp:Label></td>
                </tr>
                
                
                <tr>
                    <td>
                        Dimension Code</td>
                    <td>
                        <asp:TextBox ID="txtDimCode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("DIMENSIONCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtDimCode" Display="None" ErrorMessage="Dimension Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                    <td>
                        Dimension Name</td>
                    <td>
                        <asp:TextBox ID="txtDimName" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("DIMENSIONNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtDimName" Display="None" ErrorMessage="COA Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Dimension Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType" runat="server" DataSourceID="sdsDDLGroup" CssClass="required"
                                DataTextField="DIMTYPELEVEL" DataValueField="DIMTYPEID" SelectedValue='<%# Bind("DIMTYPEID")%>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator
                            ID="reqType" runat="server" ControlToValidate="ddlType" Display="None" ErrorMessage=" Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                             </td>
                    </tr>
                <tr>
                <td>
                    Start Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
                        <td>
                        <asp:TextBox ID="txtInqueryDate" Text='<%# Bind("STARTDATE", "{0:dd/MM/yyyy}")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgtxtInqueryDate" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <ajaxToolkit:CalendarExtender ID="ajaxCEtxtInqueryDate" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgtxtInqueryDate"
                        TargetControlID="txtInqueryDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEtxtInqueryDate" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtInqueryDate">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                </tr>
                <tr>
                <td>
                    Date Required &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
                        <td>
                        <asp:TextBox ID="TextBox1" Text='<%# Bind("DATEREQUIRED", "{0:dd/MM/yyyy}")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgtxtInqueryDate"
                        TargetControlID="txtInqueryDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtInqueryDate">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                </tr>
                <tr>
                     <td>Tags &nbsp; &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             <asp:TextBox ID="txtTags" runat="server" MaxLength="255" Text='<%# Bind("TAGS")%>' TextMode="MultiLine" Width="260px"></asp:TextBox>
                         </td>
                </tr>
                <tr>
                     <td>Memo &nbsp; &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             <asp:TextBox ID="txtMemo" runat="server" MaxLength="255" Text='<%# Bind("MEMO")%>' TextMode="MultiLine" Width="260px"></asp:TextBox>
                         </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                <tr>
                    <td class="FooterStyle" colspan="2">
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
                
             <%--   <tr>
                    <td>
                        COA Detail ID</td>
                    <td>
                        <asp:Label ID="lblCOAID" runat="server" Text='<%# Eval("COADTLID")%>'></asp:Label></td>
                </tr>--%>
                
                <tr>
                    <td>
                        Dimension Code</td>
                    <td>
                        <asp:TextBox ID="txtDimCode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("DIMENSIONCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtDimCode" Display="None" ErrorMessage="Dimension Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                    <td>
                        Dimension Name</td>
                    <td>
                        <asp:TextBox ID="txtDimName" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("DIMENSIONNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtDimName" Display="None" ErrorMessage="COA Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>Dimension Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType" runat="server" DataSourceID="sdsDDLGroup" CssClass="required"
                                DataTextField="DIMTYPELEVEL" DataValueField="DIMTYPEID" SelectedValue='<%# Bind("DIMTYPEID")%>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator
                            ID="reqType" runat="server" ControlToValidate="ddlType" Display="None" ErrorMessage=" Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                             </td>
                    </tr>
                <tr>
                <td>
                    Start Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
                        <td>
                        <asp:TextBox ID="txtInqueryDate" Text='<%# Bind("STARTDATE", "{0:dd/MM/yyyy}")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgtxtInqueryDate" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <ajaxToolkit:CalendarExtender ID="ajaxCEtxtInqueryDate" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgtxtInqueryDate"
                        TargetControlID="txtInqueryDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEtxtInqueryDate" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtInqueryDate">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                </tr>
                <tr>
                <td>
                    Date Required &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
                        <td>
                        <asp:TextBox ID="TextBox1" Text='<%# Bind("DATEREQUIRED", "{0:dd/MM/yyyy}")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgtxtInqueryDate"
                        TargetControlID="txtInqueryDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtInqueryDate">
                    </ajaxToolkit:MaskedEditExtender>
                            
                        </td>
                </tr>
                <tr>
                     <td>Tags &nbsp; &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             <asp:TextBox ID="txtTags" runat="server" MaxLength="255" Text='<%# Bind("TAGS")%>' TextMode="MultiLine" Width="260px"></asp:TextBox>
                         </td>
                </tr>
                <tr>
                     <td>Memo &nbsp; &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             <asp:TextBox ID="txtMemo" runat="server" MaxLength="255" Text='<%# Bind("MEMO")%>' TextMode="MultiLine" Width="260px"></asp:TextBox>
                         </td>
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
</asp:Content>

