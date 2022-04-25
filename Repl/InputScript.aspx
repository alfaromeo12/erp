<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InputScript.aspx.vb" Inherits="Repl_InputScript" title="Input Script" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlSQL" runat="server" GroupingText="SQL Syntax" Width="97%">
        <asp:RadioButton ID="rbSQLSelect" runat="server" Checked="True" GroupName="rbSQL"
            Text="SQL Select (SQL Query)" /><asp:RadioButton ID="rbSQLTxn" runat="server" GroupName="rbSQL"
                Text="Non SQL Select (SQL Transaction)" /><asp:TextBox ID="txtSQL" runat="server"
                    CssClass="required" Height="192px" TextMode="MultiLine" Width="97%"></asp:TextBox><br />
        <asp:Label ID="lblMessage" runat="server" CssClass="HeaderStyle" Style="text-align: center"
            Visible="False" Width="98%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
            </asp:Panel>
    <asp:Button ID="btnProcess" runat="server" Style="cursor: pointer; background-position: right; background-image: url(../Images/sql.gif); background-repeat: no-repeat; text-align: left;" Text="Process" /><ajaxToolkit:ValidatorCalloutExtender
        ID="ajaxVCESQL" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSQL">
    </ajaxToolkit:ValidatorCalloutExtender>
    <asp:RequiredFieldValidator ID="reqSQL" runat="server" ControlToValidate="txtSQL"
        Display="None" ErrorMessage="SQL Syntax must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:GridView
            ID="gvSQL" runat="server" Visible="False">
        </asp:GridView>
<script type="text/javascript">
function ShowAlert(){
    alert("SCRIPT ERROR...! Please see the error detail..!");
}
function ReportSQL(){
    window.open("ReportSQL.aspx", "ReportSQL", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
    return(false);
}
</script>
<%=strScript%>

</asp:Content>

