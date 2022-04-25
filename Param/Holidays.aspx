<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Holidays.aspx.vb" Inherits="Param_Holidays" title="Holidays" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="Convert(varchar(20), HolidayDate, 103)">Holiday Date</asp:ListItem>
        <asp:ListItem Value="Description">Description</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="600px">
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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="600px" DataKeyNames="HOLIDAYDATE" Caption="Holidays List">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" ImageUrl="~/images/edit.gif" Text="Select" 
                            Visible='<%# NOT Eval("NEW") %>' />
                    </ItemTemplate>
                    <HeaderStyle Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="HOLIDAYDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Holiday&lt;br&gt;Date"
                    HtmlEncode="False" ReadOnly="True" SortExpression="HOLIDAYDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT HOLIDAYDATE, DESCRIPTION, NEW, UPD FROM (SELECT TOP (1000) HOLIDAYDATE, DESCRIPTION, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM HOLIDAYSX WHERE HOLIDAYS_1.HOLIDAYDATE = HOLIDAYSX.HOLIDAYDATE) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM HOLIDAYS AS HOLIDAYS_1 UNION ALL SELECT HOLIDAYDATE, DESCRIPTION, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD FROM HOLIDAYSX WHERE (NOT EXISTS (SELECT 'X' AS Expr1 FROM HOLIDAYS AS HOLIDAYS_2 WHERE (HOLIDAYDATE = HOLIDAYSX.HOLIDAYDATE)))) AS HOLIDAYS WHERE (HOLIDAYDATE IS NOT NULL)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="600px" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
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
        DefaultMode="Edit" Width="600px" DataKeyNames="HOLIDAYDATE">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="600">
                <tr>
                    <td>
                        Holiday Date</td>
                    <td>
                        <asp:Label ID="HOLIDAYDATELabel1" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("HOLIDAYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="required" MaxLength="200"
                            Text='<%# Bind("DESCRIPTION") %>' Width="440px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqDescription" runat="server" ControlToValidate="txtDescription" Display="None"
                                ErrorMessage="Description must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEDescription" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDescription">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="2">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="600">
                <tr>
                    <td>
                        Holiday Date</td>
                    <td>
                        <asp:TextBox ID="txtHolidayDate" runat="server" CssClass="required" Text='<%# Bind("HOLIDAYDATE") %>'
                            Width="72px"></asp:TextBox><asp:RequiredFieldValidator ID="reqHolidayDate" runat="server"
                                ControlToValidate="txtHolidayDate" Display="None" ErrorMessage="Holday Date must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:Image ID="imgHolidayDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                            ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEHolidayDate" runat="server"
                                Format="dd/MM/yyyy" PopupButtonID="imgHolidayDate" TargetControlID="txtHolidayDate">
                            </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEEHolidayDate" runat="server" Mask="99/99/9999"
                            MaskType="Date" TargetControlID="txtHolidayDate">
                        </ajaxToolkit:MaskedEditExtender>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEHolidayDate" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqHolidayDate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="required" MaxLength="200"
                            Text='<%# Bind("DESCRIPTION") %>' Width="440px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDescription" runat="server" ControlToValidate="txtDescription"
                            Display="None" ErrorMessage="Description must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDescription" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqDescription">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="2">
                        &nbsp;<uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
            <br />
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT HOLIDAYDATE, DESCRIPTION FROM HOLIDAYS WHERE (HOLIDAYDATE = @HOLIDAYDATE) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM HOLIDAYSX WHERE (HOLIDAYS.HOLIDAYDATE = HOLIDAYDATE))) UNION ALL SELECT HOLIDAYDATE, DESCRIPTION FROM HOLIDAYSX AS HOLIDAYSX_1 WHERE (HOLIDAYDATE = @HOLIDAYDATE)" 
        DeleteCommand="DELETE HOLIDAYS WHERE HOLIDAYDATE=@HOLIDAYDATE" 
        UpdateCommand="HolidayUpdate" InsertCommand="HolidayAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="HOLIDAYDATE" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="HOLIDAYDATE" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HOLIDAYDATE" />
            <asp:Parameter Name="DESCRIPTION" />
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="HOLIDAYDATE" Type="String" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

