<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ETUploadApp.aspx.vb" Inherits="Account_ETUploadApp" title="ET Upload Approval" EnableEventValidation="false"%>
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
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="RowStyle">
                <asp:DropDownList ID="ddlCriteria" runat="server">
                    <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
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
        <tr>
            <td>
                JF
                ET Date</td>
            <td>
                <asp:TextBox ID="txtETFrom" runat="server" Width="72px"></asp:TextBox><asp:Image
                    ID="imgETFrom" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                    ToolTip="Calendar" />
                To
                <asp:TextBox ID="txtETTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgETTo"
                    runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender
                        ID="ajaxCEETFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgETFrom"
                        TargetControlID="txtETFrom">
                    </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:CalendarExtender ID="ajaxCEETTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgETTo"
                    TargetControlID="txtETTo">
                </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                    TargetControlID="txtETFrom">
                </ajaxToolkit:MaskedEditExtender>
                <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                    TargetControlID="txtETTo">
                </ajaxToolkit:MaskedEditExtender>
            </td>
        </tr>
    </table>

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
    <br />
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="Early Termination - Data Upload List" 
                DataKeyNames="LOCID,ACCID,ETID" DataSourceID="sdsGrid" Width="99%">
                <Columns>
                    <asp:TemplateField HeaderText="ACT" SortExpression="ACCID">
                        <ItemTemplate>
                    <img alt='Edit : <%#eval("LOCID")%> - <%#eval("ACCID")%>' onclick="ShowET('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("ETID")%>')"
                        src="../images/edit.gif" style="cursor: pointer" />&nbsp;
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                        HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                    <asp:BoundField DataField="REFNO" HeaderText="Ref.No." SortExpression="REFNO" />
                    <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" 
                        HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                        SortExpression="OSPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ETINTEREST" DataFormatString="{0:N}" 
                        HeaderText="ET&lt;br&gt;Interest" HtmlEncode="False" 
                        SortExpression="ETINTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ETPENALTY" DataFormatString="{0:N}" 
                        HeaderText="ET&lt;br&gt;Penalty" HtmlEncode="False" SortExpression="ETPENALTY">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ETADMIN" DataFormatString="{0:N}" 
                        HeaderText="ET&lt;br&gt;Admin" HtmlEncode="False" SortExpression="ETADMIN">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ETSTATUSNAME" HeaderText="ET&lt;br&gt;Status" 
                        HtmlEncode="False" SortExpression="ETSTATUSNAME" />
                    <asp:BoundField DataField="JFOSPRINCIPAL" DataFormatString="{0:N}" 
                        HeaderText="JF OS&lt;BR&gt;Principal" HtmlEncode="False" 
                        SortExpression="JFOSPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETINTEREST" DataFormatString="{0:N}" 
                        HeaderText="JF ET&lt;br&gt;Interest" HtmlEncode="False" 
                        SortExpression="JFETINTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETPENALTY" DataFormatString="{0:N}" 
                        HeaderText="JF ET&lt;br&gt;Penalty" HtmlEncode="False" 
                        SortExpression="JFETPENALTY">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFETADMIN" DataFormatString="{0:N}" 
                        HeaderText="JF ET&lt;br&gt;Admin" HtmlEncode="False" SortExpression="JFETADMIN">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="JFAMOUNTDUE" DataFormatString="{0:N}" 
                        HeaderText="JF Amount&lt;br&gt;Due" HtmlEncode="False" 
                        SortExpression="JFAMOUNTDUE">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGrid" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT TOP (2000) ET.LOCID, ET.ACCID, ET.ETID, ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, ET.ETTXNDATE, ET.ETSTATUS, ET.ETPENALTY, ET.ETADMIN, ET.OSPRINCIPAL, ET.ETINTEREST, '(' + CAST(ET.ETSTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('ETSTATUS', ET.ETSTATUS) AS ETSTATUSNAME, ET.JFETPENALTY, ET.JFETADMIN, ET.JFETOTHERFEE, ET.JFAMOUNTDUE, ET.JFOSPRINCIPAL, ET.JFETINTEREST FROM ACCOUNT WITH (NOLOCK) INNER JOIN ET ON ACCOUNT.LOCID = ET.LOCID AND ACCOUNT.ACCID = ET.ACCID AND ACCOUNT.ACCSTATUS = 1 WHERE (ET.ENTRYSOURCE = 2)">
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
    <asp:HiddenField ID="hidAction" runat="server" />

    <br />
    <br />
    <br />
    <br />
    <asp:Panel ID="pnlPayment" runat="server" CssClass="ShowDetail" Font-Bold="True"
        GroupingText="Payment Process" Visible="False" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="AlternatingRowStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                Txn Type</td>
                            <td>
                                <asp:DropDownList ID="ddlTxnType" runat="server" CssClass="required" 
                                    DataSourceID="sdsTxnType" DataTextField="TXNTYPE" DataValueField="CODE">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsTxnType" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT NULL AS CODE, '[TXN TYPE]' AS TXNTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS TXNTYPE FROM PARAMGLOBAL WHERE (TYPE = 'TXNTYPE')">
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="reqPaymentType" runat="server" 
                                    ControlToValidate="ddlTxnType" Display="None" 
                                    ErrorMessage="PAYMENT TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" 
                                    HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr ID="trBank">
                            <td>
                                Bank Account No.</td>
                            <td>
                                <asp:DropDownList ID="ddlAccountNo" runat="server" CssClass="required" 
                                    DataSourceID="sdsAccountNo" DataTextField="ACCOUNTNO" 
                                    DataValueField="ACCOUNTID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsAccountNo" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT NULL AS ACCOUNTID, NULL AS BANKNAME, '[ACCOUNT NUMBER]' AS ACCOUNTNO UNION ALL SELECT BANKACCOUNT.ACCOUNTID, BANK.BANKNAME, BANK.BANKNAME + '-' + BANKACCOUNT.ACCOUNTNO AS ACCOUNTNO FROM BANKACCOUNT INNER JOIN BANK ON BANKACCOUNT.BANKID = BANK.BANKID WHERE (BANKACCOUNT.DELETESTS = 0) ORDER BY BANKNAME, ACCOUNTNO">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    <asp:Button ID="btnProcess" runat="server" 
                        OnClientClick="return ProcessET();" 
                        Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                        Text="Process" Width="88px" />
                    &nbsp;<asp:Button ID="btnRejectPay" runat="server" CausesValidation="False" 
                        OnClientClick="return(confirm(&quot;Are you sure want to Reject ET Payment..?&quot;));" 
                        Style="background-position: right; background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                        Text="Reject" Width="88px" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEPayment" runat="server" TargetControlID="pnlPayment"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <br />
    <asp:Panel ID="pnlProcess" runat="server" CssClass="FooterStyle" Width="100%">
        <asp:Button ID="btnApprove" runat="server" OnClientClick='return(confirm("Are you sure want to approve data..?"));' Style="background-position: right;
            background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;
             text-align: left" Text="Approve" Width="88px" />
        <asp:Button ID="btnReject" runat="server" CausesValidation="False"
                Style="background-position: right; background-image: url(../Images/stop.png);
                cursor: pointer; background-repeat: no-repeat;  text-align: left"
                Text="Reject" Width="88px" OnClientClick='return(confirm("Are you sure want to reject data..?"));' />
        <asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" Style="background-position: right;
            background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;
             text-align: left" Text="Print Data" Width="88px" /></asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}
