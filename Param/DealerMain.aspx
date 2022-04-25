<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DealerMain.aspx.vb" Inherits="Param_DealerMain" title="DEALER MAIN" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table style="width: 100%;" cellpadding="0" cellspacing="0" >
        <tr>
            <td class="AlternatingRowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="DEALERMAINCODE">Code</asp:ListItem>
        <asp:ListItem Value="DEALERMAINNAME">Name</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td class="AlternatingRowStyle">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                <asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" Width="50px" />
            </td>
        </tr>
        <tr>
            <td class="RowStyle" style="height: 19px">
                Dealer Type</td>
            <td class="RowStyle" style="height: 19px">
                <asp:DropDownList ID="ddlDealerTypeSearch" runat="server" 
                    DataSourceID="sdsDealerTypeSearch" DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList>
    <asp:SqlDataSource ID="sdsDealerTypeSearch" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'DEALERTYPE')">
    </asp:SqlDataSource>
            </td>
        </tr>
        </table>
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
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
            DataKeyNames="DEALERMAINID" Caption="Dealer Main List" 
            RowHeaderColumn="DEALERMAINID">
            <Columns>
                <asp:TemplateField>
                <ItemTemplate>
                <asp:ImageButton CommandName="Select" ToolTip="Select" 
                        ImageUrl="../Images/edit.gif" runat="server" ID="imgSelect" 
                        Visible='<%# NOT Eval("NEW") %>' ></asp:ImageButton>
                </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="DEALERMAINID" HeaderText="ID" 
                    SortExpression="DEALERMAINID" />
                <asp:BoundField DataField="DEALERMAINCODE" HeaderText="Code" HtmlEncode="False"
                    SortExpression="DEALERMAINCODE" />
                <asp:BoundField DataField="DEALERMAINNAME" HeaderText="Name" HtmlEncode="False"
                    SortExpression="DEALERMAINNAME" />
                <asp:BoundField DataField="DEALERTYPENAME" HeaderText="Dealer&lt;br&gt;Type" 
                    HtmlEncode="False" SortExpression="DEALERTYPENAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        
        
        SelectCommand="SELECT DEALERMAINID, DEALERMAINCODE, DEALERMAINNAME, DEALERTYPENAME, NEW, Deletests, UPD, DEALERTYPE FROM (SELECT DEALERMAINID, DEALERTYPE, DEALERMAINCODE, DEALERMAINNAME, dbo.f_getParamGlobalName('DEALERTYPE', DEALERTYPE) AS DEALERTYPENAME, CAST(0 AS BIT) AS NEW, Deletests, CASE WHEN EXISTS (SELECT 'X' FROM DEALERMAINX WHERE DEALERMAIN_1.DEALERMAINID = DEALERMAINX.DEALERMAINID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM DEALERMAIN AS DEALERMAIN_1 WHERE (Deletests = 0) UNION ALL SELECT DEALERMAINID, DEALERTYPE, DEALERMAINCODE, DEALERMAINNAME, dbo.f_getParamGlobalName('DEALERTYPE', DEALERTYPE) AS DEALERTYPENAME, CAST(1 AS BIT) AS NEW, Deletests, CAST(0 AS BIT) AS UPD FROM DEALERMAINX WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'x' AS Expr1 FROM DEALERMAIN AS DEALERMAIN_2 WHERE (DEALERMAINID = DEALERMAINX.DEALERMAINID))) AND (Deletests = 0)) AS DEALERMAIN WHERE (Deletests = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="DEALERMAINID">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("DEALERMAINID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td >
                        <asp:TextBox ID="txtCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("DEALERMAINCODE") %>'
                            Width="56px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" CssClass="required" MaxLength="100" Text='<%# Bind("DEALERMAINNAME") %>'
                            Width="264px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtName" Display="None" ErrorMessage="Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dealer Type</td>
                    <td>
                        <asp:DropDownList ID="ddlDealerType" runat="server" 
                            DataSourceID="sdsDealerType" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("DEALERTYPE") %>' CssClass="required">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqDealerType" runat="server" 
                            ControlToValidate="ddlDealerType" Display="None" 
                            ErrorMessage="DEALER TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDealerType" runat="server" 
                            Enabled="True" TargetControlID="reqDealerType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDealerType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDealerType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
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
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("DEALERMAINCODE") %>'
                            Width="56px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" CssClass="required" MaxLength="100" Text='<%# Bind("DEALERMAINNAME") %>'
                            Width="264px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtName" Display="None" ErrorMessage="Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dealer Type</td>
                    <td>
                        <asp:DropDownList ID="ddlDealerType" runat="server" 
                            DataSourceID="sdsDealerType" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("DEALERTYPE") %>' CssClass="required">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqDealerType" runat="server" 
                            ControlToValidate="ddlDealerType" Display="None" 
                            ErrorMessage="DEALER TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDealerType" runat="server" 
                            Enabled="True" TargetControlID="reqDealerType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqDealerType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDealerType">
                        </ajaxToolkit:ValidatorCalloutExtender>
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
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT DEALERMAINID, DEALERMAINCODE, DEALERMAINNAME, (SELECT CODE FROM PARAMGLOBAL WHERE (TYPE = 'DEALERTYPE') AND (CODE = DEALERMAIN.DEALERTYPE)) AS DEALERTYPE FROM DEALERMAIN WHERE (DEALERMAINID = @DEALERMAINID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALERMAINX WHERE (DEALERMAIN.DEALERMAINID = DEALERMAINID))) UNION ALL SELECT DEALERMAINID, DEALERMAINCODE, DEALERMAINNAME, DEALERTYPE FROM DEALERMAINX AS DEALERMAINX_1 WHERE (DEALERMAINID = @DEALERMAINID)" 
        DeleteCommand="UPDATE DEALERMAIN SET Deletests = 1, LastUpdate = GETDATE(), LastUserID = @USERID WHERE (DEALERMAINID = @DEALERMAINID)" 
        UpdateCommand="DEALERMAINUpdate" InsertCommand="DEALERMAINAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="DEALERMAINID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="DEALERMAINID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DEALERMAINID" Type="Int32" />
            <asp:Parameter Name="DEALERMAINCode" Type="String" />
            <asp:Parameter Name="DEALERMAINName" Type="String" />
            <asp:Parameter Name="DEALERTYPE" Type="Int16" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DEALERMAINCode" Type="String" />
            <asp:Parameter Name="DEALERMAINName" Type="String" />
            <asp:Parameter Name="DEALERTYPE" Type="Int16" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDealerType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
                    
        SelectCommand="SELECT NULL AS CODE, '[SELECT DEALER TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'DEALERTYPE')">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

