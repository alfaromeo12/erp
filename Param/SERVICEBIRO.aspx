<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="SERVICEBIRO.aspx.vb" Inherits="Param_SERVICEBIRO" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
   <asp:HiddenField ID="hidSBID" runat="server" />
                 <asp:HiddenField ID="hidAction" runat="server" />
  <asp:MultiView ID="MultiView_Utama" runat="server"> 
             <asp:View ID="View_View" runat="server">   
<asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="SBNAME">Service Biro Name</asp:ListItem>
        <asp:ListItem Value="SBCODE">Service Biro Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />
        <asp:Label ID="Label1" runat="server" Text="Product"></asp:Label>

          <br />
 <asp:CheckBox ID="chkAdd" runat="server" style="display:none" />
    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" />
                 <br />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
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
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow"></ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="SBID" Caption="Service Biro List" 
            RowHeaderColumn="SBID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                <ItemStyle Width="20px" HorizontalAlign="Center" /></asp:CommandField>
                <asp:BoundField DataField="SBID" HeaderText="ID" HtmlEncode="False"
                    SortExpression="SBID"><ItemStyle HorizontalAlign="Center" Width="60px" /></asp:BoundField>
                <asp:BoundField DataField="SBCODE" HeaderText="Service Biro&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="SBCODE" ><ItemStyle Width="80px" /></asp:BoundField>
                <asp:BoundField DataField="SBNAME" HeaderText="Service Biro&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="SBNAME" />
                <asp:BoundField DataField="SBADDRESS" 
                    HeaderText="Service Biro&lt;br&gt;Address" HtmlEncode="False" 
                    SortExpression="SBADDRESS"></asp:BoundField>
                <asp:BoundField DataField="SBPHONE" HeaderText="Service  Biro&lt;br&gt;Phone" 
                    HtmlEncode="False" SortExpression="SBPHONE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
                     SelectCommand="SELECT TOP (500) SERVICEBIRO.SBID, SERVICEBIRO.SBCODE, SERVICEBIRO.SBNAME, SERVICEBIRO.SBADDRESS, SERVICEBIRO.SBZIP, SERVICEBIRO.SBCITY, SERVICEBIRO.SBPHONE, SERVICEBIRO.SBFAX, SERVICEBIRO.SBBANKID, SERVICEBIRO.SBACCOUNTNO FROM SERVICEBIRO WITH (NOLOCK) LEFT OUTER JOIN BANK WITH (NOLOCK) ON SERVICEBIRO.SBBANKID = BANK.BANKID WHERE (SERVICEBIRO.Deletests = 0)"></asp:SqlDataSource>
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
       </asp:View>
    <asp:View ID="View_Form" runat="server">   
      <asp:Panel ID="pnlFormSB" runat="server">
            <table cellpadding="0" cellspacing="0" width="100%">
                
                <tr>
                    <td colspan="2"  class="HeaderStyle" style="text-align:center">
                         <asp:Label ID="lblCaption" runat="server"></asp:Label></td>
                    
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr id="rowSBID" >
                    <td class="AlternatingRowStyle">
                        &nbsp;ID</td>
                    <td class="RowStyle">
                        <asp:Label ID="lblBJID" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Service Biro Code</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJCode" runat="server" Width="56px" MaxLength="10" 
                             CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtBJCode" 
                            Display="None" ErrorMessage="Service Biro Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Service Biro Name</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJName" runat="server" Width="264px" MaxLength="50" 
                            CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtBJName" 
                            Display="None" ErrorMessage="Service Biro Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td valign="top" class="AlternatingRowStyle">
                        Address</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJAddress" runat="server" 
                            MaxLength="100"  Width="250px" 
                            Rows="3" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Zip</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJZip" runat="server" MaxLength="5" 
                            Width="60px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        City</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJCity" runat="server" MaxLength="50" 
                            Width="120px"></asp:TextBox>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Phone</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJPhone" runat="server" MaxLength="50" 
                           Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Fax</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtBJFax" runat="server" MaxLength="50" 
                           Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Bank</td>
                    <td class="RowStyle">
                        <asp:DropDownList ID="ddlbank" runat="server" Width="250px" 
                            DataSourceID="sdsBank" DataTextField="BANKNAME" DataValueField="BANKID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Account No</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtAccountNo" runat="server" MaxLength="50" 
                            Width="120px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Account Name</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtAccountNm" runat="server" MaxLength="80" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Contact Person</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtContactPerson" runat="server" MaxLength="50" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="GvwFee" runat="server" AutoGenerateColumns="False" 
                            DataKeyNames="COLLACTID" DataSourceID="sdsGridFee" 
                            RowHeaderColumn="COLLACTID" Width="99%" 
                            Caption="SERVICE BIRO DOCUMENT PROCESS FEE">
                            <HeaderStyle Width="10%" />
                            <RowStyle Width="10%" />
                            <FooterStyle Width="10%" />
                            <Columns>
                                <asp:TemplateField Visible="False"><ItemTemplate><asp:Label ID="lblCollKey" runat="server" 
                                            Text='<% #DataBinder.Eval(Container.DataItem,"COLLACTID") %>' 
                                            Visible="false" /></ItemTemplate></asp:TemplateField>
                                <asp:BoundField DataField="COLLACTNAME" HeaderText="Process." 
                                    HtmlEncode="False" ItemStyle-Font-Bold="true" ItemStyle-Width="20%" 
                                    SortExpression="COLLACTNAME"><ItemStyle Font-Bold="True" Width="20%" /></asp:BoundField>
                                <asp:TemplateField HeaderText="Fee" SortExpression="COLLACTFEE"><Itemstyle HorizontalAlign="Right" Width="10%" /><ItemTemplate><asp:TextBox ID="txtFee" runat="server" Font-Names="Lucida Sans" 
                                            Font-Size="Smaller" style="text-align:right" Text='<%# Eval("COLLACTFEE","{0:n}") %>' 
                                            Width="95%"></asp:TextBox></ItemTemplate></asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <uc6:NoDataFound ID="NoDataFound2" runat="server" />
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
      </asp:Panel>
              <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
			                    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			                    Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessageDtl" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                                <br />
                                <br />
          <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" 
            Width="100%" Visible="false" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                          
                            <asp:Button ID="btnSave" runat="server"
                            Style="font-size: 8pt; cursor: pointer;   
                            background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" onclientclick="return CheckUserSPVSaveBR();" />
                            <asp:Button ID="btnDelete" runat="server"
                            Style="font-size: 8pt; cursor: pointer;   
                            background-position: left; background-image: url(../images/Delete.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete" 
                                Width="55px" CausesValidation="False" 
                                onclientclick="return CheckUserSPVDelBR();" />
                            <asp:Button ID="btnCancel" runat="server"
                            Style="font-size: 8pt; cursor: pointer;   
                            background-position: left; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Back" Width="55px" CausesValidation="False" 
                                ValidationGroup="Collector" />
                        </td>
			        </tr>
                </table>
            </asp:Panel>
          
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
            <asp:SqlDataSource ID="sdsBank" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
            SelectCommand="SELECT '' AS BANKID, ' ( CHOOSE BANK NAME )' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE + ' - ' + BANKNAME AS BANKNAME FROM BANK">
            </asp:SqlDataSource>
          
            <asp:SqlDataSource ID="sdsGridFee" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            SelectCommand="SELECT COLLACTID, COLLACTCODE, COLLACTNAME, dbo.f_getServiceFeeBySBID(@SBID, COLLACTID) AS COLLACTFEE FROM COLLATERALACTIVITY WITH (NOLOCK) WHERE (Deletests = 0)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidSBID" DefaultValue="0" Name="SBID" 
                        PropertyName="Value" />
                </SelectParameters>
        </asp:SqlDataSource>
          
            </asp:View>
</asp:MultiView>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">

        FormatTable("<%=gvData.ClientID%>");
        FormatTable("<%=GvwFee.ClientID%>");
        
        function getObjectbyClientID(ClientID) {
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject);
        }

        function SetValueTxtByClientID(ClientID, sValue) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                oText.value = sValue;
        }

        function GetValueTxtByClientID(ClientID) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                return (oText.value);
        }

        window.onload = function () {
            Load();
        }
        function Load() {
            var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
            if (Action == "NEW") {
                displayRowID();
            }
        }

        function displayRowID() {
            var row = getObjectbyClientID("rowSBID");
            if (row)
                row.style.display = "none";
        }

        function CheckUserSPVSaveBR() {
            if (Page_ClientValidate) {
                if (Page_ClientValidate("")) {
                    var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
                    if (RetVal.Login == 1)
                        return (true);
                    else
                        return (false);
                } else {
                    return (false);
                }
            }
        }

        function CheckUserSPVDelBR() {
            var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
            if (RetVal.Login == 1)
                return (true);
            else
                return (false);
        }

</script>
</asp:Content>

