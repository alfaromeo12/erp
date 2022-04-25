<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccForJFAppDtl.aspx.vb" Inherits="Account_AccForJFAppDtl" title="Account for JF Approval Detail" MaintainScrollPositionOnPostback="true" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)"
        Enabled="True" ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Search Criteria...)" ImageControlID="imgButtonShow" TargetControlID="pnlData"
        TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="99%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:DropDownList ID="ddlCriteria" runat="server">
                        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
                        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
                        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
                        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
                    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button ID="btnFunctionSearch"
                        runat="server" CssClass="Search" Text="Search" />
                    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
                        WatermarkText="%%">
                    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Page Size</td>
                <td colspan="3">
                    <asp:TextBox ID="txtPageSize" runat="server" CssClass="required" Style="text-align: right"
                        Width="40px"></asp:TextBox><asp:RequiredFieldValidator ID="reqPageSize" runat="server"
                            ControlToValidate="txtPageSize" Display="None" ErrorMessage="PAGE SIZE  must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPageSize" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPageSize">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:DataList ID="dlRequest" runat="server" Caption="JF REQUEST INFO" DataKeyField="REQUESTID"
        DataSourceID="sdsJFRequest" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="HeaderStyle">
                        Request ID</td>
                    <td class="HeaderStyle">
                        <asp:Label ID="REQUESTIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("REQUESTID") %>'></asp:Label></td>
                    <td class="HeaderStyle">
                        Request Date</td>
                    <td class="HeaderStyle">
                        <asp:Label ID="REQUESTDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("REQUESTDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="FooterStyle">
                        JF Group</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                        <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label></td>
                    <td class="FooterStyle">
                        JF</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)
                        <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNAME") %>'></asp:Label>
                        <img alt="JF Detail Info" onclick='JFInfo(<%# Eval("JFID") %>)' src="../Images/detail.gif"
                            style="cursor: pointer" /></td>
                </tr>
                <tr>
                    <td>
                        JF Portion</td>
                    <td>
                        <asp:Label ID="JFPORTIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPORTION", "{0:N}") %>'></asp:Label>
                        %</td>
                    <td>
                        Mirror Status</td>
                    <td>
                        <asp:Label ID="MIRRORSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MIRRORSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        PKS No.</td>
                    <td>
                        <asp:Label ID="JFPKSNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSNO") %>'></asp:Label></td>
                    <td>
                        PKS Date</td>
                    <td>
                        <asp:Label ID="JFPKSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td>
                        (<asp:Label ID="JFADMINTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFADMINTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPENAME") %>'></asp:Label></td>
                    <td>
                        Admin</td>
                    <td>
                        <asp:Label ID="JFADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMIN") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Provison Type</td>
                    <td>
                        (<asp:Label ID="JFPROVISIONTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFPROVISIONTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPENAME") %>'></asp:Label></td>
                    <td>
                        Provision</td>
                    <td>
                        <asp:Label ID="JFPROVISIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISION") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsJFRequest" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JFREQUEST.REQUESTID, JFREQUEST.REQUESTDATE, JFREQUEST.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, JF.JFPORTION, JF.JFMIRRORSTATUS, dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS MIRRORSTATUSNAME, JF.JFPKSNO, JF.JFPKSDATE, JF.JFADMINTYPE, dbo.f_getParamGlobalName('JFADMINTYPE', JF.JFADMINTYPE) AS JFADMINTYPENAME, JF.JFADMIN, JF.JFPROVISIONTYPE, dbo.f_getParamGlobalName('JFPROVISIONTYPE', JF.JFPROVISIONTYPE) AS JFPROVISIONTYPENAME, JF.JFPROVISION FROM JFREQUEST INNER JOIN JF ON JFREQUEST.JFID = JF.JFID INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (JFREQUEST.REQUESTID = @REQUESTID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="REQUESTID" QueryStringField="REQUESTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidRequestID" runat="server" />
    <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" Caption="JF REQUEST SUMMARY"
        DataSourceID="sdsJFRequestSummary" Width="100%">
        <Columns>
            <asp:BoundField DataField="NUMACC" HeaderText="#Acc" HtmlEncode="False" ReadOnly="True"
                SortExpression="NUMACC">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="NUMACCUNAPP" HeaderText="#Acc&lt;br&gt;UnApp" HtmlEncode="False"
                ReadOnly="True" SortExpression="NUMACCUNAPP">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="NUMACCAPP" HeaderText="#Acc&lt;br&gt;App" HtmlEncode="False"
                ReadOnly="True" SortExpression="NUMACCAPP">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="NUMACCRJC" HeaderText="#Acc&lt;br&gt;Rjt" HtmlEncode="False"
                ReadOnly="True" SortExpression="NUMACCRJC">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALPRINCIPAL" DataFormatString="{0:N}" HeaderText="Total&lt;br&gt;Principal"
                HtmlEncode="False" ReadOnly="True" SortExpression="TOTALPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALPRINCIPALUNAPP" DataFormatString="{0:N}" HeaderText="Principal&lt;br&gt;UnApp"
                HtmlEncode="False" ReadOnly="True" SortExpression="TOTALPRINCIPALUNAPP">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALPRINCIPALAPP" DataFormatString="{0:N}" HeaderText="Principal&lt;br&gt;App"
                HtmlEncode="False" ReadOnly="True" SortExpression="TOTALPRINCIPALAPP">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TOTALPRINCIPALRJT" DataFormatString="{0:N}" HeaderText="Principal&lt;br&gt;Rjt"
                HtmlEncode="False" ReadOnly="True" SortExpression="TOTALPRINCIPALRJT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsJFRequestSummary" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT COUNT(*) AS NUMACC, SUM(CASE WHEN JFREQUESTSTATUS = 0 THEN 1 ELSE 0 END) AS NUMACCUNAPP, SUM(CASE WHEN JFREQUESTSTATUS = 1 THEN 1 ELSE 0 END) AS NUMACCAPP, SUM(CASE WHEN JFREQUESTSTATUS = 9 THEN 1 ELSE 0 END) AS NUMACCRJC, SUM(OSPRINCIPAL) AS TOTALPRINCIPAL, SUM(CASE WHEN JFREQUESTSTATUS = 0 THEN OSPRINCIPAL ELSE 0 END) AS TOTALPRINCIPALUNAPP, SUM(CASE WHEN JFREQUESTSTATUS = 1 THEN OSPRINCIPAL ELSE 0 END) AS TOTALPRINCIPALAPP, SUM(CASE WHEN JFREQUESTSTATUS = 9 THEN OSPRINCIPAL ELSE 0 END) AS TOTALPRINCIPALRJT FROM JFREQUESTACC WHERE (REQUESTID = @REQUESTID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="REQUESTID" QueryStringField="REQUESTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table cellpadding="0" cellspacing="0" style="width:100%;">
        <tr>
            <td colspan="4">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="FooterStyle">
                Request Status&nbsp; :</td>
            <td class="FooterStyle">
    <asp:DropDownList ID="ddlJFRequestSearch" runat="server" DataSourceID="sdsJFRequestStatus"
        DataTextField="NAME" DataValueField="CODE" AutoPostBack="True">
    </asp:DropDownList><asp:SqlDataSource ID="sdsJFRequestStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT - 1 AS CODE, '[NOT REJECTED]' AS NAME UNION ALL SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS Expr1 FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFREQUESTSTATUS')">
    </asp:SqlDataSource>
            </td>
            <td class="FooterStyle">
                Request Type</td>
            <td class="FooterStyle">
                <asp:DropDownList ID="ddlJFRequestTypeSearch" runat="server" 
                    AutoPostBack="True" DataSourceID="sdsJFRequestType" DataTextField="NAME" 
                    DataValueField="CODE">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsJFRequestType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFREQUESTTYPE')">
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="ShowDetail" colspan="4">
                    <asp:Button ID="btnReport" runat="server" OnClientClick="return PrintData();" 
                        Style="background-position: right; background-image: url(../Images/report.png); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                        Text="Print JF Request" />
                    </td>
        </tr>
    </table>
    <asp:GridView ID="gvRequestAcc" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="JF REQUEST ACCOUNT LIST" DataKeyNames="REQUESTID,REQUESTIDACC,LOCID,ACCID"
        DataSourceID="sdsJFRequestAcc" RowHeaderColumn="ACCNO" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="No.">
                <ItemTemplate>
                    <asp:Label ID="lblNo" runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="INF" SortExpression="REQUESTIDACC">
                <ItemTemplate>
                    <img alt='Edit : <%#eval("LOCID")%> - <%#eval("ACCID")%>' onclick="EditApp('<%#eval("LOCID")%>', '<%#eval("APPID")%>')"
                        src="../images/view.gif" style="cursor: pointer" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CHK" SortExpression="REQUESTIDACC">
                <ItemTemplate>
                    <asp:CheckBox ID="cbCHK" runat="server" Visible='<%# Eval("APPEXIST") %>' />
                    <asp:HiddenField ID="txtAccountNo" runat="server" Value='<%# Eval("ACCNO") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="JRN">
                <ItemTemplate>
                    <img src="../Images/journal.gif" onclick='ShowJournal("<%#eval("ACCIDJF")%>", "<%#eval("BCCODE")%>")' alt='Show Journal' style='cursor: pointer; visibility:<%#eval("ShowJournal")%>;' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="ACCNO" HeaderText="Account No&lt;br&gt;(formated)" HtmlEncode="False"
                ReadOnly="True" SortExpression="ACCNO" />
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="ACCOUNTNAME" />
            <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Book&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="BOOKINGDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" HeaderText="OS&lt;br&gt;Principal"
                HtmlEncode="False" SortExpression="OSPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OSINTEREST" DataFormatString="{0:N}" HeaderText="OS&lt;br&gt;Interest"
                HtmlEncode="False" SortExpression="OSINTEREST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OSTENOR" HeaderText="OS&lt;br&gt;Ten" HtmlEncode="False"
                SortExpression="OSTENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Next&lt;br&gt;Due&lt;br&gt;Date" SortExpression="NEXTDUEDATE">
                <ItemTemplate>
                    <asp:Label ID="lblNextDueDate" runat="server" Text='<%# Eval("NEXTDUEDATE", "{0:dd/MM/yyyy}") %>' BackColor='<%# System.Drawing.Color.FromName(DataBinder.Eval(Container.DataItem,"DAYDIFFCOLOR").ToString()) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Days&lt;br&gt;To&lt;br&gt;Due" SortExpression="DAYDIFF">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("DAYDIFF") %>' BackColor='<%# System.Drawing.Color.FromName(DataBinder.Eval(Container.DataItem,"DAYDIFFCOLOR").ToString()) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:BoundField DataField="INSTALLMENTDAY" HeaderText="Inst&lt;br&gt;Day" HtmlEncode="False"
                SortExpression="INSTALLMENTDAY">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFREQUESTSTATUSNAME" HeaderText="Req.&lt;br&gt;Status"
                HtmlEncode="False" ReadOnly="True" SortExpression="JFREQUESTSTATUSNAME" />
            <asp:BoundField DataField="JFTENOR" HeaderText="JF&lt;br&gt;Ten" HtmlEncode="False"
                SortExpression="JFTENOR">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFLOANTYPENAME" HeaderText="JF&lt;br&gt;Loan Type" HtmlEncode="False"
                ReadOnly="True" SortExpression="JFLOANTYPENAME" />
            <asp:BoundField DataField="STARTPERIOD" HeaderText="Start&lt;br&gt;Per" HtmlEncode="False"
                SortExpression="STARTPERIOD">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFREQUEESTTYPENAME" HeaderText="Req&lt;br&gt;Type" HtmlEncode="False"
                SortExpression="JFREQUEESTTYPENAME" />
            <asp:BoundField DataField="JFPRINCIPALTOTAL" DataFormatString="{0:N}" 
                HeaderText="JF&lt;br&gt;Principal" HtmlEncode="False" 
                SortExpression="JFPRINCIPALTOTAL">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFBOOKEDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="JF&lt;BR&gt;Book&lt;BR&gt;Date" HtmlEncode="False" 
                SortExpression="JFBOOKEDDATE">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFINSTALLMENTSTART" 
                DataFormatString="{0:dd/MM/yyyy}" HeaderText="JF&lt;br&gt;Inst.&lt;br&gt;Start" 
                HtmlEncode="False" SortExpression="JFINSTALLMENTSTART">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFINSTALLMENT" DataFormatString="{0:N}" 
                HeaderText="Installment" HtmlEncode="False" SortExpression="JFINSTALLMENT">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFEFFECTIVERATE" 
                HeaderText="JF&lt;BR&gt;Eff.&lt;br&gt;Rate" HtmlEncode="False" 
                SortExpression="JFEFFECTIVERATE">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsJFRequestAcc" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
    
        
        
        
        SelectCommand="SELECT JFREQUESTACC.REQUESTID, JFREQUESTACC.REQUESTIDACC, ACCOUNT.ACCOUNTNAME, JFREQUESTACC.OSPRINCIPAL, JFREQUESTACC.OSINTEREST, JFREQUESTACC.OSTENOR, JFREQUESTACC.NEXTDUEDATE, JFREQUESTACC.INSTALLMENTDAY, '(' + CAST(JFREQUESTACC.JFREQUESTSTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('JFREQUESTSTATUS', JFREQUESTACC.JFREQUESTSTATUS) AS JFREQUESTSTATUSNAME, '(' + CAST(JFREQUESTACC.JFREQUESTTYPE AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('JFREQUESTTYPE', JFREQUESTACC.JFREQUESTTYPE) AS JFREQUEESTTYPENAME, JFREQUESTACC.JFTENOR, '(' + CAST(JFREQUESTACC.JFLOANTYPE AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('LOANTYPE', JFREQUESTACC.JFLOANTYPE) AS JFLOANTYPENAME, JFREQUESTACC.STARTPERIOD, dbo.f_FormatAccNoByID(ACCOUNT.BRANCHID, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.BOOKINGDATE, DATEDIFF(day, dbo.f_getAppDate(), JFREQUESTACC.NEXTDUEDATE) AS DAYDIFF, CASE WHEN DATEDIFF(day , dbo.f_getAppDate() , dbo.JFREQUESTACC.NEXTDUEDATE) &lt; 3 THEN 'RED' WHEN DATEDIFF(day , dbo.f_getAppDate() , dbo.JFREQUESTACC.NEXTDUEDATE) BETWEEN 4 AND 7 THEN 'YELLOW' ELSE 'GREEN' END AS DAYDIFFCOLOR, CAST(CASE WHEN JFREQUESTSTATUS = 0 THEN 1 ELSE 0 END AS BIT) AS APPEXIST, JFREQUESTACC.JFBOOKEDDATE, JFREQUESTACC.JFINSTALLMENTSTART, JFREQUESTACC.JFINSTALLMENT, JFREQUESTACC.JFEFFECTIVERATE, JFREQUESTACC.JFPRINCIPALTOTAL, ACCOUNT.APPID, ACCOUNTJF.ACCIDJF, CASE WHEN JFREQUESTACC.JFREQUESTTYPE = 1 THEN 'JFC' ELSE 'JFS' END AS BCCODE, CASE WHEN JFREQUESTACC.JFREQUESTSTATUS = 1 THEN 'visible' ELSE 'hidden' END AS ShowJournal FROM JFREQUESTACC INNER JOIN ACCOUNT WITH (NOLOCK) ON JFREQUESTACC.LOCID = ACCOUNT.LOCID AND JFREQUESTACC.ACCID = ACCOUNT.ACCID LEFT OUTER JOIN ACCOUNTJF WITH (NOLOCK) ON JFREQUESTACC.REQUESTIDACC = ACCOUNTJF.REQUESTIDACC WHERE (JFREQUESTACC.REQUESTID = @REQUESTID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="REQUESTID" QueryStringField="REQUESTID" />
        </SelectParameters>
    </asp:SqlDataSource>

                            <asp:CheckBox ID="chkAll" runat="server" 
        Text="Check/UnCheck All" CssClass="ShowDetail" />
                        <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <asp:Panel ID="pnlProcess" runat="server" CssClass="FooterStyle" Width="100%" Font-Bold="True" GroupingText="JF Request Process">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="RowStyle" colspan="2">
                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Style="text-align: center"
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
                        </td>
            </tr>
            <tr>
                <td class="RowStyle">
                    New Intallment Day</td>
                <td class="RowStyle">
                    <asp:TextBox ID="txtNewInstDay" runat="server" CssClass="required" Style="text-align: right"
                        Width="48px" ValidationGroup="InstDay"></asp:TextBox><asp:Button ID="btnUpdate" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Update" Width="72px" ValidationGroup="InstDay" />
                    <asp:RequiredFieldValidator ID="reqInstDay" runat="server" ControlToValidate="txtNewInstDay"
                        Display="None" ErrorMessage="NEW INSTALLMENT DAY must be entry...!" SetFocusOnError="True"
                        ValidationGroup="InstDay"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEInstDay" runat="server" HighlightCssClass="ErrHighLight"
                        TargetControlID="reqInstDay">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;Update Installment day base on checklist above</td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    JF/Bank Booked Date</td>
                <td>
                    <asp:TextBox ID="txtValueDate" runat="server" CssClass="required" Width="72px" 
                        ValidationGroup="BookDate"></asp:TextBox><asp:Image
                        ID="imgValueDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    <asp:Button ID="btnUpdateBookDate" runat="server" 
                        Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                        Text="Update" ValidationGroup="BookDate" Width="72px" />
                    <asp:RequiredFieldValidator ID="reqValuedAte" runat="server"
                            ControlToValidate="txtValueDate" Display="None" ErrorMessage="VALUE DATE must be entry...!"
                            SetFocusOnError="True" ValidationGroup="Approve"></asp:RequiredFieldValidator>
                    <asp:Label ID="lblVerifyDate" runat="server" CssClass="ErrHighLight" Text="Please CONFIRM and VERIFY booked date to the Join Finance (Bank)"></asp:Label>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEValueDate" runat="server" HighlightCssClass="ErrHighLight"
                        TargetControlID="reqValuedAte">
                    </ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEValueDate" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgValueDate"
                        TargetControlID="txtValueDate" PopupPosition="TopRight">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEValueDate" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtValueDate">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="2">
                    <asp:Button ID="btnBack" runat="server" Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="72px" CausesValidation="False" />
        <asp:Button ID="btnApprove" runat="server" Style="background-position: right; background-image: url(../Images/ok.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Approve" Width="72px" ValidationGroup="Approve" />
        <asp:Button ID="btnReject" runat="server" Style="background-position: right; background-image: url(../Images/stop.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Reject" Width="72px" OnClientClick='return confirm("Are you sure want to Reject JF Request..?")' CausesValidation="False" />
        Approve or Reject by checklist above</td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>

<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvRequestAcc.ClientID%>");
    FormatTable("<%=gvSummary.ClientID%>");
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return (oObject);
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function EditApp(LOCID, APPID){
    var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
    winref.focus();
}
function JFInfo(JFID){
    var winref = window.open("../Account/JFInfo.aspx?JFID=" + JFID, "JFInfo", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}

function PrintData() {
    var sRequestID = GetValueTxtByClientID("<%=hidRequestID.ClientID%>");
    var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/JFREQUEST&REQUESTID=" + sRequestID, "PrintJFRequest", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
    return (false);
}

function ShowJournal(RefNo, bc) {
    var WinRef = window.open("../Core/JournalViewByRefNo.aspx?Action=View&RefNo=" + RefNo + "&BookCode=" + bc, "JFBOOKJournal", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    WinRef.focus();
    return (false);
}
function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}
function CheckAll() {
    var chk = getObjectbyClientID("<%=chkAll.ClientID%>");
    var sCheck = "<%=strCheckBox%>";
    var arrCheck = sCheck.split(",");
    var oCheck;
    var nLen = arrCheck.length - 1;
    if (nLen > 0) {
        for (var i = 0; i < nLen; i++) {
            oCheck = getObjectbyClientID(arrCheck[i].toString());
            if (oCheck) {
                oCheck.checked = chk.checked;
                if (oCheck.checked)
                    oCheck.parentElement.parentElement.className = "SelectedRowStyle";
                else
                    oCheck.parentElement.parentElement.className = "";
            }
        }
    }
}

</script>
    
</asp:Content>

