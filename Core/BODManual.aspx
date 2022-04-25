<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BODManual.aspx.vb" Inherits="AppSetting_BODManual" title="BOD" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Label ID="lblMsgDAte" runat="server" CssClass="HeaderStyle" Font-Bold="True"
        Text="BOD Date :  "></asp:Label>
    <asp:TextBox ID="txtAppDate" runat="server" CssClass="required" Width="64px"></asp:TextBox><asp:Image
        ID="imgAppDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
        ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEDate" runat="server" Format="dd/MM/yyyy"
            PopupButtonID="imgAppDate" TargetControlID="txtAppDate">
        </ajaxToolkit:CalendarExtender>
    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
        TargetControlID="txtAppDate">
    </ajaxToolkit:MaskedEditExtender>
    <asp:HiddenField ID="txtJF" runat="server" />
    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
        Font-Underline="True" Width="100%" style="text-align: center"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
        <asp:GridView ID="gvDataAcc" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="Account Must be BOD....!" DataSourceID="sdsGridAcc"
        Width="100%" DataKeyNames="LOCID,ACCID" RowHeaderColumn="ACCID">
        <Columns>
            <asp:BoundField DataField="LOCID" HeaderText="LOC&lt;br&gt;ID" HtmlEncode="False"
                ReadOnly="True" SortExpression="LOCID" />
            <asp:BoundField DataField="APPID" HeaderText="APP&lt;BR&gt;ID" HtmlEncode="False"
                SortExpression="APPID" />
            <asp:BoundField DataField="ACCID" HeaderText="ACC&lt;BR&gt;ID" HtmlEncode="False"
                ReadOnly="True" SortExpression="ACCID" />
            <asp:BoundField DataField="ACCOUNTNO" HeaderText="Account&lt;br&gt;" HtmlEncode="False"
                SortExpression="ACCOUNTNO" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="ACCOUNTNAME" />
            <asp:BoundField DataField="NEXTDUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Due&lt;br&gt;Date"
                HtmlEncode="False" ReadOnly="True" SortExpression="NEXTDUEDATE" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Booking&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="BOOKINGDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" HeaderText="OS&lt;br&gt;Principal"
                HtmlEncode="False" SortExpression="OSPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGridAcc" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        DeleteCommand="Delete APPSessions Where UID=@UID" 
        
        SelectCommand="SELECT TOP (500) dbo.f_FormatAccNoByID(BRANCHID, ACCOUNTNO) AS ACCOUNTNO, ACCOUNTNAME, NEXTDUEDATE, LOCID, ACCID, APPID, BOOKINGDATE, PRINCIPALTOTAL - (SELECT ISNULL(SUM(PRINCIPAL), 0) AS Expr1 FROM INSTALLMENT WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID)) AS OSPRINCIPAL FROM ACCOUNT WITH (NOLOCK) WHERE (ACCSTATUS = 1) AND (NEXTDUEDATE &lt;= CONVERT (DATETIME, @DATE, 103)) AND (TENOR &gt; (SELECT COUNT(*) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_1 WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID))) AND (NEXTDUEDATE &lt;= CONVERT (DATETIME, @DATE, 103)) AND (INSTALLMENTTYPE IN (1, 2)) ORDER BY NEXTDUEDATE">
        <DeleteParameters>
            <asp:Parameter Name="UID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAppDate" Name="DATE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <hr />
    <asp:GridView ID="gvDataAccJF" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="Account JF/Bank Must be BOD...!" DataSourceID="sdsGridAccJF"
        Width="100%" DataKeyNames="LOCID,ACCIDJF" RowHeaderColumn="ACCID">
        <Columns>
            <asp:BoundField DataField="LOCID" HeaderText="LOC&lt;BR&gt;" HtmlEncode="False" SortExpression="LOCID" />
            <asp:BoundField DataField="APPID" HeaderText="APP&lt;BR&gt;ID" HtmlEncode="False"
                SortExpression="APPID" />
            <asp:BoundField DataField="ACCID" HeaderText="ACC&lt;BR&gt;ID" HtmlEncode="False"
                SortExpression="ACCID" />
            <asp:BoundField DataField="ACCOUNTNO" HeaderText="Account&lt;br&gt;No" HtmlEncode="False"
                ReadOnly="True" SortExpression="ACCOUNTNO" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="ACCOUNTNAME" />
            <asp:BoundField DataField="JFCODE" HeaderText="JF&lt;BR&gt;Code" HtmlEncode="False"
                SortExpression="JFCODE" />
            <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;BR&gt;Name" HtmlEncode="False"
                SortExpression="JFNAME" />
            <asp:BoundField DataField="JFBOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="JF Booking&lt;BR&gt;Date"
                HtmlEncode="False" SortExpression="JFBOOKINGDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="NEXTDUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Due&lt;br&gt;Date"
                HtmlEncode="False" ReadOnly="True" SortExpression="NEXTDUEDATE" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="OSPRINCIPALJF" DataFormatString="{0:N}" HeaderText="OS&lt;BR&gt;Principal JF"
                HtmlEncode="False" SortExpression="OSPRINCIPALJF">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound2" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGridAccJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT TOP (500) dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCOUNTNO, ACCOUNT.ACCOUNTNAME, ACCOUNTJF.JFNEXTDUEDATE AS NEXTDUEDATE, JF.JFCODE, JF.JFNAME, ACCOUNTJF.JFPRINCIPALTOTAL - (SELECT ISNULL(SUM(JFPRINCIPAL), 0) AS Expr1 FROM INSTALLMENTJF WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF)) AS OSPRINCIPALJF, ACCOUNTJF.JFBOOKINGDATE, ACCOUNT.ACCID, ACCOUNT.APPID, ACCOUNTJF.LOCID, ACCOUNTJF.ACCIDJF FROM ACCOUNT WITH (NOLOCK) INNER JOIN ACCOUNTJF WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN JF ON ACCOUNTJF.JFID = JF.JFID WHERE (ACCOUNTJF.JFACCSTATUS = 1) AND (ACCOUNTJF.JFNEXTDUEDATE &lt;= CONVERT (DATETIME, @DATE, 103)) AND (ACCOUNTJF.JFTENOR &gt; (SELECT COUNT(*) AS Expr1 FROM INSTALLMENTJF AS INSTALLMENTJF_1 WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF))) ORDER BY NEXTDUEDATE">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAppDate" Name="DATE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvDataAcc.ClientID%>");
FormatTable("<%=gvDataAccJF.ClientID%>");
</script>

    <asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
    <asp:Button ID="btnProcess" runat="server" Style="cursor: pointer; background-position: right; background-image: url(../Images/menu.gif); background-repeat: no-repeat; text-align: left; " Text="Process" OnClientClick='return (confirm("Are you sure want to execute BOD Process...?"));' CausesValidation="False" />
        <asp:Button ID="btnRefresh" runat="server" CausesValidation="False" Style="background-position: right;
            background-image: url(../Images/display.gif); cursor: pointer; background-repeat: no-repeat;
            text-align: left; " Text="Refresh Data" /></asp:Panel>
</asp:Content>

