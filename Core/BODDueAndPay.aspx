<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BODDueAndPay.aspx.vb" Inherits="AppSetting_BODDueAndPay" title="BOD" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Label ID="lblMsgDAte" runat="server" CssClass="HeaderStyle" Font-Bold="True"
        Text="Current Application Date :  "></asp:Label>
    <asp:TextBox ID="txtAppDate" runat="server" CssClass="disabled" ReadOnly="True" Width="64px"></asp:TextBox><br />
    <br />
    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
        Font-Underline="True" Width="100%" style="text-align: center" Visible="False"></asp:Label>
    <asp:Panel ID="pnlUserShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgUser" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblUser" runat="server" CssClass="required">(Show Users Active ...)</asp:Label>
        </div>
        <input id="Button3" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEUser" runat="server" CollapseControlID="pnlUserShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Users Active...)" Enabled="True"
        ExpandControlID="pnlUserShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide User Active...)"
        ImageControlID="imgUser" TargetControlID="pnlUser" TextLabelID="lblUser">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlUser" runat="server" Width="100%">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="UID" DataSourceID="sdsGrid" Width="100%" Caption="Active User(s) List">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True" />
            <asp:TemplateField SortExpression="UID">
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="False" CommandName="Delete"
                        ImageUrl="~/images/delete.gif" OnClientClick='return confirm("Are you sure want to Delete this Sessions ?")'
                        ToolTip="Delete" DescriptionUrl="Delete Data" Visible='<%# Eval("DELETESTS") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UserID" HeaderText="User ID" SortExpression="UserID" />
            <asp:BoundField DataField="UserName" HeaderText="User&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="UserName" />
            <asp:BoundField DataField="TimeOut" DataFormatString="{0:dd/MM/yyyy hh:mm:ss}" HeaderText="Time Out"
                HtmlEncode="False" SortExpression="TimeOut" />
            <asp:BoundField DataField="IP" HeaderText="IP&lt;br&gt;Address" HtmlEncode="False"
                SortExpression="IP" />
            <asp:BoundField DataField="SessionID" HeaderText="Session ID" SortExpression="SessionID" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:nodatafound id="NoDataFound1" runat="server">
</uc1:nodatafound>
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        DeleteCommand="Delete APPSessions Where UID=@UID" 
            
            SelectCommand="SELECT APPUSER.UserID, APPUSER.UserName, APPSESSIONS.SessionID, APPSESSIONS.TimeOut, APPSESSIONS.IP, APPSESSIONS.LastUpdate, APPSESSIONS.UID, CASE WHEN APPSESSIONS.UID = @UID THEN 0 ELSE 1 END AS DELETESTS FROM APPSESSIONS INNER JOIN APPUSER ON APPSESSIONS.UID = APPUSER.UID WHERE (APPSESSIONS.TimeOut &gt;= GETDATE()) ">
        <DeleteParameters>
            <asp:Parameter Name="UID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:CookieParameter CookieName="UID" Name="UID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <hr />
    </asp:Panel>
    <asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgAcc" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblAcc" runat="server" CssClass="required">(Show BOD Account ...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAcc" runat="server" CollapseControlID="pnlAccShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show BOD Account...)" Enabled="True"
        ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide BOD Account...)"
        ImageControlID="imgAcc" TargetControlID="pnlAcc" TextLabelID="lblAcc">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlAcc" runat="server" Width="100%">
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
            SelectCommand="SELECT TOP (500) dbo.f_FormatAccNoByID(BRANCHID, ACCOUNTNO) AS ACCOUNTNO, ACCOUNTNAME, NEXTDUEDATE, LOCID, ACCID, APPID, BOOKINGDATE, PRINCIPALTOTAL - (SELECT ISNULL(SUM(PRINCIPAL), 0) AS Expr1 FROM INSTALLMENT WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID)) AS OSPRINCIPAL FROM ACCOUNT WITH (NOLOCK) WHERE (ACCSTATUS = 1) AND (NEXTDUEDATE &lt;= CONVERT (DATETIME, @DATE, 103)) AND (TENOR &gt; (SELECT COUNT(*) AS Expr1 FROM INSTALLMENT AS INSTALLMENT_1 WITH (NOLOCK) WHERE (ACCOUNT.LOCID = LOCID) AND (ACCOUNT.ACCID = ACCID))) AND (NEXTDUEDATE &lt;= CONVERT (DATETIME, @DATE, 103)) ORDER BY NEXTDUEDATE">
        <DeleteParameters>
            <asp:Parameter Name="UID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAppDate" Name="DATE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <hr />
    </asp:Panel>
    <asp:Panel ID="pnlJFShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgJF" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblJF" runat="server" CssClass="required">(Show BOD Account JF...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEJF" runat="server" CollapseControlID="pnlJFShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show BOD Account JF...)"
        Enabled="True" ExpandControlID="pnlJFShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide BOD Account JF...)" ImageControlID="imgJF" TargetControlID="pnlJF"
        TextLabelID="lblJF">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlJF" runat="server" Width="100%">
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
        
            SelectCommand="SELECT TOP (500) dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCOUNTNO, ACCOUNT.ACCOUNTNAME, ACCOUNTJF.JFNEXTDUEDATE AS NEXTDUEDATE, JF.JFCODE, JF.JFNAME, ACCOUNTJF.JFPRINCIPALTOTAL - (SELECT ISNULL(SUM(JFPRINCIPAL), 0) AS Expr1 FROM INSTALLMENTJF WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF)) AS OSPRINCIPALJF, ACCOUNTJF.JFBOOKINGDATE, ACCOUNT.APPID, ACCOUNTJF.ACCIDJF, ACCOUNT.LOCID, ACCOUNT.ACCID FROM ACCOUNT WITH (NOLOCK) INNER JOIN ACCOUNTJF WITH (NOLOCK) ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN JF ON ACCOUNTJF.JFID = JF.JFID WHERE (ACCOUNTJF.JFACCSTATUS = 1) AND (ACCOUNTJF.JFNEXTDUEDATE &lt;= CONVERT (DATETIME, @DATE, 103)) AND (ACCOUNTJF.JFTENOR &gt; (SELECT COUNT(*) AS Expr1 FROM INSTALLMENTJF AS INSTALLMENTJF_1 WITH (NOLOCK) WHERE (ACCOUNTJF.ACCIDJF = ACCIDJF))) ORDER BY NEXTDUEDATE">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtAppDate" Name="DATE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Panel>
    &nbsp;&nbsp;
    <br />
    <br />
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>");
FormatTable("<%=gvDataAcc.ClientID%>");
FormatTable("<%=gvDataAccJF.ClientID%>");
</script>

    <asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
    <asp:Button ID="btnProcess" runat="server" Style="cursor: pointer; background-position: right; background-image: url(../Images/menu.gif); background-repeat: no-repeat; text-align: left; " Text="Process" OnClientClick='return (confirm("Are you sure want to execute BOD Process...?"));' CausesValidation="False" />
        <asp:Button ID="btnRefresh" runat="server" CausesValidation="False" Style="background-position: right;
            background-image: url(../Images/display.gif); cursor: pointer; background-repeat: no-repeat;
            text-align: left; " Text="Refresh Data" /></asp:Panel>
</asp:Content>

