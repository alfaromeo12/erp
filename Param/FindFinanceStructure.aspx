<%@ Page Title="" Language="VB" MasterPageFile="~/MXPageNoTitle.master" AutoEventWireup="false" CodeFile="FindFinanceStructure.aspx.vb" Inherits="Param_FindFinanceStructure" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
		WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
	<asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
		</div>
		<input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
			background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
		ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
		ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow"></ajaxToolkit:CollapsiblePanelExtender>
        <asp:Panel ID="pnlData" runat="server">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td style="width: 115px">
	<asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="AREA.AreaName">Area Name</asp:ListItem>
	    <asp:ListItem Value="BranchName">Branch Name</asp:ListItem>
        <asp:ListItem Value="ProductName">Product Name</asp:ListItem>
	    <asp:ListItem Value="CategoryName">Object Category</asp:ListItem>
        <asp:ListItem Value="PurposeCatName">Object Kind</asp:ListItem>
	</asp:DropDownList></td>
				<td>
		<asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
        <asp:Button	ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
		border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
		Text="Search" CausesValidation="False" CssClass="Search" />
					&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
			AutoGenerateColumns="False" 
            DataKeyNames="AREAID,BRANCHID,PRODUCTID,PURPOSECATID,CATEGORYID" DataSourceID="sdsGrid" 
			Width="100%" Caption="Finance Structure " RowHeaderColumn="INSURANCECODE">
			<Columns>
				
                 <asp:TemplateField HeaderText="COPY" >
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetCopyFinanceStructure('<%#eval("AREAID")%>', '<%#eval("BRANCHID")%>', '<%#eval("PRODUCTID")%>', '<%#eval("CATEGORYID")%>', '<%#eval("PURPOSECATID")%>')" alt="Edit : <%#eval("AREANAME")%> - <%#eval("BRANCHNAME")%>" />&nbsp;
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
				<asp:BoundField DataField="AREANAME" HeaderText="Area&lt;br&gt;Name" 
                    SortExpression="AREANAME" HtmlEncode="False" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch&lt;br&gt;Name" 
                    SortExpression="BRANCHNAME" HtmlEncode="False" />
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product&lt;br&gt;Name" 
                    SortExpression="PRODUCTNAME" HtmlEncode="False" />
                <asp:BoundField DataField="CATEGORYNAME" HeaderText="Category&lt;br&gt;Name" 
                    HtmlEncode="False" SortExpression="CATEGORYNAME" />
                <asp:BoundField DataField="PURPOSECATNAME" HeaderText="Object&lt;br&gt;Kind" 
                    SortExpression="PURPOSECATNAME" HtmlEncode="False" />
			</Columns>
			<EmptyDataTemplate>
				<uc6:NoDataFound ID="NoDataFound1" runat="server" />
			</EmptyDataTemplate>
		</asp:GridView>
	    <asp:SqlDataSource ID="sdsGrid" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            
            
            SelectCommand="SELECT TOP (500) FNFINSTRUCTURE.FINID, FNFINSTRUCTURE.DEALERID, FNFINSTRUCTURE.AREAID, (SELECT '(' + AREACODE + ') ' + AREANAME AS AREANAME FROM AREA WHERE (AREAID = FNFINSTRUCTURE.AREAID) AND (DELETESTS = 0)) AS AREANAME, FNFINSTRUCTURE.BRANCHID, (SELECT '(' + BRANCHCODE + ') ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WHERE (BRANCHID = FNFINSTRUCTURE.BRANCHID) AND (Deletests = 0)) AS BRANCHNAME, FNFINSTRUCTURE.PRODUCTID, (SELECT '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (PRODUCTID = FNFINSTRUCTURE.PRODUCTID)) AS PRODUCTNAME, FNFINSTRUCTURE.PURPOSECATID, (SELECT '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WHERE (PURPOSECATID = FNFINSTRUCTURE.PURPOSECATID) AND (DELETESTS = 0)) AS PURPOSECATNAME, FNFINSTRUCTURE.CATEGORYID, (SELECT '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME FROM OBJECTCATEGORY WHERE (FNFINSTRUCTURE.CATEGORYID = CATEGORYID) AND (Deletests = 0)) AS CATEGORYNAME FROM FNFINSTRUCTURE WITH (NOLOCK) LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON FNFINSTRUCTURE.BRANCHID = BRANCH_1.BRANCHID WHERE (FNFINSTRUCTURE.DeleteSts = 0)">
        </asp:SqlDataSource>
	</asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")

    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function SetCopyFinanceStructure(AREA, BRANCH, PRODUCT, CATEGORY, OBJECTKIND) {
        if (confirm("Are you sure want to copy ?")) {
            window.opener.SetCopyFinanceStructure(AREA, BRANCH, PRODUCT, CATEGORY, OBJECTKIND);
            window.close();
        }
    }
</script>
</asp:Content>

