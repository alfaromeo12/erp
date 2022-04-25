<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFGroup.aspx.vb" Inherits="Param_JFGroup" title="JF GROUP" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="JFGROUPNAME">JF Group Name</asp:ListItem>
        <asp:ListItem Value="JFGROUPCODE">JF Group Code</asp:ListItem>
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
            DataKeyNames="JFGROUPID" Caption="Join Finance Group List" 
            RowHeaderColumn="JFGROUPID">
            <Columns>
                <asp:TemplateField>
                <ItemTemplate>
                <asp:ImageButton CommandName="Select" ToolTip="Select" 
                        ImageUrl="../Images/edit.gif" runat="server" ID="imgSelect" 
                        Visible='<%# NOT Eval("NEW") %>' ></asp:ImageButton>
                </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:BoundField DataField="JFGROUPID" HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="JFGROUPID" />
                <asp:BoundField DataField="JFGROUPCODE" HeaderText="JF Group&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="JFGROUPCODE" />
                <asp:BoundField DataField="JFGROUPNAME" HeaderText="JF Group&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="JFGROUPNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME, NEW, Deletests, UPD FROM (SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME, CAST(0 AS BIT) AS NEW, Deletests, CASE WHEN EXISTS (SELECT 'X' FROM JFGROUPX WHERE JFGROUP_1.JFGROUPID = JFGROUPX.JFGROUPID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM JFGROUP AS JFGROUP_1 WHERE (Deletests = 0) UNION ALL SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME, CAST(1 AS BIT) AS NEW, Deletests, CAST(0 AS BIT) AS UPD FROM JFGROUPX WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'x' AS Expr1 FROM JFGROUP AS JFGROUP_2 WHERE (JFGROUPID = JFGROUPX.JFGROUPID))) AND (Deletests = 0)) AS JFGROUP WHERE (Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" 
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
        DefaultMode="Edit" Width="100%" DataKeyNames="JFGROUPID">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Group &nbsp;ID</td>
                    <td>
                        <asp:Label ID="lblJFGroupID" runat="server" Text='<%# Eval("JFGROUPID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Group Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("JFGROUPCODE") %>'
                            Width="56px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Group Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" CssClass="required" MaxLength="100" Text='<%# Bind("JFGROUPNAME") %>'
                            Width="264px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtName" Display="None" ErrorMessage="Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
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
                        JF Group Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("JFGROUPCODE") %>'
                            Width="56px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtCode" Display="None" ErrorMessage="Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Group Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" CssClass="required" MaxLength="100" Text='<%# Bind("JFGROUPNAME") %>'
                            Width="264px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtName" Display="None" ErrorMessage="Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
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
        
        SelectCommand="SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME FROM JFGROUP WHERE (JFGROUPID = @JFGROUPID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFGROUPX WHERE (JFGROUPID = JFGROUP.JFGROUPID))) UNION ALL SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME FROM JFGROUPX AS JFGROUPX_1 WHERE (JFGROUPID = @JFGROUPID)" 
        DeleteCommand="UPDATE JFGROUP SET Deletests = 1, LastUpdate = GETDATE(), LastUserID = @USERID WHERE (JFGROUPID = @JFGROUPID)" 
        UpdateCommand="JFGROUPUpdate" InsertCommand="JFGROUPAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="JFGROUPID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="JFGROUPID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="JFGROUPID" Type="Int32" />
            <asp:Parameter Name="JFGROUPCode" Type="String" />
            <asp:Parameter Name="JFGROUPName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="JFGROUPCode" Type="String" />
            <asp:Parameter Name="JFGROUPName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

