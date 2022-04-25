<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ProductTypeDpsrSearch.aspx.vb" Inherits="Product_MitraSearch" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
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
    <br />
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="PRODUCTDPSRCODE">Product Code</asp:ListItem>
        <asp:ListItem Value="PRODUCTDPSRNAME">Product Name</asp:ListItem>
    </asp:DropDownList></td>
        <td>
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" />
    <ajaxToolkit:textboxwatermarkextender id="ajxTBWESearch" runat="server" targetcontrolid="txtSearch"
        watermarktext="%%">
    </ajaxToolkit:textboxwatermarkextender>
                </td>
            </tr>
        </table>
         </asp:Panel>
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
          <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="PRODUCTDPSRID" Caption="Product Type De-Pasar List" RowHeaderColumn="PRODUCTDPSRID">
            <Columns>
                <asp:TemplateField HeaderText="Set" SortExpression="PRODUCTDPSRID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetProdDpsr(<%#Eval("PRODUCTDPSRID")%>, '<%#Eval("PRODUCTDPSRNAME")%>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="PRODUCTDPSRID" HeaderText="ID" 
                    SortExpression="PRODUCTDPSRID">
                    <ItemStyle HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTDPSRCODE" HeaderText="Product&lt;br&gt;Code" HtmlEncode="False" 
                    SortExpression="PRODUCTDPSRCODE" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTDPSRNAME" HeaderText="Product&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PRODUCTDPSRNAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="SERVICETYPENAME" HeaderText="Service&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="SERVICETYPENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="SERVICETYPEDTLNAME" HeaderText="Service&lt;br&gt;Type Detail" HtmlEncode="False"
                    SortExpression="SERVICETYPEDTLNAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT DPSR.PRODUCTDPSRID
                              ,DPSR.PRODUCTDPSRCODE
                              ,DPSR.PRODUCTDPSRNAME
                              ,DPSR.SERVICETYPEDTLID
	                          ,ST.SERVICETYPENAME
	                          ,STD.SERVICETYPEDTLNAME
                          FROM PRODUCTDPSR DPSR
                          LEFT OUTER JOIN SERVICETYPEDTL STD ON DPSR.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                          LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST. SERVICETYPEID
                       WHERE (DPSR.DELETESTS = 0) AND DPSR.SERVICETYPEDTLID=@SERVICETYPEDTLID">
        <SelectParameters>
                <asp:QueryStringParameter Name="SERVICETYPEDTLID" QueryStringField="SERVICETYPEDTLID" />
                
            </SelectParameters>
    </asp:SqlDataSource>
    </ContentTemplate>
    </asp:UpdatePanel>
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
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.elevateZoom-3.0.8.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery.min.js.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    TabToEnter();
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    function SetProdDpsr(PRODUCTDPSRID, PRODUCTDPSR) {
        window.opener.SetProdDpsr(PRODUCTDPSRID, PRODUCTDPSR);
        window.close();
    }
</script>

</asp:Content>

