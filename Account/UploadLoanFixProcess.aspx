<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="UploadLoanFixProcess.aspx.vb" Inherits="UploadLoanFixProcess" title="Upload Loan Data Fix Process"  EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="LOANUPLOADFIX.REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="ACCOUNTNAME">Account Name</asp:ListItem>
    </asp:DropDownList></td>
            <td class="RowStyle">
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" CssClass="Search" Text="Search" /><ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch"
            runat="server" TargetControlID="txtSearch" WatermarkText="%%">
        </ajaxToolkit:TextBoxWatermarkExtender>
            </td>
        </tr>
        </table>
    <asp:HiddenField ID="hidAPP" runat="server" />
    <asp:GridView ID="gvLoanFix" runat="server" AutoGenerateColumns="False" Caption="LOAN DATA FIX LIST"
        DataKeyNames="REFNO" DataSourceID="sdsLoanFixUpload" 
        Width="100%" AllowPaging="True" AllowSorting="True" 
        RowHeaderColumn="REFNO">
        <Columns>
            <asp:BoundField DataField="REFNO" HeaderText="Ref.&lt;br&gt;No." 
                ReadOnly="True" SortExpression="REFNO" HtmlEncode="False" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                SortExpression="ACCOUNTNAME" HtmlEncode="False" />
            <asp:BoundField DataField="BOOKINGDATE" HeaderText="Booking&lt;br&gt;Date" 
                SortExpression="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HtmlEncode="False" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="PRINCIPALTOTAL" HeaderText="Principal" 
                SortExpression="PRINCIPALTOTAL" DataFormatString="{0:N}" HtmlEncode="False" >
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="TENOR" HeaderText="Tenor" SortExpression="TENOR" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="LOANTYPE" HeaderText="Loan&lt;br&gt;Type" 
                SortExpression="LOANTYPE" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="EFFECTIVERATE" HeaderText="Eff&lt;br&gt;Rate" 
                SortExpression="EFFECTIVERATE" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="INSTALLMENT" HeaderText="Installment" 
                SortExpression="INSTALLMENT" DataFormatString="{0:N}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDPRINCIPALTOTAL" 
                HeaderText="Old&lt;br&gt;Principal" SortExpression="OLDPRINCIPALTOTAL" 
                DataFormatString="{0:N}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDTENOR" HeaderText="Old&lt;br&gt;Tenor" 
                HtmlEncode="False" SortExpression="OLDTENOR">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDLOANTYPE" 
                HeaderText="Old&lt;br&gt;Loan&lt;br&gt;Type" HtmlEncode="False" 
                SortExpression="OLDLOANTYPE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDEFFECTIVERATE" 
                HeaderText="Old&lt;br&gt;Eff&lt;br&gt;Rate" HtmlEncode="False" 
                SortExpression="OLDEFFECTIVERATE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDINSTALLMENT" DataFormatString="{0:N}" 
                HeaderText="Old&lt;br&gt;Installment" HtmlEncode="False" 
                SortExpression="OLDINSTALLMENT">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsLoanFixUpload" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        
        SelectCommand="SELECT LOANUPLOADFIX.REFNO, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, LOANUPLOADFIX.PRINCIPALTOTAL, LOANUPLOADFIX.TENOR, LOANUPLOADFIX.LOANTYPE, LOANUPLOADFIX.EFFECTIVERATE, LOANUPLOADFIX.INSTALLMENT, ACCOUNT.PRINCIPALTOTAL AS OLDPRINCIPALTOTAL, ACCOUNT.TENOR AS OLDTENOR, ACCOUNT.LOANTYPE AS OLDLOANTYPE, ACCOUNT.EFFECTIVERATE AS OLDEFFECTIVERATE, ACCOUNT.INSTALLMENT AS OLDINSTALLMENT FROM LOANUPLOADFIX LEFT OUTER JOIN ACCOUNT ON LOANUPLOADFIX.REFNO = ACCOUNT.REFNO AND ACCOUNT.ACCSTATUS = 1 WHERE (LOANUPLOADFIX.REFNO IS NOT NULL)">
    </asp:SqlDataSource>
    <br />
    <br />
    <br />
    <br />

    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <br />
    <asp:Panel ID="pnlProcess" runat="server" CssClass="ShowDetail" Width="100%">
        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
            Font-Bold="True" Font-Underline="True" Style="text-align: center" 
            Visible="False" Width="100%"></asp:Label>
        <asp:Button ID="btnProcess" runat="server" OnClientClick='return ProcessData();'
            Style="background-position: right; background-image: url(../Images/proceed.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Process" Width="136px" />
        <asp:Button ID="btnDelete" runat="server" OnClientClick='return DeleteData();'
            Style="background-position: right; background-image: url(../Images/delete.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Delete Upload Data" Width="136px" />
        <asp:Button ID="btnPrint" runat="server" OnClientClick='return PrintData();'
            Style="background-position: right; background-image: url(../Images/print.jpg);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Print Data" Width="136px" /></asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvLoanFix.ClientID%>");
var WinRef = null;
function ProcessData() {
    var APP = GetValueTxtByClientID("<%=hidAPP.ClientID%>");
    if (APP == "1") {
        if (CheckTxnType()) {
            if (!confirm("Are you sure want to APPROVE UPLOAD LOAN DATA FIX ...?")) {
                return false;
            }
        } else {
        return false;
        }
    } else {
        if (!confirm("Are you sure want to PROCESS UPLOAD LOAN DATA FIX...?")) {
            return false;
        }
    }
    return true;
}
function DeleteData(){
    if (!confirm("Are you sure want to DELETE data...?")){
        return false;
    }
}

function ViewDtl(COMPCODE, REFNO){
    WinRef = window.open("UploadAccDtl.aspx?Action=View&COMPCODE=" + COMPCODE + "&REFNO=" + REFNO, "UPDACCDTL", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    WinRef.focus();
}
function PrintData() {
    var APP = GetValueTxtByClientID("<%=hidAPP.ClientID%>");
    if (APP == "0") {
        WinRef = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/LoanFixUpload&STATUS=0", "LoanDataFix", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    }
    else{
        WinRef = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/LoanFixUpload&STATUS=1", "LoanDataFix", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    }
    WinRef.focus();
    return false;
}


function getObjectbyClientID(ClientID) {
    var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return (oObject)
}

function SetValueTxtByClientID(ClientID, sValue) {
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    if (oText)
        oText.value = sValue;
}

function GetValueTxtByClientID(ClientID) {
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    if (oText)
        return (oText.value);
}

</script>
</asp:Content>

