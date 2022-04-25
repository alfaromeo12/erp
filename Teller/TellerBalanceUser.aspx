<%@ Page Title="Teller Balance User" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="TellerBalanceUser.aspx.vb" Inherits="Teller_TellerBalanceUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="hidTellerID" runat="server" />
    <asp:DataList ID="dlTellerBalance" runat="server" Caption="TELLER BALANCE USER" 
        DataKeyField="UID" DataSourceID="sdsTellerBalance" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" style="width: 100%;">
                <tr>
                    <td class="title" colspan="4" style="text-align: center">
                        USER INFO</td>
                </tr>
                <tr>
                    <td class="ErrHighLight">
                        UID :
                        <asp:Label ID="UIDLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("UID") %>' />
                    </td>
                    <td class="ErrHighLight">
                        &nbsp;</td>
                    <td class="ErrHighLight" colspan="2">
                        Currency : (<asp:Label ID="Label7" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("CURRENCYCODE") %>'></asp:Label>)
                        <asp:Label ID="Label8" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("CURRENCYNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        User ID :<asp:Label ID="UserIDLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("UserID") %>' />
                    </td>
                    <td colspan="2">
                        User Name :
                        <asp:Label ID="UserNameLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("UserName") %>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        User Branch: (<asp:Label ID="Label3" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)
                        <asp:Label ID="Label4" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("COANO") %>'></asp:Label>
                    </td>
                    <td colspan="2">
                        User COA: (<asp:Label ID="Label1" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("COANO") %>'></asp:Label>)
                        <asp:Label ID="Label2" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("COANAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="title" colspan="3" style="text-align: center">
                        BALANCE INFO</td>
                    <td class="FooterStyle">
                        &nbsp;</td>
                </tr>
                <tr title="25%">
                    <td width="25%">
                        &nbsp;</td>
                    <td class="HeaderStyle" style="text-align: right" width="25%">
                        <strong>CASH</strong></td>
                    <td class="HeaderStyle" style="text-align: right">
                        <strong>NON CASH</strong></td>
                    <td width="25%" class="FooterStyle">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="FooterStyle" style="font-weight: bold"    >
                        Begining Balance</td>
                    <td class="RowStyle"   style="text-align: right">
                        <asp:Label ID="CASHBALANCELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CASHBALANCE", "{0:N}") %>' />
                    </td>
                    <td class="RowStyle"   style="text-align: right">
                        <asp:Label ID="NONCASHBALANCELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("NONCASHBALANCE", "{0:N}") %>' />
                    </td>
                    <td class="FooterStyle"    >
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle" style="font-weight: bold">
                        Transaction IN</td>
                    <td class="AlternatingRowStyle" style="text-align: right">
                        <asp:Label ID="CASHINLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CASHIN", "{0:N}") %>' />
                    </td>
                    <td class="AlternatingRowStyle" style="text-align: right">
                        <asp:Label ID="NONCASHINLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("NONCASHIN", "{0:N}") %>' />
                    </td>
                    <td class="FooterStyle">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="FooterStyle" style="font-weight: bold">
                        Transaction Out</td>
                    <td class="RowStyle" style="text-align: right">
                        <asp:Label ID="CASHOUTLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CASHOUT", "{0:N}") %>' />
                    </td>
                    <td class="RowStyle" style="text-align: right">
                        <asp:Label ID="NONCASHOUTLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("NONCASHOUT", "{0:N}") %>' />
                    </td>
                    <td class="FooterStyle">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="FooterStyle" style="font-weight: bold">
                        Ending Balance</td>
                    <td class="AlternatingRowStyle" style="text-align: right">
                        <asp:Label ID="Label5" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("ENDCASH", "{0:N}") %>'></asp:Label>
                    </td>
                    <td class="AlternatingRowStyle" style="text-align: right">
                        <asp:Label ID="Label6" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("ENDNONCASH", "{0:N}") %>'></asp:Label>
                    </td>
                    <td class="FooterStyle">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:Button ID="btnShow" runat="server" CausesValidation="False" 
        onclientclick="return (OpenLog())" Text="Show Teller Balance Log" />
    <asp:SqlDataSource ID="sdsTellerBalance" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT TELLERBALANCE.UID, APPUSER.UserID, APPUSER.UserName, TELLERBALANCE.CASHBALANCE, TELLERBALANCE.NONCASHBALANCE, TELLERBALANCE.CASHIN, TELLERBALANCE.CASHOUT, TELLERBALANCE.NONCASHIN, TELLERBALANCE.NONCASHOUT, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, COA.COANO, COA.COANAME, TELLERBALANCE.CASHBALANCE + (TELLERBALANCE.CASHIN - TELLERBALANCE.CASHOUT) AS ENDCASH, TELLERBALANCE.NONCASHBALANCE + (TELLERBALANCE.NONCASHIN - TELLERBALANCE.NONCASHOUT) AS ENDNONCASH, CURRENCY.CURRENCYCODE, CURRENCY.CURRENCYNAME FROM TELLERBALANCE WITH (NOLOCK) INNER JOIN APPUSER WITH (NOLOCK) ON TELLERBALANCE.UID = APPUSER.UID LEFT OUTER JOIN CURRENCY ON TELLERBALANCE.CURRENCYID = CURRENCY.CURRENCYID LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON APPUSER.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN COA WITH (NOLOCK) ON APPUSER.COAID = COA.COAID WHERE (TELLERBALANCE.UID = @TELLERID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidTellerID" DefaultValue="-99" 
                Name="TELLERID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        function getObjectbyClientID(ClientID) {
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject)
        }
        function GetValueTxtByClientID(ClientID) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                return (oText.value);
        }
        function OpenLog() {
            var TellerID = GetValueTxtByClientID("<%=hidTellerID.ClientID%>");
            WinRef = window.open("TellerBalanceUserLog.aspx?TELLERID=" + TellerID, "TellerLog", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes")
            WinRef.focus();
            return false;

        }
    </script>
</asp:Content>

