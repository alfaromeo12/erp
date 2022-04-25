<%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="ETUploadProcess.aspx.vb" Inherits="Account_ETUploadProcess" title="ET Upload Process" EnableEventValidation="false"%>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                <asp:DropDownList ID="ddlCriteria" runat="server">
                    <asp:ListItem Value="ETUPLOAD.REFNO">Reference No.</asp:ListItem>
                </asp:DropDownList></td>
            <td class="RowStyle">
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button ID="btnFunctionSearch"
                    runat="server" CssClass="Search" Text="Search" /><ajaxToolkit:textboxwatermarkextender id="ajxTBWESearch" runat="server" targetcontrolid="txtSearch"
                        watermarktext="%%">
        </ajaxToolkit:textboxwatermarkextender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle">
                Txn Date</td>
            <td class="RowStyle">
                    <asp:TextBox ID="txtTxnDate" runat="server" CssClass="disabled" ReadOnly="True" 
                        Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqTxnDate" runat="server" 
                        ControlToValidate="txtTxnDate" Display="None" 
                        ErrorMessage="TXN DATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqTxnDate_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqTxnDate">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvETUpload" runat="server" AllowPaging="True" 
                AllowSorting="True" AutoGenerateColumns="False" Caption="ET Data Upload " 
                DataKeyNames="REFNO" DataSourceID="sdsETUpload" RowHeaderColumn="REFNO" 
                Width="100%">
                <Columns>
                    <asp:BoundField DataField="REFNO" HeaderText="Ref.No." ReadOnly="True" 
                        SortExpression="REFNO" />
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Book&lt;br&gt;Date" HtmlEncode="False" SortExpression="BOOKINGDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="ET&lt;br&gt;Date" HtmlEncode="False" SortExpression="JFETDATE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFOSPRINCIPAL" DataFormatString="{0:N}" 
                        HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                        SortExpression="JFOSPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETPENALTY" DataFormatString="{0:N}" 
                        HeaderText="ET&lt;br&gt;Penalty" HtmlEncode="False" 
                        SortExpression="JFETPENALTY">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETADMIN" DataFormatString="{0:N}" 
                        HeaderText="ET&lt;BR&gt;Admin" HtmlEncode="False" SortExpression="JFETADMIN">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETINTEREST" DataFormatString="{0:N}" 
                        HeaderText="ET&lt;br&gt;Interest" HtmlEncode="False" 
                        SortExpression="JFETINTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFAMOUNTDUE" DataFormatString="{0:N}" 
                        HeaderText="Amount&lt;br&gt;Due" HtmlEncode="False" 
                        SortExpression="JFAMOUNTDUE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETOTHERFEE" DataFormatString="{0:N}" 
                        HeaderText="Other&lt;br&gt;Fee" HtmlEncode="False" 
                        SortExpression="JFETOTHERFEE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsETUpload" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT ETUPLOAD.REFNO, ETUPLOAD.JFETDATE, ETUPLOAD.JFETPENALTY, ETUPLOAD.JFETADMIN, ETUPLOAD.JFETOTHERFEE, ETUPLOAD.JFAMOUNTDUE, ETUPLOAD.JFOSPRINCIPAL, ETUPLOAD.JFETINTEREST, ISNULL(ACCOUNT.ACCOUNTNAME, 'ACCOUNT NOT FOUND') AS ACCOUNTNAME, ACCOUNT.BOOKINGDATE FROM ETUPLOAD LEFT OUTER JOIN ACCOUNT ON ETUPLOAD.REFNO = ACCOUNT.REFNO AND ACCOUNT.ACCSTATUS = 1">
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Panel ID="pnlProcess" runat="server" CssClass="FooterStyle" Width="100%">

        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
            Font-Bold="True" Font-Underline="True" Style="text-align: center" 
            Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>

    <asp:Button ID="btnProcess" runat="server" Style="cursor: pointer; background-position: right; background-image: url(../Images/proceed.png); background-repeat: no-repeat;  text-align: left;" Text="Process" OnClientClick='return (confirm("Do you want to process ET Data..?"))' Width="136px" />
    <asp:Button ID="btnDelete" runat="server" OnClientClick='return(confirm("Do you want to delete upload data..?"))'
        Style="background-position: right; background-image: url(../Images/delete.gif);
        cursor: pointer; background-repeat: no-repeat;  text-align: left"
        Text="Delete Upload Data" Width="136px" />
        <asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" Style="background-position: right;
            background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;
             text-align: left" Text="Print Data" Width="136px" /></asp:Panel>

    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvETUpload.ClientID%>");
Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
    FormatTable("<%=gvETUpload.ClientID%>");
});

function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
function PrintData(){
    if (Page_ClientValidate("")){
        var winref=window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/ETUPLOAD","PrintDataET", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
        winref.focus();
    }    
    return false;
}
</script>
    
</asp:Content>

