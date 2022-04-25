<%@ Page Title="Dashboard List" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="ReportSetup_Dashboard" %>
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
            background-repeat: no-repeat; height: 16px" type="button" />
        </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 120px">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="Dashboard.DashboardName">Dashboard Name</asp:ListItem>
        <asp:ListItem Value="Dashboard.FileName">File Name</asp:ListItem>
        <asp:ListItem Value="Dashboard.DashboardID">Dashboard ID</asp:ListItem>
        <asp:ListItem Value="Dashboard.Description">Description</asp:ListItem>
    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
            </tr>
            <tr>
                <td style="width: 120px">

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" /></td>
                <td>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="DashboardId" 
            DataSourceID="sdsGrid" Width="100%" Caption="Dashboard List" 
            RowHeaderColumn="DashboardId">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="Param" SortExpression="DASHBOARDID">
                    <ItemTemplate>
                        <input id="btnEditParam" type="button" value="Edit" onclick="EditParam('<%#eval("DashboardID")%>')" style="background-repeat: no-repeat" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                </asp:TemplateField>
                <asp:BoundField DataField="DASHBOARDNAME" HeaderText="Dashboard&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="DASHBOARDNAME" />
                <asp:BoundField DataField="FILENAME" HeaderText="File&lt;BR&gt;Name" HtmlEncode="False"
                    SortExpression="FILENAME" />
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" HtmlEncode="False"
                    SortExpression="DESCRIPTION" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        SelectCommand="SELECT TOP (500) DASHBOARDID, DASHBOARDNAME, DESCRIPTION, FILENAME FROM DASHBOARD WHERE (Deletests = 0)"></asp:SqlDataSource>
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
    <asp:FormView ID="fvData" runat="server" DataKeyNames="DASHBOARDID" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Dashboard ID</td>
                    <td>
                        <asp:Label ID="lblReportID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("DASHBOARDID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Dashboard Name</td>
                    <td>
                        <asp:TextBox ID="txtDashboardName" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("DASHBOARDNAME") %>' Width="320px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDashboardName" runat="server" 
                            ControlToValidate="txtDashboardName" Display="None" 
                            ErrorMessage="Dashboard Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEReportName" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDashboardName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        File Name</td>
                    <td>
                        <asp:TextBox ID="txtFileName" runat="server" MaxLength="100" Text='<%# Bind("FileName") %>'
                            Width="320px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqFileName"
                                runat="server" ControlToValidate="txtFileName" Display="None" ErrorMessage="File Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEFileName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFileName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="200" Text='<%# Bind("Description") %>'
                            Width="472px"></asp:TextBox></td>
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
                        Dashboard Name</td>
                    <td>
                        <asp:TextBox ID="txtDashboardName" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("DASHBOARDNAME") %>' Width="320px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqDashboardName" runat="server" 
                            ControlToValidate="txtDashboardName" Display="None" 
                            ErrorMessage="Dashboard Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEReportName" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqDashboardName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        File Name</td>
                    <td>
                        <asp:TextBox ID="txtFileNameIns" runat="server" MaxLength="100" Text='<%# Bind("FileName") %>'
                            Width="320px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqFileName"
                                runat="server" ControlToValidate="txtFileNameIns" Display="None" ErrorMessage="File Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEFileName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFileName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="200" Text='<%# Bind("Description") %>'
                            Width="472px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc5:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT DASHBOARDID, DASHBOARDNAME, DESCRIPTION, FILENAME FROM DASHBOARD WHERE (Deletests = 0) AND (DASHBOARDID = @DASHBOARDID)" 
        DeleteCommand="UPDATE DASHBOARD SET Deletests = 1 WHERE (DASHBOARDID = @DASHBOARDID)" 
        UpdateCommand="UPDATE DASHBOARD SET DASHBOARDNAME = @DASHBOARDNAME, DESCRIPTION = @DESCRIPTION, FILENAME = @FILENAME, LastUpdate = GETDATE() WHERE (DASHBOARDID = @DASHBOARDID)" 
        InsertCommand="rptDashboardAdd" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="DASHBOARDID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="DASHBOARDID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DASHBOARDNAME" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="FileName" />
            <asp:Parameter Name="DASHBOARDID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DashboardName" Type="String" />
            <asp:Parameter Name="FileName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="DashboardID" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    &nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
    function EditParam(ReportID) {
        window.location = "DashboardParam.aspx?DASHBOARDID=" + ReportID
    }
 </script>

</asp:Content>

