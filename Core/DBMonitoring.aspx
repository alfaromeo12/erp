<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DBMonitoring.aspx.vb" Inherits="Core_DBMonitoring" title="Database Process Monitoring" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:GridView ID="gvDBProcess" runat="server" AutoGenerateColumns="False" Caption="DATABASE PROCESS LIST"
        DataSourceID="sdsDBProcess" Width="100%">
        <Columns>
            <asp:BoundField DataField="spid" HeaderText="spid" SortExpression="spid" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="KILL">
                <ItemTemplate>
                    <img src="../Images/stop.png" alt="KILL <%# Eval("spid") %>" style="cursor: pointer"  onclick="KillProc(<%# Eval("spid") %>)" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="40px" />
            </asp:TemplateField>
            <asp:BoundField DataField="blocked" HeaderText="blocked" SortExpression="blocked" />
            <asp:BoundField DataField="hostname" HeaderText="hostname" SortExpression="hostname" />
            <asp:BoundField DataField="program_name" HeaderText="program_name" SortExpression="program_name" />
            <asp:TemplateField HeaderText="SQL Command"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsDBProcess" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT spid, blocked, hostname, program_name FROM master.sys.sysprocesses WHERE (status = 'runnable')">
    </asp:SqlDataSource>
    <asp:Button ID="btnRefresh" runat="server" CausesValidation="False" Text="Refresh" />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvDBProcess.ClientID%>")
function KillProc(ProcId){
    var oForm = document.getElementById ? document.getElementById("<%=Form.ClientID%>") : document.forms["<%=Form.ClientID%>"]; 

	if (confirm("Are you sure want to kill Proc ID " + ProcId + " ?")){
		oForm.action="DBMonitoring.aspx?Action=KILL&ProcId=" + ProcId;
		oForm.method="POST";
		oForm.submit();
		return true;
	}	
}
</SCRIPT>

    <asp:Label ID="lblError" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label>

</asp:Content>

