<%@ Page Title="Rpt Setup - Dashboard Param" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DashboardParam.aspx.vb" Inherits="ReportSetup_DashboardParam" %>

<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <asp:Button ID="btnBack" runat="server" CausesValidation="False" 
            Text="Back To Dashboard List" 
            style="cursor: pointer; background-image: url(../images/back.gif); background-repeat: no-repeat;" /></asp:Panel>
    <ajaxToolkit:collapsiblepanelextender id="ajaxCPEData" runat="server" collapsecontrolid="pnlShow"
        collapsedimage="~/images/expand.jpg" collapsedtext="(Show Detail...)" enabled="True"
        expandcontrolid="pnlShow" expandedimage="~/images/collapse.jpg" expandedtext="(Hide Detail...)"
        imagecontrolid="imgButtonShow" targetcontrolid="pnlData" textlabelid="lblShow">
    </ajaxToolkit:collapsiblepanelextender>
    <asp:Panel ID="pnlData" runat="server" GroupingText="Detail Data">
    <asp:DataList ID="dlReport" runat="server" Caption="Dashboard Info" DataKeyField="DASHBOARDID"
        DataSourceID="sdsReport" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Dashboard ID</td>
                    <td>
                        <asp:Label ID="ReportIdLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("DASHBOARDID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Dashboard Name</td>
                    <td>
                        <asp:Label ID="ReportNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("DASHBOARDNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        File</td>
                    <td>
                        <asp:Label ID="FileNameLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("FileName") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Description</td>
                    <td>
                        <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("Description") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList></asp:Panel>
    <asp:SqlDataSource ID="sdsReport" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT DASHBOARDID, DASHBOARDNAME, DESCRIPTION, FILENAME FROM DASHBOARD WHERE (DASHBOARDID = @DASHBOARDID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="DASHBOARDID" QueryStringField="DashboardID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" ToolTip="New Parameter" CausesValidation="False" /><br />
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="DASHBOARDPARAMID" DataSourceID="sdsGrid" Width="100%" 
        Caption="Dashboard Parameter(s)">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                <ItemStyle Width="20px" />
            </asp:CommandField>
            <asp:BoundField DataField="DASHBOARDPARAMNAME" 
                HeaderText="Dashboard&lt;br&gt;Param Name" SortExpression="DASHBOARDPARAMNAME" 
                HtmlEncode="False" />
            <asp:BoundField DataField="DASHBOARDPARAMTYPE" 
                HeaderText="Dashboard&lt;br&gt;Type" SortExpression="DASHBOARDPARAMTYPE" 
                HtmlEncode="False" />
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT DASHBOARDPARAMID, DASHBOARDID, DASHBOARDPARAMNAME, '( ' + CAST(DASHBOARDPARAMTYPE AS VARCHAR(10)) + ' ) ' + dbo.f_getParamGlobalName('DASHBOARDPARAMTYPE', DASHBOARDPARAMTYPE) AS DASHBOARDPARAMTYPE FROM DASHBOARDPARAM WHERE (DASHBOARDID = @DASHBOARDID) AND (Deletests = 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="DASHBOARDID" QueryStringField="DashboardID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvData" runat="server" DataKeyNames="DASHBOARDPARAMID" 
        DataSourceID="sdsForm" DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Dashboard ID</td>
                    <td>
                        <asp:Label ID="lblDashboardID" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("DASHBOARDPARAMID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Dashboard Name</td>
                    <td>
                        <asp:TextBox ID="txtDashboardName" runat="server" MaxLength="50" Text='<%# Bind("DASHBOARDPARAMNAME") %>'
                            Width="248px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqParamName"
                                runat="server" ControlToValidate="txtDashboardName" 
                            CssClass="required" Display="None"
                                ErrorMessage="Parameter Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEParam" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParamName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Dashboard Type</td>
                    <td>
                        <asp:DropDownList ID="ddlDashboardType" runat="server" CssClass="required" 
                            DataSourceID="sdsDashboardType" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("DASHBOARDPARAMTYPE") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsDashboardType" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            SelectCommand="SELECT NULL AS CODE, '( SELECT TYPE ) ' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = 'DASHBOARDPARAMTYPE') ORDER BY NAME">
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="reqParamType" runat="server" 
                            ControlToValidate="ddlDashboardType" CssClass="required" Display="None" 
                            ErrorMessage="Parameter Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqParamType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParamType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc5:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc3:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc6:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Parameter Name</td>
                    <td>
                        <asp:TextBox ID="txtParamName" runat="server" MaxLength="50" Text='<%# Bind("DASHBOARDPARAMNAME") %>'
                            Width="248px" CssClass="required"></asp:TextBox><asp:RequiredFieldValidator ID="reqParamName"
                                runat="server" ControlToValidate="txtParamName" CssClass="required" Display="None"
                                ErrorMessage="Parameter Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEParam" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParamName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Parameter Type</td>
                    <td>
                        <asp:SqlDataSource ID="sdsDashboardType" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            SelectCommand="SELECT NULL AS CODE, '( SELECT TYPE ) ' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = 'DASHBOARDPARAMTYPE') ORDER BY NAME">
                        </asp:SqlDataSource>
                        <asp:DropDownList ID="ddlDashboardType" runat="server" CssClass="required" 
                            DataSourceID="sdsDashboardType" DataTextField="NAME" DataValueField="CODE" 
                            SelectedValue='<%# Bind("DASHBOARDPARAMTYPE") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqParamType" runat="server" 
                            ControlToValidate="ddlDashboardType" CssClass="required" Display="None" 
                            ErrorMessage="Parameter Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqParamType_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqParamType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc2:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc4:BtnCancelHTML ID="BtnCancelHTML1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT DASHBOARDPARAMID, DASHBOARDPARAMNAME, DASHBOARDPARAMTYPE FROM DASHBOARDPARAM WHERE (DASHBOARDPARAMID = @DASHBOARDPARAMID) AND (Deletests = 0)" 
        DeleteCommand="UPDATE DASHBOARDPARAM SET DELETESTS=1, LastUpdate = GETDATE() WHERE (DASHBOARDPARAMID = @DASHBOARDPARAMID)" 
        InsertCommand="rptParamDashboardAdd" InsertCommandType="StoredProcedure" 
        UpdateCommand="UPDATE DASHBOARDPARAM SET DASHBOARDPARAMNAME = @DASHBOARDPARAMNAME, DASHBOARDPARAMTYPE = @DASHBOARDPARAMTYPE, LastUpdate = GETDATE() WHERE (DASHBOARDPARAMID = @DASHBOARDPARAMID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="DASHBOARDPARAMID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="DASHBOARDPARAMID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DASHBOARDPARAMNAME" />
            <asp:Parameter Name="DASHBOARDPARAMTYPE" />
            <asp:Parameter Name="DASHBOARDPARAMID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="DashboardID" Type="Int32"  QueryStringField="DashboardID" />
            <asp:Parameter Name="DASHBOARDPARAMNAME" Type="String" />
            <asp:Parameter Name="DASHBOARDPARAMTYPE" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="DASHBOARDPARAMID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
  
</script>

</asp:Content>

