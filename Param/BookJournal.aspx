<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BookJournal.aspx.vb" Inherits="Param_BookJournal" title="Set Journal" EnableEventValidation="false" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlBookCode" runat="server" Caption="Book Code Info" DataKeyField="BCID"
        DataSourceID="sdsBookCode" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="width: 97px">
                        Book Type</td>
                    <td>
                        <asp:Label ID="BOOKTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("BOOKTYPE") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 97px">
                        Book Code</td>
                    <td>
                        (<asp:Label ID="BCCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("BCCODE") %>'></asp:Label>)<asp:Label ID="BCNAMELabel" runat="server"
                                Font-Bold="True" Font-Underline="True" Text='<%# Eval("BCNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 97px">
                        Journal&nbsp; Type</td>
                    <td>
                        <asp:Label ID="JOURNALTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JOURNALTYPE") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 97px">
                        Txn Type</td>
                    <td>
                        <asp:Label ID="TXNTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("TXNTYPE") %>'></asp:Label></td>
                </tr>
                
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:Panel ID="pnlBranchCat" runat="server" CssClass="HeaderStyle">
        Finance Category :
        <asp:DropDownList ID="ddlFinanceCategory" runat="server" AutoPostBack="True" 
            DataSourceID="sdsFinanceCategory" DataTextField="FINCATNAME" DataValueField="FINCATID" 
            style="height: 22px" CssClass="required">
        </asp:DropDownList>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsBookCode" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT BOOKCODE.BTID, BOOKCODE.BCCODE, BOOKCODE.BCNAME, '(' + BOOKTYPE.BTCODE + ') ' + BOOKTYPE.BTNAME AS BOOKTYPE, '(' + PARAMGLOBAL.CODE + ') ' + PARAMGLOBAL.NAME AS JOURNALTYPE, '(' + PARAMGLOBAL_1.CODE + ') ' + PARAMGLOBAL_1.NAME AS TXNTYPE, BOOKCODE.BCID FROM BOOKTYPE INNER JOIN BOOKCODE ON BOOKTYPE.BTID = BOOKCODE.BTID INNER JOIN PARAMGLOBAL ON BOOKCODE.JOURNALTYPE = PARAMGLOBAL.CODE AND PARAMGLOBAL.TYPE = 'JOURNALTYPE' INNER JOIN PARAMGLOBAL AS PARAMGLOBAL_1 ON BOOKCODE.TXNTYPE = PARAMGLOBAL_1.CODE AND PARAMGLOBAL_1.TYPE = 'JOURNALTXNTYPE' WHERE (BOOKCODE.BCID = @BCID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="BCID" QueryStringField="BCID" />
        </SelectParameters>
    </asp:SqlDataSource>
 
    <asp:SqlDataSource ID="sdsFinanceCategory" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT FINCATID, '(' + FINCATCODE + ') ' + FINCATNAME AS FINCATNAME FROM FINANCECATEGORY WHERE (Deletests = 0) ORDER BY FINCATCODE">
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidUseGenTran" runat="server" />
    <br />
    <asp:ImageButton ID="imgBtnNew" runat="server" CausesValidation="False" ImageUrl="~/images/add.gif"
        ToolTip="New Journal Setting" />
    <asp:Panel ID="pnlNew" runat="server" CssClass="RowStyle" GroupingText="New Journal Setting"
        Visible="False" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    COA</td>
                <td>
                    <asp:DropDownList ID="ddlCOA" runat="server" CssClass="required" DataSourceID="sdsJournal"
                        DataTextField="COANAME" DataValueField="COAID">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqCOA" runat="server" ControlToValidate="ddlCOA"
                        Display="None" ErrorMessage="COA Must be entry...!" SetFocusOnError="True" ValidationGroup="INSERT"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCECOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOA">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Value</td>
                <td>
                    <asp:DropDownList ID="ddlBookValue" runat="server" CssClass="required" DataSourceID="sdsBookValue"
                        DataTextField="VALUE" DataValueField="VBID">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqVAlue" runat="server" ControlToValidate="ddlBookValue"
                        Display="None" ErrorMessage="Value Must be entry...!" SetFocusOnError="True"
                        ValidationGroup="INSERT"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEValue" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqVAlue">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Dr/Cr</td>
                <td>
                    <asp:DropDownList ID="ddlDrCr" runat="server" CssClass="required">
                        <asp:ListItem Value="D">Debet</asp:ListItem>
                        <asp:ListItem Value="C">Credit</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>
                    Sort</td>
                <td>
                    <asp:TextBox ID="txtSort" runat="server" CssClass="required" MaxLength="3" Width="32px"></asp:TextBox><asp:RequiredFieldValidator
                        ID="reqSort" runat="server" ControlToValidate="txtSort" Display="None" ErrorMessage="Sort Must be entry...!"
                        SetFocusOnError="True" ValidationGroup="INSERT"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCESort" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSort">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
             <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <asp:Button ID="btnInsert" runat="server" Style="cursor: pointer; background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat;  text-align: right;" Text="Insert" ToolTip="Insert New Data"
            ValidationGroup="INSERT" Width="55px" />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" Style="cursor: pointer; background-position: left; background-image: url(../images/cancel.gif); background-repeat: no-repeat;  text-align: right;"
            Text="Cancel" ToolTip="Cancel New Data" Width="55px" /></asp:Panel>
    <asp:GridView ID="gvData" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        Caption="Journal Setting" DataKeyNames="BJID" DataSourceID="sdsBookJournal" Width="100%">
        <Columns>
            <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/images/cancel.gif" DeleteImageUrl="~/images/delete.gif" EditImageUrl="~/images/edit.gif" InsertImageUrl="~/images/add.gif" UpdateImageUrl="~/images/Save.gif">
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:CommandField>
            <asp:CommandField ShowDeleteButton="True" ButtonType="Image" DeleteImageUrl="~/images/delete.gif">
                <ItemStyle Width="20px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="Cr/Dr" SortExpression="CRDRNAME">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlDrCr" runat="server" CssClass="required" SelectedValue='<%# Bind("DRCR") %>'>
                        <asp:ListItem Value="D">Debet</asp:ListItem>
                        <asp:ListItem Value="C">Credit</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CRDRNAME") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Chart Of Account" SortExpression="COA">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlCOA" runat="server" CssClass="required" DataSourceID="sdsJournal"
                        DataTextField="COANAME" DataValueField="COAID" SelectedValue='<%# Bind("COAID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqCOA" runat="server" ControlToValidate="ddlCOA"
                        Display="None" ErrorMessage="COA Must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCECOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOA">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("COA") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Value" SortExpression="BVNAME">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlBookValue" runat="server" CssClass="required" DataSourceID="sdsBookValue"
                        DataTextField="VALUE" DataValueField="VBID" SelectedValue='<%# Bind("BVID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqVAlue" runat="server" ControlToValidate="ddlBookValue"
                        Display="None" ErrorMessage="Value Must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEValue" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqVAlue">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("BVNAME") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sort" SortExpression="SORT">
                <EditItemTemplate>
                    <asp:TextBox ID="txtSort" runat="server" CssClass="required" MaxLength="3" Text='<%# Bind("SORT") %>'
                        Width="32px"></asp:TextBox><asp:RequiredFieldValidator ID="reqSort" runat="server"
                            ControlToValidate="txtSort" Display="None" ErrorMessage="Sort Must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCESort" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqSort">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("SORT") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
                    <asp:SqlDataSource ID="sdsJournal" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
        SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COANAME UNION ALL SELECT COAID, COANO, COANO + '- ' + COANAME AS Expr1 FROM COA WHERE (DELETESTS = 0) ORDER BY COANO">
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsBookValue" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
        SelectCommand="SELECT NULL AS VBID, '[CHOOSE VALUE]' AS VALUE UNION ALL SELECT BVID, BVNAME FROM BOOKVALUES WHERE (1 = 1) ORDER BY VALUE">
                    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBookJournal" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BOOKJOURNAL.BJID, BOOKJOURNAL.BCID, BOOKJOURNAL.COAID, BOOKJOURNAL.BVID, BOOKJOURNAL.DRCR, BOOKJOURNAL.SORT, COA.COANO + '- ' + COA.COANAME AS COA, BOOKVALUES.BVNAME, CASE WHEN DRCR = 'D' THEN 'DEBET' ELSE 'CREDIT' END AS CRDRNAME, BOOKJOURNAL.FINCATID FROM BOOKJOURNAL INNER JOIN COA ON BOOKJOURNAL.COAID = COA.COAID INNER JOIN BOOKVALUES ON BOOKJOURNAL.BVID = BOOKVALUES.BVID WHERE (BOOKJOURNAL.BCID = @BCID) AND (BOOKJOURNAL.FINCATID = @FINCATID) ORDER BY BOOKJOURNAL.SORT" 
        DeleteCommand="DELETE BOOKJOURNAL WHERE BJID=@BJID" 
        
        
        
        
        
        
        UpdateCommand="UPDATE BOOKJOURNAL SET COAID = @COAID, BVID = @BVID, DRCR = @DRCR, SORT = @SORT, LASTUSERID = @USERID, LASTUPDATE = GETDATE() WHERE (BJID = @BJID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="BCID" QueryStringField="BCID" />
            <asp:ControlParameter ControlID="ddlFinanceCategory" Name="FINCATID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="BJID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="COAID" />
            <asp:Parameter Name="BVID" />
            <asp:Parameter Name="DRCR" />
            <asp:Parameter Name="SORT" />
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="BJID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btnBack" runat="server" Style="cursor: pointer; background-position: left; background-image: url(../images/back.gif); background-repeat: no-repeat;  text-align: right;" Text="Back" Width="55px" />
&nbsp;
    <input id="btnCopy" style="background-position: left; background-image: url(../images/expand.jpg); 
        cursor: pointer; background-repeat: no-repeat" type="button" 
        value="Copy Journal" onclick="ParamCopy()"/>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>");

function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function SetValueTxtByClientID(ClientID, sValue){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        oText.value = sValue;
}

function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function ParamCopy(){
   window.open("ParamCopyBookCode.aspx?Action=Copy","CopyParamBookCode", "height=500,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
}
function CopyParam(BCID){
    window.location="BookJournal.aspx?Action=CopyBookCode&BCID=<%=Request.QueryString("BCID")%>&BCIDCopy=" + BCID;
}
</script>

</asp:Content>

