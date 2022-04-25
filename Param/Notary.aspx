<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Notary.aspx.vb" Inherits="Param_Notary" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="hidNotaryID" runat="server" />
    <asp:HiddenField ID="hidAction" runat="server" />
       <asp:CheckBox ID="chkAddNew" runat="server" Font-Names="Lucida Sans" 
                            Font-Size="7.5pt" Visible="False"/>
    <asp:TextBox ID="txtTmpSelectedIndex" runat="Server" style="display:none" Text="0" />    
  <asp:MultiView ID="MultiView_Utama" runat="server"> 
             <asp:View ID="View_View" runat="server">   
<asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="NOTARYNAME">Notary Name</asp:ListItem>
        <asp:ListItem Value="NOTARYCODE">Notary Code</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

          

          <br />
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
            DataKeyNames="NOTARYID" Caption="Notary List" 
            RowHeaderColumn="NOTARYID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                <ItemStyle Width="20px" HorizontalAlign="Center" /></asp:CommandField>
                <asp:BoundField DataField="NOTARYID" HeaderText="ID"
                    SortExpression="NOTARYID"><ItemStyle HorizontalAlign="Center" 
                    Width="60px" /></asp:BoundField>
                <asp:BoundField DataField="NOTARYCODE" HeaderText="Notary&lt;br&gt;Code" 
                    HtmlEncode="False" SortExpression="NOTARYCODE" />
                <asp:BoundField DataField="NOTARYNAME" HeaderText="Notary&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="NOTARYNAME" ></asp:BoundField>
                <asp:BoundField DataField="NOTARYADDRESS" HeaderText="Notary&lt;br&gt;Address" HtmlEncode="False"
                    SortExpression="NOTARYADDRESS" />
                <asp:BoundField DataField="NOTARYPHONE" 
                    HeaderText="Notary&lt;br&gt;Phone" HtmlEncode="False" 
                    SortExpression="NOTARYPHONE"></asp:BoundField>
                <asp:BoundField DataField="CONTACTPERSON" HeaderText="Contact&lt;br&gt;Person" 
                    HtmlEncode="False" SortExpression="CONTACTPERSON" />
                <asp:BoundField DataField="NOTARYCITY" HeaderText="Notary&lt;br&gt;City" 
                    HtmlEncode="False" SortExpression="NOTARYCITY" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                  
                     SelectCommand="SELECT TOP (500) NOTARYID, NOTARYNAME, NOTARYADDRESS, NOTARYPHONE, NOTARYFAX, CONTACTPERSON, NOTARYCITY, NOTARYCODE FROM NOTARY WITH (NOLOCK) WHERE (Deletests = 0)"></asp:SqlDataSource>
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
                <tr id="rowNotaryID" >
                    <td class="AlternatingRowStyle">
                        &nbsp;ID</td>
                    <td class="RowStyle">
                        <asp:Label ID="lblNotaryID" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Notary Code</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryCode" runat="server" Width="56px" MaxLength="10" 
                             CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtNotaryCode" 
                            Display="None" ErrorMessage="Notary Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Notary Name</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryName" runat="server" Width="264px" MaxLength="50" 
                            CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtNotaryName" 
                            Display="None" ErrorMessage="Notary Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td valign="top" class="AlternatingRowStyle">
                        Address</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryAddress" runat="server" 
                            MaxLength="100"  Width="250px" 
                            Rows="3" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Zip</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryZip" runat="server" MaxLength="5" 
                            Width="99px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        City</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryCity" runat="server" MaxLength="50" 
                            Width="244px"></asp:TextBox>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Phone</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryPhone" runat="server" MaxLength="50" 
                           Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Fax</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryFax" runat="server" MaxLength="50" 
                           Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Bank</td>
                    <td class="RowStyle">
                        <asp:DropDownList ID="ddlbank" runat="server" Width="254px" 
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
                    <td class="AlternatingRowStyle">
                        Branch</td>
                    <td class="RowStyle">
                        <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="sdsBranch" 
                            DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                            Width="256px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsBranch" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                            
                            
                            SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[SELECT BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' - ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY BRANCHCODE">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        NPWP No.
                    </td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNPWPName" runat="server" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        NPWP Name
                    </td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNPWPNo" runat="server" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        Notary Tax
                    </td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtNotaryTax" runat="server" Width="50px" MaxLength="10"></asp:TextBox>
                        %</td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
            </table>
      </asp:Panel>
         <asp:Panel ID="pnlDocData" runat="server" Width="100%" Font-Bold="True" >
                 
                            <table cellpadding="0" cellspacing="0" width="100%" >
                                <tr>
                                    <td>
                                            <asp:CheckBox ID="chkAddRow" runat="server" Font-Names="Lucida Sans" 
                                                  Font-Size="7.5pt" Visible="False"/></td>
                                    <td colspan="2" width="100px">
                                        &nbsp;</td>
                                </tr>
                      
                                <tr>
                                    <td width="100">
                                    
                                    </td>
                                    <td width="100">
                                        &nbsp;</td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3" >
                                        <asp:GridView ID="gvNotaryFee" ShowFooter="True" runat="server" 
                                            AllowPaging="True" AutoGenerateColumns="False"
                                            Width="100%" PageSize="5" style="margin-top: 0px" Caption="NOTARY FEE" >
                                                <Columns>
                                                    <asp:TemplateField HeaderText="DEL" ShowHeader="False" >
                                                        <ItemTemplate>
                                                             <asp:Label ID="lblFeeID" runat="server" 
                                                                    Text='<%# Eval("FEEID") %>' Visible="false" />
                                                            <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                                                                CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                                                style="cursor:pointer" Text="Delete">
                                                            </asp:ImageButton>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="No.">
                                                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Principal&lt;br&gt;From" 
                                                        SortExpression="PRINCIPALFROM">
                                                        <Itemstyle HorizontalAlign="Right"/>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtStartRange" runat="server" Font-Names="Lucida Sans"  CssClass="required"
                                                                    Font-Size="Smaller" style="text-align:right" 
                                                                    Text='<%# Eval("PRINCIPALFROM","{0:n}") %>'></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqStartRange" runat="server" 
                                                                ControlToValidate="txtStartRange" Display="None" 
                                                                ErrorMessage="Start Range Fee must be entry...!" SetFocusOnError="True"> 
                                                                </asp:RequiredFieldValidator>
                                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEStartRange" runat="server" 
                                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqStartRange"></ajaxToolkit:ValidatorCalloutExtender>
                                                            </ItemTemplate>
                                                          
                                                    </asp:TemplateField>                                                                                                  
                                                     <asp:TemplateField HeaderText="Principal&lt;br&gt;To"  
                                                        SortExpression="PRINCIPALTO">
                                                        <Itemstyle HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtEndRange" runat="server"  Font-Names="Lucida Sans" CssClass="required"
                                                                    Font-Size="Smaller" style="text-align:right" 
                                                                    Text='<%# Eval("PRINCIPALTO","{0:n}") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="reqEndRange" runat="server" 
                                                                ControlToValidate="txtEndRange" Display="None" 
                                                                ErrorMessage="End Range Fee must be entry...!" SetFocusOnError="True"> 
                                                            </asp:RequiredFieldValidator>
                                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEEndRange" runat="server" 
                                                                HighlightCssClass="ErrHighLight" TargetControlID="reqEndRange"></ajaxToolkit:ValidatorCalloutExtender>
                                                            </ItemTemplate>
                                                           
                                                    </asp:TemplateField>  
                                                     <asp:TemplateField HeaderText="Notary&lt;br&gt;Fee" SortExpression="NOTARYFEE">
                                                        <Itemstyle HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtNotaryFee" runat="server" Font-Names="Lucida Sans" CssClass="required"
                                                                    Font-Size="Smaller" style="text-align:right" 
                                                                    Text='<%# Eval("NOTARYFEE","{0:n}") %>'></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqNotaryFee" runat="server" 
                                                                ControlToValidate="txtNotaryFee" Display="None" 
                                                                ErrorMessage="Notary Fee must be entry...!" SetFocusOnError="True"> 
                                                            </asp:RequiredFieldValidator>
                                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENotaryFee" runat="server" 
                                                                HighlightCssClass="ErrHighLight" TargetControlID="reqNotaryFee"></ajaxToolkit:ValidatorCalloutExtender>
                                                            </ItemTemplate>
                                                         
                                                    </asp:TemplateField>    
                                                    <asp:TemplateField HeaderText="Internal&lt;br&gt;Fee" 
                                                        SortExpression="INTERNALFEE">
                                                        <Itemstyle HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtInternalFee" runat="server" Font-Names="Lucida Sans" CssClass="required"
                                                                    Font-Size="Smaller" style="text-align:right" 
                                                                    Text='<%# Eval("INTERNALFEE","{0:n}") %>'></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqInternalFee" runat="server" 
                                                                    ControlToValidate="txtInternalFee" Display="None" 
                                                                    ErrorMessage="Internal Fee must be entry...!" SetFocusOnError="True"> 
                                                                </asp:RequiredFieldValidator>
                                                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEInternalFee" runat="server" 
                                                                    HighlightCssClass="ErrHighLight" TargetControlID="reqInternalFee"></ajaxToolkit:ValidatorCalloutExtender>
                                                            </ItemTemplate>
                                                             <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                 <asp:ImageButton ID="btnNew" runat="server" CausesValidation="True"  onclick="btnNew_Click"
                                                                    CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                                                    style="cursor:pointer" Text="New" >
                                                                </asp:ImageButton>
                                                            </FooterTemplate>
                                                    </asp:TemplateField>  
                                                                                     
                                                </Columns>
                                               
                                                  <EmptyDataTemplate>
                                                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                                </EmptyDataTemplate>  
                                            </asp:GridView>

                                        <asp:SqlDataSource ID="sdsNotaryFee" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                                            SelectCommand="SELECT NOTARYID, FEEID, PRINCIPALFROM, PRINCIPALTO, NOTARYFEE, INTERNALFEE FROM NOTARYFEE WHERE (NOTARYID = @NOTARYID) AND (Deletests = 0)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="gvData" Name="NOTARYID" 
                                                    PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    </td>
                                    
                                </tr>
                                <tr>
                                 <td width="100">
                                    
                                    </td>
                                    <td width="100">
                                        &nbsp;</td>
                                    <td style="text-align:right;" >
                                     
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="3">
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
                                </ajaxToolkit:AnimationExtender></td>
                                </tr>
                            </table>
                 
                </asp:Panel>
              
        <br />
                                         
        <br />
        <br />
        <br />
          <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="100%" Visible="false" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                          
                            <asp:Button ID="btnSave" runat="server"
                            Style="font-size: 8pt; cursor: pointer; 
                            background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" onclientclick="return CheckUserSPVNotarySave();" />
                            <asp:Button ID="btnDelete" runat="server"
                            Style="font-size: 8pt; cursor: pointer;   
                            background-position: left; background-image: url(../images/Delete.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete" 
                                Width="55px" CausesValidation="False" 
                                onclientclick="return CheckUserSPVNotaryDelete();" />
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
                
            SelectCommand="SELECT '' AS BANKID, NULL AS BANKCODE, '[SELECT BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, BANKCODE + ' - ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
            </asp:SqlDataSource>
          
            <asp:SqlDataSource ID="sdsGridFee" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            SelectCommand="SELECT NOTARYID, FEEID, PRINCIPALFROM, PRINCIPALTO, NOTARYFEE, INTERNALFEE FROM NOTARYFEE WHERE (Deletests = 0) AND (NOTARYID = @NOTARYID) ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidNotaryID" Name="NOTARYID" 
                        PropertyName="Value" />
                </SelectParameters>
        </asp:SqlDataSource>
          
            </asp:View>
</asp:MultiView>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">

        FormatTable("<%=gvData.ClientID%>");
        FormatTable("<%=gvNotaryFee.ClientID%>");
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
            var row = getObjectbyClientID("rowNotaryID");
            if (row)
                row.style.display = "none";
        }

        function CheckUserSPVNotarySave() {
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

        function CheckUserSPVNotaryDelete() {
            var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
            if (RetVal.Login == 1)
                return (true);
            else
                return (false);
        }

</script>
</asp:Content>

