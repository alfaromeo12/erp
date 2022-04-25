<%@ Control Language="VB" AutoEventWireup="false" CodeFile="JFInstallmentDataAll.ascx.vb" Inherits="UserControl_JFInstallmentDataAll" %>
<%@ Register src="NoDataFound.ascx" tagname="nodatafound" tagprefix="uc1" %>
        <asp:GridView ID="gvInstallment" runat="server" AutoGenerateColumns="False"
				Caption="JF(BANK) INSTALLMENT DATA" DataSourceID="sdsInstallment" 
    Width="100%">
            <Columns>
                <asp:BoundField DataField="JFPERIOD" HeaderText="Per" SortExpression="JFPERIOD">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFDUEDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="JF Due&lt;br&gt;Date"
						HtmlEncode="False" SortExpression="JFDUEDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPRINCIPAL" DataFormatString="{0:N}" HeaderText="JF&lt;BR&gt;Principal"
						HtmlEncode="False" SortExpression="JFPRINCIPAL">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFINTEREST" DataFormatString="{0:N}" HeaderText="JF&lt;BR&gt;Interest"
						HtmlEncode="False" SortExpression="JFINTEREST">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:CheckBoxField DataField="JFPAIDSTS" HeaderText="Paid&lt;br&gt;Sts" 
                        SortExpression="JFPAIDSTS">
                <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:BoundField DataField="JFPRINCIPALPAID" DataFormatString="{0:N}" HeaderText="JF Principal&lt;BR&gt;Paid"
						HtmlEncode="False" SortExpression="JFPRINCIPALPAID">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFINTERESTPAID" DataFormatString="{0:N}" HeaderText="JF Interest&lt;BR&gt;Paid"
						HtmlEncode="False" SortExpression="JFINTERESTPAID">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPAIDDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;Date"
						HtmlEncode="False" SortExpression="JFPAIDDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPAIDTXNDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Paid&lt;br&gt;TxnDate"
						HtmlEncode="False" SortExpression="JFPAIDTXNDATE">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPENALTY" DataFormatString="{0:N}" HeaderText="JF&lt;br&gt;Penalty"
						HtmlEncode="False" SortExpression="JFPENALTY">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPENALTYPAID" DataFormatString="{0:N}" HeaderText="JF Penalty&lt;br&gt;Paid"
						HtmlEncode="False" SortExpression="JFPENALTYPAID">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPENALTYWAIVE" DataFormatString="{0:N}" HeaderText="JF Penalty&lt;br&gt;Waive"
						HtmlEncode="False" SortExpression="JFPENALTYWAIVE">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:nodatafound id="NoDataFound1" runat="server">
                </uc1:nodatafound>
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsInstallment" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
    SelectCommand="SELECT LOCID, ACCID, ACCIDJF, JFID, ACCOUNTNO, ACCOUNTNOFORM, BRANCHID, JFDUEDATE, JFPERIOD, JFPRINCIPAL, JFINTEREST, JFPAIDSTS, JFPRINCIPALPAID, JFINTERESTPAID, JFPAIDDATE, JFPAIDTXNDATE, JFPENALTYSTS, JFPENALTYREAL, JFPENALTY, JFPENALTYPAID, JFPENALTYWAIVE, CASE WHEN JFPAIDSTS = 0 AND JFDUEDATE &lt;= dbo.f_getAppDate() THEN 1 ELSE 0 END AS FLAGDUE FROM dbo.f_AccInstalmentJFDueList(@ACCIDJF, @TXNDATE) AS f_AccInstalmentJFDueList_1 ORDER BY JFPERIOD">
            <SelectParameters>
                <asp:Parameter Name="ACCIDJF" />
                <asp:Parameter Name="TXNDATE" />
            </SelectParameters>
        </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvInstallment.ClientID%>");
</script>