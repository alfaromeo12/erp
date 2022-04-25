<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Bank.aspx.vb" Inherits="Param_Bank" title="Bank" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BankName">Bank Name</asp:ListItem>
        <asp:ListItem Value="BankCode">Bank Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /><br />
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
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="BANKID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Bank List" RowHeaderColumn="BANKID">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/images/edit.gif" >
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="BANKID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="BANKID" />
                <asp:BoundField DataField="BANKCODE" HeaderText="Bank&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="BANKCODE" />
                <asp:BoundField DataField="BANKNAME" HeaderText="Bank&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="BANKNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT BANKID, BANKCODE, BANKNAME FROM BANK WHERE BANKID&lt;&gt;0"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>

    <asp:FormView ID="fvData" runat="server" DataKeyNames="BANKID" DataSourceID="sdsForm"
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
                        <asp:Label ID="lblBankID" runat="server" Font-Bold="True" Text='<%# Eval("BANKID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        Code &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtBankCode" runat="server" Text='<%# Bind("BANKCODE") %>' MaxLength=7 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtBankCode" Display="None" ErrorMessage="Bank Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtBankName" runat="server" Text='<%# Bind("BANKNAME") %>' MaxLength=100 Width="272px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtBankName" Display="None" ErrorMessage="Bank Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;
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
                <td >
                    Code &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtBankCode" runat="server" MaxLength="7" Text='<%# Bind("BANKCODE") %>' Width="72px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                        ID="reqCode" runat="server" ControlToValidate="txtBankCode" Display="None" ErrorMessage="Bank Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td >
                    Name</td>
                <td>
                    <asp:TextBox ID="txtBankName" runat="server" MaxLength="100" Text='<%# Bind("BANKNAME") %>'
                        Width="272px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                            runat="server" ControlToValidate="txtBankName" Display="None" ErrorMessage="Bank Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
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
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT BANKID, BANKCODE, BANKNAME FROM BANK WHERE (BANKID = @BankID)" DeleteCommand="DELETE BANKACCOUNT WHERE BANKID=@BankID&#13;&#10;DELETE BANK WHERE BANKID=@BankID" UpdateCommand="BankUpdate" InsertCommand="BankAdd" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BankID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="BankID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="BANKID" Type="Int32" />
            <asp:Parameter Name="BANKCODE" Type="String" />
            <asp:Parameter Name="BANKNAME" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="BankCode" Type="String" />
            <asp:Parameter Name="BankName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
</script>

</asp:Content>

