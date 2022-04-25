<%@ Control Language="VB" AutoEventWireup="false" CodeFile="InstallmentDataAll.ascx.vb" Inherits="UserControl_InstallmentDataAll" %>
        <asp:GridView ID="gvInstallment" runat="server" 
            AutoGenerateColumns="False" Caption="INSTALLMENT DATA" 
            DataSourceID="sdsInstallment" Width="100%">
            <Columns>
                <asp:BoundField DataField="PERIOD" HeaderText="Per" SortExpression="PERIOD">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Due&lt;br&gt;Date" HtmlEncode="False" SortExpression="DUEDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Principal" SortExpression="PRINCIPAL">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("PRINCIPAL", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Interest" SortExpression="INTEREST">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("INTEREST", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:CheckBoxField DataField="PAIDSTS" HeaderText="Paid&lt;br&gt;Sts" 
                    SortExpression="PAIDSTS">
                <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:TemplateField HeaderText="Principal&lt;BR&gt;Paid" 
                    SortExpression="PRINCIPALPAID">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" 
                            Text='<%# eval("PRINCIPALPAID", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Interest&lt;BR&gt;Paid" 
                    SortExpression="INTERESTPAID">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" 
                            Text='<%# eval("INTERESTPAID", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Principal&lt;br&gt;Waive" 
                    SortExpression="PRINCIPALWAIVE">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# eval("PRINCIPALWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Interest&lt;br&gt;Waive" 
                    SortExpression="INTERESTWAIVE">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# eval("INTERESTWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:BoundField DataField="PAIDDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Paid&lt;br&gt;Date" HtmlEncode="False" 
                    SortExpression="PAIDDATE">
                <ItemStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                    HeaderText="Paid&lt;br&gt;TxnDate" HtmlEncode="False" 
                    SortExpression="PAIDTXNDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PENALTYDAY" 
                    HeaderText="Due&lt;br&gt;Day" HtmlEncode="False" 
                    SortExpression="PENALTYDAY">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Penalty" SortExpression="PENALTY">
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("PENALTY", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Penalty&lt;br&gt;Paid" 
                    SortExpression="PENALTYPAID">
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" 
                            Text='<%# eval("PENALTYPAID", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Penalty&lt;br&gt;Waive" 
                    SortExpression="PENALTYWAIVE">
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" 
                            Text='<%# eval("PENALTYWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Inst.&lt;br&gt;Diff" 
                    SortExpression="INSDIFFUNPAID">
                    <ItemTemplate>
                        <asp:Label ID="Label10" runat="server" Text='<%# eval("INSDIFFUNPAID", Eval("DECPOINT")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsInstallment" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
    SelectCommand="SELECT f_AccInstalmentList_1.LOCID, f_AccInstalmentList_1.ACCID, f_AccInstalmentList_1.ACCOUNTNO, f_AccInstalmentList_1.ACCOUNTNOFORM, f_AccInstalmentList_1.BRANCHID, f_AccInstalmentList_1.DUEDATE, f_AccInstalmentList_1.PERIOD, f_AccInstalmentList_1.PRINCIPAL, f_AccInstalmentList_1.INTEREST, f_AccInstalmentList_1.PAIDSTS, f_AccInstalmentList_1.PRINCIPALPAID, f_AccInstalmentList_1.INTERESTPAID, f_AccInstalmentList_1.PAIDDATE, f_AccInstalmentList_1.PAIDTXNDATE, f_AccInstalmentList_1.PENALTYDAY, f_AccInstalmentList_1.PENALTYSTS, f_AccInstalmentList_1.PENALTYREAL, f_AccInstalmentList_1.PENALTY, f_AccInstalmentList_1.PENALTYPAID, f_AccInstalmentList_1.PENALTYWAIVE, f_AccInstalmentList_1.PRINCIPALWAIVE, f_AccInstalmentList_1.INTERESTWAIVE, dbo.f_getCurrencyDecPointForNet(f_AccInstalmentList_1.CURRENCYID) AS DECPOINT, f_AccInstalmentList_1.INSTDIFF - f_AccInstalmentList_1.INSTDIFFPAID - f_AccInstalmentList_1.INSTDIFFWAIVE AS INSDIFFUNPAID, dbo.f_getTermInterest(f_AccInstalmentList_1.FINCATID) AS INTERESTTERM FROM dbo.f_AccInstalmentList(@LOCID, @ACCID, DEFAULT) AS f_AccInstalmentList_1 INNER JOIN ACCOUNT WITH (NOLOCK) ON f_AccInstalmentList_1.LOCID = ACCOUNT.LOCID AND f_AccInstalmentList_1.ACCID = ACCOUNT.ACCID WHERE (f_AccInstalmentList_1.DUEDATE &lt;= CASE WHEN ACCOUNT.ACCSTATUS &lt;&gt; 1 THEN CLOSETXNDATE ELSE DUEDATE END) ORDER BY f_AccInstalmentList_1.PERIOD">
            <SelectParameters>
                <asp:Parameter Name="LOCID" DefaultValue="0" />
                <asp:Parameter Name="ACCID" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvInstallment.ClientID%>");
</script>	