<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BookType.aspx.vb" Inherits="Param_BT" title="Book Type" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>

<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BTName">Name</asp:ListItem>
        <asp:ListItem Value="BTCode">Code</asp:ListItem>
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
            AutoGenerateColumns="False" DataKeyNames="BTID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Book Type List" RowHeaderColumn="BTID">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/images/edit.gif" >
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="BTID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="BTID" />
                <asp:BoundField DataField="BTCODE" HeaderText="Code" HtmlEncode="False"
                    SortExpression="BTCODE" />
                <asp:BoundField DataField="BTNAME" HeaderText="Name" HtmlEncode="False"
                    SortExpression="BTNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT BTID, BTCODE, BTNAME FROM BOOKTYPE WHERE (BTID &lt;&gt; 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="Error" Visible="False"></asp:Label>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

    <asp:FormView ID="fvData" runat="server" DataKeyNames="BTID" DataSourceID="sdsForm"
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
                        <asp:Label ID="lblBTID" runat="server" Font-Bold="True" Text='<%# Eval("BTID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        Code &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtBTCode" runat="server" Text='<%# Bind("BTCODE") %>' MaxLength=10 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtBTCode" Display="None" ErrorMessage="Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtBTName" runat="server" Text='<%# Bind("BTNAME") %>' MaxLength=80 Width="272px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtBTName" Display="None" ErrorMessage="Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
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
                    <asp:TextBox ID="txtBTCode" runat="server" CssClass="required" MaxLength="10" Text='<%# Bind("BTCODE") %>'
                        Width="80px"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode" runat="server"
                            ControlToValidate="txtBTCode" Display="None" ErrorMessage="Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td >
                    Name</td>
                <td>
                    <asp:TextBox ID="txtBTName" runat="server" CssClass="required" MaxLength="80" Text='<%# Bind("BTNAME") %>'
                        Width="272px"></asp:TextBox><asp:RequiredFieldValidator ID="reqName" runat="server"
                            ControlToValidate="txtBTName" Display="None" ErrorMessage="Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
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
        SelectCommand="SELECT BTID, BTCODE, BTNAME FROM BOOKTYPE WHERE (BTID = @BTID)" DeleteCommand="DELETE BOOKTYPE WHERE BTID=@BTID" UpdateCommand="BookTypeUpdate" InsertCommand="BookTypeAdd" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BTID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="BTID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="BTID" Type="Int32" />
            <asp:Parameter Name="BTCode" Type="String" />
            <asp:Parameter Name="BTName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="BTCode" Type="String" />
            <asp:Parameter Name="BTName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>

