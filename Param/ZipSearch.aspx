<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ZipSearch.aspx.vb" Inherits="Param_ZipSearch" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<style type="text/css">
.modalBackground
{
	background-color: Gray;
	filter: alpha(opacity=50);
	opacity: 0.50;
}

.updateProgress
{
	background-color: #cccccc;
	position: absolute;
	width: 180px;
	height: 65px;
	border-bottom: thin outset;
	border-left: thin outset;
	border-top: thin outset;
	border-right: thin outset;
	font-weight: bold;
}

</style>

<script type="text/javascript" language="javascript">
    var ModalProgress = '<%=ModalProgress.ClientID%>';
</script>

<ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
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
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ZipCode">Zip Code</asp:ListItem>
        <asp:ListItem Value="Kelurahan">Kelurahan</asp:ListItem>
        <asp:ListItem Value="Kecamatan">Kecamatan</asp:ListItem>
        <asp:ListItem Value="City"></asp:ListItem>
        <asp:ListItem>Wilayah</asp:ListItem>
        <asp:ListItem>Province</asp:ListItem>
    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ZIPID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Zip List" RowHeaderColumn="ZIPCODE">
            <Columns>
               <asp:TemplateField HeaderText="Set" SortExpression="ZIPID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetZip('<%#eval("ZIPCODE")%>', '<%#eval("CITY")%>', '<%#eval("PROVINCE")%>', '<%#eval("KECAMATAN")%>', '<%#eval("KELURAHAN")%>','<%#eval("CITYID")%>','<%#eval("CITYNAME")%>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="ZIPCODE" HeaderText="Zip&lt;br&gt;Code" 
                    SortExpression="ZIPCODE" HtmlEncode="False" />
                <asp:BoundField DataField="KELURAHAN" HeaderText="Kelurahan" 
                    SortExpression="KELURAHAN" HtmlEncode="False" />
                <asp:BoundField DataField="KECAMATAN" HeaderText="Kecamatan" 
                    SortExpression="KECAMATAN" />
                <asp:BoundField DataField="CITY" HeaderText="City" 
                    SortExpression="CITY" />
                <asp:BoundField DataField="WILAYAH" HeaderText="Wilayah" 
                    SortExpression="WILAYAH" />
                <asp:BoundField DataField="PROVINCE" HeaderText="Province" 
                    SortExpression="PROVINCE" />
                <asp:BoundField DataField="CITYNAME" HeaderText="City&lt;br&gt;Name" 
                    SortExpression="CITYNAME" HtmlEncode="False" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT ZIP.ZIPID, ZIP.ZIPCODE, ZIP.KELURAHAN, ZIP.KECAMATAN, ZIP.CITY, ZIP.WILAYAH, ZIP.PROVINCE, ZIP.CITYID, '(' + CITY.CITYCODE + ') ' + CITY.CITYNAME AS CITYNAME FROM ZIP WITH (NOLOCK) LEFT OUTER JOIN CITY WITH (NOLOCK) ON ZIP.CITYID = CITY.CITYID WHERE (CITY.DELETESTS = 0)"></asp:SqlDataSource>
    </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript" src="../include/jsUpdateProgress.js"></script>
   <ajaxToolkit:ModalPopupExtender ID="ModalProgress" runat="server" TargetControlID="panelUpdateProgress"
		BackgroundCssClass="modalBackground" PopupControlID="panelUpdateProgress"   />
<asp:Panel ID="panelUpdateProgress" runat="server" CssClass="updateProgress">
    <asp:UpdateProgress ID="UpdateProgMaster" DisplayAfter="0" runat="server" >
        <ProgressTemplate>
            <div style="position: relative; top: 30%; text-align: center;" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/wait.gif" 
                ToolTip="Processing" /><br />
                Processing ...
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Panel>

    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
    function SetZip(ZipCode, City, Province, Kecamatan, Kelurahan, Dati, DatiName) {
        window.opener.SetZip(ZipCode, City, Province, Kecamatan, Kelurahan, Dati, DatiName);
        window.close();
    }
   
</script>
</asp:Content>

