<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AO.aspx.vb" Inherits="Param_AO" title="Account Officer" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6"  %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
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
                <td style="width: 144px" class="RowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="AO.AOName">AO Name</asp:ListItem>
        <asp:ListItem Value="AO.AOCode">AO Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="RowStyle" colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 144px">
                    Area</td>
                <td style="width: 216px">
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA" LoadingText="[Loading Area...]"
                        PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH" LoadingText="[Loading Branch...]"
                        ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" />
    </asp:Panel>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="AOID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Account Officer List" RowHeaderColumn="AOID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" 
                    ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>
                <asp:BoundField DataField="AOID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="AOID" />
                <asp:BoundField DataField="AOCODE" HeaderText="Code" SortExpression="AOCODE" />
                <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                    SortExpression="BRANCH" />
                <asp:BoundField DataField="AONAME" HeaderText="Name" SortExpression="AONAME" />
                <asp:BoundField DataField="AOADDRESS" HeaderText="Address" 
                    SortExpression="AOADDRESS" />
                <asp:BoundField DataField="AOCITY" HeaderText="City" SortExpression="AOCITY" />
                <asp:BoundField DataField="PHONE" HeaderText="Phone&lt;br&gt;No." HtmlEncode="False"
                    ReadOnly="True" SortExpression="PHONE" />
                <asp:BoundField DataField="AOMOBILE" HeaderText="Mobile&lt;br&gt;No." HtmlEncode="False"
                    SortExpression="AOMOBILE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT TOP (700) AO.AOID, AO.AOCODE, AO.AONAME, AO.AOADDRESS, AO.AOCITY, '(' + AO.AOPHONEAREA + ') ' + AO.AOPHONENO AS PHONE, AO.AOMOBILE, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH FROM AREA WITH (nolock) INNER JOIN BRANCH WITH (nolock) ON AREA.AREAID = BRANCH.AREAID RIGHT OUTER JOIN AO WITH (nolock) ON BRANCH.BRANCHID = AO.BRANCHID WHERE (AO.DELETESTS = 0)"></asp:SqlDataSource>
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
    <asp:FormView ID="fvData" runat="server" DataKeyNames="AOID" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    AO ID</td>
                <td>
                    <asp:Label ID="lblOAID" runat="server" Font-Bold="True" Text='<%# Eval("AOID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    Code</td>
                <td>
                    <asp:TextBox ID="txtAOCode" runat="server" MaxLength="15" Text='<%# Bind("AOCODE") %>'
                        Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                            runat="server" ControlToValidate="txtAOCode" Display="None" ErrorMessage="Account Officer Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Name</td>
                <td>
                    <asp:TextBox ID="txtAOName" runat="server" MaxLength="60" Text='<%# Bind("AONAME") %>'
                        Width="280px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                            runat="server" ControlToValidate="txtAOName" Display="None" ErrorMessage="Account Officer Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td style="height: 22px">
                    Branch</td>
                <td style="height: 22px">
                    <asp:DropDownList ID="ddlBranchID" runat="server" DataSourceID="sdsBranch" DataTextField="BRANCH"
                            DataValueField="BRANCHID" SelectedValue='<%# Bind("BRANCHID") %>' AppendDataBoundItems="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Address</td>
                <td>
                    <asp:TextBox ID="txtAOAddress" runat="server" MaxLength="100" Text='<%# Bind("AOADDRESS") %>'
                        Width="440px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    City</td>
                <td>
                    <asp:TextBox ID="txtAOCity" runat="server" MaxLength="30" Text='<%# Bind("AOCITY") %>'
                        Width="232px"></asp:TextBox>
                    Zip Code :
                    <asp:TextBox ID="txtAOZipCode" runat="server" MaxLength="10" Text='<%# Bind("AOZIPCODE") %>'
                        Width="72px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Phone</td>
                <td>
                    <asp:TextBox ID="txtAOPhoneArea" runat="server" MaxLength="7" Text='<%# Bind("AOPHONEAREA") %>'
                        Width="56px"></asp:TextBox>
                    <asp:TextBox ID="txtAOPhone" runat="server" MaxLength="15" Text='<%# Bind("AOPHONENO") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Mobile No.</td>
                <td>
                    <asp:TextBox ID="txtAOMobile" runat="server" MaxLength="20" Text='<%# Bind("AOMOBILE") %>'></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Email</td>
                <td>
                    <asp:TextBox ID="txtAOEmail" runat="server" MaxLength="40" Text='<%# Bind("AOEMAIL") %>'
                        Width="304px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                    <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                    <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                </td>
            </tr>
        </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Code</td>
                    <td>
                        <asp:TextBox ID="txtAOCode" runat="server" MaxLength="15" Text='<%# Bind("AOCODE") %>'
                            Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqCode"
                                runat="server" ControlToValidate="txtAOCode" Display="None" ErrorMessage="Account Officer Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtAOName" runat="server" MaxLength="60" Text='<%# Bind("AONAME") %>'
                            Width="280px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqName"
                                runat="server" ControlToValidate="txtAOName" Display="None" ErrorMessage="Account Officer Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td style="height: 22px">
                        Branch</td>
                    <td style="height: 22px">
                        <asp:DropDownList ID="ddlBranchID" runat="server" DataSourceID="sdsBranch" DataTextField="BRANCH"
                            DataValueField="BRANCHID" SelectedValue='<%# Bind("BRANCHID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td>
                        <asp:TextBox ID="txtAOAddress" runat="server" MaxLength="100" Text='<%# Bind("AOADDRESS") %>'
                            Width="440px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:TextBox ID="txtAOCity" runat="server" MaxLength="30" Text='<%# Bind("AOCITY") %>'
                            Width="232px"></asp:TextBox>
                        Zip Code :
                        <asp:TextBox ID="txtAOZipCode" runat="server" MaxLength="10" Text='<%# Bind("AOZIPCODE") %>'
                            Width="72px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Phone</td>
                    <td>
                        <asp:TextBox ID="txtAOPhoneArea" runat="server" MaxLength="7" Text='<%# Bind("AOPHONEAREA") %>'
                            Width="56px"></asp:TextBox>
                        <asp:TextBox ID="txtAOPhone" runat="server" MaxLength="15" Text='<%# Bind("AOPHONENO") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Mobile No.</td>
                    <td>
                        <asp:TextBox ID="txtAOMobile" runat="server" MaxLength="20" Text='<%# Bind("AOMOBILE") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Email</td>
                    <td>
                        <asp:TextBox ID="txtAOEmail" runat="server" MaxLength="40" Text='<%# Bind("AOEMAIL") %>'
                            Width="304px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT AOID, (SELECT AO.BRANCHID FROM BRANCH WHERE (BRANCHID = AO.BRANCHID) AND (DELETESTS = 0)) AS BRANCHID, AOCODE, AONAME, AOADDRESS, AOCITY, AOZIPCODE, AOPHONEAREA, AOPHONENO, AOMOBILE, AOEMAIL FROM AO WHERE (AOID = @AOID)" DeleteCommand="UPDATE AO SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID&#13;&#10;WHERE AOID=@AOID" UpdateCommand="AOUpdate" InsertCommand="AOAdd" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="AOID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="AOID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="AOID" Type="Int32" />
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:Parameter Name="AOCODE" Type="String" />
            <asp:Parameter Name="AONAME" Type="String" />
            <asp:Parameter Name="AOADDRESS" Type="String" />
            <asp:Parameter Name="AOCITY" Type="String" />
            <asp:Parameter Name="AOZIPCODE" Type="String" />
            <asp:Parameter Name="AOPHONEAREA" Type="String" />
            <asp:Parameter Name="AOPHONENO" Type="String" />
            <asp:Parameter Name="AOMOBILE" Type="String" />
            <asp:Parameter Name="AOEMAIL" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="BRANCHID" Type="Int32" />
            <asp:Parameter Name="AOCODE" Type="String" />
            <asp:Parameter Name="AONAME" Type="String" />
            <asp:Parameter Name="AOADDRESS" Type="String" />
            <asp:Parameter Name="AOCITY" Type="String" />
            <asp:Parameter Name="AOZIPCODE" Type="String" />
            <asp:Parameter Name="AOPHONEAREA" Type="String" />
            <asp:Parameter Name="AOPHONENO" Type="String" />
            <asp:Parameter Name="AOMOBILE" Type="String" />
            <asp:Parameter Name="AOEMAIL" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="AOID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBranch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCH UNION ALL SELECT BRANCHID, '(' + BRANCHCODE + ')' + BRANCHNAME AS BRANCH FROM BRANCH WHERE (DELETESTS = 0)">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
TabToEnter();
FormatTable("<%=gvData.ClientID%>")
</script>
</asp:Content>