function ShowET(LOCID, ACCID, ETID){
    window.location="ETDisplay.aspx?Action=INQ&LOCID=" + LOCID + "&ACCID=" + ACCID + "&ETID=" + ETID
}
function ViewDetailAcc(LOCID, APPID){
    var winref=window.open("../Account/AccInqFrame.aspx?Action=INQ&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
    winref.focus();
}

function PrintData(){
    var ETDate1=getFormatDate(ConvertToDate(GetValueTxtByClientID("<%=txtETFrom.ClientID%>")));
    var ETDate2=getFormatDate(ConvertToDate(GetValueTxtByClientID("<%=txtETTo.ClientID%>")));
    if (Page_ClientValidate("")){
        var winref=window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/ETUPLOADCOMPARE&ETDATE1=" + ETDate1 + "&ETDATE2=" + ETDate2,"PrintDataETComp", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
        winref.focus();
    }    
    return false;
}
function getFormatDate(theDate){
    var iYear=theDate.getYear();
    var iMonth=theDate.getMonth() + 1;
    var iDate=theDate.getDate();
    var sYear=iYear.toString()
    var sMonth=iMonth.toString()
    var sDate=iDate.toString()
    var sDate=sYear + "-" + sMonth + "-" + sDate;
    return(sDate);
}
function TxnTypeChange() {
    var oTxn = getObjectbyClientID("<%=ddlTxnType.ClientID%>");
    if (oTxn) {
        var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
        var oDiv = getObjectbyClientID("trBank");
        if (TxnType == "1") {
            var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
            oAcc.value = "";
            oDiv.style.display = "none";
        } else {
            oDiv.style.display = "";
        }
    }
}

function CheckTxnType() {
    var TxnType = GetValueTxtByClientID("<%=ddlTxnType.ClientID%>");
    if (TxnType == "2") {
        var oAcc = getObjectbyClientID("<%=ddlAccountNo.ClientID%>");
        if (oAcc.value == "") {
            alert("[BANK ACCOUNT NO.] must be entry...!");
            oAcc.className = "ErrHighLight";
            oAcc.focus();
            return false;
        }

    }
    return true;
}

function ProcessET() {
    if (Page_ClientValidate("")) {
            if (CheckTxnType()) {
                if (!confirm("Are you sure want to Process PAYMENT Early Termination...?")) {
                    return false;
                }
            } else 
                return false;            
    }
    return true;
}

</script>

    
</asp:Content>

