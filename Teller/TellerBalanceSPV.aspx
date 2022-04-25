<%@ Page Title="Teller Balance for Supervisor" Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="TellerBalanceSPV.aspx.vb" Inherits="Teller_TellerBalanceSPV" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="UserID">User ID</asp:ListItem>
        <asp:ListItem Value="UserName">User Name</asp:ListItem>
    </asp:DropDownList>
    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajaxTBWESearch" runat="server" 
        TargetControlID="txtSearch" WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Button
        ID="btnFunctionSearch" runat="server" 
        Text="Search" CausesValidation="False" CssClass="Search" />
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvUser" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" DataKeyNames="UID" DataSourceID="sdsUser" 
                Width="100%" Caption="User Teller/Cashier List">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                <img src="../images/edit.gif" style="cursor: pointer" onclick="ShowTeller('<%#eval("UID")%>')" alt="Show Teller: <%#eval("UserID")%> " />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="UserID" HeaderText="User&lt;br&gt;ID" 
                        HtmlEncode="False" SortExpression="UserID" />
                    <asp:BoundField DataField="UserName" HeaderText="User&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="UserName" />
                    <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" ReadOnly="True" 
                        SortExpression="BRANCHNAME" />
                    <asp:BoundField DataField="CASHBALANCE" DataFormatString="{0:N}" 
                        HeaderText="Begining&lt;br&gt;Cash Balance" HtmlEncode="False" 
                        SortExpression="CASHBALANCE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NONCASHBALANCE" DataFormatString="{0:N}" 
                        HeaderText="Begining&lt;br&gt;Non Cash Balance" HtmlEncode="False" 
                        SortExpression="NONCASHBALANCE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ENDCASHBALANCE" DataFormatString="{0:N}" 
                        HeaderText="Ending&lt;br&gt;Cash Balance" HtmlEncode="False" ReadOnly="True" 
                        SortExpression="ENDCASHBALANCE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ENDNONCASHBALANCE" DataFormatString="{0:N}" 
                        HeaderText="Ending&lt;br&gt;Non Cash Balance" HtmlEncode="False" 
                        ReadOnly="True" SortExpression="ENDNONCASHBALANCE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsUser" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT TOP (500) TELLERBALANCE.UID, APPUSER.UserID, APPUSER.UserName, TELLERBALANCE.CASHBALANCE, TELLERBALANCE.NONCASHBALANCE, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME, TELLERBALANCE.CASHBALANCE + (TELLERBALANCE.CASHIN - TELLERBALANCE.CASHOUT) AS ENDCASHBALANCE, TELLERBALANCE.NONCASHBALANCE + (TELLERBALANCE.NONCASHIN - TELLERBALANCE.NONCASHOUT) AS ENDNONCASHBALANCE FROM APPUSER WITH (NOLOCK) INNER JOIN TELLERBALANCE WITH (NOLOCK) ON APPUSER.UID = TELLERBALANCE.UID INNER JOIN BRANCH WITH (NOLOCK) ON APPUSER.BRANCHID = BRANCH.BRANCHID WHERE (APPUSER.Deletests = 0)">
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvUser.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvUser.ClientID%>");
    });
    function ShowTeller(TellerID) {
        window.location = "TellerBalanceUser.aspx?TELLERID=" + TellerID
    }
</script>
</asp:Content>

