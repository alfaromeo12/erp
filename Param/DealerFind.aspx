<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DealerFind.aspx.vb" Inherits="Param_DealerFind" title="Param : Dealer Find" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc1" %>
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
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 144px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="DEALER.DEALERNAME">DEALER Name</asp:ListItem>
        <asp:ListItem Value="DEALER.DEALERCODE">DEALER Code</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" /><ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Area</td>
                <td style="width: 216px">
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA" LoadingText="[Loading Area...]"
                        PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
        Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH" LoadingText="[Loading Branch...]"
                        ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="Dealer List" DataKeyNames="DEALERID" 
                    DataSourceID="sdsGrid" RowHeaderColumn="DEALERID" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="SET" SortExpression="DEALERID">
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                            <ItemTemplate>
                                <img src="../images/edit.gif" style="cursor: pointer" onclick="SetDealer('<%#eval("DealerID")%>', '(<%#eval("DEALERCODE")%>) <%#eval("DealerName")%>')" alt="SET Dealer: <%#eval("DEALERCODE")%>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DEALERID" HeaderText="ID" ReadOnly="True" 
                            SortExpression="DEALERID" />
                        <asp:BoundField DataField="DEALERMAINCODE" 
                            HeaderText="Dealer Main&lt;br&gt;Code" HtmlEncode="False" 
                            SortExpression="DEALERMAINCODE" />
                        <asp:BoundField DataField="DEALERMAINNAME" 
                            HeaderText="Dealer Main&lt;br&gt;Name" HtmlEncode="False" 
                            SortExpression="DEALERMAINNAME" />
                        <asp:BoundField DataField="DEALERCODE" HeaderText="Dealer&lt;br&gt;Code" 
                            HtmlEncode="False" SortExpression="DEALERCODE" />
                        <asp:BoundField DataField="DEALERNAME" HeaderText="Dealer&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="DEALERNAME" />
                        <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                            SortExpression="BRANCH" />
                        <asp:BoundField DataField="ADDRESS" HeaderText="Address" 
                            SortExpression="ADDRESS" />
                        <asp:BoundField DataField="CITYNAME" HeaderText="City" 
                            SortExpression="CITYNAME" />
                        <asp:BoundField DataField="PHONE" HeaderText="Phone&lt;br&gt;No." 
                            HtmlEncode="False" ReadOnly="True" SortExpression="PHONE" />
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, DEALER.DEALERID, DEALER.DEALERCODE, DEALER.DEALERNAME, DEALERMAIN.DEALERMAINCODE, DEALERMAIN.DEALERMAINNAME, DEALER.ADDRESS, '(' + DEALER.PHONEAREA + ')' + DEALER.PHONE AS PHONE, CITY.CITYNAME FROM DEALERMAIN WITH (NOLOCK) INNER JOIN DEALER WITH (NOLOCK) ON DEALERMAIN.DEALERMAINID = DEALER.DEALERMAINID LEFT OUTER JOIN CITY WITH (NOLOCK) ON DEALER.CITYID = CITY.CITYID LEFT OUTER JOIN AREA WITH (nolock) INNER JOIN BRANCH WITH (nolock) ON AREA.AREAID = BRANCH.AREAID ON DEALER.BRANCHID = BRANCH.BRANCHID WHERE (DEALER.Deletests = 0)">
                </asp:SqlDataSource>
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
    </asp:Panel>
    &nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
function SetDealer(DealerID, DealerName){
    window.opener.SetDealer(DealerID, DealerName);
    window.close()
}
</script>

</asp:Content>

