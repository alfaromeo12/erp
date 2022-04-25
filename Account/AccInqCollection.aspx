<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccInqCollection.aspx.vb" Inherits="Account_AccInqCollection" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>

<%@ Register src="../UserControl/DataAccountFromParamAccIDOS.ascx" tagname="DataAccountFromParamAccIDOS" tagprefix="uc2" %>
<%@ Register src="../UserControl/CollectibilityParamAccID.ascx" tagname="CollectibilityParamAccID" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="hidAccID" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
     <asp:HiddenField ID="txtAction" runat="server" />

     <uc2:DataAccountFromParamAccIDOS ID="ctlDataAccountFromParamAccIDOS" 
        runat="server" />
      <asp:Panel ID="Panel1" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgCollect" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblCollect" runat="server" CssClass="required">(Show Collectibility Data...)</asp:Label>
        </div>
        <input id="Button3" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollect" runat="server" CollapseControlID="pnlCollectShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collectibility Data...)"
        Enabled="True" ExpandControlID="pnlCollectShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Collectibility Data...)" ImageControlID="imgCollect" TargetControlID="pnlCollectData"
        TextLabelID="lblCollect">
    </ajaxToolkit:CollapsiblePanelExtender>
            <uc3:CollectibilityParamAccID ID="ctlCollectibilityParamAccID" 
        runat="server" />
  <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Warning Letter Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Warning Letter Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>

    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Warning Letter Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <asp:Panel ID="pnlLoanData" runat="server"  
        Font-Bold="True" Width="100%">
                <asp:GridView ID="gvWarning" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="LOCID,APPID" 
                    DataSourceID="sdsGridWarningLetter" Width="100%" Caption="WARNING LETTER LIST" 
                    RowHeaderColumn="ACCID">
            <Columns>
                <asp:TemplateField HeaderText="ACT" SortExpression="APPID">
                    <ItemTemplate>
                        <img src="../images/detail.gif" style="cursor: pointer" onclick="InfoCollectView('<%#eval("LOCID")%>', '<%#eval("ACCID")%>' , '<%#eval("LETTERID")%>', '<%#eval("WARNTYPE")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("APPID")%>" />&nbsp;
                        <asp:HiddenField ID="hidLetterID" runat="server" 
                            Value='<%# Eval("LETTERID") %>' />
                        <asp:HiddenField ID="HidWarnType" runat="server" 
                            Value='<%# Eval("WARNTYPE") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="LETTERNO" HeaderText="Letter No" 
                    SortExpression="LETTERNO" />
                <asp:BoundField DataField="WARNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Warn&lt;br&gt;Date" HtmlEncode="False" SortExpression="WARNDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="WARNTYPENAME" HeaderText="Warn&lt;br&gt;Type" 
                    HtmlEncode="False" SortExpression="WARNTYPENAME" />
                <asp:BoundField DataField="FROMPERIOD" HeaderText="Periode&lt;br&gt;From" HtmlEncode="False" 
                    SortExpression="FROMPERIOD">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TOPERIOD" 
                    HeaderText="Periode&lt;br&gt;To" HtmlEncode="False" 
                    SortExpression="TOPERIOD">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ODPRINCIPAL" DataFormatString="{0:n}" 
                    HeaderText="Over Due&lt;br&gt;Principal" HtmlEncode="False" 
                    SortExpression="ODPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ODINTEREST" DataFormatString="{0:n}" 
                    HeaderText="Over Due&lt;br&gt;Interest" HtmlEncode="False" 
                    SortExpression="ODINTEREST">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Due&lt;br&gt;Date" HtmlEncode="False" SortExpression="DUEDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PRINTSTATUSNAME" HeaderText="Print&lt;br&gt;Status" HtmlEncode="False"
                    SortExpression="PRINTSTATUSNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
      
                <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                    Visible="False" Width="100%"></asp:Label>
        <br />
        <br />
        <br />
       
    <asp:SqlDataSource ID="sdsGridWarningLetter" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    
                    
                    SelectCommand="SELECT TOP (500) ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, ACCOUNT.ACCSTATUS, WARNINGLETTER.LETTERID, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) + '.' + CAST(WARNINGLETTER.LETTERID AS VARCHAR(20)) AS LETTERNO, WARNINGLETTER.FROMPERIOD, WARNINGLETTER.TOPERIOD, WARNINGLETTER.ODPRINCIPAL, WARNINGLETTER.ODINTEREST, WARNINGLETTER.DUEDATE, CASE WHEN WARNINGLETTER.PRINTSTATUS = 0 THEN 'UNPRINT (BOD)' WHEN WARNINGLETTER.PRINTSTATUS = 1 THEN 'PRINT (BOD)' ELSE 'PRINT (MANUAL)' END AS PRINTSTATUSNAME, ACCOUNT.APPID, WARNINGLETTER.WARNDATE, WARNINGLETTER.WARNTYPE, dbo.f_getParamGlobalName('WARNTYPE', WARNINGLETTER.WARNTYPE) AS WARNTYPENAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN WARNINGLETTER WITH (NOLOCK) ON ACCOUNT.LOCID = WARNINGLETTER.LOCID AND ACCOUNT.ACCID = WARNINGLETTER.ACCID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (ACCOUNT.ACCID = @ACCID) AND (ACCOUNT.LOCID = @LOCID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
            <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
        </SelectParameters>
                </asp:SqlDataSource>
    </asp:Panel>


     <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollectActivities" runat="server" CollapseControlID="pnlCollectShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collection Activities Data...)" Enabled="True"
        ExpandControlID="pnlCollectShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Collection Activities Data...)"
        ImageControlID="imgCollectShow" TargetControlID="pnlCollectData" TextLabelID="lblCollectShow">
    </ajaxToolkit:CollapsiblePanelExtender>

    <asp:Panel ID="pnlCollectShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgCollectShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblCollectShow" runat="server" CssClass="required">(Show Collection Activities Data...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
       <asp:SqlDataSource ID="sdsData" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
        SelectCommand="SELECT TOP (300) COLLECTACTIVITIES.LOCIDCOLL, COLLECTACTIVITIES.COLLECTID, COLLECTACTIVITIES.LOCID, COLLECTACTIVITIES.ACCID, ACCOUNT.APPID, ACCOUNT.LOCIDCUST, ACCOUNT.CUSTID, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNT.ACCOUNTNAME, COLLECTACTIVITIES.DUEDATE, DATEDIFF(DAY, COLLECTACTIVITIES.DUEDATE, dbo.f_getAppDate()) AS AGE, dbo.f_getOSPrincipalRealAccount(COLLECTACTIVITIES.LOCID, COLLECTACTIVITIES.ACCID) AS OSPRINCIPAL, dbo.f_getOSInterestRealAccount(COLLECTACTIVITIES.LOCID, COLLECTACTIVITIES.ACCID) AS OSINTEREST, COLLECTACTIVITIES.COLLECTSTATUS, '(' + CAST(COLLECTACTIVITIES.COLLECTSTATUS AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('COLLECTSTATUS', COLLECTACTIVITIES.COLLECTSTATUS) AS COLLECTSTATUSNAME, COLLECTACTIVITIES.VISITDATE, COLLECTACTIVITIES.ODINSTALLMENT, COLLECTOR.COLLECTORNAME, COLLECTORACTIVITY.ACTIVITYNAME, COLLECTACTIVITIES.STARTACTIVITY FROM COLLECTACTIVITIES WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON COLLECTACTIVITIES.LOCID = ACCOUNT.LOCID AND COLLECTACTIVITIES.ACCID = ACCOUNT.ACCID INNER JOIN COLLECTORACTIVITY WITH (NOLOCK) ON COLLECTACTIVITIES.COLLECTORACTIVITYID = COLLECTORACTIVITY.COLLECTORACTIVITYID INNER JOIN COLLECTOR WITH (NOLOCK) ON COLLECTACTIVITIES.COLLECTORID = COLLECTOR.COLLECTORID WHERE (COLLECTACTIVITIES.Deletests = 0) AND (COLLECTACTIVITIES.LOCID = @LOCID) AND (COLLECTACTIVITIES.ACCID = @ACCID)">
           <SelectParameters>
               <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
               <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
           </SelectParameters>
            </asp:SqlDataSource>
        <asp:Panel ID="pnlCollectData" runat="server"  
            Font-Bold="True" Width="100%">
            <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Caption="COLLECTOR ACTIVITY LIST" 
                DataKeyNames="LOCIDCOLL,COLLECTID,LOCID,ACCID,APPID,LOCIDCUST,CUSTID" DataSourceID="sdsData" 
                Width="100%">
                <Columns>
                      <asp:TemplateField HeaderText="INFO">
                            <ItemTemplate>
                                <img src="../images/detail.gif" style="cursor: pointer" onclick="InfoCollectList('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("APPID")%>', '<%#eval("LOCIDCOLL")%>', '<%#eval("COLLECTID")%>')" alt="Info Colection : <%#eval("LOCIDCOLL")%> - <%#eval("COLLECTID")%>" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="40px" />
                        </asp:TemplateField>
                    <asp:BoundField DataField="CollectorName" HeaderText="Collector" 
                        SortExpression="CollectorName" />
                    <asp:BoundField DataField="STARTACTIVITY" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Assign&lt;br&gt;Date" HtmlEncode="False" 
                        SortExpression="STARTACTIVITY">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Visit&lt;br&gt;Date" HtmlEncode="False" SortExpression="VisitDate">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Due&lt;br&gt;Date" HtmlEncode="False" SortExpression="DUEDATE"><ItemStyle HorizontalAlign="Center" /></asp:BoundField>
                    <asp:BoundField DataField="Age" HeaderText="DPD" ReadOnly="True" 
                        SortExpression="Age"><ItemStyle HorizontalAlign="Center" /></asp:BoundField>
                    <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" 
                        HeaderText="OS&lt;br&gt;Principal" HtmlEncode="False" 
                        SortExpression="OSPRINCIPAL">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="OSINTEREST" DataFormatString="{0:N}" 
                        HeaderText="OS&lt;br&gt;Interest" HtmlEncode="False" 
                        SortExpression="OSINTEREST">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="COLLECTSTATUSNAME" 
                        HeaderText="Collect&lt;br&gt;Status" HtmlEncode="False" ReadOnly="True" 
                        SortExpression="COLLECTSTATUSNAME" />
                    <asp:BoundField DataField="ODINSTALLMENT" DataFormatString="{0:N}" 
                        HeaderText="Over Due&lt;br&gt;Installment" HtmlEncode="False" 
                        SortExpression="ODINSTALLMENT">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACTIVITYNAME" HeaderText="Activity" 
                        SortExpression="ACTIVITYNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <br />
            <br />
        </asp:Panel>


    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEReposes" runat="server" CollapseControlID="pnlReposesShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Reposes Data...)" Enabled="True"
        ExpandControlID="pnlReposesShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Reposes Data...)"
        ImageControlID="imgReposesShow" TargetControlID="pnlReposesData" TextLabelID="lblReposesShow">
    </ajaxToolkit:CollapsiblePanelExtender>

    <asp:Panel ID="pnlReposesShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgReposesShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblReposesShow" runat="server" CssClass="required">(Show Reposes Data...)</asp:Label>
        </div>
        <input id="Button2" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
     <asp:Panel ID="pnlReposesData" runat="server"  
            Font-Bold="True" Width="100%">
         <asp:GridView ID="gvReposes" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="LOCID,ACCID" 
        DataSourceID="sdsGrid" Width="100%" Caption="REPOSES LIST" 
        RowHeaderColumn="ACCID">
            <Columns>
                <asp:TemplateField HeaderText="ACT" SortExpression="APPID">
                    <ItemTemplate>
                        <img src="../images/detail.gif" style="cursor: pointer" onclick="EditApp('<%#eval("LOCID")%>', '<%#eval("APPID")%>', '<%#eval("ACCID")%>', '<%#eval("REPOSESID")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("APPID")%>" />&nbsp;
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="COLLECTORNAME" HeaderText="Collector" 
                    SortExpression="COLLECTORNAME" />
                <asp:BoundField DataField="ASSIGNSTART" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Assign&lt;br&gt;Start" HtmlEncode="False" 
                    SortExpression="ASSIGNSTART">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="LETTERNO" HeaderText="Letter&lt;br&gt;No" 
                    HtmlEncode="False" SortExpression="LETTERNO" />
                <asp:BoundField DataField="COLLECTNAMEINT" 
                    HeaderText="BI&lt;BR&gt;Collectibility" HtmlEncode="False" 
                    SortExpression="COLLECTNAMEINT" />
                <asp:BoundField DataField="COLLECTNAMEBI" 
                    HeaderText="Internal&lt;BR&gt;Collectibility" HtmlEncode="False" 
                    SortExpression="COLLECTNAMEBI" />
                <asp:BoundField DataField="REPOSESSTATUSNAME" 
                    HeaderText="Reposes&lt;br&gt;Status" HtmlEncode="False" 
                    SortExpression="REPOSESSTATUSNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
         <br />
         <br />
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
             
             SelectCommand="SELECT TOP (500) ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, CUSTOMER.CUSTID, CUSTOMER.IDNUMBER, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNO, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME, '(' + COLLECTSTS_1.COLLECTCODE + ')' + COLLECTSTS_1.COLLECTNAME AS COLLECTNAMEBI, '(' + COLLECTSTS.COLLECTCODE + ')' + COLLECTSTS.COLLECTNAME AS COLLECTNAMEINT, REPOSSES.ASSIGNSTART, REPOSSES.LETTERNO, '(' + COLLECTOR.COLLECTORCODE + ') ' + COLLECTOR.COLLECTORNAME AS COLLECTORNAME, REPOSSES.REPOSESID, dbo.f_getParamGlobalName('REPOSESSTATUS', REPOSSES.REPOSESSTATUS) AS REPOSESSTATUSNAME, REPOSSES.REPOSESSTATUS FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN AREA WITH (NOLOCK) ON BRANCH.AREAID = AREA.AREAID INNER JOIN REPOSSES WITH (NOLOCK) ON ACCOUNT.LOCID = REPOSSES.LOCID AND ACCOUNT.ACCID = REPOSSES.ACCID INNER JOIN COLLECTOR WITH (NOLOCK) ON REPOSSES.COLLECTORID = COLLECTOR.COLLECTORID LEFT OUTER JOIN COLLECTSTS WITH (NOLOCK) ON ACCOUNT.COLLECTIDBI = COLLECTSTS.COLLECTID LEFT OUTER JOIN COLLECTSTS AS COLLECTSTS_1 WITH (NOLOCK) ON ACCOUNT.COLLECTIDINT = COLLECTSTS_1.COLLECTID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidLocID" Name="LOCID" PropertyName="Value" />
            <asp:ControlParameter ControlID="hidAccID" Name="ACCID" PropertyName="Value" />
        </SelectParameters>
         </asp:SqlDataSource>
    </asp:Panel>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">

    FormatTable("<%=gvWarning.ClientID%>");
    FormatTable("<%=gvData.ClientID%>");
    FormatTable("<%=gvReposes.ClientID%>");
    window.onload=function(){
		TabToEnter();
        <%=strScript%>
    }
    var WinRef = null;
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function EditApp(LOCID, APPID, ACCID, REPOSESID) {
//       window.location = "../Collect/ReposesProcessEntry.aspx?Action=" + "LIST" + "&LOCID=" + LOCID + "&APPID=" + APPID + "&ACCID=" + ACCID + "&REPOSESID=" + REPOSESID
        var winref = window.open("../Collect/ReposesProcessEntry.aspx?Action=" + "LIST" + "&LOCID=" + LOCID + "&APPID=" + APPID + "&ACCID=" + ACCID + "&REPOSESID=" + REPOSESID, "ReposesInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=VIEW&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }


    function InfoCollect(LOCIDCOLL, COLLECTID) {
        var winref = window.open("CollectAccInfo.aspx?Action=INFO&LOCIDCOLL=" + LOCIDCOLL + "&COLLECTID=" + COLLECTID, "CollectInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }
    function InfoCollectList(LOCID,ACCID,APPID, LOCIDCOLL, COLLECTID) {
        var winref = window.open("../Collect/CollectionInqList.aspx?Action=INFO&LOCID=" + LOCID + "&ACCID=" + ACCID + "&APPID=" + APPID + "&LOCIDCOLL=" + LOCIDCOLL + "&COLLECTID=" + COLLECTID, "CollectInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }


    function InfoCollectView(LOCID, ACCID, LETTERNO, WARNTYPE) {
        // var winref = window.open("../Collect/CollectionWarningView.aspx?Action=" + "ACC" + "&LOCID=" + LOCID + "&ACCID=" + ACCID + "&APPID=" + APPID , "WarningLetterInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        // winref.focus();
        // var oLocid = GetValueTxtByClientID("<%=hidLocID.ClientID%>");
        // var oAccid = GetValueTxtByClientID("<%=hidAccID.ClientID%>");

        if (WARNTYPE == 1) {
            var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/sp1.rpt&stsprn=1&prompt1=" + LOCID + "&prompt2=" + ACCID + "&prompt3=" + LETTERNO, "PrintWarn", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable")
        } else if (WARNTYPE == 2) {
            var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/sp1.rpt&stsprn=1&prompt1=" + LOCID + "&prompt2=" + ACCID + "&prompt3=" + LETTERNO, "PrintWarn", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable")
        } else {
            var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/sp3.rpt&stsprn=1&prompt1=" + LOCID + "&prompt2=" + ACCID + "&prompt3=" + LETTERNO, "PrintWarn", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable")
        }
        winref.focus();
        return false;
    }
    
</script>          
</asp:Content>

