<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Currency.aspx.vb" Inherits="Param_Currency" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BankName">Currency Name</asp:ListItem>
        <asp:ListItem Value="BankCode">Currency Code</asp:ListItem>
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
            AutoGenerateColumns="False" DataKeyNames="CURRENCYID" 
            DataSourceID="sdsGrid" Width="100%" Caption="Currency List" 
            RowHeaderColumn="CURRENCYID">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/images/edit.gif" >
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="CURRENCYID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="CURRENCYID" />
                <asp:BoundField DataField="CURRENCYCODE" HeaderText="Currency&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="CURRENCYCODE" />
                <asp:BoundField DataField="CURRENCYNAME" HeaderText="Currency&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="CURRENCYNAME" />
                <asp:BoundField DataField="BASEEQUIVALENT" DataFormatString="{0:N4}" 
                    HeaderText="Base&lt;br&gt;Equivalent" HtmlEncode="False" 
                    SortExpression="BASEEQUIVALENT">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="DECPOINT" HeaderText="Dec&lt;br&gt;Point" 
                    HtmlEncode="False" SortExpression="DECPOINT">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        SelectCommand="SELECT CURRENCYID, CURRENCYCODE, CURRENCYNAME,CONVERT(DECIMAL(18,2),BASEEQUIVALENT ) AS BASEEQUIVALENT, DECPOINT FROM CURRENCY WHERE (DELETESTS=0)"></asp:SqlDataSource>
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

    <asp:FormView ID="fvData" runat="server" DataKeyNames="CURRENCYID" DataSourceID="sdsForm"
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
                        <asp:Label ID="lblCurrencyID" runat="server" Font-Bold="True" 
                            Text='<%# Eval("CURRENCYID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td >
                        Code &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="txtCurCode" runat="server" Text='<%# Bind("CURRENCYCODE") %>' 
                            MaxLength=7 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCurCode" Display="None" ErrorMessage="Currency Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtCurName" runat="server" Text='<%# Bind("CURRENCYNAME") %>' 
                            MaxLength=100 Width="250px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtCurName" Display="None" ErrorMessage="Currency Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Base Equivalent</td>
                    <td>
                        <asp:TextBox ID="txtBaseEq" runat="server" 
                            Text='<%# Bind("BASEEQUIVALENT", "{0:N}") %>' style="text-align:right"
                            MaxLength=12 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqbase" runat="server" ControlToValidate="txtBaseEq" Display="None" ErrorMessage="Base Equivalent must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBase" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqbase">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Decimal Point</td>
                    <td>
                        <asp:TextBox ID="txtDecPoint" runat="server" 
                            Text='<%# Bind("DECPOINT", "{0:D}") %>' style="text-align:right"
                            MaxLength=12 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDP" runat="server" ControlToValidate="txtDecPoint" Display="None" ErrorMessage="Decimal Point must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDP">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>
                    Periode Date From</td>
                        <td>
                        <asp:TextBox ID="txtPeriodeDateFrom" Text='<%# Bind("PERIODEDATEFROM")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgPeriodeDateFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPeriodeDateFrom" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgPeriodeDateFrom"
                        TargetControlID="txtPeriodeDateFrom"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEPeriodeDateFrom" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtPeriodeDateFrom"></ajaxToolkit:MaskedEditExtender>
                           

                        </td> 
                <td>
                    To</td>
                        <td>
                        <asp:TextBox ID="txtPeriodeDateTo" Text='<%# Bind("PERIODEDATETO")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgtxtPeriodeDateTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCEtxtPeriodeDateTo" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgDELIVERYDATE"
                        TargetControlID="txttxtPeriodeDateTo"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEtxtPeriodeDateTo" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txttxtPeriodeDateTo"></ajaxToolkit:MaskedEditExtender>
                           

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
        <InsertItemTemplate>
        <table cellpadding=0 cellspacing=0 width="100%">
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
                        <asp:TextBox ID="txtCurCode" runat="server" Text='<%# Bind("CURRENCYCODE") %>' 
                            MaxLength=7 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtCurCode" Display="None" ErrorMessage="Currency Code must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtCurName" runat="server" Text='<%# Bind("CURRENCYNAME") %>' 
                            MaxLength=100 Width="272px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtCurName" Display="None" ErrorMessage="Currency Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Base Equivalent</td>
                    <td>
                        <asp:TextBox ID="txtBaseEq" runat="server" 
                            Text='<%# Bind("BASEEQUIVALENT", "{0:N}")%>' style="text-align:right"
                            MaxLength=12 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqbase" runat="server" ControlToValidate="txtBaseEq" Display="None" ErrorMessage="Base Equivalent must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBase" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqbase">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td >
                        Decimal Point</td>
                    <td>
                        <asp:TextBox ID="txtDecPoint" runat="server" 
                            Text='<%# Bind("DECPOINT", "{0:D}") %>' style="text-align:right"
                            MaxLength=12 Width="80px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDP" runat="server" ControlToValidate="txtDecPoint" Display="None" ErrorMessage="Decimal Point must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDP" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDP">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            <tr>
                        <td>
                    Periode Date From</td>
                        <td>
                        <asp:TextBox ID="txtPeriodeDateFrom" Text='<%# Bind("PERIODEDATEFROM")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgPeriodeDateFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPeriodeDateFrom" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgPeriodeDateFrom"
                        TargetControlID="txtPeriodeDateFrom"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEPeriodeDateFrom" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtPeriodeDateFrom"></ajaxToolkit:MaskedEditExtender>
                           

                        </td> 
                <td>
                    To</td>
                        <td>
                        <asp:TextBox ID="txtPeriodeDateTo" Text='<%# Bind("PERIODEDATETO")%>'
                            runat="server" Width="72px" CssClass="required"></asp:TextBox>
                            <asp:Image ID="imgtxtPeriodeDateTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                            <ajaxToolkit:CalendarExtender ID="ajaxCEtxtPeriodeDateTo" runat="server" 
                        Format="dd/MM/yyyy" PopupButtonID="imgDELIVERYDATE"
                        TargetControlID="txttxtPeriodeDateTo"></ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEtxtPeriodeDateTo" runat="server" 
                        Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txttxtPeriodeDateTo"></ajaxToolkit:MaskedEditExtender>
                           

                        </td> 
                     </tr>
                <tr>
                    <td colspan="2">&nbsp;
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
        
        SelectCommand="SELECT CURRENCYID, CURRENCYCODE, CURRENCYNAME, CAST(BASEEQUIVALENT AS MONEY) AS BASEEQUIVALENT, DECPOINT,PERIODEDATEFROM,PERIODEDATETO FROM CURRENCY WHERE (CURRENCYID = @CURRENCYID)" 
        DeleteCommand="DELETE CURRENCY WHERE CURRENCYID=@CURRENCYID" 
        UpdateCommand="CurrencyUpdate" InsertCommand="CurrencyAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="CURRENCYID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CURRENCYID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CURRENCYID" Type="Int32" />
            <asp:Parameter Name="CURRENCYCODE" Type="String" />
            <asp:Parameter Name="CURRENCYNAME" Type="String" />
            <asp:Parameter Name="BaseEquivalent" Type="Decimal" />
            <asp:Parameter Name="DecPoint" Type="int32" />
            <asp:Parameter Name="PERIODEDATEFROM" Type="DateTime" />
            <asp:Parameter Name="PERIODEDATETO" Type="DateTime" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CURRENCYCode" Type="String" />
            <asp:Parameter Name="CURRENCYName" Type="String" />
            <asp:Parameter Name="BaseEquivalent" Type="String" />
            <asp:Parameter Name="DecPoint" Type="int32" />
            <asp:Parameter Name="PERIODEDATEFROM" Type="DateTime" />
            <asp:Parameter Name="PERIODEDATETO" Type="DateTime" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>
