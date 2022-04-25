<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFGroupApp.aspx.vb" Inherits="Param_JFGroupApp" title="JF GROUP APPROVAL" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register src="../UserControl/BtnRejectNoSPV.ascx" tagname="BtnRejectNoSPV" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnApprovetNoSPV.ascx" tagname="BtnApprovetNoSPV" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="JFGROUPNAME">JF Group Name</asp:ListItem>
        <asp:ListItem Value="JFGROUPCODE">JF Group Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

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
            DataKeyNames="JFGROUPID" Caption="Join Finance Group Approval List" 
            RowHeaderColumn="JFGROUPID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="JFGROUPID" HeaderText="JF Group&lt;br&gt;ID" HtmlEncode="False"
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
        
        SelectCommand="SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME FROM JFGROUPX WHERE (Deletests = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="Error" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm" Width="100%" 
        DataKeyNames="JFGROUPID">
        <ItemTemplate>
            <table style="width:100%;">
                <tr>
                    <td class="RowStyle">
                        JF Group ID</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label2" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("JFGROUPID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="RowStyle">
                        JF Group Code</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label1" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="RowStyle">
                        JF Group Name</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label3" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc8:BtnApprovetNoSPV ID="BtnApprovetNoSPV1" runat="server" />
                        <uc7:BtnRejectNoSPV ID="BtnRejectNoSPV1" runat="server" />
                        <uc5:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JFGROUPID, JFGROUPCODE, JFGROUPNAME FROM JFGROUPX WHERE (JFGROUPID = @JFGROUPID)" >
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="JFGROUPID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

