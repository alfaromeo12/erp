<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFInstallment.aspx.vb" Inherits="Account_JFInstallment" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlAccJF" runat="server" Caption="ACCOUNT JF(MULTIFINANCE) INFO" DataKeyField="ACCIDJF"
        DataSourceID="sdsAccJF" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="HeaderStyle" >
                        JF INFO</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="required" >
                        Acc ID JF</td>
                    <td class="required">
                        <asp:Label ID="ACCIDJFLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("ACCIDJF") %>'></asp:Label></td>
                    <td class="required">
                        JF ID&nbsp;</td>
                    <td class="required">
                        <asp:Label ID="JFIDLabel" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="required" >
                        JF Group</td>
                    <td class="required">
                        (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                        <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label>&nbsp;</td>
                    <td class="required">
                        JF (Bank)</td>
                    <td class="required">
                        (<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCODE") %>'></asp:Label>)
                        <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        JF Booking Date</td>
                    <td>
                        <asp:Label ID="JFBOOKINGDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFBOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td class="ErrHighLight">
                        JF Status</td>
                    <td class="ErrHighLight">
                        (<asp:Label ID="JFACCSTATUSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFACCSTATUS") %>'></asp:Label>)
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFACCSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="HeaderStyle" >
                        TOTAL</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle" >
                        Principal</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFOSPRINCIPAL", "{0:N}") %>'></asp:Label></td>
                    <td class="AlternatingRowStyle">
                        Interest</td>
                    <td class="AlternatingRowStyle">
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFOSINTEREST", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="HeaderStyle" >
                        JF LOAN DATA</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td >
                        JF Installment Type</td>
                    <td>
                        (<asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFINSTALLMENTTYPENAME") %>'></asp:Label>
                    </td>
                    <td>
                        Residual Value</td>
                    <td>
                        <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFRESIDUALVALUE", "{0:N}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td >
                        JF Principal</td>
                    <td>
                        <asp:Label ID="JFPRINCIPALTOTALLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("JFPRINCIPALTOTAL", "{0:N}") %>'></asp:Label>
                    </td>
                    <td>
                        JF Tenor</td>
                    <td>
                        <asp:Label ID="JFTENORLabel" runat="server" Font-Bold="True" 
                            Font-Underline="True" Text='<%# Eval("JFTENOR") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td >
                        JF Eff. Rate</td>
                    <td>
                        <asp:Label ID="JFEFFECTIVERATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFEFFECTIVERATE") %>'></asp:Label></td>
                    <td>
                        JF Loan Type</td>
                    <td>
                        (<asp:Label ID="JFLOANTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFLOANTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFLOANTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        JF Installment</td>
                    <td>
                        <asp:Label ID="JFINSTALLMENTLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFINSTALLMENT", "{0:N}") %>'></asp:Label></td>
                    <td>
                        JF Next Due Date</td>
                    <td>
                        <asp:Label ID="JFNEXTDUEDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNEXTDUEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        JF Installment Start</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFINSTALLMENTSTART", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                    <td>
                        JF Installment Day</td>
                    <td>
                        <asp:Label ID="JFINSTALLMENTDAYLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFINSTALLMENTDAY") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        JF Start Period</td>
                    <td>
                        <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("JFSTARTPERIOD") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsAccJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ACCOUNTJF.ACCIDJF, ACCOUNTJF.JFBOOKINGDATE, ACCOUNTJF.JFACCSTATUS, dbo.f_getParamGlobalName('JFACCSTATUS', ACCOUNTJF.JFACCSTATUS) AS JFACCSTATUSNAME, ACCOUNTJF.JFPRINCIPALTOTAL, ACCOUNTJF.JFTENOR, ACCOUNTJF.JFLOANTYPE, dbo.f_getParamGlobalName('LOANTYPE', ACCOUNTJF.JFLOANTYPE) AS JFLOANTYPENAME, ACCOUNTJF.JFEFFECTIVERATE, ACCOUNTJF.JFINSTALLMENT, ACCOUNTJF.JFOSINTERESTREAL AS JFOSINTEREST, ACCOUNTJF.JFOSPRINCIPALREAL AS JFOSPRINCIPAL, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, ACCOUNTJFDTL.JFINSTALLMENTSTART, ACCOUNTJFDTL.JFINSTALLMENTEND, JF.JFID, ACCOUNTJF.JFNEXTDUEDATE, ACCOUNTJF.JFINSTALLMENTDAY, ACCOUNTJF.JFRESIDUALVALUE, ACCOUNTJF.JFINSTALLMENTTYPE, dbo.f_getParamGlobalName('JFINSTALLMENTTYPE', ACCOUNTJF.JFINSTALLMENTTYPE) AS JFINSTALLMENTTYPENAME, ACCOUNTJF.JFSTARTPERIOD FROM ACCOUNTJF WITH (NOLOCK) INNER JOIN JF WITH (NOLOCK) ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP.JFGROUPID LEFT OUTER JOIN ACCOUNTJFDTL WITH (NOLOCK) ON ACCOUNTJF.ACCIDJF = ACCOUNTJFDTL.ACCIDJF WHERE (ACCOUNTJF.ACCIDJF = @ACCIDJF)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ACCIDJF" QueryStringField="ACCIDJF" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvJFInstallment" runat="server" AutoGenerateColumns="False" Caption="JF/BANK INSTALLMENT"
        DataSourceID="sdsJFInstallment" Width="100%">
        <Columns>
            <asp:BoundField DataField="JFDUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Due&lt;BR&gt;Date"
                HtmlEncode="False" SortExpression="JFDUEDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPERIOD" HeaderText="Per" HtmlEncode="False" SortExpression="JFPERIOD">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPRINCIPAL" DataFormatString="{0:N}" HeaderText="Principal"
                HtmlEncode="False" SortExpression="JFPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFINTEREST" DataFormatString="{0:N}" HeaderText="Interest"
                HtmlEncode="False" SortExpression="JFINTEREST">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="JFPAIDSTS" HeaderText="Paid&lt;br&gt;sts" SortExpression="JFPAIDSTS">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="JFPRINCIPALPAID" DataFormatString="{0:N}" HeaderText="Principal&lt;br&gt;Paid"
                HtmlEncode="False" SortExpression="JFPRINCIPALPAID">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFINTERESTPAID" DataFormatString="{0:N}" HeaderText="Interest&lt;br&gt;Paid"
                HtmlEncode="False" SortExpression="JFINTERESTPAID">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPAIDDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="JFPAIDDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;Txn Date"
                HtmlEncode="False" SortExpression="JFPAIDTXNDATE">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPENALTY" DataFormatString="{0:N}" HeaderText="Penalty"
                HtmlEncode="False" SortExpression="JFPENALTY">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPENALTYPAID" DataFormatString="{0:N}" HeaderText="Penalty&lt;br&gt;Paid"
                HtmlEncode="False" SortExpression="JFPENALTYPAID">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="JFPENALTYWAIVE" DataFormatString="{0:N}" HeaderText="Penalty&lt;br&gt;Waive"
                HtmlEncode="False" SortExpression="JFPENALTYWAIVE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsJFInstallment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT f_AccInstalmentJFList_1.LOCID, f_AccInstalmentJFList_1.ACCID, f_AccInstalmentJFList_1.ACCIDJF, f_AccInstalmentJFList_1.JFID, f_AccInstalmentJFList_1.ACCOUNTNO, f_AccInstalmentJFList_1.ACCOUNTNOFORM, f_AccInstalmentJFList_1.BRANCHID, f_AccInstalmentJFList_1.JFDUEDATE, f_AccInstalmentJFList_1.JFPERIOD, f_AccInstalmentJFList_1.JFPRINCIPAL, f_AccInstalmentJFList_1.JFINTEREST, f_AccInstalmentJFList_1.JFPAIDSTS, f_AccInstalmentJFList_1.JFPRINCIPALPAID, f_AccInstalmentJFList_1.JFINTERESTPAID, f_AccInstalmentJFList_1.JFPAIDDATE, f_AccInstalmentJFList_1.JFPAIDTXNDATE, f_AccInstalmentJFList_1.JFPENALTYSTS, f_AccInstalmentJFList_1.JFPENALTYREAL, f_AccInstalmentJFList_1.JFPENALTY, f_AccInstalmentJFList_1.JFPENALTYPAID, f_AccInstalmentJFList_1.JFPENALTYWAIVE, CASE WHEN JFDUEDATE &lt;= dbo.f_getAppDate() AND jfpaidsts = 0 THEN 'RED' ELSE 'BLACK' END AS COLOR FROM dbo.f_AccInstalmentJFList(@ACCIDJF, DEFAULT) AS f_AccInstalmentJFList_1 INNER JOIN ACCOUNTJF ON f_AccInstalmentJFList_1.ACCIDJF = ACCOUNTJF.ACCIDJF WHERE (f_AccInstalmentJFList_1.JFDUEDATE &lt;= CASE WHEN JFACCSTATUS &lt;&gt; 1 THEN JFCLOSETXNDATE ELSE JFDUEDATE END)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ACCIDJF" QueryStringField="ACCIDJF" />
        </SelectParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvJFInstallment.ClientID%>");
</script>
    
</asp:Content>

