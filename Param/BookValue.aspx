<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BookValue.aspx.vb" Inherits="Param_BV" title="Books Values" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>

<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BVName">Value Name</asp:ListItem>
        <asp:ListItem Value="BVValue">Value(Formula)</asp:ListItem>
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
            AutoGenerateColumns="False" DataKeyNames="BVID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Book Values List" RowHeaderColumn="BVID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="BVID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="BVID" />
                <asp:BoundField DataField="BVNAME" HeaderText="Value&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="BVNAME" />
                <asp:BoundField DataField="BVVALUE" HeaderText="Value&lt;br&gt;(Formula)" HtmlEncode="False"
                    SortExpression="BVVALUE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT BVID, BVNAME, BVVALUE FROM BOOKVALUES WHERE (BVVALUE IS NOT NULL)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="Error" Visible="False"></asp:Label>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

    <asp:FormView ID="fvData" runat="server" DataKeyNames="BVID" DataSourceID="sdsForm"
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
                        <asp:Label ID="lblValueID" runat="server" Font-Bold="True" Text='<%# Eval("BVID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        Value Name</td>
                    <td>
                        <asp:TextBox ID="txtValueName" runat="server" Text='<%# Bind("BVNAME") %>' MaxLength=50 Width="248px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqValueName" runat="server" ControlToValidate="txtValueName" Display="None" ErrorMessage="Value Name must be entry...!" SetFocusOnError="True" Text='<%# Eval("BVNAME") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEValueName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqValueName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Value(Formula)</td>
                    <td>
                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("BVVALUE") %>' MaxLength=500 Width="544px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqValue" runat="server" ControlToValidate="txtValue" Display="None" ErrorMessage="Value(Formula) must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEValue" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqValue">
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
                    Value Name</td>
                <td>
                    <asp:TextBox ID="txtValueName" runat="server" CssClass="required" MaxLength="50"
                        Text='<%# Bind("BVNAME") %>' Width="248px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqValueName" runat="server" ControlToValidate="txtValueName" Display="None"
                            ErrorMessage="Value Name must be entry...!" SetFocusOnError="True" Text='<%# Eval("BVNAME") %>'></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEValueName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqValueName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td >
                    Value(Formula)</td>
                <td>
                    <asp:TextBox ID="txtValue" runat="server" CssClass="required" MaxLength="500" Text='<%# Bind("BVVALUE") %>'
                        Width="544px"></asp:TextBox><asp:RequiredFieldValidator ID="reqValue" runat="server"
                            ControlToValidate="txtValue" Display="None" ErrorMessage="Value(Formula) must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEValue" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqValue">
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
        SelectCommand="SELECT BVID, BVNAME, BVVALUE FROM BOOKVALUES WHERE (BVID = @BVID)" DeleteCommand="DELETE BOOKVALUES WHERE BVID=@BVID" UpdateCommand="UPDATE BOOKVALUES SET BVNAME = @BVNAME, BVVALUE = @BVVALUE, LASTUSERID = @USERID, LASTUPDATE = GETDATE() WHERE (BVID = @BVID)" InsertCommand="BookValuesAdd" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="BVID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="BVID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="BVNAME" />
            <asp:Parameter Name="BVVALUE" />
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="BVID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="BVName" Type="String" />
            <asp:Parameter Name="BVValue" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>

