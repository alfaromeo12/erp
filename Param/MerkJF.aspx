<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="MerkJF.aspx.vb" Inherits="Param_Merk" title="Merk/Branch" EnableEventValidation="FALSE" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="MerkName">Merk/Brand Name</asp:ListItem>
        <asp:ListItem Value="MerkCode">Merk/Brand Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" 
        CausesValidation="False" CssClass="New" Visible="False" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="600px">
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
        <table cellpadding="0" cellspacing="0" width="600">
            <tr>
                <td class="RowStyle">
                    JF Group</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlJFGroupSearch" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJFGroupSearch" runat="server"
                        Category="JFGROUP" LoadingText="[Loading JF Group...]" PromptText="[DISPLAY ALL]"
                        ServiceMethod="GetDropDownJFGroup" ServicePath="~\Param\WebService.asmx" TargetControlID="ddlJFGroupSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td class="RowStyle">
                    JF (Multifinance)</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlJFSearch" runat="server" AutoPostBack="True">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJFSearch" runat="server" Category="JF"
                        LoadingText="[Loading JF...]" ParentControlID="ddlJFGroupSearch" PromptText="[DISPLAY ALL]"
                        ServiceMethod="GetDropDownJFByJFGroup" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJFSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="600px" DataKeyNames="MERKID" Caption="MERK/BRAND LIST" RowHeaderColumn="MERKID">
            <Columns>
                <asp:TemplateField HeaderText="Model&lt;br&gt;Mapping" SortExpression="JFMERKCODE">
                    <ItemTemplate>
                        &nbsp;<asp:ImageButton ID="imgModel" runat="server" ImageUrl="~/Images/car.gif" OnClientClick='<%# string.Format("return ModelMap({0}, {1});", Eval("JFID"), Eval("MerkID")) %>'
                            Visible='<%# Eval("CHECKJFMERK") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="MERKID" HeaderText="Merk&lt;br&gt;ID" HtmlEncode="False"
                    SortExpression="MERKID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="MERKCODE" HeaderText="Merk&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="MERKCODE" />
                <asp:BoundField DataField="MERKNAME" HeaderText="Merk&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="MERKNAME" />
                <asp:TemplateField HeaderText="JF Merk&lt;br&gt;Code" SortExpression="JFMERKCODE">
                    <ItemTemplate>
                        <asp:TextBox ID="txtJFMerkCode" runat="server" MaxLength="20" Text='<%# Bind("JFMERKCODE") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
        <br />
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT MERK.MERKID, MERK.MERKCODE, MERK.MERKNAME, MERKJF.JFMERKCODE, MERKJF.JFID, CAST(CASE WHEN JFMERKCODE IS NULL THEN 0 ELSE 1 END AS BIT) AS CHECKJFMERK FROM MERK LEFT OUTER JOIN MERKJF ON MERK.MERKID = MERKJF.MERKID AND MERKJF.JFID = CASE WHEN @JFID IS NULL THEN MERKJF.JFID ELSE @JFID END WHERE (MERK.Deletests = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlJFSearch" Name="JFID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <ajaxToolkit:AlwaysVisibleControlExtender
        ID="ajaxAVCESAve" runat="server" TargetControlID="pnlSave" VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <asp:Panel ID="pnlSave" runat="server" CssClass="HeaderStyle" Width="100%">
        <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Save" Width="56px" /></asp:Panel>
    &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
function ModelEdit(MerkID){
    window.location="Model.aspx?MerkID=" + MerkID + "&Action=Edit"
}
function ModelMap(JFID, MerkID){
    window.location="ModelMap.aspx?Action=Edit&JFID=" + JFID + "&MERKID=" + MerkID;
    return false;
}

</script>

</asp:Content>

