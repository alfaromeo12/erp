<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AreaApp.aspx.vb" Inherits="Param_AreaApp" title="Area Parameter Approval" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<%@ Register src="../UserControl/BtnApprovetNoSPV.ascx" tagname="btnapprovetnospv" tagprefix="uc8" %>
<%@ Register src="../UserControl/BtnRejectNoSPV.ascx" tagname="btnrejectnospv" tagprefix="uc7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="AreaName">Area Name</asp:ListItem>
        <asp:ListItem Value="AreaCode">Area Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <br />
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
            DataKeyNames="AREAID" Caption="Area Approval List" 
            RowHeaderColumn="AREAID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="AREAID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="AREAID" />
                <asp:BoundField DataField="AREACODE" HeaderText="Area&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="AREACODE" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="AREANAME" HeaderText="Area&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="AREANAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT AREAID, AREACODE, AREANAME FROM AREAX
WHERE DELETESTS=0"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <br />

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm" Width="100%" 
        DataKeyNames="AREAID">
        <ItemTemplate>
            <table style="width:100%;">
                <tr>
                    <td class="RowStyle">
                        Area ID</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label4" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("AREAID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="RowStyle">
                        Area Code</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label1" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("AREACODE") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="RowStyle">
                        Area Name</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label3" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("AREANAME") %>'></asp:Label>
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
        SelectCommand="SELECT AREAID, AREACODE, AREANAME FROM AREAX WHERE (AREAID = @AreaID)" >
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="AreaID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

