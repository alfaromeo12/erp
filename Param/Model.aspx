<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Model.aspx.vb" Inherits="Param_Model" title="Untitled Page" %>

<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>

<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlMerk" runat="server" Caption="MERK/BRAND INFO" DataKeyField="MERKID"
        DataSourceID="sdsMerk" Width="100%">
        <ItemTemplate>
            Merk/Brand ID :
            <asp:Label ID="MERKIDLabel" runat="server" Text='<%# Eval("MERKID") %>' Font-Bold="True" Font-Underline="True"></asp:Label><br />
            Merk/Brand Code :
            <asp:Label ID="MERKCODELabel" runat="server" Text='<%# Eval("MERKCODE") %>' Font-Bold="True" Font-Underline="True"></asp:Label><br />
            Merk/Brand Name :
            <asp:Label ID="MERKNAMELabel" runat="server" Text='<%# Eval("MERKNAME") %>' Font-Bold="True" Font-Underline="True"></asp:Label><br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsMerk" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT MERKID, MERKCODE, MERKNAME FROM MERK WHERE (MERKID = @MERKID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="MERKID" QueryStringField="MERKID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" CausesValidation="False" ImageUrl="~/images/add.gif" />
    <asp:GridView ID="gvModel" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="MODEL LIST" DataKeyNames="MODELID" DataSourceID="sdsModel"
        Width="100%" RowHeaderColumn="MODELID">
        <Columns>
            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                    <img src="../Images/car.gif" style="cursor: pointer" alt='TYPE : <%#eval("MODELID")%>' onclick="TypeEdit(<%#eval("MODELID")%>)" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="25px" />
            </asp:TemplateField>
            <asp:BoundField DataField="MODELID" HeaderText="Model&lt;BR&gt;ID" HtmlEncode="False"
                ReadOnly="True" SortExpression="MODELID" />
            <asp:BoundField DataField="MODELCODE" HeaderText="Model&lt;br&gt;Code" HtmlEncode="False"
                SortExpression="MODELCODE" />
            <asp:BoundField DataField="MODELNAME" HeaderText="Model&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="MODELNAME" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsModel" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT (SELECT MERKID FROM MERK WITH (NOLOCK) WHERE (MERKID = MODEL.MERKID) AND (Deletests = 0)) AS MERKID, MODELID, MODELCODE, MODELNAME FROM MODEL WITH (NOLOCK) WHERE (MERKID = @MERKID) AND (Deletests = 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="MERKID" QueryStringField="MERKID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" CssClass="ErrHighLight" Font-Bold="False" Style="text-align: center"
        Visible="False" Width="100%"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvModel.ClientID%>")
</script>

    <asp:FormView ID="fvModel" runat="server" DataKeyNames="MODELID" DataSourceID="sdsModelEdit"
        DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="MODELIDLabel1" runat="server" Text='<%# Eval("MODELID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Merk/Brand</td>
                    <td>
                        <asp:DropDownList ID="ddlMerk" runat="server" CssClass="required" DataSourceID="sdsMerkList"
                            DataTextField="MERKNAME" DataValueField="MERKID" SelectedValue='<%# Bind("MERKID") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqMerk" runat="server" ControlToValidate="ddlMerk"
                            Display="None" ErrorMessage="[MERK/BRAND] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMerk" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMerk">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Model Code</td>
                    <td>
                        <asp:TextBox ID="MODELCODETextBox" runat="server" CssClass="required" MaxLength="15"
                            Text='<%# Bind("MODELCODE") %>' Width="88px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCode" runat="server" ControlToValidate="MODELCODETextBox" Display="None"
                                ErrorMessage="[MODEL CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Model Name</td>
                    <td>
                        <asp:TextBox ID="MODELNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("MODELNAME") %>' Width="400px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqName" runat="server" ControlToValidate="MODELNAMETextBox" Display="None"
                                ErrorMessage="[MODEL NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            </table>
            <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
        </EditItemTemplate>
        <InsertItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    Merk/Brand</td>
                <td>
                    <asp:DropDownList ID="ddlMerk" runat="server" CssClass="required" DataSourceID="sdsMerkList"
                            DataTextField="MERKNAME" DataValueField="MERKID" SelectedValue='<%# Bind("MERKID") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqMerk" runat="server" ControlToValidate="ddlMerk"
                        Display="None" ErrorMessage="[MERK/BRAND] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMerk" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMerk">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Model Code</td>
                <td>
                    <asp:TextBox ID="MODELCODETextBox" runat="server" CssClass="required" MaxLength="15"
                        Text='<%# Bind("MODELCODE") %>' Width="88px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="MODELCODETextBox" Display="None"
                            ErrorMessage="[MODEL CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Model Name</td>
                <td>
                    <asp:TextBox ID="MODELNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                        Text='<%# Bind("MODELNAME") %>' Width="400px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="MODELNAMETextBox" Display="None"
                            ErrorMessage="[MODEL NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
        </table>
            <uc4:BtnInsert ID="BtnInsert1" runat="server" />
            <uc3:BtnCancel ID="BtnCancel2" runat="server" />
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsMerkList" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS MERKID, NULL AS MERKCODE, '[MERK/BRAND]' AS MERKNAME UNION ALL SELECT MERKID, MERKCODE, MERKNAME + ' (' + MERKCODE + ')' AS MERKNAME FROM MERK WHERE (Deletests = 0) ORDER BY MERKNAME">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsModelEdit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        DeleteCommand="UPDATE MODEL SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE MODELID=@MODELID"
        InsertCommand="MODELAdd" InsertCommandType="StoredProcedure" SelectCommand="SELECT (SELECT MERKID FROM MERK WHERE (MERKID = MODEL.MERKID) AND (Deletests = 0)) AS MERKID, MODELID, MODELCODE, MODELNAME FROM MODEL WHERE (MODELID = @MODELID)"
        UpdateCommand="MODELUpdate" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvModel" Name="MODELID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="MODELID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MODELID" Type="Int32" />
            <asp:Parameter Name="MERKID" Type="Int32" />
            <asp:Parameter Name="MODELCODE" Type="String" />
            <asp:Parameter Name="MODELNAME" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="MERKID" Type="Int32" />
            <asp:Parameter Name="MODELCODE" Type="String" />
            <asp:Parameter Name="MODELNAME" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

<script type="text/javascript">
    FormatTable("<%=gvModel.ClientID%>")
   // alert(ModelID) 
    function TypeEdit(ModelID) {
        window.location = "ObjectType.aspx?ModelID=" + ModelID + "&Action=Edit"
    }
</script>
</asp:Content>

