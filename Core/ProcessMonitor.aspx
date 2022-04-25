<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ProcessMonitor.aspx.vb" Inherits="Core_ProcessMonitor" title="Process Monitor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:GridView ID="gvAppProcess" runat="server" AutoGenerateColumns="False" Caption="BACK END PROCESS MONITORING"
        DataKeyNames="PROCESSID" DataSourceID="sdsAppProcess" RowHeaderColumn="PROCESSID"
        Width="100%">
        <Columns>
            <asp:BoundField DataField="PROCESSID" HeaderText="PROCESS&lt;BR&gt;ID" HtmlEncode="False"
                ReadOnly="True" SortExpression="PROCESSID" />
            <asp:BoundField DataField="PROCESSNAME" HeaderText="PROCESS&lt;BR&gt;NAME" HtmlEncode="False"
                SortExpression="PROCESSNAME" />
            <asp:BoundField DataField="PROCESSSTATUSNAME" HeaderText="PROCESS&lt;BR&gt;STATUS"
                HtmlEncode="False" ReadOnly="True" SortExpression="PROCESSSTATUSNAME" />
            <asp:BoundField DataField="PROCESSSTART" DataFormatString="{0:dd/MM/yyyy hh:mm:ss.fff}"
                HeaderText="PROCESS&lt;BR&gt;START" HtmlEncode="False" SortExpression="PROCESSSTART" />
            <asp:BoundField DataField="PROCESSEND" DataFormatString="{0:dd/MM/yyyy hh:mm:ss.fff}"
                HeaderText="PROCESS&lt;BR&gt;END" HtmlEncode="False" SortExpression="PROCESSEND" />
            <asp:BoundField DataField="PROCESSDESC" HeaderText="PROCESS&lt;BR&gt;DESC" HtmlEncode="False"
                SortExpression="PROCESSDESC" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsAppProcess" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PROCESSID, PROCESSNAME, CASE WHEN PROCESSSTATUS = 0 THEN 'NOT ACTIVE' ELSE 'ACTIVE' END AS PROCESSSTATUSNAME, PROCESSSTART, PROCESSEND, PROCESSDESC FROM APPPROCESS WITH(NOLOCK)">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvAppProcess.ClientID%>");
 var reloadTimer = null;
 var sURL = unescape(window.location.pathname);
 
 function setReloadTime(secs) 
 { 
    if (arguments.length == 1) 
    {
        if (reloadTimer) clearTimeout(reloadTimer);
        reloadTimer = setTimeout("setReloadTime()", 
                         Math.ceil(parseFloat(secs) * 1000));
    }
    else 
    { 
        reloadTimer = null;
        location.reload(true);
        window.location.replace( sURL );
    }
 }
 
 window.onload=function(){
    setReloadTime(5);
 }
</script>

    <asp:Button ID="btnRefresh" runat="server" Style="cursor: pointer" Text="Refresh" />

</asp:Content>

