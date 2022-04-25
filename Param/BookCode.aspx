<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BookCode.aspx.vb" Inherits="Param_BC" title="Book Code" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="FooterStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BCName">Name</asp:ListItem>
        <asp:ListItem Value="BCCode">Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
            </tr>
            <tr>
                <td class="RowStyle">
                    Book Type</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlBTSearch" runat="server" AutoPostBack="True" DataSourceID="sdsBookTypeSearch"
                        DataTextField="BOOKTYPE" DataValueField="BTID">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsBookTypeSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        SelectCommand="SELECT NULL AS BTID, NULL AS BTCODE, '[DISPLAY ALL]' AS BOOKTYPE UNION ALL SELECT BTID, BTCODE, + BTCODE + ' - ' + BTNAME AS BOOKTYPE FROM BOOKTYPE ORDER BY BTCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Used by General Txn</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlUsedTxnSearch" runat="server" 
                        DataSourceID="sdsUsedTxnSearch" DataTextField="NAME" DataValueField="CODE" 
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsUsedTxnSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'YESNO')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Journal Type</td>
                <td class="FooterStyle">
                    <asp:DropDownList ID="ddlJournalTypeSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsJournalTypeSearch" DataTextField="JOURNALTYPE" 
                        DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsJournalTypeSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS JOURNALTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS JOURNALTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JOURNALTYPE')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="RowStyle">
                    Txn Type</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlTxnTypeSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsTxnTypeSearch" DataTextField="TXNTYPE" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTxnTypeSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS TXNTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS TXNTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JOURNALTXNTYPE')">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /><br />
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="BCID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Book Code List" RowHeaderColumn="BCID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="Journal&lt;br&gt;Set" SortExpression="BCID">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkJnl" runat="server" NavigateUrl='<%# "BookJournal.aspx?BCID=" & eval("BCID") & "&USEDTXN=" & eval("USEDTXN") %>' ImageUrl="~/images/detail.gif" ToolTip="Edit Book Journal">SET</asp:HyperLink>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="BCID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="BCID" />
                <asp:BoundField DataField="BCCODE" HeaderText="Code" SortExpression="BCCODE" />
                <asp:BoundField DataField="BCNAME" HeaderText="Name" SortExpression="BCNAME" />
                <asp:BoundField DataField="BOOKTYPE" HeaderText="Book&lt;br&gt;Type" HtmlEncode="False"
                    ReadOnly="True" SortExpression="BOOKTYPE" />
                <asp:BoundField DataField="JOURNALTYPE" HeaderText="Journal&lt;br&gt;Type" HtmlEncode="False"
                    ReadOnly="True" SortExpression="JOURNALTYPE" />
                <asp:BoundField DataField="TXNTYPE" HeaderText="Txn&lt;br&gt;Type" HtmlEncode="False"
                    ReadOnly="True" SortExpression="TXNTYPE" />
                <asp:BoundField DataField="USEDTXNAME" HeaderText="General&lt;br&gt;Txn?" 
                    HtmlEncode="False" SortExpression="USEDTXNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT BOOKCODE.BTID, BOOKCODE.BCCODE, BOOKCODE.BCNAME, '(' + BOOKTYPE.BTCODE + ') ' + BOOKTYPE.BTNAME AS BOOKTYPE, '(' + PARAMGLOBAL.CODE + ') ' + PARAMGLOBAL.NAME AS JOURNALTYPE, '(' + PARAMGLOBAL_1.CODE + ') ' + PARAMGLOBAL_1.NAME AS TXNTYPE, BOOKCODE.BCID, dbo.f_getParamGlobalName('YESNO', CAST(BOOKCODE.USEDTXN AS INT)) AS USEDTXNAME, BOOKCODE.USEDTXN FROM BOOKTYPE WITH (NOLOCK) INNER JOIN BOOKCODE WITH (NOLOCK) ON BOOKTYPE.BTID = BOOKCODE.BTID INNER JOIN PARAMGLOBAL ON BOOKCODE.JOURNALTYPE = PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE = 'JOURNALTYPE' INNER JOIN PARAMGLOBAL AS PARAMGLOBAL_1 ON BOOKCODE.TXNTYPE = PARAMGLOBAL_1.CODE AND PARAMGLOBAL_1.TYPE = 'JOURNALTXNTYPE' WHERE (BOOKTYPE.BTID IS NOT NULL)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:FormView ID="fvData" runat="server" DataKeyNames="BCID" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                    <hr />
                        </td>
                </tr>
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblBCID" runat="server" Font-Bold="True" Text='<%# Eval("BCID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Book Type</td>
                    <td>
                        <asp:DropDownList ID="ddlBookType" runat="server" DataSourceID="sdsBookType" DataTextField="BOOKTYPE"
                        DataValueField="BTID" SelectedValue='<%# Bind("BTID") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqBookType" runat="server" ControlToValidate="ddlBookType"
                            Display="None" ErrorMessage="Txn Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBookType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Code &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtBCCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("BCCODE") %>'
                            Width="80px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtBCCode" Display="None" ErrorMessage="Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtBCName" runat="server" CssClass="required" MaxLength="80" Text='<%# Bind("BCNAME") %>'
                            Width="272px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtBCName" Display="None" ErrorMessage="Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Journal Type</td>
                    <td>
                        <asp:DropDownList ID="ddlJournalType" runat="server" DataSourceID="sdsJournalType"
                        DataTextField="JOURNALTYPE" DataValueField="CODE" SelectedValue='<%# Bind("JOURNALTYPE") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqJournalType" runat="server"
                            ControlToValidate="ddlJournalType" CssClass="required" Display="None" ErrorMessage="Journal Type must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEJournalType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJournalType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Txn Type</td>
                    <td>
                        <asp:DropDownList ID="ddlTxnType" runat="server" DataSourceID="sdsTxnType" DataTextField="TXNTYPE"
                        DataValueField="CODE" SelectedValue='<%# Bind("TXNTYPE") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqTxnType" runat="server" ControlToValidate="ddlTxnType"
                            Display="None" ErrorMessage="Txn Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCETxnType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTxnType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Used by General Txn</td>
                    <td>
                        <asp:DropDownList ID="ddlUsedTxn" runat="server" CssClass="required" 
                            DataSourceID="sdsUsedTxn" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("USEDTXN") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqUsedTxn" runat="server" 
                            ControlToValidate="ddlUsedTxn" Display="None" 
                            ErrorMessage="Txn Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqUsedTxn_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUsedTxn">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 19px">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
            <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate><table cellpadding=0 cellspacing=0 width="100%">
            <tr>
                <td colspan="2">
                    <hr />
                    </td>
            </tr>
            <tr>
                <td>
                    Book Type</td>
                <td>
                    <asp:DropDownList ID="ddlBookType" runat="server" DataSourceID="sdsBookType" DataTextField="BOOKTYPE"
                        DataValueField="BTID" SelectedValue='<%# Bind("BTID") %>' CssClass="required">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqBookType" runat="server" ControlToValidate="ddlBookType"
                        Display="None" ErrorMessage="Txn Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBookType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBookType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td >
                    Code &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtBCCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("BCCODE") %>'
                        Width="80px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                            ControlToValidate="txtBCCode" Display="None" ErrorMessage="Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td >
                    Name</td>
                <td>
                    <asp:TextBox ID="txtBCName" runat="server" CssClass="required" MaxLength="80" Text='<%# Bind("BCNAME") %>'
                        Width="272px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                            ControlToValidate="txtBCName" Display="None" ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Journal Type</td>
                <td>
                    <asp:DropDownList ID="ddlJournalType" runat="server" DataSourceID="sdsJournalType"
                        DataTextField="JOURNALTYPE" DataValueField="CODE" SelectedValue='<%# Bind("JOURNALTYPE") %>' CssClass="required">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqJournalType" runat="server"
                        ControlToValidate="ddlJournalType" CssClass="required" Display="None" ErrorMessage="Journal Type must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEJournalType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJournalType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Txn Type</td>
                <td>
                    <asp:DropDownList ID="ddlTxnType" runat="server" DataSourceID="sdsTxnType" DataTextField="TXNTYPE"
                        DataValueField="CODE" SelectedValue='<%# Bind("TXNTYPE") %>' CssClass="required">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqTxnType" runat="server" ControlToValidate="ddlTxnType"
                        Display="None" ErrorMessage="Txn Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCETxnType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTxnType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Used by General Txn</td>
                <td>
                    <asp:DropDownList ID="ddlUsedTxn" runat="server" CssClass="required" 
                        DataSourceID="sdsUsedTxn" DataTextField="NAME" DataValueField="CODE" 
                        SelectedValue='<%# Bind("USEDTXN") %>'>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqUsedTxn" runat="server" 
                        ControlToValidate="ddlUsedTxn" Display="None" 
                        ErrorMessage="Txn Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqUsedTxn_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUsedTxn">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 19px">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2" class="FooterStyle">
                    <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                    &nbsp;<uc3:BtnCancel ID="BtnCancel2" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                    </td>
            </tr>
        </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <br />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsBookType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        SelectCommand="SELECT NULL AS BTID, NULL AS BTCODE, '[CHOOSE BOOK TYPE]' AS BOOKTYPE UNION ALL SELECT BTID, BTCODE, + BTCODE + '- ' + BTNAME AS BOOKTYPE FROM BOOKTYPE WITH (NOLOCK) ORDER BY BTCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BCID, BTID, BCCODE, BCNAME, JOURNALTYPE, TXNTYPE, CAST(USEDTXN AS tinyint) AS USEDTXN FROM BOOKCODE WHERE (BCID = @BCID)" 
        DeleteCommand="DELETE BOOKCODE WHERE BCID=@BCID" UpdateCommand="BookCodeUpdate" 
        InsertCommand="BookCodeAdd" InsertCommandType="StoredProcedure" 
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BCID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="BCID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="gvData" Name="BCID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter Name="BTID" Type="Int32" />
            <asp:Parameter Name="BCCode" Type="String" />
            <asp:Parameter Name="BCName" Type="String" />
            <asp:Parameter Name="JOURNALTYPE" Type="Int32" />
            <asp:Parameter Name="TXNTYPE" Type="Int32" />
            <asp:Parameter Name="USEDTXN" Type="Byte" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="BTID" Type="Int32" />
            <asp:Parameter Name="BCCode" Type="String" />
            <asp:Parameter Name="BCName" Type="String" />
            <asp:Parameter Name="JOURNALTYPE" Type="Int32" />
            <asp:Parameter Name="TXNTYPE" Type="Int32" />
            <asp:Parameter Name="USEDTXN" Type="Byte" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsJournalType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[CHOOSE TYPE]' AS JOURNALTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS JOURNALTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JOURNALTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUsedTxn" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS CODE, '[SELECT]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'YESNO')">
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTxnType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[CHOOSE TXN TYPE]' AS TXNTYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS TXNTYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JOURNALTXNTYPE')">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

