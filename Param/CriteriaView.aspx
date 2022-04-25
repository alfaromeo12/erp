<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CriteriaView.aspx.vb" Inherits="Param_CriteriaShow" title="View Criteria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlCriteria" runat="server" Caption="VALIDATION CRITERIA" DataKeyField="CRID"
        DataSourceID="sdsCriteria" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        ID</td>
                    <td colspan="3">
                        <asp:Label ID="CRIDLabel" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("CRID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Code</td>
                    <td colspan="3">
                        <asp:Label ID="CRCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("CRCODE") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td colspan="3">
                        <asp:Label ID="CRNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("CRNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Validation Scheme</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Interest Scheme</td>
                    <td>
                        (<asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("INTERESTID") %>'></asp:Label>)
                        <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("INTERESTNAME") %>'></asp:Label></td>
                    <td>
                        Description</td>
                    <td>
                        <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("INTDESC") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Tenor Scheme</td>
                    <td>
                        (<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TENORID") %>'></asp:Label>)
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TENORNAME") %>'></asp:Label></td>
                    <td>
                        Description</td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TENORDESC") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        DP Scheme</td>
                    <td>
                        (<asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DPID") %>'></asp:Label>)
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DPVALIDNAME") %>'></asp:Label></td>
                    <td>
                        Description</td>
                    <td>
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DPDESC") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Maximum Loan</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MAXIMUMLOAN", "{0:N}") %>'></asp:Label></td>
                    <td>
                        Allow Used Vehicle</td>
                    <td>
                        <asp:CheckBox ID="cbUsedCar" runat="server" Checked='<%# eval("USEDCAR") %>' CssClass="FooterStyle"
                            Enabled="False" Text="Checked if allow used vehicle(car)." /></td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Installment Deviation</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Installment Deviation</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Min. Dev.</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("MINDEVINSTALLMENT", "{0:N}") %>'></asp:Label></td>
                    <td>
                        Max Dev.</td>
                    <td>
                        &nbsp;<asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MAXDEVINSTALLMENT", "{0:N}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Age Validation</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Marital Status Age Checking</td>
                    <td colspan="3">
                        <asp:CheckBox ID="cbMaritalStatus" runat="server" Checked='<%# Bind("AGECHECK") %>'
                            CssClass="FooterStyle" Enabled="False" Text="if checked  then Age validation for Single Marital Status, if not checked, age validation for all customer" /></td>
                </tr>
                <tr>
                    <td>
                        Min</td>
                    <td>
                        <asp:Label ID="MINAGELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MINAGE", "{0:N2}") %>'></asp:Label>
                        year(s)</td>
                    <td>
                        Max</td>
                    <td>
                        <asp:Label ID="MAXAGELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MAXAGE", "{0:N2}") %>'></asp:Label>
                        year(s)</td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Working Time Validation</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Min</td>
                    <td>
                        <asp:Label ID="MINWORKLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MINWORK", "{0:N2}") %>'></asp:Label>
                        year(s)</td>
                    <td>
                        Max</td>
                    <td>
                        <asp:Label ID="MAXWORKLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MAXWORK", "{0:N2}") %>'></asp:Label>
                        year(s)</td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Employee&nbsp; Validation</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Employe Status</td>
                    <td>
                        (<asp:Label ID="EMPLOYEESTSLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("EMPLOYEESTS") %>'></asp:Label>)
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("EMPLOYEESTSNAME") %>'></asp:Label></td>
                    <td>
                        Contract end</td>
                    <td>
                        <asp:Label ID="MINCONTRACTENDLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MINCONTRACTEND", "{0:N2}") %>'></asp:Label>
                        month(s)</td>
                </tr>
                <tr>
                    <td>
                        Min Income (Salary)</td>
                    <td colspan="3">
                        <asp:Label ID="MININCOMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MININCOME", "{0:N2}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        DSR</td>
                    <td colspan="3">
                        <asp:Label ID="DSRLabel" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("DSR", "{0:N2}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="ShowDetail">
                        Stay Length and Home Status</td>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Min Home Stay Length</td>
                    <td colspan="3">
                        <asp:Label ID="MINStayLengthLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MINSTAYLENGTH") %>'></asp:Label>
                        year(s)</td>
                </tr>
                <tr>
                    <td>
                        Home Status</td>
                    <td colspan="3">
                        <asp:BulletedList ID="BulletedList1" runat="server" DataSourceID="sdsValidHomeSts"
                            DataTextField="HOMESTATUSNAME" DataValueField="HOMESTATUS">
                        </asp:BulletedList>
                        <asp:SqlDataSource ID="sdsValidHomeSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT CRID, HOMESTATUS, dbo.f_getParamGlobalName('HOMESTATUS', HOMESTATUS) AS HOMESTATUSNAME FROM VALIDHOMESTS WHERE (Deletests = 0) AND (CRID = @CRID)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="CRID" QueryStringField="CRID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td colspan="3">
                        <asp:Label ID="DESCRIPTIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("DESCRIPTION") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsCriteria" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT VALIDCRITERIA.CRID, VALIDCRITERIA.CRCODE, VALIDCRITERIA.CRNAME, VALIDCRITERIA.MINAGE, VALIDCRITERIA.MAXAGE, VALIDCRITERIA.MINWORK, VALIDCRITERIA.MAXWORK, VALIDCRITERIA.DSR, VALIDCRITERIA.EMPLOYEESTS, CASE WHEN EMPLOYEESTS = 0 THEN 'ALL STATUS' ELSE (SELECT NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE TYPE = 'EMPLOYEESTATUS' AND CODE = EMPLOYEESTS) END AS EMPLOYEESTSNAME, VALIDCRITERIA.MINCONTRACTEND, VALIDCRITERIA.MININCOME, VALIDCRITERIA.DESCRIPTION, VALIDCRITERIA.AGECHECK, VALIDCRITERIA.MINSTAYLENGTH, VALIDINTEREST.INTERESTID, VALIDINTEREST.INTERESTNAME, VALIDINTEREST.MININTERESTNEW, VALIDINTEREST.MAXINTERESTNEW, VALIDINTEREST.MININTERESTUSED, VALIDINTEREST.MAXINTERESTUSED, VALIDDP.DPID, VALIDDP.DPVALIDNAME, VALIDDP.MINDPNEW, VALIDDP.MINDPUSED, VALIDTENOR.TENORID, VALIDTENOR.TENORNAME, VALIDTENOR.MINTENORNEW, VALIDTENOR.MAXTENORNEW, VALIDTENOR.MINTENORUSED, VALIDTENOR.MAXTENORUSED, VALIDINTEREST.DESCRIPTION AS INTDESC, VALIDDP.DESCRIPTION AS DPDESC, VALIDTENOR.DESCRIPTION AS TENORDESC, VALIDCRITERIA.MAXIMUMLOAN, VALIDCRITERIA.USEDCAR, VALIDCRITERIA.MINDEVINSTALLMENT, VALIDCRITERIA.MAXDEVINSTALLMENT FROM VALIDCRITERIA WITH (NOLOCK) LEFT OUTER JOIN VALIDTENOR WITH (NOLOCK) ON VALIDCRITERIA.TENORID = VALIDTENOR.TENORID LEFT OUTER JOIN VALIDDP WITH (NOLOCK) ON VALIDCRITERIA.DPID = VALIDDP.DPID LEFT OUTER JOIN VALIDINTEREST WITH (NOLOCK) ON VALIDCRITERIA.INTERESTID = VALIDINTEREST.INTERESTID WHERE (VALIDCRITERIA.CRID = @CRID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="CRID" QueryStringField="CRID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btnClose" runat="server" OnClientClick="window.close();return false;"
        Style="cursor: pointer" Text="Close" />
</asp:Content>

