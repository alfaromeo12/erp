<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JournalViewByRefNo.aspx.vb" Inherits="Txn_JournalViewByRefNo" title="Journal" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:FormView ID="fvInfoHdr" runat="server" Caption="Journal Info" DataSourceID="sdsInfoHeader"
        Width="100%">
        <EditItemTemplate>
            BCCODE:
            <asp:TextBox ID="BCCODETextBox" runat="server" Text='<%# Bind("BCCODE") %>'>
            </asp:TextBox><br />
            BCNAME:
            <asp:TextBox ID="BCNAMETextBox" runat="server" Text='<%# Bind("BCNAME") %>'>
            </asp:TextBox><br />
            JOURNALDATE:
            <asp:TextBox ID="JOURNALDATETextBox" runat="server" Text='<%# Bind("JOURNALDATE") %>'>
            </asp:TextBox><br />
            REFNO:
            <asp:TextBox ID="REFNOTextBox" runat="server" Text='<%# Bind("REFNO") %>'>
            </asp:TextBox><br />
            JOURNALTYPE:
            <asp:TextBox ID="JOURNALTYPETextBox" runat="server" Text='<%# Bind("JOURNALTYPE") %>'>
            </asp:TextBox><br />
            JOURNALTYPENAME:
            <asp:TextBox ID="JOURNALTYPENAMETextBox" runat="server" Text='<%# Bind("JOURNALTYPENAME") %>'>
            </asp:TextBox><br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton>
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
        </EditItemTemplate>
        <InsertItemTemplate>
            BCCODE:
            <asp:TextBox ID="BCCODETextBox" runat="server" Text='<%# Bind("BCCODE") %>'>
            </asp:TextBox><br />
            BCNAME:
            <asp:TextBox ID="BCNAMETextBox" runat="server" Text='<%# Bind("BCNAME") %>'>
            </asp:TextBox><br />
            JOURNALDATE:
            <asp:TextBox ID="JOURNALDATETextBox" runat="server" Text='<%# Bind("JOURNALDATE") %>'>
            </asp:TextBox><br />
            REFNO:
            <asp:TextBox ID="REFNOTextBox" runat="server" Text='<%# Bind("REFNO") %>'>
            </asp:TextBox><br />
            JOURNALTYPE:
            <asp:TextBox ID="JOURNALTYPETextBox" runat="server" Text='<%# Bind("JOURNALTYPE") %>'>
            </asp:TextBox><br />
            JOURNALTYPENAME:
            <asp:TextBox ID="JOURNALTYPENAMETextBox" runat="server" Text='<%# Bind("JOURNALTYPENAME") %>'>
            </asp:TextBox><br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton>
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
        </InsertItemTemplate>
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Book Code</td>
                    <td class="required">
                        (<asp:Label ID="BCCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Bind("BCCODE") %>'></asp:Label>)
                        <asp:Label ID="BCNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Bind("BCNAME") %>'></asp:Label><asp:LinkButton ID="lbJournalSet" runat="server"
                                CausesValidation="False" Style="background-image: url(../images/detail.gif);
                                background-repeat: no-repeat; background-color: transparent" ToolTip="Detail Journal Setting">___</asp:LinkButton><ajaxToolkit:ModalPopupExtender
                                    ID="ajaxMPEJournalSet" runat="server" CancelControlID="btnCloseJournalSet"
                                    PopupControlID="pnlJournalSet" PopupDragHandleControlID="pnlJournalSet" TargetControlID="lbJournalSet">
                                </ajaxToolkit:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Ref. No</td>
                    <td>
                        <asp:Label ID="REFNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Bind("REFNO") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Journal Type</td>
                    <td>
                        (<asp:Label ID="JOURNALTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Bind("JOURNALTYPE") %>'></asp:Label>)
                        <asp:Label ID="JOURNALTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Bind("JOURNALTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Txn Type</td>
                    <td>
                        (<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TXNTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("TXNTYPENAME") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsInfoHeader" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT TOP (1) BOOKCODE.BCCODE, BOOKCODE.BCNAME, JOURNAL.JOURNALDATE, JOURNAL.REFNO, BOOKCODE.JOURNALTYPE, dbo.f_getParamGlobalName('JOURNALTYPE', BOOKCODE.JOURNALTYPE) AS JOURNALTYPENAME, JOURNAL.REVERSAL, BOOKCODE.TXNTYPE, dbo.f_getParamGlobalName('JOURNALTXNTYPE', BOOKCODE.TXNTYPE) AS TXNTYPENAME FROM JOURNAL WITH (nolock) INNER JOIN BOOKCODE WITH (nolock) ON JOURNAL.BCID = BOOKCODE.BCID WHERE (JOURNAL.REFNO = @REFNO) AND (BOOKCODE.BCCODE = @BCCODE)">
        <SelectParameters>
            <asp:QueryStringParameter Name="REFNO" QueryStringField="RefNo" />
            <asp:QueryStringParameter Name="BCCODE" QueryStringField="BookCode" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvJournal" runat="server" AutoGenerateColumns="False" DataSourceID="sdsJournalDtl" AllowSorting="True" Caption="Journal Detail" Width="100%" ShowFooter="True">
        <Columns>
            <asp:TemplateField HeaderText="No.">
                <ItemTemplate>
                    <asp:Label ID="lblNo" runat="server" 
                        Text="<%#Container.DataItemIndex + 1 %>"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:TemplateField>
            <asp:BoundField DataField="JOURNALDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Journal&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="JOURNALDATE" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="COANO" HeaderText="COA No." SortExpression="COANO" />
            <asp:BoundField DataField="COANAME" HeaderText="COA Name" SortExpression="COANAME" />
            <asp:BoundField DataField="BRANCH" HeaderText="Branch" SortExpression="BRANCH" />
            <asp:BoundField DataField="DRCR" HeaderText="Dr&lt;br&gt;Cr" SortExpression="DRCR" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:BoundField>
            <asp:BoundField DataField="AMOUNTDEBET" DataFormatString="{0:N2}" HeaderText="Debet"
                SortExpression="AMOUNTDEBET">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="AMOUNTCREDIT" DataFormatString="{0:N2}" HeaderText="Credit"
                SortExpression="AMOUNTCREDIT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="ReversalName" HeaderText="Reversal" SortExpression="ReversalName" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsJournalDtl" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT COA.COANO, COA.COANAME, JOURNAL.DRCR, JOURNAL.AMOUNT, CASE WHEN REVERSAL = 1 THEN 'Yes' ELSE 'No' END AS ReversalName, CASE WHEN DRCR = 'D' THEN AMOUNT ELSE 0 END AS AMOUNTDEBET, CASE WHEN DRCR = 'C' THEN AMOUNT ELSE 0 END AS AMOUNTCREDIT, JOURNAL.LOCID, JOURNAL.JOURNALID, '(' + BRANCH.BRANCHCODE + ')' + BRANCH.BRANCHNAME AS BRANCH, JOURNAL.JOURNALDATE, JOURNAL.REVERSAL FROM JOURNAL WITH (nolock) INNER JOIN COA WITH (nolock) ON JOURNAL.COAID = COA.COAID INNER JOIN BOOKCODE WITH (nolock) ON JOURNAL.BCID = BOOKCODE.BCID LEFT OUTER JOIN BRANCH WITH (nolock) ON JOURNAL.BRANCHID = BRANCH.BRANCHID WHERE (JOURNAL.REFNO = @REFNO) AND (BOOKCODE.BCCODE = @BOOKCODE) ORDER BY JOURNAL.REVERSAL, JOURNAL.DRCR DESC">
        <SelectParameters>
            <asp:QueryStringParameter Name="REFNO" QueryStringField="RefNo" />
            <asp:QueryStringParameter Name="BOOKCODE" QueryStringField="BookCode" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Panel ID="pnlClose" runat="server" CssClass="FooterStyle" Width="100%">
        <asp:Button ID="btnClose" runat="server" OnClientClick="return CloseScript();" Style="cursor: pointer;" Text="Close" /></asp:Panel>

    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEClose" runat="server" TargetControlID="pnlClose"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <asp:Panel ID="pnlJournalSet" runat="server" CssClass="ShowDetail">
        <asp:DataList ID="dlJournalSet" runat="server" Caption="Book Code" DataSourceID="sdsJournalBook">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 95px">
                            Book Type</td>
                        <td>
                            (<asp:Label ID="BTCODELabel" runat="server" Font-Bold="True" Font-Italic="False"
                                Font-Underline="True" Text='<%# Eval("BTCODE") %>'></asp:Label>)
                            <asp:Label ID="BTNAMELabel" runat="server" Font-Bold="True" Font-Italic="False" Font-Underline="True"
                                Text='<%# Eval("BTNAME") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 95px">
                            Book Code</td>
                        <td>
                            (<asp:Label ID="BCCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("BCCODE") %>'></asp:Label>)
                            <asp:Label ID="BCNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                                Text='<%# Eval("BCNAME") %>'></asp:Label></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="sdsJournalBook" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            SelectCommand="SELECT BOOKTYPE.BTCODE, BOOKTYPE.BTNAME, BOOKCODE.BCCODE, BOOKCODE.BCNAME FROM BOOKCODE INNER JOIN BOOKTYPE ON BOOKCODE.BTID = BOOKTYPE.BTID WHERE (BOOKCODE.BCCODE = @BookCode)">
            <SelectParameters>
                <asp:QueryStringParameter Name="BookCode" QueryStringField="BookCode" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gvJournalSet" runat="server" AutoGenerateColumns="False" Caption="Journal Setting"
            DataSourceID="sdsJournalSet">
            <Columns>
                <asp:BoundField DataField="COANO" HeaderText="COA&lt;br&gt;No." HtmlEncode="False"
                    SortExpression="COANO" />
                <asp:BoundField DataField="COANAME" HeaderText="COA&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="COANAME" />
                <asp:BoundField DataField="DRCR" HeaderText="Dr&lt;br&gt;Cr" HtmlEncode="False" 
                    SortExpression="DRCR" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="SORT" HeaderText="Sort" SortExpression="SORT" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="BVNAME" HeaderText="Value&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="BVNAME" />
                <asp:BoundField DataField="BVVALUE" HeaderText="Value&lt;br&gt;(Formula)" HtmlEncode="False"
                    SortExpression="BVVALUE" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsJournalSet" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
            SelectCommand="SELECT COA.COANO, COA.COANAME, BOOKJOURNAL.DRCR, BOOKJOURNAL.SORT, BOOKVALUES.BVNAME, BOOKVALUES.BVVALUE FROM BOOKCODE WITH (nolock) INNER JOIN BOOKJOURNAL WITH (nolock) ON BOOKCODE.BCID = BOOKJOURNAL.BCID INNER JOIN BOOKVALUES WITH (nolock) ON BOOKJOURNAL.BVID = BOOKVALUES.BVID INNER JOIN COA WITH (nolock) ON BOOKJOURNAL.COAID = COA.COAID WHERE (BOOKCODE.BCCODE = @BookCode) ORDER BY BOOKJOURNAL.SORT">
            <SelectParameters>
                <asp:QueryStringParameter Name="BookCode" QueryStringField="BookCode" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="btnCloseJournalSet" runat="server" CausesValidation="False" Style="cursor: pointer"
            Text="Close" /></asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvJournal.ClientID%>");
FormatTable("<%=gvJournalSet.ClientID%>");
function CloseScript(){
    window.close();
    return(false);
}
</script>
</asp:Content>

