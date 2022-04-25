<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AuditSQL.aspx.vb" Inherits="Audit_AuditSQL" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlTable" runat="server" Width="100%">
        &nbsp;<table cellpadding="0" cellspacing="0" style="width:100%;">
            <tr>
                <td class="ShowDetail">
                    AUDIT DATA :&nbsp;&nbsp;</td>
                <td class="ShowDetail">
                    <asp:DropDownList ID="ddlView" runat="server" AutoPostBack="True" 
                        CssClass="required" DataSourceID="sdsView" DataTextField="name" 
                        DataValueField="ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsView" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS ID, '[CHOOSE TABLE]' AS name UNION ALL SELECT id, name FROM sys.sysobjects WHERE (name LIKE 'VAUDIT%')">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqView" runat="server" 
                        ControlToValidate="ddlView" Display="None" 
                        ErrorMessage="[TABLE AUDIT DATA] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEView" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqView">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Row Retrieve</td>
                <td class="FooterStyle">
                    <asp:RadioButton ID="rbAll" runat="server" Text="All Rows" 
                        GroupName="rbRetrive" />
                    <asp:RadioButton ID="rbLimitRow" runat="server" Text="Limit to : " 
                        GroupName="rbRetrive" />
                    <asp:TextBox ID="txtRows" runat="server" CssClass="required" Width="50px"></asp:TextBox>
                    &nbsp;row(s)<asp:RequiredFieldValidator ID="reqRow" runat="server" 
                        ControlToValidate="txtRows" Display="None" 
                        ErrorMessage="[LIMIT ROWS] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqRow_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqRow">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <%--Div contains the new header of the GridView--%>
  <div id="HeaderDiv" 
        style="width: 100%;">
  </div>
    <%--Wrapper Div which will scroll the GridView--%>
<div id="DataDiv" style="overflow: auto; border: 0px solid olive; 
width: 100%; height: 150px;" onscroll="Onscrollfnction();">
        <asp:GridView ID="gvColumn" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" 
            DataSourceID="sdsColumns" Width="100%">
            <HeaderStyle  CssClass="GridViewHeaderStyle" />
            <Columns>
                <asp:TemplateField HeaderText="Select&lt;br&gt;Column">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbCheck" runat="server" />
                        <asp:HiddenField ID="hidColumn" runat="server" Value='<%# Eval("name") %>' />
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="name" HeaderText="Column&lt;br&gt;Name" 
                    HtmlEncode="False" SortExpression="name" />
                <asp:BoundField DataField="xtypename" HeaderText="Column&lt;br&gt;Type" 
                    HtmlEncode="False" SortExpression="xtypename" />
                <asp:BoundField DataField="length" HeaderText="Length" SortExpression="length">
                <HeaderStyle Width="100px" />
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
</div>
		<asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
			Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			Visible="False" Width="100%"></asp:Label>
		<asp:GridView ID="gvFilter" runat="server" Caption=" FILTER ROWS" Width="100%" 
        AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField HeaderText="Del">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgDeleteRow" runat="server" CausesValidation="False" 
                            CommandName="DeleteRow" ImageUrl="~/Images/delete.gif" 
                            ToolTip="Delete Filter" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Column&lt;br&gt;Name">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlColumn" runat="server" CssClass="required" 
                            DataSourceID="sdsColumnFilter" DataTextField="NAME" DataValueField="NAME" 
                            SelectedValue='<%# eval("COLUMN") %>' ValidationGroup="Filter">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqColumn" runat="server" 
                            ControlToValidate="ddlColumn" Display="None" 
                            ErrorMessage="[COLUMN] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Filter"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEColumn" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqColumn">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Operator">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlOperator" runat="server" CssClass="required" 
                            SelectedValue='<%# eval("OPERATOR") %>'>
                            <asp:ListItem>=</asp:ListItem>
                            <asp:ListItem>Like</asp:ListItem>
                            <asp:ListItem>&lt;</asp:ListItem>
                            <asp:ListItem>&gt;</asp:ListItem>
                            <asp:ListItem>&lt;=</asp:ListItem>
                            <asp:ListItem>&gt;=</asp:ListItem>
                            <asp:ListItem Value="&lt;&gt;"></asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Filter&lt;br&gt;Value">
                    <ItemTemplate>
                        <asp:TextBox ID="txtFilter" runat="server" CssClass="required" 
                            Text='<%# eval("FILTER") %>' ValidationGroup="Filter" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqFilter" runat="server" 
                            ControlToValidate="txtFilter" Display="None" 
                            ErrorMessage="[FILTER VALUE] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Filter"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEFilter" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqFilter">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Operand">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlOperand" runat="server" 
                            SelectedValue='<%# eval("OPERAND") %>' CssClass="required" 
                            ValidationGroup="Filter">
                            <asp:ListItem Value=" ">-</asp:ListItem>
                            <asp:ListItem>AND</asp:ListItem>
                            <asp:ListItem>OR</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqOperand" runat="server" 
                            ControlToValidate="ddlOperand" Display="None" 
                            ErrorMessage="[OPERAND] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Filter"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOperand" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqOperand">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
    </asp:GridView>
        <asp:SqlDataSource ID="sdsColumns" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            SelectCommand="SELECT sys.syscolumns.id, sys.syscolumns.name, sys.syscolumns.xtype, sys.syscolumns.length, sys.systypes.name AS xtypename FROM sys.syscolumns INNER JOIN sys.systypes ON sys.syscolumns.xtype = sys.systypes.xtype WHERE (sys.syscolumns.id = @id) ORDER BY sys.syscolumns.name">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlView" Name="id" 
                    PropertyName="SelectedValue" DefaultValue="-111111" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsColumnFilter" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            
        
        
        
        SelectCommand="SELECT NULL AS ID, NULL AS NAME UNION ALL SELECT id, name FROM sys.syscolumns WHERE (id = @id) ORDER BY name">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlView" Name="id" 
                    PropertyName="SelectedValue" DefaultValue="-111111" />
            </SelectParameters>
        </asp:SqlDataSource>
    <table border="0" cellpadding="0" style="width:100%;">
        <tr>
            <td class="AlternatingRowStyle">
        <asp:ImageButton ID="imgButtonAddFilter" runat="server" 
        ImageUrl="~/Images/New.png" ToolTip="Add Filter" ValidationGroup="Filter" />
            </td>
        </tr>
        <tr>
            <td>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="100px" 
    Width="100%">
    </rsweb:ReportViewer>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table>
