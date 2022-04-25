<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="UploadCollProcess.aspx.vb" Inherits="FrontEnd_UploadProcess" title="Upload Payment Process"  EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BPKBUPLOAD.REFNO">Reference No.</asp:ListItem>
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
    <asp:GridView ID="gvSummary" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        Caption="SUMMARY UPLOAD COLLATERAL DATA PER JF (MULTIFINANCE)"
        DataSourceID="sdsSummary" Width="100%">
        <Columns>
            <asp:BoundField DataField="NUMACC" HeaderText="NUMACC" ReadOnly="True" SortExpression="NUMACC">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound2" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsSummary" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT COUNT(*) AS NUMACC FROM BPKBUPLOAD">
    </asp:SqlDataSource>
    <asp:GridView ID="gvBPKB" runat="server" AutoGenerateColumns="False" Caption="COLLATERAL DATA UPLOAD LIST"
        DataKeyNames="REFNO" DataSourceID="sdsCollateral" Width="100%" 
        AllowPaging="True" AllowSorting="True" RowHeaderColumn="REFNO">
        <Columns>
            <asp:BoundField DataField="BRANCHNAME" HeaderText="BRANCH&lt;BR&gt;NAME" 
                HtmlEncode="False" SortExpression="BRANCHNAME" />
            <asp:BoundField DataField="REFNO" HeaderText="REF&lt;BR&gt;NO" HtmlEncode="False"
                ReadOnly="True" SortExpression="REFNO" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="ACCOUNT&lt;br&gt;NAME" 
                HtmlEncode="False" SortExpression="ACCOUNTNAME" />
            <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="BOOKING&lt;br&gt;DATE" HtmlEncode="False" 
                SortExpression="BOOKINGDATE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="BPKBCARTYPE" HeaderText="BPKB&lt;BR&gt;CAR&lt;BR&gt;TYPE"
                HtmlEncode="False" SortExpression="BPKBCARTYPE" />
            <asp:BoundField DataField="BPKBNO" HeaderText="BPKB&lt;BR&gt;NO" HtmlEncode="False"
                SortExpression="BPKBNO" />
            <asp:BoundField DataField="BPKBDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="BPKB&lt;BR&gt;DATE"
                HtmlEncode="False" SortExpression="BPKBDATE" />
            <asp:BoundField DataField="BPKBADDRESS" HeaderText="BPKB&lt;BR&gt;ADDRESS" HtmlEncode="False"
                SortExpression="BPKBADDRESS" />
            <asp:BoundField DataField="BPKBCITYID" HeaderText="BPKB&lt;BR&gt;CITY&lt;BR&gt;ID"
                HtmlEncode="False" SortExpression="BPKBCITYID" />
            <asp:BoundField DataField="BPKBNAME" HeaderText="BPKB&lt;BR&gt;NAME" HtmlEncode="False"
                SortExpression="BPKBNAME" />
            <asp:BoundField DataField="BPKBOWNERID" HeaderText="BPKB&lt;BR&gt;OWNER&lt;BR&gt;ID"
                HtmlEncode="False" SortExpression="BPKBOWNERID" />
            <asp:BoundField DataField="POLICENO" HeaderText="POLICE&lt;BR&gt;NO" HtmlEncode="False"
                SortExpression="POLICENO" />
            <asp:BoundField DataField="STNKEXPIRED" HeaderText="STNK&lt;BR&gt;EXPIRED" HtmlEncode="False"
                SortExpression="STNKEXPIRED" />
            <asp:BoundField DataField="CHASSISNO" HeaderText="CHASSIS&lt;BR&gt;NO" HtmlEncode="False"
                SortExpression="CHASSISNO" />
            <asp:BoundField DataField="ENGINENO" HeaderText="ENGINE&lt;BR&gt;NO" HtmlEncode="False"
                SortExpression="ENGINENO" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsCollateral" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT BPKBUPLOAD.REFNO, BPKBUPLOAD.BPKBCARTYPE, BPKBUPLOAD.BPKBNO, BPKBUPLOAD.BPKBDATE, BPKBUPLOAD.BPKBADDRESS, BPKBUPLOAD.BPKBCITYID, BPKBUPLOAD.BPKBNAME, BPKBUPLOAD.BPKBOWNERID, BPKBUPLOAD.POLICENO, BPKBUPLOAD.STNKEXPIRED, BPKBUPLOAD.CHASSISNO, BPKBUPLOAD.ENGINENO, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, '(' + BRANCH.BRANCHCODE + ')' + BRANCH.BRANCHNAME AS BRANCHNAME FROM ACCOUNT LEFT OUTER JOIN BRANCH ON ACCOUNT.BRANCHID = BRANCH.BRANCHID RIGHT OUTER JOIN BPKBUPLOAD ON ACCOUNT.REFNO = BPKBUPLOAD.REFNO">
    </asp:SqlDataSource>
    <br />

    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
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
    FormatTable("<%=gvBPKB.ClientID%>");
FormatTable("<%=gvSummary.ClientID%>");
function ProcessData(){
    //if (Page_ClientValidate("")){
        if (!confirm("Are you sure want to PROCESS data...?")){
            return false;
        }
    //}
    return true;
}
function DeleteData(){
    //if (Page_ClientValidate("")){
        if (!confirm("Are you sure want to DELETE data...?")){
            return false;
        }
    //}
    return true;
}

function ViewDtl(COMPCODE, REFNO){
    var winref=window.open("UploadAccDtl.aspx?Action=View&COMPCODE=" + COMPCODE + "&REFNO=" +  REFNO,"UPDACCDTL", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
    winref.focus();
}
function PrintData(){
    //window.open("../Reports/ReportView.aspx?Back=0&RPT=/TUCCAR/TxnInfo&LOCATIONID=" + LocID + "&TXNID=" + TxnID,"PrintTxn", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
    //if (Page_ClientValidate("")){
        var winref=window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/BPKBUPLOAD","PrintDataBPKB", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
        //}
        winref.focus();
    return false;
}
</script>
</asp:Content>

