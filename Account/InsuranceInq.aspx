<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="InsuranceInq.aspx.vb" Inherits="Account_InsuranceInq" title="Untitled Page" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="nodatafound" tagprefix="uc6" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
        </div>
        <input id="Button5" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
        ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
        ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlLoanData" runat="server" Width="100%">
        <uc1:LoanDataFromParamAccID ID="ctlLoanDataFromParamAccID" runat="server" />
    </asp:Panel><asp:Panel ID="pnlInsShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgIns" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblIns" runat="server" CssClass="required">(Show Insurance Data...)</asp:Label>
        </div>
        <input id="Button1" noenter="" style="background-position: left top; width: 24px;
            cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEIns" runat="server" CollapseControlID="pnlInsShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Insurance Data...)" Enabled="True"
        ExpandControlID="pnlInsShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Insurance Data...)"
        ImageControlID="imgIns" TargetControlID="pnlInsData" TextLabelID="lblIns">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlInsData" runat="server" Width="100%">
        <asp:Panel ID="pnlInsOld" runat="server">
            <asp:DataList ID="fvInsurance" runat="server" Caption="INSURANCE DATA" 
                DataSourceID="sdsInsuranceData" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="ErrHighLight">
                                JF Insurance Code</td>
                            <td class="ErrHighLight">
                                <asp:Label ID="JFINSCODELabel" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("JFINSCODE") %>'></asp:Label>
                            </td>
                            <td class="ErrHighLight">
                                JF Insurance Name</td>
                            <td class="ErrHighLight">
                                <asp:Label ID="JFINSNAMELabel" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("JFINSNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Address</td>
                            <td colspan="3">
                                <asp:Label ID="JFINSADDRESSLabel" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("JFINSADDRESS") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                City</td>
                            <td colspan="3">
                                <asp:Label ID="JFINSCITYLabel" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("JFINSCITY") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="FooterStyle">
                                Insurance Premi</td>
                            <td class="FooterStyle">
                                <asp:Label ID="INSPREMILabel" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("INSPREMI", "{0:N}") %>'></asp:Label>
                            </td>
                            <td class="FooterStyle">
                                Insurance Premi On Loan</td>
                            <td class="FooterStyle">
                                <asp:Label ID="INSONLOANLabel" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("INSONLOAN", "{0:N}") %>'></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="sdsInsuranceData" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT ACCOUNT.JFINSID, JFINSURANCE.JFINSCODE, JFINSURANCE.JFINSNAME, JFINSURANCE.JFINSADDRESS, JFINSURANCE.JFINSCITY, ACCOUNT.INSPREMI, ACCOUNT.INSONLOAN FROM ACCOUNT WITH (NOLOCK) LEFT OUTER JOIN JFINSURANCE WITH (NOLOCK) ON ACCOUNT.JFINSID = JFINSURANCE.JFINSID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.APPID = @APPID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
                    <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="pnlInsNew" runat="server">
            <asp:DataList ID="dlInsuranceInfo" runat="server" Caption="INSURANCE INFO" 
                DataSourceID="sdsInsuranceInfo" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:100%;">
                        <tr>
                            <td>
                                Insurance Premi</td>
                            <td>
                                <asp:Label ID="INSPREMILabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSPREMI", "{0:N}") %>' />
                            </td>
                            <td>
                                Insurance On Loan</td>
                            <td>
                                <asp:Label ID="INSONLOANLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSONLOAN", "{0:N}") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Insurance Paid By</td>
                            <td>
                                (<asp:Label ID="INSPAIDBYLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSPAIDBY") %>' />
                                )
                                <asp:Label ID="INSPAIDBYNAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSPAIDBYNAME") %>' />
                            </td>
                            <td>
                                Value |Base On</td>
                            <td>
                                (<asp:Label ID="INSVALBASEONLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSVALBASEON") %>' />
                                )
                                <asp:Label ID="INSVALBASEONNAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSVALBASEONNAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Object Value(OTR)</td>
                            <td>
                                <asp:Label ID="Label43" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("OBJECTVALUE", "{0:N}") %>'></asp:Label>
                            </td>
                            <td>
                                Principal</td>
                            <td>
                                <asp:Label ID="Label44" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("PRINCIPALTOTAL", "{0:N}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="HeaderStyle" colspan="2">
                                Insurance Company and Branch</td>
                            <td class="ShowDetail" colspan="2">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                Insurance Company</td>
                            <td>
                                (<asp:Label ID="INSURANCECODELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSURANCECODE") %>' />
                                )
                                <asp:Label ID="INSURANCENAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSURANCENAME") %>' />
                            </td>
                            <td>
                                Insurance Branch</td>
                            <td>
                                (<asp:Label ID="INSBRANCHCODELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSBRANCHCODE") %>' />
                                )
                                <asp:Label ID="INSBRANCHNAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSBRANCHNAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Address</td>
                            <td colspan="3">
                                <asp:Label ID="INSBRANCHADDRESSLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSBRANCHADDRESS") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                City</td>
                            <td>
                                <asp:Label ID="Label42" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("CITYNAME") %>'></asp:Label>
                            </td>
                            <td>
                                Zip</td>
                            <td>
                                <asp:Label ID="INSBRANCHZIPLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("INSBRANCHZIP") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="sdsInsuranceInfo" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                SelectCommand="SELECT ACCOUNT.INSPREMI, ACCOUNT.INSONLOAN, ACCOUNT.INSPAIDBY, dbo.f_getParamGlobalName('INSPAIDBY', ACCOUNT.INSPAIDBY) AS INSPAIDBYNAME, ACCOUNT.INSVALBASEON, dbo.f_getParamGlobalName('INSVALBASEON', ACCOUNT.INSVALBASEON) AS INSVALBASEONNAME, INSBRANCH.INSBRANCHCODE, INSBRANCH.INSBRANCHNAME, INSCOMPANY.INSURANCECODE, INSCOMPANY.INSURANCENAME, INSBRANCH.INSBRANCHADDRESS, INSBRANCH.INSBRANCHZIP, CITY.CITYNAME, ACCOUNT.OBJECTVALUE, ACCOUNT.PRINCIPALTOTAL FROM ACCOUNT WITH (NOLOCK) INNER JOIN INSURANCE WITH (NOLOCK) ON ACCOUNT.LOCID = INSURANCE.LOCID AND ACCOUNT.ACCID = INSURANCE.ACCID INNER JOIN INSBRANCH ON INSURANCE.INSBRANCHID = INSBRANCH.INSBRANCHID INNER JOIN INSCOMPANY ON INSBRANCH.INSCOMPANYID = INSCOMPANY.INSCOMPANYID LEFT OUTER JOIN CITY ON INSBRANCH.CITYID = CITY.CITYID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID) AND (INSURANCE.Deletests = 0)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidLOCID" Name="lOCID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="hidACCID" Name="ACCID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvInsurance" runat="server" AutoGenerateColumns="False" 
                Caption="DETAIL INSURANCE DATA" DataSourceID="sdsInsurance" ShowFooter="True" 
                Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="YR">
                        <ItemTemplate>
                            <asp:Label ID="lblNo" runat="server" Text="<%#Container.DataItemIndex + 1%>"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ins.&lt;br&gt;Type">
                        <ItemTemplate>
                            <asp:Label ID="ddlInsuranceType" runat="server" 
                                Text='<%# eval("INSURANCETYPENAME") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cust&lt;br&gt;Rate&lt;br&gt;(%)">
                        <ItemTemplate>
                            <asp:Label ID="txtBaseRateCust" runat="server" style="text-align: right" 
                                Text='<%# eval("BASERATECUST") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="txtBaseRateCustTotal" runat="server" style="text-align: right"></asp:Label>
                        </FooterTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RSCC&lt;br&gt;(a)">
                        <ItemTemplate>
                            <asp:Label ID="ddlRSCC" runat="server" 
                                Text='<%# Eval("BASEPREMIRSCCCUST", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RSMB&lt;BR&gt;(b)">
                        <ItemTemplate>
                            <asp:Label ID="ddlRSMB" runat="server" 
                                Text='<%# Eval("BASEPREMIRSMBCUST", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Other&lt;br&gt;(c)">
                        <ItemTemplate>
                            <asp:Label ID="ddlOther" runat="server" 
                                Text='<%# Eval("BASEPREMIOTHERCUST", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TJH&lt;br&gt;(d)">
                        <ItemTemplate>
                            <asp:Label ID="ddlTJH" runat="server" text='<%# Eval("INSTJHCUST", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Payment&lt;br&gt;Type">
                        <ItemTemplate>
                            <asp:Label ID="ddlPaymentType" runat="server" 
                                Text='<%# Eval("INSPAYMENTTYPENAME") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Premi">
                        <ItemTemplate>
                            <asp:Label ID="txtPremi" runat="server" Style="text-align: right" 
                                Text='<%# Eval("BASEPREMICUST", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Propotional&lt;br&gt;Premi&lt;br&gt;(e)">
                        <ItemTemplate>
                            <asp:Label ID="txtPremiProp" runat="server" Style="text-align: right" 
                                Text='<%# Eval("TOTALPREMI", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Premi&lt;br&gt;(a+b+c+d+e)">
                        <ItemTemplate>
                            <asp:Label ID="txtPremiTotal" runat="server" Style="text-align: right" 
                                Text='<%# Eval("TOTALPREMI", "{0:N}") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="txtPremiGrandTotal" runat="server" style="text-align: right" 
                                Text='<%# eval("PREMITOTAL", "{0:N2}") %>'></asp:Label>
                        </FooterTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsInsurance" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                
                SelectCommand="SELECT '(' + CAST(INSURANCEDTL.INSURANCETYPE AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('INSURANCETYPE', INSURANCEDTL.INSURANCETYPE) AS INSURANCETYPENAME, '(' + CAST(INSURANCEDTL.INSPAYMENTTYPE AS VARCHAR(20)) + ')' + dbo.f_getParamGlobalName('INSPAYMENTTYPE', INSURANCEDTL.INSPAYMENTTYPE) AS INSPAYMENTTYPENAME, INSURANCEDTL.BASEPREMICUSTPROP, INSURANCEDTL.BASEPREMICUST, INSURANCEDTL.BASEPREMIDEALERPROP, INSURANCEDTL.BASEPREMIRSCCCUST, INSURANCEDTL.BASEPREMIRSMBCUST, INSURANCEDTL.BASEPREMIOTHERCUST, INSURANCEDTL.INSTJHCUST, INSURANCEDTL.BASEPREMICUSTPROP + INSURANCEDTL.BASEPREMIRSCCCUST + INSURANCEDTL.BASEPREMIRSMBCUST + INSURANCEDTL.BASEPREMIOTHERCUST + INSURANCEDTL.INSTJHCUST AS TOTALPREMI, INSURANCEDTL.BASERATECUST FROM INSURANCEDTL WITH (NOLOCK) RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) LEFT OUTER JOIN INSURANCE WITH (NOLOCK) ON ACCOUNT.LOCID = INSURANCE.LOCID AND ACCOUNT.ACCID = INSURANCE.ACCID ON INSURANCEDTL.LOCIDINS = INSURANCE.LOCIDINS AND INSURANCEDTL.POLISID = INSURANCE.POLISID WHERE (INSURANCEDTL.Deletests = 0) AND (INSURANCE.Deletests = 0) AND (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID) ORDER BY INSURANCEDTL.POLISDTLID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidLOCID" Name="LOCID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="hidACCID" Name="ACCID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:HiddenField ID="hidLOCID" runat="server" />
        <asp:HiddenField ID="hidACCID" runat="server" />
    </asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvInsurance.ClientID%>");
</script>
</asp:Content>

