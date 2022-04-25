<%@ Page Title="REPOSES STORE PLACE" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ReposesStorePlace.aspx.vb" Inherits="Param_ReposesStorePlace"  %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="StoreName">Store Name</asp:ListItem>
        <asp:ListItem Value="StoreAddress">Store Address</asp:ListItem>
        <asp:ListItem Value="StoreCity">Store City</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
        <br />
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="STOREID" Caption="Reposses Store Place List" 
            RowHeaderColumn="PRODUCTID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>
                <asp:BoundField DataField="STOREID" HeaderText="ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="STOREID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="STORECODE" HeaderText="Store&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="STORECODE" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="STORENAME" HeaderText="Store&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="STORENAME" />
                <asp:BoundField DataField="STOREADDRESS" HeaderText="Store&lt;br&gt;Address" 
                    HtmlEncode="False" SortExpression="STOREADDRESS" />
                <asp:BoundField DataField="STORECITY" HeaderText="Store&lt;br&gt;City" 
                    HtmlEncode="False" SortExpression="STORECITY" />
                <asp:BoundField DataField="STOREZIP" HeaderText="Store&lt;br&gt;Zip" 
                    HtmlEncode="False" SortExpression="STOREZIP" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch&lt;br&gt;Name" 
                    HtmlEncode="False" SortExpression="BRANCHNAME" />
            </Columns>
            <EmptyDataTemplate>
                &nbsp;<uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT REPOSSESSTOREPLACE.STOREID, REPOSSESSTOREPLACE.STORECODE, REPOSSESSTOREPLACE.STORENAME, REPOSSESSTOREPLACE.STOREADDRESS, REPOSSESSTOREPLACE.STORECITY, REPOSSESSTOREPLACE.STOREZIP, REPOSSESSTOREPLACE.BRANCHID, '( ' + BRANCH.BRANCHCODE + ' ) ' + BRANCH.BRANCHNAME AS BRANCHNAME FROM REPOSSESSTOREPLACE INNER JOIN BRANCH ON REPOSSESSTOREPLACE.BRANCHID = BRANCH.BRANCHID WHERE (REPOSSESSTOREPLACE.DeleteSts = 0) AND (BRANCH.Deletests = 0)"></asp:SqlDataSource>
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
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="STOREID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Store ID</td>
                    <td>
                        <asp:Label ID="lblStoreID" runat="server" Text='<%# Bind("STOREID") %>' 
                            Font-Bold="True" Font-Underline="True"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Store Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Width="56px" MaxLength="10" 
                            Text='<%# Bind("STORECODE") %>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCode" Display="None" 
                            ErrorMessage="[STORE CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Store Name</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="264px" MaxLength="50" 
                            Text='<%# Bind("STORENAME") %>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtName" Display="None" 
                            ErrorMessage="[STORE NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top">
                        Store Address</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" MaxLength="100" 
                            Rows="3" Text='<%# Bind("STOREADDRESS") %>' TextMode="MultiLine" 
                            Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Store City</td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" MaxLength="50" 
                            Text='<%# Bind("STORECITY") %>' Width="264px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Store Zip</td>
                    <td>
                        <asp:TextBox ID="txtZip" runat="server" MaxLength="10" 
                            Text='<%# Bind("STOREZIP") %>' Width="56px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch</td>
                    <td>
                        <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="sdsBranch" 
                            DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                            SelectedValue='<%# Bind("BRANCHID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
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
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Store Code</td>
                    <td>
                        <asp:TextBox ID="txtCodeIns" runat="server" Width="56px" MaxLength="10" 
                            Text='<%# Bind("STORECODE") %>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCodeIns" Display="None" 
                            ErrorMessage="[STORE CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Store Name</td>
                    <td>
                        <asp:TextBox ID="txtNameIns" runat="server" Width="264px" MaxLength="50" 
                            Text='<%# Bind("STORENAME") %>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtNameIns" Display="None" 
                            ErrorMessage="[STORE NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top">
                        Store Address</td>
                    <td>
                        <asp:TextBox ID="txtAddressIns" runat="server" MaxLength="100" 
                            Rows="3" Text='<%# Bind("STOREADDRESS") %>' TextMode="MultiLine" 
                            Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Store City</td>
                    <td>
                        <asp:TextBox ID="txtCityIns" runat="server" MaxLength="50" 
                            Text='<%# Bind("STORECITY") %>' Width="264px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Store Zip</td>
                    <td>
                        <asp:TextBox ID="txtZipIns" runat="server" MaxLength="10" 
                            Text='<%# Bind("STOREZIP") %>' Width="56px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchIns" runat="server" DataSourceID="sdsBranch" 
                            DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                            SelectedValue='<%# Bind("BRANCHID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 19px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert2" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT STOREID, STORECODE, STORENAME, STOREADDRESS, STORECITY, STOREZIP, BRANCHID FROM REPOSSESSTOREPLACE WHERE (STOREID = @STOREID)" 
        DeleteCommand="UPDATE REPOSSESSTOREPLACE SET DeleteSts = 1, LastUserID = @UserID, LastUpdate = GETDATE() WHERE (STOREID = @STOREID)" 
        UpdateCommand="REPOSSESSTOREPLACEUpdate" InsertCommand="REPOSSESSTOREPLACEAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:Parameter Name="STOREID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="STOREID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="STOREID" Type="Int32" />
            <asp:Parameter Name="STORECODE" Type="String" />
            <asp:Parameter Name="STORENAME" Type="String" />
            <asp:Parameter Name="STOREADDRESS" Type="String" />
            <asp:Parameter Name="STORECITY" Type="String" />
            <asp:Parameter Name="STOREZIP" Type="String" />
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="STORECODE" Type="String" />
            <asp:Parameter Name="STORENAME" Type="String" />
            <asp:Parameter Name="STOREADDRESS" Type="String" />
            <asp:Parameter Name="STORECITY" Type="String" />
            <asp:Parameter Name="STOREZIP" Type="String" />
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBranch" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            
        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[SELECT BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' - ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY BRANCHCODE">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
</script>
</asp:Content>

