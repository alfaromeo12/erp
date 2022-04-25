<%@ Page Title="Param TP - Dealer Account Bank" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="DealerAccount.aspx.vb" Inherits="Param_DealerAccount" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="~/usercontrol/btncancel.ascx" TagPrefix="uc" TagName="BtnCancel" %>
<%@ Register Src="~/usercontrol/btninsert.ascx" TagPrefix="uc" TagName="BtnInsert" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
        
            <asp:HiddenField ID="hidREFUNDID" runat="server" />
        <asp:HiddenField ID="hidFinID" runat="server" />
    <asp:MultiView ID="MultiView_Utama" runat="server"> 
        <asp:view ID="View_View" runat="server" >
           <asp:Label ID="lblCommand" runat="server" Visible="False"></asp:Label>     
        <asp:Label ID="lblIndex" runat="server" Visible="False"></asp:Label>           
        <asp:Label ID="lblKey" runat="server" Visible="False"></asp:Label>  
         <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtSearchDealer"
        WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
    <asp:Panel ID="pnlShow1" runat="server" CssClass="ShowDetail">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow1" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShowl1" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="Button1" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" CollapseControlID="pnlShow1"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow1" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow1" TargetControlID="pnlSearchMaintenance" TextLabelID="lblShow1">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlSearchMaintenance" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px" class="RowStyle">
    <asp:DropDownList ID="ddlCriteriaDealer" runat="server">
        <asp:ListItem Value="DealerName">Dealer Name</asp:ListItem>
        <asp:ListItem Value="DealerCode">Dealer Code</asp:ListItem>
    </asp:DropDownList></td>
                <td class="RowStyle">
                    <asp:TextBox ID="txtSearchDealer" runat="server" CssClass="required"></asp:TextBox>
                    <asp:Button
        ID="btnFunctionDealer" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="AlternatingRowStyle">
                    Branch</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlBranchSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsBranchSearch" DataTextField="BRANCHNAME" 
                        DataValueField="BRANCHID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsBranchSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[ALL BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, '(' + BRANCHCODE + ') ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WHERE (Deletests = 0) ORDER BY BRANCHCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 115px" class="RowStyle">
                    Main Dealer</td>
                <td class="RowStyle">
                    <asp:DropDownList ID="ddlMainDealerSearch" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsMainDealerSearch" DataTextField="DEALERMAINNAME" 
                        DataValueField="DEALERMAINID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsMainDealerSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT NULL AS DEALERMAINID, NULL AS DEALERMAINCODE, '[ALL MAIN DEALER]' AS DEALERMAINNAME UNION ALL SELECT DEALERMAINID, DEALERMAINCODE, '(' + DEALERMAINCODE + ') ' + DEALERMAINNAME AS DEALERMAINNAME FROM DEALERMAIN WHERE (Deletests = 0) ORDER BY DEALERMAINCODE">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle" colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel ID="pnlDealer" runat="server">
        <asp:GridView ID="GvDealer" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="DEALERID" DataSourceID="sdsDealer" 
            Width="100%" Caption="Dealer List" RowHeaderColumn="DEALERCODE">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="btnViewDealerProduct" runat="server" 
                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                            CommandName="VIEW" Enabled="True" ImageAlign="AbsMiddle" 
                            ImageUrl="~/Images/Product.png" OnCommand="btnViewDealerProduct_Command" 
                            ToolTip="Dealer Product" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
               </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnViewDealerAcc" runat="server" ToolTip="Dealer Bank Account"
                            CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                            CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/Coin.gif" 
                            OnCommand="btnViewDealerAcc_Command" Enabled="True" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnViewDealerPerson" runat="server" ToolTip="Dealer Person"
                            CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                            CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/DealerPerson.png" 
                            OnCommand="btnViewDealerPerson_Command" Enabled="True" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="btnViewRefund" runat="server" 
                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                            CommandName="VIEW" Enabled="True" ImageAlign="AbsMiddle" 
                            ImageUrl="~/Images/refund.png" 
                            ToolTip="Dealer Refund (Compensation)" OnCommand="btnViewRefund_Command" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                 <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="btnViewFinStructure" runat="server" 
                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                            CommandName="VIEW" Enabled="True" ImageAlign="AbsMiddle" 
                            ImageUrl="~/Images/financeStructure.png" 
                            ToolTip="Finance Structure" OnCommand="btnViewFinStructure_Command" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:BoundField DataField="DEALERCODE" HeaderText="Dealer&lt;br&gt;Code" 
                    SortExpression="DEALERCODE" HtmlEncode="False" />
                <asp:BoundField DataField="DEALERNAME" HeaderText="Dealer&lt;br&gt;Name" 
                    SortExpression="DEALERNAME" HtmlEncode="False" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" 
                    SortExpression="BRANCHNAME" />
                <asp:BoundField DataField="ADDRESS" HeaderText="Address" 
                    SortExpression="ADDRESS" />
                <asp:BoundField DataField="CITYNAME" HeaderText="City" 
                    SortExpression="CITYNAME" HtmlEncode="False" />
                <asp:BoundField DataField="HEADDEALER" HeaderText="Head&lt;br&gt;Dealer" 
                    SortExpression="HEADDEALER" HtmlEncode="False" />
                <asp:BoundField DataField="PHONE" HeaderText="Phone" SortExpression="PHONE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsDealer" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                 SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID &lt;&gt; - 1)"></asp:SqlDataSource>
        </asp:view>
        <asp:View ID="View_DealerAccount" runat="server">   
           <asp:FormView ID="fvDealerInfo" runat="server" DataSourceID="sdsDealerInfo" 
                    Width="100%" DataKeyNames="BRANCHID" 
                Caption="Dealer Info for Dealer Bank Account">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 20%">
                                    Dealer ID</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtIDDealer" runat="server"  Text='<%# Eval("DEALERID") %>' 
                                        Font-Bold="True" Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Dealer Code</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtCodeDealer" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("DEALERCODE") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Dealer Name</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtNamaDealer" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("DEALERNAME") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Dealer Address</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtAreaDealer" runat="server" Font-Bold="True"
                                     Text='<%# Eval("ADDRESS") %>' Font-Underline="True"></asp:Label>
                                      <asp:HiddenField ID="hidDealer" runat="server" Value='<%# Bind("DEALERID") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
              </asp:FormView>
                 <asp:SqlDataSource ID="sdsDealerInfo" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                         SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID=@DEALERID)">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                             PropertyName="SelectedValue" />
                     </SelectParameters>
                    </asp:SqlDataSource>
        <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
		    WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
             <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
            <div style="float: right; vertical-align: middle">
                <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
                <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
            </div>
            <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
                    background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
             <ajaxToolkit:collapsiblepanelextender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
                ImageControlID="imgButtonShow" TargetControlID="pnlData" 
                TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
             <asp:Panel ID="pnlData" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                         <tr class="RowStyle">
                            <td style="width: 115px">
                                <asp:DropDownList ID="ddlCriteria" runat="server">
                                    <asp:ListItem Value="ACCBANKBRANCH">Bank Branch</asp:ListItem>
                                    <asp:ListItem Value="ACCNAME">Account Name</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                   <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                                    ID="btnFunctionSearch" runat="server" Text="Search" CausesValidation="False" CssClass="Search" />
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td style="width: 115px">
                                <asp:ImageButton ID="btnNew" runat="server" CausesValidation="False" 
                                    CommandName="New" Height="19px" ImageUrl="~/images/add.gif" />
                            </td>
                            <td>
                                     
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="gvData" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="DEALERACCOUNTID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Dealer Bank Account List" RowHeaderColumn="DEALERACCOUNTID" 
                        Height="19px">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif"><ItemStyle HorizontalAlign="Center" Width="2px" /></asp:CommandField>
                            <asp:BoundField DataField="DEALERACCOUNTID" HeaderText="ID" SortExpression="DEALERACCOUNTID" />
                            <asp:BoundField DataField="ACCBANKID" HeaderText="Bank" 
                                SortExpression="ACCBANKID" />
                            <asp:BoundField DataField="ACCBANKBRANCH" HeaderText="Bank&lt;br&gt;Branch" 
                                SortExpression="ACCBANKBRANCH" HtmlEncode="False" />
                            <asp:BoundField DataField="ACCNAME" HeaderText="Bank Account&lt;br&gt;Name" 
                                SortExpression="ACCNAME" HtmlEncode="False" />
                            <asp:BoundField DataField="ACCNO" HeaderText="Account&lt;br&gt;No."  
                                SortExpression="ACCNO" HtmlEncode="False" />
                            <asp:BoundField DataField="BANKACCSTATUSname" 
                                HeaderText="Account&lt;br&gt;Status" HtmlEncode="False" 
                                SortExpression="BANKACCSTATUSname" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
             <asp:Button ID="btnBackDealerAccount" runat="server" CausesValidation="False" 
                Style="font-size: 8pt; cursor: pointer;  background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                Text="Back" Width="55px" />
             <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
                
                SelectCommand="SELECT DA.DEALERACCOUNTID, DA.ACCBANKBRANCH, '(' + CAST(BK.BANKCODE AS VARCHAR(5)) + ') ' + BK.BANKNAME AS ACCBANKID, DA.ACCNAME, DA.ACCNO, '(' + CAST(DA.BANKACCSTATUS AS varchar(20)) + ') ' + dbo.f_getParamGlobalName('BANKACCSTATUS', DA.BANKACCSTATUS) AS BANKACCSTATUSname FROM DEALERACCOUNT AS DA WITH (NOLOCK) INNER JOIN BANK AS BK WITH (NOLOCK) ON BK.BANKID = DA.ACCBANKID WHERE (DA.Deletests = 0) AND (DA.DEALERID = @DEALERID)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                         PropertyName="SelectedValue" />
                 </SelectParameters>
        </asp:SqlDataSource>
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
                     
                     <asp:FormView ID="fvDealerAccBank" runat="server" DataSourceID="sdsDealerAccBank"
                            DefaultMode="Edit" Width="100%" DataKeyNames="DEALERACCOUNTID">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Dealer Acc ID</td>
                                        <td>
                                            <asp:Label ID="lblDealerID" runat="server" Font-Underline="True" 
                                                Text='<%# Bind("DEALERACCOUNTID") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    <tr>
					                    <td>
						                    Account Bank</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankID" runat="server" DataSourceID="sdsBank" 
							                    DataTextField="BANKNAME" DataValueField="BANKID" CssClass="required" 
							                    SelectedValue='<%# Bind("ACCBANKID") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqAccBankID" runat="server" 
							                    ControlToValidate="ddlBankID" Display="None" 
							                    ErrorMessage="Account BankID Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankID" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccBankID"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Bank Branch</td>
					                    <td>
						                    <asp:TextBox ID="txtAccBankBranch" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCBANKBRANCH") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccBankBranch" runat="server" 
							                    ControlToValidate="txtAccBankBranch" Display="None" 
							                    ErrorMessage="Account Bank Branch Name must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankBranch" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccBankBranch"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account No</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNo" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCNO") %>' Width="200px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNO" runat="server" 
							                    ControlToValidate="txtAccNo" Display="None" 
							                    ErrorMessage="Account Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccNO" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNO"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Name</td>
					                    <td>
						                    <asp:TextBox ID="txtAccName" runat="server" CssClass="required" MaxLength="50" 
							                    Text='<%# Bind("ACCNAME") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccName" runat="server" 
							                    ControlToValidate="txtAccName" Display="None" 
							                    ErrorMessage="Account Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccName" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccName"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Bank Account Status</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankAccStatus" runat="server" CssClass="required" 
							                    DataSourceID="sdsParamGlobal_BankSts" DataTextField="NAME" DataValueField="CODE" 
							                    SelectedValue='<%# Bind("BANKACCSTATUS") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqBankAccStatus" runat="server" 
							                    ControlToValidate="ddlBankAccStatus" Display="None" 
							                    ErrorMessage="Bank Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankAccStatus" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqBankAccStatus"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
                                   <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="FooterStyle" colspan="2">
                                            &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                                            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                            </EditItemTemplate>
                             <InsertItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     
                                    <tr>
					                    <td>
						                    Account Bank</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankID" runat="server" DataSourceID="sdsBank" 
							                    DataTextField="BANKNAME" DataValueField="BANKID" CssClass="required" 
							                    SelectedValue='<%# Bind("ACCBANKID") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqAccBankID" runat="server" 
							                    ControlToValidate="ddlBankID" Display="None" 
							                    ErrorMessage="Account BankID Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankID" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccBankID"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Bank Branch</td>
					                    <td>
						                    <asp:TextBox ID="txtAccBankBranch" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCBANKBRANCH") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccBankBranch" runat="server" 
							                    ControlToValidate="txtAccBankBranch" Display="None" 
							                    ErrorMessage="Account Bank Branch Name must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankBranch" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccBankBranch"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account No</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNo" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCNO") %>' Width="200px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNO" runat="server" 
							                    ControlToValidate="txtAccNo" Display="None" 
							                    ErrorMessage="Account Number must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccNO" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNO"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Name</td>
					                    <td>
						                    <asp:TextBox ID="txtAccName" runat="server" CssClass="required" MaxLength="50" 
							                    Text='<%# Bind("ACCNAME") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccName" runat="server" 
							                    ControlToValidate="txtAccName" Display="None" 
							                    ErrorMessage="Account Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccName" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccName"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Bank Account Status</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankAccStatus" runat="server" CssClass="required" 
							                    DataSourceID="sdsParamGlobal_BankSts" DataTextField="NAME" DataValueField="CODE" 
							                    SelectedValue='<%# Bind("BANKACCSTATUS") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqBankAccStatus" runat="server" 
							                    ControlToValidate="ddlBankAccStatus" Display="None" 
							                    ErrorMessage="Bank Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankAccStatus" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqBankAccStatus"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                      <tr>
                                        <td colspan="2" class="FooterStyle">
                                            <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>  
                           <asp:SqlDataSource ID="sdsDealerAccBank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT DA.DEALERACCOUNTID, '(' + DL.DEALERCODE + ') ' + DL.DEALERNAME AS DEALERNAME, DL.DEALERID, DA.ACCBANKBRANCH, '(' + CAST(DA.ACCBANKID AS VARCHAR(5)) + ') ' + BK.BANKNAME AS ACCBANK, DA.ACCBANKID, DA.ACCNAME, DA.ACCNO, DA.BANKACCSTATUS FROM DEALER AS DL WITH (NOLOCK) INNER JOIN DEALERACCOUNT AS DA WITH (NOLOCK) ON DL.DEALERID = DA.DEALERID INNER JOIN BANK AS BK WITH (NOLOCK) ON BK.BANKID = DA.ACCBANKID WHERE (DA.Deletests = 0) AND (DA.DEALERACCOUNTID = @DEALERACCOUNTID)" 
                    DeleteCommand="UPDATE DEALERACCOUNT SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  DEALERACCOUNTID=@DEALERACCOUNTID" 
                    UpdateCommand="DEALERACCOUNTUpdate" InsertCommand="DEALERACCOUNTAdd" 
                    InsertCommandType="StoredProcedure" 
                     UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="DEALERACCOUNTID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="DEALERACCOUNTID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="DEALERACCOUNTID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="ACCBANKID" Type="Int32" />  
                        <asp:Parameter Name="ACCBANKBRANCH" Type="String" />
                        <asp:Parameter Name="ACCNO" Type="String" />
                        <asp:Parameter Name="ACCNAME" Type="String" />
                        <asp:Parameter Name="BANKACCSTATUS" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="ACCBANKID" Type="Int32" />  
                        <asp:Parameter Name="ACCBANKBRANCH" Type="String" />
                        <asp:Parameter Name="ACCNO" Type="String" />
                        <asp:Parameter Name="ACCNAME" Type="String" />
                        <asp:Parameter Name="BANKACCSTATUS" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
               <asp:SqlDataSource ID="sdsBank" runat="server" 
		            ConnectionString="<%$ ConnectionStrings:connection %>" 
		            
                SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[SELECT BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, BANKCODE + ' - ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
	            </asp:SqlDataSource>   
                <asp:SqlDataSource ID="sdsParamGlobal_BankSts" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                SelectCommand="SELECT NULL AS CODE, '[SELECT BANK STATUS]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'BANKACCSTATUS')">
                </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="View_DealerPerson" runat="server">   
         <asp:FormView ID="fvDealerInfoPerson" runat="server" DataSourceID="sdsDealerInfo" 
                    Width="100%" DataKeyNames="DEALERID" 
                Caption="Dealer Info for Dealer Person">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 20%">
                                    Dealer ID</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtIDDealer" runat="server"  Text='<%# Eval("DEALERID") %>' 
                                        Font-Bold="True" Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Dealer Code</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtCodeDealer" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("DEALERCODE") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Dealer Name</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtNamaDealer" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("DEALERNAME") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Dealer Address</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtAreaDealer" runat="server" Font-Bold="True"
                                     Text='<%# Eval("ADDRESS") %>' Font-Underline="True"></asp:Label>
                                      <asp:HiddenField ID="hidDealer" runat="server" Value='<%# Bind("DEALERID") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
              </asp:FormView>
                 <asp:SqlDataSource ID="sdsDealerInfoPerson" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                         SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID=@DEALERID)">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                             PropertyName="SelectedValue" />
                     </SelectParameters>
                    </asp:SqlDataSource>
             <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtSearchPerson"
		    WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
             <asp:Panel ID="Panel3" runat="server" CssClass="ShowDetail">
            <div style="float: right; vertical-align: middle">
                <asp:Image ID="Image2" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
                <asp:Label ID="Label2" runat="server">(Show Details...)</asp:Label>
            </div>
            <input id="Button2" style="background-position: left top; width: 24px; cursor: pointer;
                    background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
             <ajaxToolkit:collapsiblepanelextender ID="Collapsiblepanelextender2" runat="server" CollapseControlID="pnlShow"
                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
                ImageControlID="imgButtonShow" TargetControlID="pnlData" 
                TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
             <asp:Panel ID="Panel4" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                         <tr class="RowStyle">
                            <td style="width: 115px">
                                <asp:DropDownList ID="ddlCriteriaPerson" runat="server">
                                    <asp:ListItem Value="PERSONNAME">Person Name</asp:ListItem>
                                    <asp:ListItem Value="PERSONTITLE">Person Title</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                   <asp:TextBox ID="txtSearchPerson" runat="server" CssClass="required"></asp:TextBox>
                                   <asp:Button
                                    ID="btnFunctionPerson" runat="server" Text="Search" CausesValidation="False" CssClass="Search" />
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td style="width: 115px">
                                <asp:ImageButton ID="imgBtnNewPerson" runat="server" CausesValidation="False" 
                                    CommandName="New" Height="19px" ImageUrl="~/images/add.gif" />
                            </td>
                            <td>
                                     
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="GvPerson" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="PERSONID" 
                            DataSourceID="sdsGridPerson" Width="100%" 
                        Caption="Dealer Person List" RowHeaderColumn="PERSONID">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif"><ItemStyle HorizontalAlign="Center" Width="2px" /></asp:CommandField>
                             <asp:TemplateField ShowHeader="False"><ItemTemplate><asp:ImageButton ID="btnViewDealerAccPerson" runat="server" ToolTip="Dealer Person Bank Account"
                                            CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                                CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/coin.gif" 
                                                OnCommand="btnViewDealerAccPerson_Command" Enabled="True" /></ItemTemplate><ItemStyle HorizontalAlign="Center" Width="25px" /></asp:TemplateField>
                            <asp:BoundField DataField="PERSONID" HeaderText="ID" SortExpression="PERSONID" />
                            <asp:BoundField DataField="PERSONNAME" HeaderText="Person&lt;br&gt;Name" 
                                SortExpression="PERSONNAME" HtmlEncode="False" />
                            <asp:BoundField DataField="PERSONTITLE" HeaderText="Person&lt;br&gt;Title" 
                                SortExpression="PERSONTITLE" HtmlEncode="False" />
                            <asp:BoundField DataField="IDNUMBER" HeaderText="ID&lt;br&gt;Number" 
                                SortExpression="IDNUMBER" HtmlEncode="False" />
                            <asp:BoundField DataField="IDADDRESS" HeaderText="Address" 
                                SortExpression="IDADDRESS" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            <asp:Label ID="lblErrorPerson" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
            <ajaxToolkit:AnimationExtender ID="ajaxAEMessagePerson" runat="server" TargetControlID="lblErrorPerson">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
            </asp:Panel>
             <asp:Button ID="BtnBackPerson" runat="server" CausesValidation="False" 
                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                Text="Back" Width="55px" />
             <asp:SqlDataSource ID="sdsGridPerson" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
                SelectCommand="SELECT DP.PERSONID, '(' + DP.PERSONTITLE + ') ' + PG.NAME AS PERSONTITLE, DP.PERSONNAME, DP.IDNUMBER, DP.IDADDRESS FROM DEALERPERSON AS DP WITH (NOLOCK) INNER JOIN (SELECT TYPE, CODE, NAME, LASTUSERID, LASTUPDATE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'PERSONTITLE')) AS PG ON PG.CODE = DP.PERSONTITLE WHERE (DP.Deletests = 0) AND (DP.DEALERID = @DEALERID)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                         PropertyName="SelectedValue" />
                 </SelectParameters>
        </asp:SqlDataSource>
         <asp:FormView ID="fvDealerPerson" runat="server" DataSourceID="sdsPerson"
                            DefaultMode="Edit" Width="100%" DataKeyNames="PERSONID" 
                Caption="Dealer Person">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Dealer Person ID</td>
                                        <td>
                                            <asp:Label ID="lblDealerID" runat="server" Font-Underline="True" 
                                                Text='<%# Bind("PERSONID") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
					                    <td>
						                   Person Title</td>
					                    <td>
						                    <asp:DropDownList ID="ddlPersonTitle" runat="server" DataSourceID="sdsPersonTitle" 
							                    DataTextField="NAME" DataValueField="CODE" CssClass="required" 
							                    SelectedValue='<%# Bind("PERSONTITLE") %>' CausesValidation="True" ValidationGroup="Person">
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqPersonTitle" runat="server" 
							                    ControlToValidate="ddlPersonTitle" Display="None" 
							                    ErrorMessage="PERSON TITLE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEPersonTitle" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPersonTitle"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Person Name</td>
					                    <td>
						                    <asp:TextBox ID="txtPersonName" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("PERSONNAME") %>' Width="240px" CausesValidation="True" 
                                                ValidationGroup="Person"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqPersonName" runat="server" 
							                    ControlToValidate="txtPersonName" Display="None" 
							                    ErrorMessage="PERSON NAME must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEPersonName" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqPersonName"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    ID Number</td>
					                    <td>
						                    <asp:TextBox ID="txtIdNumber" runat="server" 
							                    MaxLength="50" Text='<%# Bind("IDNUMBER") %>' Width="200px"></asp:TextBox>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Address</td>
					                    <td>
						                    <asp:TextBox ID="txtIdAddress" runat="server" MaxLength="100" TextMode="MultiLine"
							                    Text='<%# Bind("IDADDRESS") %>' Width="240px" Rows="2"></asp:TextBox>
						                   
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Kelurahan</td>
					                    <td>
						                    <asp:TextBox ID="txtIdKelurahan" runat="server" MaxLength="50" 
							                    Text='<%# Bind("IDKELURAHAN") %>' Width="200px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                     <tr>
					                    <td>
						                    City</td>
					                    <td>
						                    <asp:TextBox ID="txtIdCity" runat="server" MaxLength="50" 
							                    Text='<%# Bind("IDCITY") %>' Width="200px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                     <tr>
					                    <td>
						                    ZIP</td>
					                    <td>
						                    <asp:TextBox ID="txtIdZIP" runat="server" MaxLength="10" 
							                    Text='<%# Bind("IDZIP") %>' Width="100px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                       <tr>
					                    <td>
						                    PHONE AREA</td>
					                    <td>
						                    <asp:TextBox ID="txtPhoneArea" runat="server" MaxLength="5" 
							                    Text='<%# Bind("PHONEAREA") %>' Width="50px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                       <tr>
					                    <td>
						                    PHONE NO</td>
					                    <td>
						                    <asp:TextBox ID="txtPhoneNo" runat="server"  MaxLength="20" 
							                    Text='<%# Bind("PHONENO") %>' Width="240px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                       <tr>
					                    <td>
						                    MOBILE NO</td>
					                    <td>
						                    <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="30" 
							                    Text='<%# Bind("MOBILENO") %>' Width="240px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                   <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="FooterStyle" colspan="2">
                                            &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                                            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                            </EditItemTemplate>
                             <InsertItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                       <tr>
					                    <td>
						                   Person Title</td>
					                    <td>
						                    <asp:DropDownList ID="ddlPersonTitle" runat="server" DataSourceID="sdsPersonTitle" 
							                    DataTextField="NAME" DataValueField="CODE" CssClass="required" 
							                    SelectedValue='<%# Bind("PERSONTITLE") %>' CausesValidation="True" ValidationGroup="Person">
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqPersonTitle" runat="server" 
							                    ControlToValidate="ddlPersonTitle" Display="None" 
							                    ErrorMessage="PERSON TITLE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEPersonTitle" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPersonTitle"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Person Name</td>
					                    <td>
						                    <asp:TextBox ID="txtPersonName" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("PERSONNAME") %>' Width="240px" CausesValidation="True" 
                                                ValidationGroup="Person"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqPersonName" runat="server" 
							                    ControlToValidate="txtPersonName" Display="None" 
							                    ErrorMessage="PERSON NAME must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="reqVCEPersonName" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqPersonName"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    ID Number</td>
					                    <td>
						                    <asp:TextBox ID="txtIdNumber" runat="server" 
							                    MaxLength="50" Text='<%# Bind("IDNUMBER") %>' Width="200px"></asp:TextBox>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Address</td>
					                    <td>
						                    <asp:TextBox ID="txtIdAddress" runat="server" MaxLength="100" TextMode="multiline"
							                    Text='<%# Bind("IDADDRESS") %>' Width="240px" Rows="2"></asp:TextBox>
						                   
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Kelurahan</td>
					                    <td>
						                    <asp:TextBox ID="txtIdKelurahan" runat="server" MaxLength="50" 
							                    Text='<%# Bind("IDKELURAHAN") %>' Width="200px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                     <tr>
					                    <td>
						                    City</td>
					                    <td>
						                    <asp:TextBox ID="txtIdCity" runat="server" MaxLength="50" 
							                    Text='<%# Bind("IDCITY") %>' Width="200px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                     <tr>
					                    <td>
						                    ZIP</td>
					                    <td>
						                    <asp:TextBox ID="txtIdZIP" runat="server" MaxLength="10" 
							                    Text='<%# Bind("IDZIP") %>' Width="100px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                       <tr>
					                    <td>
						                    PHONE AREA</td>
					                    <td>
						                    <asp:TextBox ID="txtPhoneArea" runat="server" MaxLength="5" 
							                    Text='<%# Bind("PHONEAREA") %>' Width="50px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                       <tr>
					                    <td>
						                    PHONE NO</td>
					                    <td>
						                    <asp:TextBox ID="txtPhoneNo" runat="server"  MaxLength="20" 
							                    Text='<%# Bind("PHONENO") %>' Width="240px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                       <tr>
					                    <td>
						                    MOBILE NO</td>
					                    <td>
						                    <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="30" 
							                    Text='<%# Bind("MOBILENO") %>' Width="240px"></asp:TextBox>
						                
					                    </td>
				                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                      <tr>
                                        <td colspan="2" class="FooterStyle">
                                            <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>  
                <asp:SqlDataSource ID="sdsPerson" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT DP.PERSONID, '(' + DL.DEALERCODE + ') ' + DL.DEALERNAME AS DEALERNAME, DP.PERSONTITLE, DP.PERSONNAME, DP.IDNUMBER, DP.IDADDRESS, DP.IDKELURAHAN,DP.IDCITY, DP.IDZIP, DP.MOBILENO, DP.PHONEAREA, DP.PHONENO FROM DEALER AS DL INNER JOIN DEALERPERSON AS DP ON DL.DEALERID = DP.DEALERID WHERE (DL.Deletests = 0) AND (DP.Deletests = 0) AND (DP.PERSONID = @PERSONID)" 
                    DeleteCommand="UPDATE DEALERPERSON SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  PERSONID=@PERSONID" 
                    UpdateCommand="DEALERPERSONUpdate" InsertCommand="DEALERPERSONAdd" 
                    InsertCommandType="StoredProcedure" 
                     UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GvPerson" Name="PERSONID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="PERSONID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="PERSONID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="PERSONTITLE" Type="String" />  
                        <asp:Parameter Name="PERSONNAME" Type="String" />
                        <asp:Parameter Name="IDNUMBER" Type="String" />
                        <asp:Parameter Name="IDADDRESS" Type="String" />
                        <asp:Parameter Name="IDKELURAHAN" Type="String" />
                        <asp:Parameter Name="IDCITY" Type="String" />
                        <asp:Parameter Name="IDZIP" Type="String" />
                        <asp:Parameter Name="PHONEAREA" Type="String" />
                        <asp:Parameter Name="PHONENO" Type="String" />
                        <asp:Parameter Name="MOBILENO" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="PERSONTITLE" Type="String" />  
                        <asp:Parameter Name="PERSONNAME" Type="String" />
                        <asp:Parameter Name="IDNUMBER" Type="String" />
                        <asp:Parameter Name="IDADDRESS" Type="String" />
                        <asp:Parameter Name="IDKELURAHAN" Type="String" />
                        <asp:Parameter Name="IDCITY" Type="String" />
                        <asp:Parameter Name="IDZIP" Type="String" />
                        <asp:Parameter Name="PHONEAREA" Type="String" />
                        <asp:Parameter Name="PHONENO" Type="String" />
                        <asp:Parameter Name="MOBILENO" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsPersonTitle" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                SelectCommand="SELECT NULL AS CODE, '[SELECT PERSON TITLE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'PERSONTITLE')">
                </asp:SqlDataSource>
        </asp:View>
          <asp:View ID="ViewDealerPersonBank" runat="server">   
           <asp:FormView ID="fvDealerPersonBank" runat="server" DataSourceID="sdsDealerPersonBankInfo" 
                    Width="100%" DataKeyNames="DEALERID" Caption="Dealer Person Info">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 20%">
                                    Dealer Name</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtIDDealer" runat="server"  Text='<%# Bind("DEALERNAME") %>' 
                                        Font-Bold="True" Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Person Code</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtPersonID" runat="server" Font-Bold="True" 
                                        Text='<%# Bind("PERSONID") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Person Name</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtNamaDealer" runat="server" Font-Bold="True" 
                                        Text='<%# Bind("PERSONNAME") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    Person Title</td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtAreaDealer" runat="server" Font-Bold="True"
                                     Text='<%# Bind("PERSONTITLE") %>' Font-Underline="True"></asp:Label>
                                    
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
              </asp:FormView>
               <asp:HiddenField ID="hidPersonACC" runat="server"
                                        Value='<%# Bind("PERSONID") %>' />
                 <asp:SqlDataSource ID="sdsDealerPersonBankInfo" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                         
                  
                  SelectCommand="SELECT DP.DEALERID, '(' + CAST(DL.DEALERCODE AS VARCHAR(10)) + ') ' + DL.DEALERNAME AS DEALERNAME, DP.PERSONID, '(' + DP.PERSONTITLE + ') ' + PT.NAME AS PERSONTITLE, DP.PERSONNAME AS PERSONNAME FROM DEALERPERSON AS DP INNER JOIN DEALER AS DL ON DL.DEALERID = DP.DEALERID INNER JOIN (SELECT TYPE, CODE, NAME, LASTUSERID, LASTUPDATE FROM PARAMGLOBAL WHERE (TYPE = 'PERSONTITLE')) AS PT ON PT.CODE = DP.PERSONTITLE WHERE (DP.PERSONID = @PERSONID) AND (DP.Deletests = 0) AND (DL.Deletests = 0)">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="hidPersonACC" Name="PERSONID" 
                             PropertyName="Value" />
                     </SelectParameters>
                    </asp:SqlDataSource>
                     <ajaxToolkit:TextBoxWatermarkExtender ID="txtWEPersonACC" runat="server" TargetControlID="txtCriteriaPersonACC"
		    WatermarkText="%%"></ajaxToolkit:TextBoxWatermarkExtender>
             <asp:Panel ID="Panel5" runat="server" CssClass="ShowDetail">
            <div style="float: right; vertical-align: middle">
                <asp:Image ID="Image3" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
                <asp:Label ID="Label3" runat="server">(Show Details...)</asp:Label>
            </div>
            <input id="Button3" style="background-position: left top; width: 24px; cursor: pointer;
                    background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
             <ajaxToolkit:collapsiblepanelextender ID="Collapsiblepanelextender3" runat="server" CollapseControlID="pnlShow"
                CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
                ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
                ImageControlID="imgButtonShow" TargetControlID="pnlData" 
                TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
            <asp:Panel ID="Panel6" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                         <tr class="RowStyle">
                            <td style="width: 115px">
                                <asp:DropDownList ID="ddlCriteriaPersonAcc" runat="server">
                                    <asp:ListItem Value="PERSONNAME">Person Name</asp:ListItem>
                                    <asp:ListItem Value="ACCOUNTBRANCH">Account Branch</asp:ListItem>
                                    <asp:ListItem Value="ACCOUNTNAME">Account Name</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                   <asp:TextBox ID="txtCriteriaPersonACC" runat="server" CssClass="required"></asp:TextBox>
                                   <asp:Button
                                    ID="btnFunctionSearchPersonACC" runat="server" Text="Search" CausesValidation="False" CssClass="Search" />
                            </td>
                        </tr>
                        <tr class="AlternatingRowStyle">
                            <td style="width: 115px">
                                <asp:ImageButton ID="imgBtnNewPersonACC" runat="server" 
                                    CausesValidation="False" CommandName="New" ImageUrl="~/images/add.gif" />
                            </td>
                            <td>
                                     
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="GvPersonACC" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="PERSONACCOUNTID" 
                            DataSourceID="sdsGridPersonACC" Width="100%" 
                        Caption="Dealer Person Bank Account List" 
                        RowHeaderColumn="PERSONACCOUNTID">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif"><ItemStyle HorizontalAlign="Center" Width="2px" /></asp:CommandField>
                            <asp:BoundField DataField="PERSONACCOUNTID" HeaderText="ID" SortExpression="PERSONACCOUNTID" />
                            <asp:BoundField DataField="PERSONNAME" HeaderText="Person&lt;br&gt;Name" 
                                SortExpression="PERSONNAME" HtmlEncode="False" />
                            <asp:BoundField DataField="BANKID" HeaderText="Bank" SortExpression="BANKID" />
                            <asp:BoundField DataField="ACCOUNTBRANCH" HeaderText="Bank&lt;br&gt;Branch" 
                                SortExpression="ACCOUNTBRANCH" HtmlEncode="False" />
                            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                                SortExpression="ACCOUNTNAME" HtmlEncode="False" />
                            <asp:BoundField DataField="ACCOUNTNO" HeaderText="Bank&lt;br&gt;Account No."  
                                SortExpression="ACCOUNTNO" HtmlEncode="False" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
              <asp:Button ID="BtnBackPersonACC" runat="server" CausesValidation="False" 
                  Style="font-size: 8pt; cursor: pointer;  background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                  Text="Back" ValidationGroup="Collector" Width="55px" />
             <asp:SqlDataSource ID="sdsGridPersonACC" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                  
                  SelectCommand="SELECT DEALERPERSONACCOUNT.PERSONACCOUNTID, DEALERPERSON.PERSONNAME AS PERSONNAME, DEALERPERSONACCOUNT.ACCOUNTBRANCH, '(' + CAST(BANK.BANKCODE AS VARCHAR(5)) + ') ' + BANK.BANKNAME AS BANKID, DEALERPERSONACCOUNT.ACCOUNTNAME, DEALERPERSONACCOUNT.ACCOUNTNO FROM DEALERPERSONACCOUNT INNER JOIN DEALERPERSON ON DEALERPERSONACCOUNT.PERSONID = DEALERPERSON.PERSONID INNER JOIN BANK ON BANK.BANKID = DEALERPERSONACCOUNT.BANKID WHERE (DEALERPERSON.Deletests = 0) AND (DEALERPERSONACCOUNT.Deletests = 0) AND (DEALERPERSONACCOUNT.PERSONID = @PERSONID)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="hidPersonACC" Name="PERSONID" 
                         PropertyName="Value" />
                 </SelectParameters>
            </asp:SqlDataSource>
               <asp:Label ID="lblErrorPersonACC" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
               <ajaxToolkit:AnimationExtender ID="ajaxAEMessagePersonAcc" runat="server" TargetControlID="lblErrorPersonACC">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                     <asp:FormView ID="fvPersonACC" runat="server" DataSourceID="sdsAccPersonBank"
                            DefaultMode="Edit" Width="100%" DataKeyNames="PERSONACCOUNTID">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Person ID</td>
                                        <td>
                                            <asp:Label ID="lblIDPersonACC" runat="server" Font-Underline="True" 
                                                Text='<%# Bind("PERSONACCOUNTID") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    <tr>
					                    <td>
						                    Account Bank</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankIDPersonACC" runat="server" DataSourceID="sdsBank" 
							                    DataTextField="BANKNAME" DataValueField="BANKID" 
							                    SelectedValue='<%# Bind("BANKID") %>' CssClass="required" >
						                    </asp:DropDownList>

						                    <asp:RequiredFieldValidator ID="reqAccBankIDPersonACC" runat="server" 
							                    ControlToValidate="ddlBankIDPersonACC" Display="None" 
							                    ErrorMessage="Account BankID Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccBankIDPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Bank Branch</td>
					                    <td>
						                    <asp:TextBox ID="txtBranchPersonACC" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCOUNTBRANCH") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccBankBranchPersonACC" runat="server" 
							                    ControlToValidate="txtBranchPersonACC" Display="None" 
							                    ErrorMessage="Account Bank Branch Name must be entry...!" 
							                    SetFocusOnError="True" ></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBranchPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccBankBranchPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account No</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNoPersonACC" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCOUNTNO") %>' Width="200px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNoPersonACC" runat="server" 
							                    ControlToValidate="txtAccNoPersonACC" Display="None" 
							                    ErrorMessage="Account Number must be entry...!" SetFocusOnError="True" 
                                                ></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccNoPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNoPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Name</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNamePersonACC" runat="server" CssClass="required" MaxLength="50" 
							                    Text='<%# Bind("ACCOUNTNAME") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNamePersonACC" runat="server" 
							                    ControlToValidate="txtAccNamePersonACC" Display="None" 
							                    ErrorMessage="Account Name must be entry...!" SetFocusOnError="True" 
                                               ></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccNmPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNamePersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Bank Status</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankStatusPersonACC" runat="server" CssClass="required" 
							                    DataSourceID="sdsParamGlobal_BankSts" DataTextField="NAME" DataValueField="CODE" 
							                    SelectedValue='<%# Bind("BANKACCSTATUS") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqBankAccStatusPersonACC" runat="server" 
							                    ControlToValidate="ddlBankStatusPersonACC" Display="None" 
							                    ErrorMessage="Bank Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankStsPerson" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqBankAccStatusPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
                                   <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="FooterStyle" colspan="2">
                                            &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                                            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                            </EditItemTemplate>
                             <InsertItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                     
                                     <tr>
					                    <td>
						                    Account Bank</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankIDPersonACC" runat="server" DataSourceID="sdsBank" 
							                    DataTextField="BANKNAME" DataValueField="BANKID" CssClass="required" 
							                    SelectedValue='<%# Bind("BANKID") %>' >
						                    </asp:DropDownList>

						                    <asp:RequiredFieldValidator ID="reqAccBankIDPersonACC" runat="server" 
							                    ControlToValidate="ddlBankIDPersonACC" Display="None" 
							                    ErrorMessage="Account BankID Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccBankIDPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Bank Branch</td>
					                    <td>
						                    <asp:TextBox ID="txtBranchPersonACC" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCOUNTBRANCH") %>' Width="240px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccBankBranchPersonACC" runat="server" 
							                    ControlToValidate="txtBranchPersonACC" Display="None" 
							                    ErrorMessage="Account Bank Branch Name must be entry...!" 
							                    SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBranchPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccBankBranchPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account No</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNoPersonACC" runat="server" CssClass="required" 
							                    MaxLength="50" Text='<%# Bind("ACCOUNTNO") %>' Width="200px"></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNoPersonACC" runat="server" 
							                    ControlToValidate="txtAccNoPersonACC" Display="None" 
							                    ErrorMessage="Account Number must be entry...!" SetFocusOnError="True" 
                                               ></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccNoPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNoPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Account Name</td>
					                    <td>
						                    <asp:TextBox ID="txtAccNamePersonACC" runat="server" CssClass="required" MaxLength="50" 
							                    Text='<%# Bind("ACCOUNTNAME") %>' Width="240px" ></asp:TextBox>
						                    <asp:RequiredFieldValidator ID="reqAccNamePersonACC" runat="server" 
							                    ControlToValidate="txtAccNamePersonACC" Display="None" 
							                    ErrorMessage="Account Name must be entry...!" SetFocusOnError="True" ></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEAccNmPersonACC" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqAccNamePersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
				                    <tr>
					                    <td>
						                    Bank Status</td>
					                    <td>
						                    <asp:DropDownList ID="ddlBankStatusPersonACC" runat="server" CssClass="required" 
							                    DataSourceID="sdsParamGlobal_BankSts" DataTextField="NAME" DataValueField="CODE" 
							                    SelectedValue='<%# Bind("BANKACCSTATUS") %>'>
						                    </asp:DropDownList>
						                    <asp:RequiredFieldValidator ID="reqBankAccStatusPersonACC" runat="server" 
							                    ControlToValidate="ddlBankStatusPersonACC" Display="None" 
							                    ErrorMessage="Bank Status must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
						                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEBankStsPerson" 
							                    runat="server" HighlightCssClass="ErrHighLight" 
							                    TargetControlID="reqBankAccStatusPersonACC"></ajaxToolkit:ValidatorCalloutExtender>
					                    </td>
				                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                      <tr>
                                        <td colspan="2" class="FooterStyle">
                                            <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>  
                        <asp:SqlDataSource ID="sdsAccPersonBank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                            SelectCommand="SELECT DEALERPERSONACCOUNT.PERSONACCOUNTID, DEALERPERSONACCOUNT.BANKID,DEALERPERSONACCOUNT.ACCOUNTBRANCH,		DEALERPERSONACCOUNT.ACCOUNTNO,DEALERPERSONACCOUNT.ACCOUNTNAME,DEALERPERSONACCOUNT.BANKACCSTATUS
                                                FROM DEALERPERSONACCOUNT 
                                                INNER JOIN DEALERPERSON  ON DEALERPERSONACCOUNT.PERSONID=DEALERPERSON.PERSONID
                                                INNER JOIN BANK ON BANK.BANKID=DEALERPERSONACCOUNT.BANKID
                                                WHERE  DEALERPERSON.Deletests=0 AND DEALERPERSONACCOUNT.Deletests=0  AND  DEALERPERSONACCOUNT.PERSONACCOUNTID=@PERSONACCOUNTID" 
                            DeleteCommand="UPDATE DEALERPERSONACCOUNT SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  PERSONACCOUNTID=@PERSONACCOUNTID" 
                            UpdateCommand="DEALERPERSONACCOUNTUpdate" InsertCommand="DEALERPERSONACCOUNTAdd" 
                            InsertCommandType="StoredProcedure" 
                             UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GvPersonACC" Name="PERSONACCOUNTID" 
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:CookieParameter CookieName="UID" Name="UserID" />
                                <asp:ControlParameter ControlID="GvPersonACC" Name="PERSONACCOUNTID" 
                                    PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:ControlParameter ControlID="hidPersonACC" Name="PERSONID" 
                                    PropertyName="Value" Type="Int32" />
                                <asp:Parameter Name="PERSONACCOUNTID" Type="Int32" />
                                <asp:Parameter Name="BANKID" Type="Int32" />  
                                <asp:Parameter Name="ACCOUNTBRANCH" Type="String" />
                                <asp:Parameter Name="ACCOUNTNO" Type="String" />
                                <asp:Parameter Name="ACCOUNTNAME" Type="String" />
                                <asp:Parameter Name="BANKACCSTATUS" Type="Int32" />
                                <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hidPersonACC" Name="PERSONID" 
                                    PropertyName="Value" Type="Int32" />
                                <asp:Parameter Name="BANKID" Type="Int32" />  
                                <asp:Parameter Name="ACCOUNTBRANCH" Type="String" />
                                <asp:Parameter Name="ACCOUNTNO" Type="String" />
                                <asp:Parameter Name="ACCOUNTNAME" Type="String" />
                                <asp:Parameter Name="BANKACCSTATUS" Type="Int32" />
                                <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                            </InsertParameters>
                        </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="ViewDealerRefund" runat="server">
            <asp:FormView ID="fvDealerInfoRefund" runat="server" 
                Caption="Dealer Info for Dealer Refund (Compensation)" DataKeyNames="DEALERID" 
                DataSourceID="sdsDealerInfoRefund" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="LblKodeCabang0" runat="server" Font-Bold="False" 
                                    Font-Underline="False" Text="ID :"></asp:Label>
                            </td>
                            <td style="width: 80%">
                                <asp:Label ID="txtIDDealer0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERID") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="lblCodeCabang0" runat="server" Font-Bold="False" 
                                    Font-Underline="False" Text="Dealer Code :"></asp:Label>
                            </td>
                            <td style="width: 80%">
                                <asp:Label ID="txtCodeDealer0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERCODE") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="lblNamaCabang0" runat="server" Font-Bold="False" 
                                    Font-Underline="False" Text="Dealer Name :"></asp:Label>
                            </td>
                            <td style="width: 80%">
                                <asp:Label ID="txtNamaDealer0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="Label4" runat="server" Font-Bold="False" Font-Underline="False" 
                                    Text="Dealer Area :"></asp:Label>
                            </td>
                            <td style="width: 80%">
                                <asp:Label ID="txtAreaDealer0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ADDRESS") %>'></asp:Label>
                                <asp:HiddenField ID="hidDealer0" runat="server" 
                                    Value='<%# Bind("DEALERID") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sdsDealerInfoRefund" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID=@DEALERID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:DataList ID="dlDealerProduct" runat="server" Caption="DEALER REFUND" 
                DataKeyField="PRODUCTID" DataSourceID="sdsDealerProduct" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:100%;">
                        <tr>
                            <td class="ShowDetail">
                                Product Code:&nbsp;
                                <asp:Label ID="PRODUCTCODELabel" runat="server" 
                                    Text='<%# Eval("PRODUCTCODE") %>' />
                                &nbsp;Product Name:
                                <asp:Label ID="PRODUCTNAMELabel" runat="server" 
                                    Text='<%# Eval("PRODUCTNAME") %>' />
                                <asp:HiddenField ID="hidProductID" runat="server" 
                                    Value='<%# Eval("PRODUCTID") %>' />
                                <asp:HiddenField ID="hidDEALERID" runat="server" 
                                    Value='<%# Eval("DEALERID") %>' />
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="gvDealerProduct" runat="server" AutoGenerateColumns="False" 
                        Caption="Refund/Compensation Detail" DataKeyNames="REFUNDID" 
                        DataSourceID="sdsRefund" Width="100%"  >
                        <Columns>
                            <asp:TemplateField>
                            <ItemTemplate><asp:ImageButton ID="btnViewRefundDtl" runat="server" 
                                        CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                                        CommandName="VIEW" Enabled="True" ImageAlign="AbsMiddle" 
                                        ImageUrl="~/Images/refunddetail.png" 
                                        ToolTip="Dealer Refund (Compensation)" 
                                        OnCommand="btnViewRefundDtl_Command" 
                                        onclientclick='<%# "return CheckRefund(" & Eval("REFUNDID") & ");" %>' />
                            <asp:HiddenField ID="hidRefundCategory" runat="server" 
                                        Value='<%# Eval("REFUNDCATEGORY") %>' />
                           
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="REFUNDCATEGORYNAME" 
                                HeaderText="Refund&lt;br&gt;Category" HtmlEncode="False" ReadOnly="True" 
                                SortExpression="REFUNDCATEGORYNAME" />
                            <asp:TemplateField HeaderText="Refund&lt;br&gt;Type" 
                                SortExpression="REFUNDTYPENAME"><ItemTemplate><asp:RadioButton ID="rbAmount" runat="server" GroupName="TYPE"
                                        Text="Amount" ValidationGroup="rbRefundType" 
                                        Enabled='<%# Eval("ENABLEREFUNDTYPE") %>'
                                         Checked='<%# IIF(Eval("REFUNDTYPE")="2",TRUE,FALSE) %>'/><asp:RadioButton ID="rbPercentage" runat="server"  GroupName="TYPE"
                                        Checked='<%# IIF(Eval("REFUNDTYPE")="1",TRUE,FALSE) %>' Text="Percentage" 
                                        ValidationGroup="rbRefundType" /></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Refund" SortExpression="REFUND"><ItemTemplate><asp:TextBox ID="txtRefund" runat="server" style="text-align: right" CssClass="required"
                                        Text='<%# Bind("REFUND", "{0:N}") %>'></asp:TextBox><asp:RequiredFieldValidator ID="reqRefund" runat="server" 
							            ControlToValidate="txtRefund" Display="None" 
							            ErrorMessage="Refund must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender ID="VCERefund" 
							            runat="server" HighlightCssClass="ErrHighLight" 
							            TargetControlID="reqRefund"></ajaxToolkit:ValidatorCalloutExtender></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Shared?" SortExpression="SHARESTS"><ItemTemplate><asp:CheckBox ID="chShared" runat="server" Checked='<%# Bind("SHARESTS") %>' /></ItemTemplate><ItemStyle HorizontalAlign="Center" /></asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsRefund" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        SelectCommand="SELECT REFUNDID, REFUNDCATEGORY, REFUNDCATEGORYNAME, REFUNDTYPE, REFUNDTYPENAME, REFUND, SHARESTS, CAST(CASE WHEN REFUNDCATEGORY = 2 THEN 1 ELSE 0 END AS BIT) AS ENABLEREFUNDTYPE, CAST(CASE WHEN REFUNDTYPE = 1 THEN 1 ELSE 0 END AS BIT) AS PCTCHECK, CAST(CASE WHEN REFUNDTYPE = 2 THEN 1 ELSE 0 END AS BIT) AS AMTCHECK FROM (SELECT REFUNDID, REFUNDCATEGORY, dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUNDCATEGORY) AS REFUNDCATEGORYNAME, REFUNDTYPE, dbo.f_getParamGlobalName('REFUNDTYPE', REFUNDTYPE) AS REFUNDTYPENAME, REFUND, SHARESTS FROM REFUND WITH (NOLOCK) WHERE (DEALERID = @DEALERID) AND (PRODUCTID = @PRODUCTID) AND (Deletests = 0) AND EXISTS (SELECT 'X' AS Expr1 FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'REFUNDCATEGORY') AND (CODE IN ('1', '2', '3')) AND (CODE = REFUND.REFUNDCATEGORY)) UNION ALL SELECT 0 AS REFUNDID, CODE AS REFUNDCATEGORY, NAME AS REFUNDCATEGORYNAME, 1 AS REFUNDTYPE, dbo.f_getParamGlobalName('REFUNDTYPE', 1) AS REFUNDTYPENAME, 0 AS REFUND, CAST(0 AS BIT) AS SHARESTS FROM PARAMGLOBAL AS PARAMGLOBAL_1 WITH (NOLOCK) WHERE (TYPE = 'REFUNDCATEGORY') AND (CODE IN ('1', '2', '3')) AND (NOT EXISTS (SELECT 'X' AS EXPR1 FROM REFUND AS REFUND_1 WITH (NOLOCK) WHERE (DEALERID = @DEALERID) AND (PRODUCTID = @PRODUCTID) AND (Deletests = 0) AND (REFUNDCATEGORY = PARAMGLOBAL_1.CODE)))) AS A ORDER BY REFUNDCATEGORY">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidDEALERID" Name="DEALERID" 
                                PropertyName="Value" />
                            <asp:ControlParameter ControlID="hidProductID" DefaultValue="" 
                                Name="PRODUCTID" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                </ItemTemplate>
                <SeparatorTemplate>
                    <hr />
                </SeparatorTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="sdsDealerProduct" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                SelectCommand="SELECT DEALERPRODUCT.DEALERID, PRODUCT.PRODUCTID, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME FROM DEALERPRODUCT WITH (NOLOCK) INNER JOIN PRODUCT WITH (NOLOCK) ON DEALERPRODUCT.PRODUCTID = PRODUCT.PRODUCTID WHERE (DEALERPRODUCT.DEALERID = @DEALERID) AND (DEALERPRODUCT.Deletests = 0)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>

             <br />
            <br />
            <br />
            <br />

             <br />
        

             <asp:Panel ID="pnlControlRefund" runat="server" CssClass="HeaderStyle" 
            Style="border-right: thin inset; 
		            border-top: thin inset; border-left: thin inset; border-bottom: thin inset" 
            Width="100%" Visible="true" >
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <asp:Label ID="lblMessageRefund" runat="server" CssClass="ErrHighLight" Font-Size="Large"
                                    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                    Visible="False" Width="100%"></asp:Label>
                    </tr>
			        <tr>
				        <td>
                          
                            <asp:Button ID="btnSaveRefund" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" OnClientClick="return CheckUserSPVDlrRefund();" />
                          
                            <asp:Button ID="BtnBackRefund" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Back" ValidationGroup="Collector" Width="55px" />
                        </td>
			        </tr>
                </table>
            </asp:Panel>
          
            <ajaxToolkit:AlwaysVisibleControlExtender ID="AlwaysVisibleControlExtender1" runat="server" 
                TargetControlID="pnlControlRefund" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>

       
        </asp:View>
        <asp:View ID="ViewDealerProduct" runat="server">
            <asp:FormView ID="fvDealerInfoProduct" runat="server" 
                Caption="Dealer Info for Dealer Product" DataKeyNames="DEALERID" 
                DataSourceID="sdsDealerInfoProduct" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 20%">
                                Dealer ID</td>
                            <td style="width: 80%">
                                <asp:Label ID="txtIDDealer1" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERID") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                Dealer Code</td>
                            <td style="width: 80%">
                                <asp:Label ID="txtCodeDealer1" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERCODE") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                Dealer Name</td>
                            <td style="width: 80%">
                                <asp:Label ID="txtNamaDealer1" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                Dealer Address</td>
                            <td style="width: 80%">
                                <asp:Label ID="txtAreaDealer1" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ADDRESS") %>'></asp:Label>
                                <asp:HiddenField ID="hidDealer1" runat="server" 
                                    Value='<%# Bind("DEALERID") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sdsDealerInfoProduct" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID=@DEALERID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:UpdatePanel ID="UpdListBox" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th class="HeaderStyle" colspan="3">
                                DEALER PRODUCT</th>
                        </tr>
                        <tr style="vertical-align: middle">
                            <td style="text-align: right">
                                <asp:ListBox ID="lvProductSrc" Runat="server" DataSourceID="sdsProductSrc" 
                                    DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" Height="150px" Rows="10" 
                                    SelectionMode="Multiple" Width="250px" />
                                <asp:SqlDataSource ID="sdsProductSrc" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    
                                    SelectCommand="SELECT PRODUCTID, '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WITH (NOLOCK) WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALERPRODUCT WHERE (Deletests = 0) AND (PRODUCT.PRODUCTID = PRODUCTID) AND (DEALERID = @DEALERID))) ORDER BY PRODUCTCODE">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <td style="vertical-align: middle; text-align: center;" width="20px">
                                <p>
                                    <asp:Button ID="btnRight" runat="server" Text="&gt;&gt;" />
                                    <asp:Button ID="btnLeft" runat="server" Text="&lt;&lt;" />
                                </p>
                            </td>
                            <td>
                                <asp:ListBox ID="lvbProductDest" runat="server" DataSourceID="sdsProductDest" 
                                    DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" Height="150px" 
                                    SelectionMode="Multiple" width="250px" />
                                <asp:SqlDataSource ID="sdsProductDest" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    
                                    SelectCommand="SELECT PRODUCT.PRODUCTID, '(' + PRODUCT.PRODUCTCODE + ') ' + PRODUCT.PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WITH (NOLOCK) INNER JOIN DEALERPRODUCT WITH (NOLOCK) ON PRODUCT.PRODUCTID = DEALERPRODUCT.PRODUCTID WHERE (DEALERPRODUCT.Deletests = 0) AND (DEALERPRODUCT.DEALERID = @DEALERID) ORDER BY PRODUCT.PRODUCTCODE">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="GvDealer" Name="DEALERID" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <hr />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="99%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessageProduct" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessageProduct" runat="server" TargetControlID="lblMessageProduct">
                                 <Animations>
                                    <OnLoad>
                                        <Sequence>
                                            <Pulse Duration="0.5" Iterations="0" />
                                        </Sequence>
                                    </OnLoad>
                                </Animations>
                                </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSaveProduct" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" OnClientClick="return CheckUserSPVDlrProduct();" />
                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Back" ValidationGroup="Collector" Width="55px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
        </asp:View>
        <asp:View ID="ViewRefundDetail" runat="server">
            <asp:FormView ID="fvDealerInfoRefundDtl" runat="server" 
                Caption="Dealer Info for Dealer Refund (Compensation)" DataKeyNames="DEALERID" 
                DataSourceID="sdsDealerInfoRefundDtl" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 20%">
                                Dealer ID</td>
                            <td>
                                <asp:Label ID="txtIDDealer2" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERID") %>'></asp:Label>
                            </td>
                            <td>
                                Product</td>
                            <td>
                                (<asp:Label ID="lblProduct" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("PRODUCTCODE") %>'></asp:Label>
                                )&nbsp;-
                                <asp:Label ID="lblProduct0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                Dealer Code</td>
                            <td>
                                <asp:Label ID="txtCodeDealer2" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERCODE") %>'></asp:Label>
                            </td>
                            <td>
                                Refund Category</td>
                            <td>
                                (<asp:Label ID="lblCompensationType" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("REFUNDCATEGORYID") %>'></asp:Label>
                                ) -
                                <asp:Label ID="lblCompensationType0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("REFUNDCATEGORY") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                Dealer Name</td>
                            <td>
                                <asp:Label ID="txtNamaDealer2" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                            </td>
                            <td>
                                Type Compensation
                            </td>
                            <td>
                                (<asp:Label ID="lblTypeCompensation" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("REFUNDTYPEID") %>'></asp:Label>
                                ) -
                                <asp:Label ID="lblTypeCompensation0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("REFUNDTYPE") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                Dealer Address</td>
                            <td>
                                <asp:Label ID="txtAreaDealer2" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text='<%# Eval("ADDRESS") %>'></asp:Label>
                            </td>
                            <td>
                                Value</td>
                            <td>
                                <asp:Label ID="lblValue" runat="server" Font-Bold="True" Font-Underline="True" 
                                    Text='<%# Eval("REFUND", "{0:N}") %>'></asp:Label>
                                &nbsp;<asp:Label ID="lblValue0" runat="server" Font-Bold="True" 
                                    Font-Underline="True" Text="%" 
                                    Visible='<%# IIF(Eval("REFUNDTYPEID")="1",True,False) %>'></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sdsDealerInfoRefundDtl" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connection %>" 
                
                
                SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME, PRODUCTCODE, PRODUCTNAME, REFUNDTYPE, REFUND, REFUNDID, REFUNDCATEGORY, REFUNDTYPEID, REFUNDCATEGORYID FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, dbo.f_getParamGlobalName('REFUNDTYPE', REFUND.REFUNDTYPE) AS REFUNDTYPE, REFUND.REFUND, REFUND.REFUNDID, REFUND.REFUNDTYPE AS REFUNDTYPEID, dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUND.REFUNDCATEGORY) AS REFUNDCATEGORY, REFUND.REFUNDCATEGORY AS REFUNDCATEGORYID FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY WITH (NOLOCK) ON DEALER_2.CITYID = CITY.CITYID LEFT OUTER JOIN REFUND WITH (NOLOCK) ON DEALER_2.DEALERID = REFUND.DEALERID LEFT OUTER JOIN PRODUCT WITH (NOLOCK) ON REFUND.PRODUCTID = PRODUCT.PRODUCTID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME, PRODUCT_1.PRODUCTCODE, PRODUCT_1.PRODUCTNAME, dbo.f_getParamGlobalName('REFUNDTYPE', REFUND_1.REFUNDTYPE) AS REFUNDTYPE, REFUND_1.REFUND, REFUND_1.REFUNDID, 1 AS REFUNDTYPEID, dbo.f_getParamGlobalName('REFUNDCATEGORY', REFUND_1.REFUNDCATEGORY) AS REFUNDCATEGORY, 0 AS REFUNDCATEGORYID FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID LEFT OUTER JOIN REFUND AS REFUND_1 WITH (NOLOCK) ON DEALERX.DEALERID = REFUND_1.DEALERID LEFT OUTER JOIN PRODUCT AS PRODUCT_1 WITH (NOLOCK) ON REFUND_1.PRODUCTID = PRODUCT_1.PRODUCTID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (REFUNDID = @REFUNDID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidRefundID" Name="REFUNDID" 
                        PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
        
             <asp:HiddenField ID="hidVALUEREFUND" runat="server" />
             <asp:HiddenField ID="hidREFUNDTYPE" runat="server" />
             <asp:GridView ID="gvDealerRefundDtl" runat="server" 
                AutoGenerateColumns="False" BorderColor="White"
                BorderWidth="2px"  Caption="Refund Detail" DataKeyNames="REFUNDID"  
                ShowFooter="True" Width="99%"  >
                <Columns>
                    <asp:TemplateField Visible="False">
                        </asp:TemplateField>
                            <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" 
                                ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                                        CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                        style="cursor: pointer" Text="Delete" />
                                    </ItemTemplate>
                                    <ControlStyle CssClass="HeaderStyle" />
                                    <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                                <FooterTemplate>
                                <asp:ImageButton ID="btnNewRefunddtl" runat="server" CausesValidation="True" 
                                        CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                        onclick="btnNewRefunddtl_Click" style="cursor:pointer" Text="New" />
                                </FooterTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="No.">
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    <ItemTemplate>
                                           <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Include&lt;br&gt;Disburse ?" 
                                SortExpression="INCLUDEDISBURSE">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkDisburse" runat="server"  
                                        Checked='<%# Eval("INCLUDEDISBURSE") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Position" SortExpression="PERSONTITLE">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlPosition" runat="server" 
                                        DataSourceID="sdsPersonTitleDtl" CssClass="required" 
                                        DataTextField="NAME" DataValueField="CODE"  
                                        SelectedValue='<%# Eval("PERSONTITLE") %>' Width="100%">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="reqTitlePosition" runat="server" 
                                        ControlToValidate="ddlPosition" Display="None" 
                                        ErrorMessage="TITLE POSITION must be entry...!" SetFocusOnError="True">
                                    </asp:RequiredFieldValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="VCEPersonTitle" runat="server" 
                                        HighlightCssClass="ErrHighLight" TargetControlID="reqTitlePosition">
                                    </ajaxToolkit:ValidatorCalloutExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Compensation Allocation" 
                                    SortExpression="PERSONREFUND">
                                <FooterTemplate>
                                Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                    <asp:TextBox ID="txtTotalCompenAllocate" runat="server" style="text-align:right"
                                        Font-Bold="true" Font-Underline="true"  BorderColor="White"
                                        CssClass="disabled" ReadOnly="true" >
                                    </asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>&nbsp;
                                    <asp:Label ID="lblTypeCompensation" runat="server" 
                                        Text='<%# Eval("REFUNDTYPE") %>'></asp:Label>
                                    <asp:TextBox ID="txtCompenAllocate" runat="server" style="text-align:right" 
                                        Text='<%# Eval("PERSONREFUND", "{0:N}") %>'
                                        CssClass="required" Width="50%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqCompenAllocate" runat="server" 
                                        ControlToValidate="txtCompenAllocate" Display="None" 
                                        ErrorMessage="COMPENSATION ALLOCATION must be entry...!" 
                                        SetFocusOnError="True">
                                    </asp:RequiredFieldValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="VCECompenAllocate" runat="server" 
                                        HighlightCssClass="ErrHighLight" TargetControlID="reqCompenAllocate">
                                    </ajaxToolkit:ValidatorCalloutExtender>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                        </Columns>
                          <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>  
                    </asp:GridView>
               <asp:SqlDataSource ID="sdsPersonTitleDtl" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                SelectCommand="SELECT NULL AS CODE, '(SELECT POSITION ) ' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'PERSONTITLE')">
                            </asp:SqlDataSource>
          
            <br />
            <br />
            <br />
            <br />
            <br />
          
            <br />
            
            <asp:Panel ID="pnlControlRefundDtl" runat="server" CssClass="HeaderStyle" Visible="true" Width="100%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <asp:Label ID="lblMessageRefundDtl" runat="server" CssClass="ErrHighLight" 
                Font-Bold="True" Font-Underline="True" Style="text-align: center" Font-Size="Large"
                Visible="False" Width="100%"></asp:Label>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnSaveRefundDtl" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" 
                                onclientclick="return ValidationRefundDtl();" 
                                ValidationGroup="SaveDetail" />
                            &nbsp;<asp:Button ID="btnBackRefundDtl" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Back" ValidationGroup="Collector" Width="55px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="AlwaysVisibleControlExtender2" 
                runat="server" TargetControlID="pnlControlRefundDtl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
        </asp:View>
          <asp:View ID="ViewDealerFinStructure" runat="server">

              <table style="width:100%;" cellpadding="0" cellspacing="0">
                  <tr>
                      <td colspan="2">
                          <asp:DataList ID="fvDealerInfoFnStructure" runat="server" 
                              DataKeyNames="DEALERID" DataSourceID="sdsDealerInfoFnStructure" 
                              Width="100%" Caption="Dealer Info for Financing Structure">
                              <ItemTemplate>
                                  <table width="100%" cellpadding="0" cellspacing="0">
                                      <tr>
                                          <td style="width: 20%">
                                              Dealer ID</td>
                                          <td style="width: 80%">
                                              <asp:Label ID="txtIDDealer3" runat="server" Font-Bold="True" 
                                                  Font-Underline="True" Text='<%# Eval("DEALERID") %>'></asp:Label>
                                          </td>
                                      </tr>
                                      <tr>
                                          <td style="width: 20%">
                                              Dealer Code</td>
                                          <td style="width: 80%">
                                              <asp:Label ID="txtCodeDealer3" runat="server" Font-Bold="True" 
                                                  Font-Underline="True" Text='<%# Eval("DEALERCODE") %>'></asp:Label>
                                          </td>
                                      </tr>
                                      <tr>
                                          <td style="width: 20%">
                                              Dealer Name</td>
                                          <td style="width: 80%">
                                              <asp:Label ID="txtNamaDealer3" runat="server" Font-Bold="True" 
                                                  Font-Underline="True" Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                                          </td>
                                      </tr>
                                      <tr>
                                          <td style="width: 20%">
                                              Dealer Address</td>
                                          <td style="width: 80%">
                                              <asp:Label ID="txtAreaDealer3" runat="server" Font-Bold="True" 
                                                  Font-Underline="True" Text='<%# Eval("ADDRESS") %>'></asp:Label>
                                          </td>
                                      </tr>
                                     
                                  </table>
                              </ItemTemplate>
                          </asp:DataList>
                      </td>
                  </tr>
                   <tr>
                        <td class="FooterStyle" width="20%" colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="RowStyle" width="20%">
                            Product</td>
                        <td class="RowStyle">
                            <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                                DataTextField="PRODUCTNAME" DataValueField="PRODUCTID" ValidationGroup="Search">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDProduct" runat="server" 
                                BehaviorID="BehavProduct" Category="PRODUCTID" Enabled="True" 
                                LoadingText="[Loading Product..]" 
                                ServiceMethod="GetDropDownProductPricing" ServicePath="~\Param\WebService.asmx" 
                                TargetControlID="ddlProduct">
                            </ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                                ControlToValidate="ddlProduct" Display="None" 
                                ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="reqProduct_ValidatorCalloutExtender" 
                                runat="server" BehaviorID="reqVCEProduct" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqProduct">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                  </tr>
                    <tr>
                        <td class="AlternatingRowStyle">
                            Object Category</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="required" 
                                DataTextField="CATEGORYNAME" DataValueField="CATEGORYID" 
                                ValidationGroup="Search">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDCategory" runat="server" 
                                BehaviorID="BehavCategory" Category="ProductID" 
                                LoadingText="[Loading Object Category..]" ParentControlID="ddlProduct" 
                                ServiceMethod="GetDropDownCategoryByProduct" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlCategory">
                            </ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqCategory" runat="server" 
                                ControlToValidate="ddlCategory" Display="None" 
                                ErrorMessage="[OBJECT CATEGORY] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPurpose" runat="server" 
                                BehaviorID="ajaxVCEObjectCategory" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqCategory">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="RowStyle">
                            Object Kind</td>
                        <td class="RowStyle">
                            <asp:DropDownList ID="ddlObjectKind" runat="server" CssClass="required" 
                                DataTextField="NAME" DataValueField="CODE" ValidationGroup="Search">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCDDObjectKind" runat="server" 
                                BehaviorID="BehavObjectKind" Category="ProductID" 
                                LoadingText="[Loading Object Kind..]" ParentControlID="ddlProduct" 
                                ServiceMethod="GetDropDownObjectKindByProduct" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlObjectKind">
                            </ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqObjectKind" runat="server" 
                                ControlToValidate="ddlObjectKind" Display="None" 
                                ErrorMessage="[OBJECT KIND] must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Search"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEInsType" runat="server" 
                                BehaviorID="ajaxVCEObjectKind" HighlightCssClass="ErrHighLight" 
                                TargetControlID="reqObjectKind">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                  <tr class="AlternatingRowStyle">
                      <td colspan="2">
                          <asp:Button ID="btnSearch" runat="server" 
                              Style="font-size: 8pt; cursor: pointer; background-position-x: left; background-image: url(../images/search.gif); background-repeat: no-repeat; text-align: right;" 
                              Text="Search" ToolTip="Search" ValidationGroup="Search" Width="55px" />
                          <asp:Button ID="btnbackView" runat="server" CausesValidation="False" 
                              Style="font-size: 8pt; cursor: pointer; background-position-x: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                              Text="Back" ValidationGroup="Collector" Width="55px" />
                      </td>
                  </tr>
                  <tr>
                      <td colspan="2" class="FooterStyle">
                          <hr />
                      </td>
                  </tr>
              </table>

              <asp:SqlDataSource ID="sdsDealerInfoFnStructure" runat="server" 
                  ConnectionString="<%$ ConnectionStrings:connection %>" 
                  SelectCommand="SELECT DEALERID, DEALERCODE, DEALERMAINID, DEALERNAME, BRANCHID, BRANCHCODE, BRANCHNAME, ADDRESS, CITYID, PROVINCE, HEADDEALER, PHONE, NEW, UPD, Deletests, CITYNAME FROM (SELECT TOP (700) DEALER_2.DEALERID, DEALER_2.DEALERMAINID, DEALER_2.DEALERCODE, DEALER_2.DEALERNAME, DEALER_2.BRANCHID, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, DEALER_2.ADDRESS, DEALER_2.CITYID, DEALER_2.PROVINCE, DEALER_2.HEADDEALER, '(' + DEALER_2.PHONEAREA + ') ' + DEALER_2.PHONE AS PHONE, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM DEALERX WHERE DEALER_2.DEALERID = DEALERX.DEALERID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD, DEALER_2.Deletests, CITY.CITYNAME FROM DEALER AS DEALER_2 LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON DEALER_2.BRANCHID = BRANCH.BRANCHID LEFT OUTER JOIN CITY ON DEALER_2.CITYID = CITY.CITYID WHERE (DEALER_2.Deletests = 0) UNION ALL SELECT DEALERX.DEALERID, DEALERX.DEALERMAINID, DEALERX.DEALERCODE, DEALERX.DEALERNAME, DEALERX.BRANCHID, BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, DEALERX.ADDRESS, DEALERX.CITYID, DEALERX.PROVINCE, DEALERX.HEADDEALER, '(' + DEALERX.PHONEAREA + ') ' + DEALERX.PHONE AS PHONE, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD, DEALERX.Deletests, CITY_1.CITYNAME FROM DEALERX LEFT OUTER JOIN BRANCH AS BRANCH_1 WITH (NOLOCK) ON DEALERX.BRANCHID = BRANCH_1.BRANCHID LEFT OUTER JOIN CITY AS CITY_1 ON DEALERX.CITYID = CITY_1.CITYID WHERE (DEALERX.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM DEALER AS DEALER_1 WHERE (DEALERID = DEALERX.DEALERID)))) AS DEALER WHERE (DEALERID=@DEALERID)">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="hidDealerID" Name="DEALERID" 
                          PropertyName="Value" />
                  </SelectParameters>
              </asp:SqlDataSource>

              <asp:HiddenField ID="hidDealerID" runat="server" />
              <asp:SqlDataSource ID="sdsCondition" runat="server" 
                  ConnectionString="<%$ ConnectionStrings:connection %>" 
                  
                  SelectCommand="SELECT NULL AS CODE, '( Select ) ' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')">
              </asp:SqlDataSource>
              <asp:GridView ID="gvDPMinimum" runat="server" AutoGenerateColumns="False" 
                  BorderWidth="1px" Caption="Down Payment Minimum" 
                  DataKeyNames="DEALERID,PRODUCTID,PURPOSECATID,CATEGORYID" 
                  OnRowCreated="gvDPMinimum_RowCreated" PageSize="15" ShowFooter="True" 
                  style="margin-top: 0px" Width="100%">
                  <Columns>
                      <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" 
                          ShowHeader="False">
                          <ItemTemplate>
                              <asp:ImageButton ID="btnDelete2" runat="server" CausesValidation="False" 
                                  CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                  style="cursor: pointer" Text="Delete" />
                          </ItemTemplate>
                          <ControlStyle CssClass="HeaderStyle" />
                          <ControlStyle CssClass="HeaderStyle" />
                          <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                          <FooterTemplate>
                              <asp:ImageButton ID="btnNewFnStruc" runat="server" CausesValidation="True" 
                                  CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                  onclick="btnNewFnStruc_Click" style="cursor:pointer" Text="New" 
                                  ValidationGroup="FinStrucSave" />
                          </FooterTemplate>
                          <ItemStyle HorizontalAlign="Center" Width="30px" />
                      </asp:TemplateField>
                      <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DTL">
                          <ItemTemplate>
                              <asp:ImageButton ID="btnFNDetail" runat="server" CausesValidation="False" 
                                  CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" 
                                  CommandName="Detail" imageAlign="Middle" ImageUrl="~/Images/detail.gif" 
                                  OnCommand="btnFNDetail_Command" style="cursor: pointer" Text="Delete" 
                                  onclientclick='<%# "return CheckFinanceStructure(" & Eval("FINID") & ");" %>'/>
                          </ItemTemplate>
                          <ControlStyle CssClass="HeaderStyle" />
                          <ItemStyle HorizontalAlign="Center" Width="30px" />
                      </asp:TemplateField>
                      <asp:TemplateField>
                          <ItemStyle HorizontalAlign="Center" Width="20px" />
                          <ItemTemplate>
                              <%# Container.DataItemIndex + 1 %>
                          </ItemTemplate>
                          <ItemStyle HorizontalAlign="Center" Width="20px" />
                      </asp:TemplateField>
                      <asp:TemplateField Visible="FALSE">
                          <ItemTemplate>
                              <asp:TextBox ID="txtFINID" runat="server" CausesValidation="True" 
                                  Font-Names="Lucida Sans" Font-Size="Smaller" 
                                  Text='<%#Databinder.Eval(Container.DataItem,"FINID") %>' Visible="false"></asp:TextBox>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="From" SortExpression="YEARFROM">
                          <Itemstyle HorizontalAlign="Right" />
                          <ItemTemplate>
                              <asp:TextBox ID="txtYearFrom" runat="server" CausesValidation="True" 
                                  CssClass="required" MaxLength="4" style="text-align: right" 
                                  Text='<%# Eval("YEARFROM") %>' ValidationGroup="FinStrucSave" Width="70px"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="reqYearFrom" runat="server" 
                                  ControlToValidate="txtYearFrom" Display="None" 
                                  ErrorMessage="Year From must be entry...!" SetFocusOnError="True" 
                                  ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                              <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEYearFrom" runat="server" 
                                  HighlightCssClass="ErrHighLight" TargetControlID="reqYearFrom">
                              </ajaxToolkit:ValidatorCalloutExtender>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="To" SortExpression="YEARTO">
                          <Itemstyle HorizontalAlign="Right" />
                          <ItemTemplate>
                              <asp:TextBox ID="txtYearTo" runat="server" CausesValidation="True" 
                                  CssClass="required" MaxLength="4" style="text-align: right" 
                                  Text='<%# Eval("YEARTO") %>' ValidationGroup="FinStrucSave" Width="70px"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="reqYearTo" runat="server" 
                                  ControlToValidate="txtYearTo" Display="None" 
                                  ErrorMessage="To From must be entry...!" SetFocusOnError="True" 
                                  ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                              <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEYearTo" runat="server" 
                                  HighlightCssClass="ErrHighLight" TargetControlID="reqYearTo">
                              </ajaxToolkit:ValidatorCalloutExtender>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField SortExpression="CONDITION">
                          <Itemstyle HorizontalAlign="Center" />
                          <ItemTemplate>
                              <asp:DropDownList ID="ddlCondition" runat="server" CausesValidation="True" 
                                  CssClass="required" DataSourceID="sdsCondition" DataTextField="NAME" 
                                  DataValueField="CODE" SelectedValue='<%# Eval("CONDITION") %>' 
                                  ValidationGroup="FinStrucSave">
                              </asp:DropDownList>
                              <asp:RequiredFieldValidator ID="reqCondition" runat="server" 
                                  ControlToValidate="ddlCondition" Display="None" 
                                  ErrorMessage="Condition must be entry...!" SetFocusOnError="True" 
                                  ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                              <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECondition" runat="server" 
                                  HighlightCssClass="ErrHighLight" TargetControlID="reqCondition">
                              </ajaxToolkit:ValidatorCalloutExtender>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField SortExpression="DP">
                          <Itemstyle HorizontalAlign="Right" />
                          <ItemTemplate>
                              <asp:TextBox ID="txtDP" runat="server" CausesValidation="True" 
                                  CssClass="required" style="text-align: right" Text='<%# Eval("DP","{0:N}") %>' 
                                  ValidationGroup="FinStrucSave" Width="80px"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="reqDP" runat="server" ControlToValidate="txtDP" 
                                  Display="None" ErrorMessage="DP must be entry...!" SetFocusOnError="True" 
                                  ValidationGroup="FinStrucSave"></asp:RequiredFieldValidator>
                              <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDP" runat="server" 
                                  HighlightCssClass="ErrHighLight" TargetControlID="reqDP">
                              </ajaxToolkit:ValidatorCalloutExtender>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField SortExpression="Description">
                          <ItemTemplate>
                              <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("REMARK") %>' 
                                  Width="219px"></asp:TextBox>
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
                  <EmptyDataTemplate>
                      <uc6:NoDataFound ID="NoDataFound2" runat="server" />
                  </EmptyDataTemplate>
              </asp:GridView>
              <br />
              <br />
              <br />
              <br />
              <asp:Panel ID="pnlControlFinStructure" runat="server" CssClass="HeaderStyle" Width="99%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessageFinStructure" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessageFinStruc" runat="server" TargetControlID="lblMessageFinStructure">
                                     <Animations>
                                        <OnLoad>
                                            <Sequence>
                                                <Pulse Duration="0.5" Iterations="0" />
                                            </Sequence>
                                        </OnLoad>
                                    </Animations>
                                    </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSaveFnStructure" runat="server" 
                                Style="font-size: 8pt; cursor: pointer; background-position-x: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" OnClientClick="return CheckUserSPVDlrFinStr();" />
                           
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="AlwaysVisibleControlExtender3" runat="server" 
                TargetControlID="pnlControlFinStructure" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
          </asp:View>

        <br />
        <asp:View ID="ViewFnStructureDtl" runat="server">
            <asp:Panel ID="pnlDtl" runat="server" GroupingText="Effective Rate Info" 
                Width="100%">
                <asp:DataList ID="dlDetail" runat="server" Caption="EFFECTIVE RATE INFO" 
                    DataKeyField="FINID" DataSourceID="sdsEffRateInfo" Width="100%">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td class="HeaderStyle" colspan="4">
                                    Finance Structure -&nbsp; Effective Rate</td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Area</td>
                                <td>
                                    <asp:Label ID="lbArea" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("AREANAME") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Product</td>
                                <td>
                                    <asp:Label ID="lblProduct1" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    Category</td>
                                <td>
                                    <asp:Label ID="lblCategory" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("CATEGORYNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Object Kind</td>
                                <td>
                                    <asp:Label ID="lblObjectKind" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("PURPOSENAME") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    Build Year</td>
                                <td>
                                    <asp:Label ID="lblYearFrom" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("YEARFROM") %>'></asp:Label>
                                    &nbsp;-
                                    <asp:Label ID="lblYearTo" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("YEARTO") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    DP Min</td>
                                <td>
                                    <asp:Label ID="lblDPMinimum" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("DP", "{0:N}") %>'></asp:Label>
                                    %</td>
                                <td class="FooterStyle">
                                    Item Condition</td>
                                <td>
                                    <asp:Label ID="lblItemCondition" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("CONDITIONNM") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsEffRateInfo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) FINID, DEALERID, (SELECT '(' + DEALERCODE + ') ' + DEALERNAME AS DEALERNAME FROM DEALER WHERE (DEALERID = FNFINSTRUCTURE.DEALERID)) AS DEALERNAME, AREAID, (SELECT '(' + AREACODE + ') ' + AREANAME AS AREANAME FROM AREA WHERE (AREAID = FNFINSTRUCTURE.AREAID)) AS AREANAME, BRANCHID, (SELECT '(' + BRANCHCODE + ') ' + BRANCHNAME AS AREANAME FROM BRANCH WHERE (BRANCHID = FNFINSTRUCTURE.BRANCHID)) AS BRANCHNAME, PRODUCTID, (SELECT '(' + PRODUCTCODE + ') ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (PRODUCTID = FNFINSTRUCTURE.PRODUCTID)) AS PRODUCTNAME, PURPOSECATID, (SELECT '(' + PURPOSECATCODE + ') ' + PURPOSECATNAME AS PURPOSECATNAME FROM OBJECTPURPOSECAT WHERE (PURPOSECATID = FNFINSTRUCTURE.PURPOSECATID)) AS PURPOSENAME, CATEGORYID, (SELECT '(' + CATEGORYCODE + ') ' + CATEGORYNAME AS CATEGORYNAME FROM OBJECTCATEGORY WHERE (FNFINSTRUCTURE.CATEGORYID = CATEGORYID)) AS CATEGORYNAME, YEARFROM, YEARTO, CONDITION, dbo.f_getParamGlobalName('CONDITION', CONDITION) AS CONDITIONNM, DP FROM FNFINSTRUCTURE WITH (NOLOCK) WHERE (DeleteSts = 0) AND (FINID = @FINID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidFinID" Name="FINID" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <asp:Panel ID="pnlEffRate" runat="server">
                <table style="width: 100%;">
                    <tr>
                        <td colspan="3">
                            <asp:GridView ID="gvEffRate" runat="server" AutoGenerateColumns="False" 
                                BorderColor="White" BorderWidth="2px" Caption="Interest Rate" 
                                DataKeyNames="FINID" OnRowCreated="gvEffRate_RowCreated" ShowFooter="True" 
                                Width="99%">
                                <Columns>
                                    <asp:TemplateField Visible="False">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFindtlKey" runat="server" 
                                                Text='<% #DataBinder.Eval(Container.DataItem,"FINDTLID") %>' Visible="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ControlStyle-CssClass="HeaderStyle" HeaderText="DEL" 
                                        ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete3" runat="server" CausesValidation="False" 
                                                CommandName="Delete" ImageAlign="Middle" ImageUrl="~/Images/delete.gif" 
                                                style="cursor: pointer" Text="Delete" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="HeaderStyle" />
                                        <FooterStyle CssClass="HeaderStyle" HorizontalAlign="center" />
                                        <FooterTemplate>
                                            <asp:ImageButton ID="btnNewEffRate" runat="server" CausesValidation="True" 
                                                CommandName="New" ImageAlign="Middle" ImageUrl="~/Images/New.png" 
                                                onclick="btnNewEffRate_Click" style="cursor:pointer" Text="New" />
                                        </FooterTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="No.">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FROM">
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlOprFrTenor" runat="server" CssClass="required" 
                                                DataSourceID="sdsOperator" DataTextField="NAME" DataValueField="CODE" 
                                                SelectedValue='<%# Eval("TENOROPR1") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="reqOprFrTenor" runat="server" 
                                                ControlToValidate="ddlOprFrTenor" Display="None" 
                                                ErrorMessage="Operator From Tenor must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOprFrTenor" runat="server" 
                                                HighlightCssClass="ErrHighLight" TargetControlID="reqOprFrTenor">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTenorFrom" runat="server" CssClass="required" MaxLength="5" 
                                                style="text-align:right" Text='<%# Eval("TENORFROM") %>' Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtTenorFrom" runat="server" 
                                                ControlToValidate="txtTenorFrom" Display="None" 
                                                ErrorMessage="Tenor From must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEtxtTenorFrom" runat="server" 
                                                HighlightCssClass="ErrHighLight" TargetControlID="reqtxtTenorFrom">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="TO">
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlOprToTenor" runat="server" DataSourceID="sdsOperator" 
                                                DataTextField="NAME" DataValueField="CODE" 
                                                SelectedValue='<%# Eval("TENOROPR2") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTenorTo" runat="server" MaxLength="5" 
                                                style="text-align:right" Text='<%# Eval("TENORTO") %>' Width="50px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FROM">
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlOprFromPrincipal" runat="server" 
                                                DataSourceID="sdsOperator" DataTextField="NAME" DataValueField="CODE" 
                                                SelectedValue='<%# Eval("PRINCIPALOPR1") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPrincipalFrom" runat="server" style="text-align:right" 
                                                Text='<%# Eval("PRINCIPALFROM", "{0:N}") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="TO">
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlOprToPrincipal" runat="server" 
                                                DataSourceID="sdsOperator" DataTextField="NAME" DataValueField="CODE" 
                                                SelectedValue='<%# Eval("PRINCIPALOPR2") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPrincipalTo" runat="server" style="text-align:right" 
                                                Text='<%# Eval("PRINCIPALTO", "{0:N}") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlJnsTrayek" runat="server" DataSourceID="sdsRouteKind" 
                                                DataTextField="NAME" DataValueField="CODE" 
                                                SelectedValue='<%# Eval("ROUTEKIND") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <Itemstyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtEffRate" runat="server" CssClass="required" 
                                                style="text-align:right" Text='<%# Eval("EFFRATE", "{0:N}") %>' Width="100px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqEffRate" runat="server" 
                                                ControlToValidate="txtEffRate" Display="None" 
                                                ErrorMessage="Effective Rate must be entry...!" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEEffRate" runat="server" 
                                                HighlightCssClass="ErrHighLight" TargetControlID="reqEffRate">
                                            </ajaxToolkit:ValidatorCalloutExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <uc6:NoDataFound ID="NoDataFound3" runat="server" />
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsOperator" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                SelectCommand="SELECT NULL AS CODE, ' -- ' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'OPERATOR')">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sdsRouteKind" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:connection %>" 
                                
                                SelectCommand="SELECT NULL AS CODE, '(-- SELECT --) ' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ROUTEKIND')">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <br />
            </asp:Panel>
            <asp:Panel ID="pnlControlIntRate" runat="server" CssClass="HeaderStyle" 
                Visible="false" Width="99%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessageIntRate" runat="server" CssClass="ErrHighLight" 
                                Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessageIntRate" runat="server" TargetControlID="lblMessageIntRate">
                                     <Animations>
                                        <OnLoad>
                                            <Sequence>
                                                <Pulse Duration="0.5" Iterations="0" />
                                            </Sequence>
                                        </OnLoad>
                                    </Animations>
                                    </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSaveIntRate" runat="server" 
                                onclientclick="return ProcessSave();" 
                                Style="font-size: 8pt; cursor: pointer; background-position-x: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" 
                                Text="Save" ToolTip="Save" Width="55px" />
                            <asp:Button ID="btnBackIntRate" runat="server" CausesValidation="False" 
                                Style="font-size: 8pt; cursor: pointer; background-position-x: left; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat;  text-align: right" 
                                Text="Back" ValidationGroup="Interest" Width="55px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:AlwaysVisibleControlExtender ID="AlwaysVisibleControlExtender4" 
                runat="server" TargetControlID="pnlControlIntRate" VerticalSide="Bottom">
            </ajaxToolkit:AlwaysVisibleControlExtender>
        </asp:View>

    </asp:MultiView>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
    var iDealer = 0;
    FormatTable("<%=gvData.ClientID%>")
    FormatTable("<%=GvPersonACC.ClientID%>")
    FormatTable("<%=GvPerson.ClientID%>")
    FormatTable("<%=GvDealer.ClientID%>")
    FormatTable("<%=gvDealerRefundDtl.ClientID%>")
    FormatTable("<%=gvDPMinimum.ClientID%>")
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    var WinRef = null;
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function toNumeric(theValue) {
        var ValX = parseFloat(FormatNumberClear(theValue));
        if (isNaN(ValX))
            ValX = 0;
        return (ValX);
    }
    function CheckRefund(RefundID) {
       
        if (RefundID == 0) {
            alert("Refund Amount Must Be Greater Than 0...!! ")
            return false;
        } else {
            SetValueTxtByClientID("<%=hidREFUNDID.ClientID%>", RefundID);
            return true;
        }
    }
    function CheckFinanceStructure(FNSTRUCTUREID) {
        if (FNSTRUCTUREID == 0) {
            alert("Finance Structure Must Be Save...!! ")
            return false;
        }
    }
    function CalcTotalAllocated() {
        var oCompensation = "<%=oStrtxtCompenAllocated%>";
        var oTotalCompensation  = getObjectbyClientID("<%=oStrTotaltxtCompenAllocated%>");
        var arrCompensation = oCompensation.split(",");
        var nLen = arrCompensation.length - 1;
        if (nLen > 0) {
            oTotalCompensation.value = 0;
            for (var i = 0; i < nLen; i++) {
                var oCompensation1 = toNumeric(GetValueTxtByClientID(arrCompensation[i]));
                oTotalCompensation.value = FormatNumber(oCompensation1 + toNumeric(oTotalCompensation.value), 'True', 2);
            }
        }
    }

    function ValidationRefundDtl() {
        var oTotalCompensation = getObjectbyClientID("<%=oStrTotaltxtCompenAllocated%>");
        var oTotalRefund = getObjectbyClientID("<%=hidValueRefund.ClientID%>");
        var oRefundType = getObjectbyClientID("<%=hidREFUNDTYPE.ClientID%>");
        var oRefund = "<%=oStrtxtCompenAllocated%>";
        var arrRefund = oRefund.split(",");
        var nLen = arrRefund.length - 1;
        if (ValidatePage() == true) {
            if (nLen > 0) {
                oTotalCompensation.value = 0;
                for (var i = 0; i < nLen; i++) {
                    var oarrRefund2 = toNumeric(GetValueTxtByClientID(arrRefund[i]));
                    oTotalCompensation.value = FormatNumber(oarrRefund2 + toNumeric(oTotalCompensation.value), 'True', 2);
                    if (oRefundType.value == 1) { // Persentage
                        if (toNumeric(oTotalCompensation.value) > toNumeric(100)) {
                            alert("Total Persentage > 100%");
                            return false;
                        }
                    } else if (oRefundType.value == 2) { //Amount
                        if (toNumeric(oTotalCompensation.value) > toNumeric(oTotalRefund.value)) {
                            alert("Total Amount > " + oTotalRefund.value);
                            return false;
                        }
                    }
                }
            }
        } else {return false;}

    }
    function ValidatePage() {
        var oPOSITIONTITLE = "<%=ostrTitlePosition%>";
        var arrPOSITIONTITLE = oPOSITIONTITLE.split(",");
        var nLen = arrPOSITIONTITLE.length - 1;
        if (nLen > 0) {
            for (var i = 0; i < nLen; i++) {
                var arrPOSITIONTITLE2 = GetValueTxtByClientID(arrPOSITIONTITLE[i]);
                if (arrPOSITIONTITLE2 == "") {
                    alert("TITLE POSITION must be entry...!");
                    arrPOSITIONTITLE2.className = "ErrHighLight";
                //    arrPOSITIONTITLE2.focus();
                    return false;
                }
            }
        }
        var oVALUEREFUND = "<%=oStrValueRefund%>";
        var arrVALUEREFUND = oVALUEREFUND.split(",");
        var nLen = arrVALUEREFUND.length - 1;
        if (nLen > 0) {
            for (var i = 0; i < nLen; i++) {
                var arrVALUEREFUND2 = toNumeric(GetValueTxtByClientID(arrVALUEREFUND[i]));
                if (arrVALUEREFUND2 == 0) {
                    alert("COMPENSATION ALLOCATION must be entry...!");
                    arrVALUEREFUND2.className = "ErrHighLight";
                 //   arrVALUEREFUND2.focus();
                    return false;
                }
            }
        }
        return true;
    }

    function CheckUserSPVDlrProduct() {
        var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
        if (RetVal.Login == 1)
            return (true);
        else
            return (false);
    }

    function CheckUserSPVDlrRefund() {
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

    function CheckUserSPVDlrFinStr() {
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

    function CheckUserSPVDlrIntRate() {
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
</script>
</asp:Content>

