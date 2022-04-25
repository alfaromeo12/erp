<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="COADtl.aspx.vb" Inherits="Param_COADtl" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="COADTLCODE">COA Code</asp:ListItem>
        <asp:ListItem Value="COADTLNAME">COA Name</asp:ListItem>
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
            DataKeyNames="COADTLID" Caption="COA Detail" RowHeaderColumn="COADTLID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="COADTLID" HeaderText="ID"
                    SortExpression="COADTLID">
                </asp:BoundField>
                <asp:BoundField DataField="COADTLCODE" HeaderText="COA&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="COADTLCODE" />
                <asp:BoundField DataField="COADTLNAME" HeaderText="COA&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="COADTLNAME" />
                <asp:BoundField DataField="COANAME" HeaderText="COA&lt;br&gt;Group" HtmlEncode="False"
                    SortExpression="COANAME" />
                
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT CD.COADTLID AS COADTLID
                      ,CD.COADTLCODE AS COADTLCODE
                      ,CD.COADTLNAME AS COADTLNAME
	                  ,C.COAID AS COAID
	                  ,C.COANAME AS COANAME
                FROM COADTL CD
				LEFT OUTER JOIN COA C ON CD.COAID = C.COAID WHERE (CD.DELETESTS = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="COADTLID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        COA Detail ID</td>
                    <td>
                        <asp:Label ID="lblCOAID" runat="server" Text='<%# Eval("COADTLID")%>'></asp:Label></td>
                </tr>
                
                <tr>
                    <td>
                        COA Code</td>
                    <td>
                        <asp:TextBox ID="txtCOACode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("COADTLCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCOACode" Display="None" ErrorMessage="COA Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                    <td>
                        COA Name</td>
                    <td>
                        <asp:TextBox ID="txtCOAName" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("COADTLNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtCOAName" Display="None" ErrorMessage="COA Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>COA Header &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlGroup" runat="server" DataSourceID="sdsDDLGroup" CssClass="required"
                                DataTextField="COANAME" DataValueField="COAID" SelectedValue='<%# Bind("COAID")%>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator
                            ID="reqDllCoaGroup" runat="server" ControlToValidate="ddlGroup" Display="None" ErrorMessage=" COA Group Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECoaGrp" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDllCoaGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
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
                        COA Code</td>
                    <td>
                        <asp:TextBox ID="txtCOACode" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("COADTLCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCOACode" Display="None" ErrorMessage="COA Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                    <td>
                        COA Name</td>
                    <td>
                        <asp:TextBox ID="txtCOAName" runat="server" Width="264px" MaxLength="100" Text='<%# Bind("COADTLNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtCOAName" Display="None" ErrorMessage="COA Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                 <tr>
                        <td>COA Header &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlGroup" runat="server" DataSourceID="sdsDDLGroup" CssClass="required"
                                DataTextField="COANAME" DataValueField="COAID" SelectedValue='<%# Bind("COAID")%>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator
                            ID="reqDllCoaGroup" runat="server" ControlToValidate="ddlGroup" Display="None" ErrorMessage=" COA Group Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECoaGrp" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDllCoaGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
                             </td>
                    </tr>
                <tr>
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
     <asp:SqlDataSource ID="sdsDDLGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS COAID, '[DISPLAY ALL]' AS COANAME UNION ALL 
                                        SELECT COAID, COANAME FROM COA WHERE (DELETESTS= 0) ORDER BY COANAME"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT CD.COADTLID AS COADTLID
                      ,CD.COADTLCODE AS COADTLCODE
                      ,CD.COADTLNAME AS COADTLNAME
	                  ,C.COAID AS COAID
	                  ,C.COANAME AS COANAME
                FROM COADTL CD
				LEFT OUTER JOIN COA C ON CD.COAID = C.COAID WHERE (CD.COADTLID=@COADTLID)" DeleteCommand="UPDATE COADTL SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE COADTLID=@COADTLID" UpdateCommand="COADTLUPDATE" InsertCommand="COADTLADD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="COADTLID" PropertyName="SelectedValue" />
        </SelectParameters>
          <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="COADTLID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="COADTLID" Type="Int32" />
            <asp:Parameter Name="COADTLCODE" Type="String" />
            <asp:Parameter Name="COADTLNAME" Type="String" />
            <asp:Parameter Name="COAID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
           <asp:Parameter Name="COADTLCODE" Type="String" />
            <asp:Parameter Name="COADTLNAME" Type="String" />
            <asp:Parameter Name="COAID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
         </asp:SqlDataSource>
</asp:Content>