<asp:Panel ID="pnlReport" runat="server" CssClass="HeaderStyle" Width="100%">
    <asp:Button ID="btnReport" runat="server" 
    Text="Report" />
</asp:Panel>
<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEReport" runat="server" 
    Enabled="True" TargetControlID="pnlReport" VerticalSide="Bottom">
</ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvColumn.ClientID%>");
    FormatTable("<%=gvFilter.ClientID%>");
    function Onscrollfnction() {
        var div = document.getElementById('DataDiv');
        var div2 = document.getElementById('HeaderDiv');
        //****** Scrolling HeaderDiv along with DataDiv ******
        div2.scrollLeft = div.scrollLeft;
        return false;
    }

    function CreateGridHeader(DataDiv, GridView1, HeaderDiv) {
        //alert(1);
        var DataDivObj = document.getElementById(DataDiv);
        var DataGridObj = document.getElementById(GridView1);
        var HeaderDivObj = document.getElementById(HeaderDiv);
        if (!(DataGridObj))
            return (false);

        //********* Creating new table which contains the header row ***********
        var HeadertableObj = HeaderDivObj.appendChild(document.createElement('table'));
        //DataDivObj.style.paddingTop = '0px';
        var DataDivWidth = DataDivObj.clientWidth;
        //DataDivObj.style.width = '5000px';
        DataDivObj.style.width = '100%';
        //********** Setting the style of Header Div as per the Data Div ************
        HeaderDivObj.className = DataDivObj.className;
        HeaderDivObj.style.cssText = DataDivObj.style.cssText;

        //**** Making the Header Div scrollable. *****
        HeaderDivObj.style.overflow = 'auto';

        //*** Hiding the horizontal scroll bar of Header Div ****
        //*** this is because we have to scroll the Div along with the DataDiv.  
        HeaderDivObj.style.overflowX = 'hidden';
        //**** Hiding the vertical scroll bar of Header Div **** 
        HeaderDivObj.style.overflowY = 'hidden';
        HeaderDivObj.style.height = DataGridObj.rows[0].clientHeight + 'px';
        //**** Removing any border between Header Div and Data Div ****
        HeaderDivObj.style.borderBottomWidth = '0px';
        //********** Setting the style of Header Table as per the GridView ************
        HeadertableObj.className = DataGridObj.className;
        //**** Setting the Headertable css text as per the GridView css text 
        HeadertableObj.style.cssText = DataGridObj.style.cssText;
        //HeadertableObj.border = '1px';
        HeadertableObj.border = '1px';

        //HeadertableObj.rules = 'all';
        HeadertableObj.rules = DataGridObj.rules;

        HeadertableObj.cellPadding = DataGridObj.cellPadding;
        HeadertableObj.cellSpacing = DataGridObj.cellSpacing;
        //********** Creating the new header row **********
        var Row = HeadertableObj.insertRow(0);
        Row.className = DataGridObj.rows[0].className;
        Row.style.cssText = DataGridObj.rows[0].style.cssText;
        //Row.style.fontWeight = 'bold';
        //******** This loop will create each header cell *********
        for (var iCntr = 0; iCntr < DataGridObj.rows[0].cells.length; iCntr++) {
            //var spanTag = Row.appendChild(document.createElement('td'));
            var spanTag = Row.appendChild(document.createElement('th'));
            
            spanTag.innerHTML = DataGridObj.rows[0].cells[iCntr].innerHTML;
            spanTag.scope = DataGridObj.rows[0].cells[iCntr].scope;
            /*
            var width = 0;
            //****** Setting the width of Header Cell **********
            if (spanTag.clientWidth > DataGridObj.rows[1].cells[iCntr].clientWidth) {
                width = spanTag.clientWidth;
            }
            else {
                width = DataGridObj.rows[1].cells[iCntr].clientWidth;
            }
            if (iCntr <= DataGridObj.rows[0].cells.length - 2) {
                spanTag.style.width = width + 'px';
            }
            else {
                spanTag.style.width = width + 20 + 'px';
            }
            DataGridObj.rows[1].cells[iCntr].style.width = width + 'px';
            */
            width = DataGridObj.rows[1].cells[iCntr].clientWidth;
            spanTag.style.width = width + 'px';
            //spanTag.style = DataGridObj.rows[0].cells[iCntr].style;
        }
        var tableWidth = DataGridObj.clientWidth;
        //********* Hidding the original header of GridView *******
        DataGridObj.rows[0].style.display = 'none';
        //********* Setting the same width of all the components **********
        HeaderDivObj.style.width = DataDivWidth + 'px';
        DataDivObj.style.width = DataDivWidth + 'px';
        DataGridObj.style.width = tableWidth + 'px';
        //HeadertableObj.style.width = tableWidth + 20 + 'px';
        HeadertableObj.style.width = tableWidth + 'px';
        return false;
    }

    window.onload = function () {
        CreateGridHeader('DataDiv', '<%=gvColumn.ClientID%>', 'HeaderDiv')
    }
</script>
</asp:Content>

