<%@ Control Language="VB" AutoEventWireup="false" CodeFile="InstallmentDataDue.ascx.vb" Inherits="UserControl_InstallmentDataDue" %>
<%@ Register src="NoDataFound.ascx" tagname="nodatafound" tagprefix="uc1" %>
			<asp:GridView ID="gvInstallment" runat="server" AutoGenerateColumns="False"
				Caption="INSTALLMENT DUE DATA" DataSourceID="sdsInstallment" Width="100%">
				<Columns>
					<asp:BoundField DataField="PERIOD" HeaderText="Per" SortExpression="PERIOD">
						<ItemStyle HorizontalAlign="Center" />
					</asp:BoundField>
					<asp:BoundField DataField="DUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Due&lt;br&gt;Date"
						HtmlEncode="False" SortExpression="DUEDATE">
						<ItemStyle HorizontalAlign="Center" />
					</asp:BoundField>
					<asp:TemplateField HeaderText="Principal" SortExpression="PRINCIPAL">
                        <ItemTemplate>
                            <asp:Label ID="lblPrincipal" runat="server" 
                                Text='<%# Eval("PRINCIPAL", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Interest" SortExpression="INTEREST">
                        <ItemTemplate>
                            <asp:Label ID="lblInterest" runat="server" 
                                Text='<%# Eval("INTEREST", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Principal&lt;br&gt;Paid" 
                        SortExpression="PRINCIPALPAID">
                        <ItemTemplate>
                            <asp:Label ID="lblPrincipalPaid" runat="server" 
                                Text='<%# Eval("PRINCIPALPAID", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Interst&lt;br&gt;Paid" 
                        SortExpression="INTERESTPAID">
                        <ItemTemplate>
                            <asp:Label ID="lblInterestPaid" runat="server" 
                                Text='<%# Eval("INTERESTPAID", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
					<asp:TemplateField HeaderText="Principal&lt;br&gt;Waive" 
                        SortExpression="PRINCIPALWAIVE">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" 
                                Text='<%# Eval("PRINCIPALWAIVE", Eval("DECPOINT"))%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Interest&lt;br&gt;Waive" 
                        SortExpression="INTERESTWAIVE">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" 
                                Text='<%# Eval("INTERESTWAIVE", Eval("DECPOINT"))%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
					<asp:BoundField DataField="PENALTYDAY" HeaderText="DPD" 
                        SortExpression="PENALTYDAY">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
					<asp:TemplateField HeaderText="Penalty" SortExpression="PENALTY">
                        <ItemTemplate>
                            <asp:Label ID="lblPenalty" runat="server" 
                                Text='<%# Eval("PENALTY", Eval("DECPOINT") ) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Penalty&lt;br&gt;Paid" 
                        SortExpression="PENALTYPAID">
                        <ItemTemplate>
                            <asp:Label ID="lblPenaltyPaid" runat="server" 
                                Text='<%# Eval("PENALTYPAID", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Penalty&lt;br&gt;Waive" 
                        SortExpression="PENALTYWAIVE">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" 
                                Text='<%# Eval("PENALTYWAIVE", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
				    <asp:TemplateField HeaderText="Inst&lt;br&gt;Diff" SortExpression="INSDIFF">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" 
                                Text='<%# Eval("INSDIFF", Eval("DECPOINT")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
				</Columns>
				<EmptyDataTemplate>
					<uc1:nodatafound id="NoDataFound1" runat="server">
</uc1:nodatafound>
				</EmptyDataTemplate>
			</asp:GridView>
			<asp:SqlDataSource ID="sdsInstallment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
    SelectCommand="SELECT LOCID, ACCID, ACCOUNTNO, ACCOUNTNOFORM, BRANCHID, DUEDATE, PERIOD, PRINCIPAL, INTEREST, PAIDSTS, PRINCIPALPAID, INTERESTPAID, PAIDDATE, PAIDTXNDATE, PENALTYDAY, PENALTYSTS, PENALTYREAL, PENALTY, PENALTYPAID, PENALTYWAIVE, dbo.f_getCurrencyDecPointForNet(CURRENCYID) AS DECPOINT, INSTDIFF - INSTDIFFPAID - INSTDIFFWAIVE AS INSDIFF, PRINCIPALWAIVE, INTERESTWAIVE FROM dbo.f_AccInstalmentDueList(@LOCID, @ACCID, CASE WHEN @APPDATE IS NULL OR len(rtrim(@APPDATE)) &lt;= 0 THEN dbo.f_getappDate() ELSE @APPDATE END) AS f_AccInstalmentList_1 WHERE (DUEDATE &lt;= dbo.f_getAppDate()) AND (PAIDSTS = 0) ORDER BY PERIOD">
				<SelectParameters>
					<asp:Parameter Name="LOCID" DefaultValue="0" />
                    <asp:Parameter Name="ACCID" DefaultValue="0" />
                    <asp:Parameter Name="APPDATE" DefaultValue=" " 
                        ConvertEmptyStringToNull="False" />
				</SelectParameters>
			</asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvInstallment.ClientID%>");
</script>		
