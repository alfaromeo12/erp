<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BankAccountApp.aspx.vb" Inherits="Param_BankAccount" title="Bank Account" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnApprovetNoSPV.ascx" tagname="BtnApprovetNoSPV" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnRejectNoSPV.ascx" tagname="BtnRejectNoSPV" tagprefix="uc8" %>
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
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 110px" class="RowStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="BankAccountX.AccountNo">Account No</asp:ListItem>
        <asp:ListItem Value="Bank.BankName">Bank Name</asp:ListItem>
    </asp:DropDownList></td>
                <td class="RowStyle">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
            </tr>
            <tr>
                <td style="width: 110px" class="AlternatingRowStyle">
                    Bank</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlBankSearch" runat="server" AutoPostBack="True"
        DataSourceID="sdsBankSearch" DataTextField="BANKNAME" DataValueField="BANKID">
    </asp:DropDownList><asp:SqlDataSource ID="sdsBankSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS BANKID, 'ALL BANK' AS BANKNAME UNION ALL SELECT BANKID, BANKNAME + ' (' + BANKCODE + ')' AS BANKNAME FROM BANK WHERE EXISTS (SELECT 'X' AS Expr1 FROM BANKACCOUNT WHERE (BANK.BANKID = BANKID)) ORDER BY BANKNAME">
    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

        <br />
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="ACCOUNTID" Caption="Bank Account Approval List" 
            RowHeaderColumn="ACCOUNTID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" 
                    ShowSelectButton="True" >
                <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:CommandField>
                <asp:BoundField DataField="ACCOUNTID" HeaderText="ID" ReadOnly="True" 
                    SortExpression="ACCOUNTID" />
                <asp:BoundField DataField="BANKNAME" HeaderText="Bank" SortExpression="BANKNAME" />
                <asp:BoundField DataField="ACCOUNTNO" HeaderText="Account No." SortExpression="ACCOUNTNO" />
                <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ACCOUNTNAME" />
                <asp:BoundField DataField="BANKBRANCH" HeaderText="Bank&lt;br&gt;Branch" HtmlEncode="False"
                    SortExpression="BANKBRANCH" />
                <asp:BoundField DataField="BRANCHNAME" HeaderText="Account&lt;br&gt;Branch" HtmlEncode="False"
                    SortExpression="BRANCHNAME" />
                <asp:BoundField DataField="COANO" HeaderText="COA No" SortExpression="COANO" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ACCOUNTID,BANKNAME,ACCOUNTNO,ACCOUNTNAME,BANKBRANCH,BRANCHNAME,COANO
FROM BANKACCOUNTX INNER JOIN BANK ON BANKACCOUNTX.BANKID=BANK.BANKID
INNER JOIN BRANCH ON BANKACCOUNTX.BRANCHID=BRANCH.BRANCHID"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="ACCOUNTID">
        <EditItemTemplate>
        <asp:Panel ID="pnlAPPROVAL" runat="server" Enabled="False"> 
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Account ID</td>
                    <td>
                        <asp:Label ID="lblAccountID" runat="server" Font-Bold="True" 
                            Text='<%# Eval("ACCOUNTID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Bank</td>
                    <td>
                        <asp:DropDownList ID="ddlBankID" runat="server" CssClass="required" 
                            DataSourceID="sdsBank" DataTextField="BANKNAME" DataValueField="BANKID" 
                            SelectedValue='<%# Bind("BANKID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqBank" runat="server" 
                            ControlToValidate="ddlBankID" Display="None" 
                            ErrorMessage="Bank must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBank" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqBank">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Account No</td>
                    <td>
                        <asp:TextBox ID="txtAccountNo" runat="server" CssClass="required" 
                            MaxLength="50" Text='<%# Bind("ACCOUNTNO") %>' Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqAccountNo" runat="server" 
                            ControlToValidate="txtAccountNo" Display="None" 
                            ErrorMessage="Account No must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAccNo" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqAccountNo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Account Name</td>
                    <td>
                        <asp:TextBox ID="txtAccountName" runat="server" CssClass="required" 
                            MaxLength="80" Text='<%# Bind("ACCOUNTNAME") %>' Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqAccountName" runat="server" 
                            ControlToValidate="txtAccountName" Display="None" 
                            ErrorMessage="Account Name must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAccountName" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqAccountName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Bank Branch</td>
                    <td>
                        <asp:TextBox ID="txtBankBranch" runat="server" CssClass="required" 
                            MaxLength="60" Text='<%# Bind("BANKBRANCH") %>' Width="232px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqBankBranch" runat="server" 
                            ControlToValidate="txtBankBranch" Display="None" 
                            ErrorMessage="Bank Branch must be entry..!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBAnkBranch" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqBankBranch">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Owner</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchID" runat="server" CssClass="required" 
                            DataSourceID="sdsBranch" DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                            SelectedValue='<%# Bind("BRANCHID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqBranchOwner" runat="server" 
                            ControlToValidate="ddlBranchID" Display="None" 
                            ErrorMessage="Branch Owner must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBranchOwner" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqBranchOwner">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        COA</td>    
                    <td>
                        <asp:DropDownList ID="ddlCOA" runat="server" CssClass="required" DataSourceID="sdsCOA"
                            DataTextField="COA" DataValueField="COAID" SelectedValue='<%# Bind("COANO") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqCOA" runat="server" ControlToValidate="ddlCOA"
                            Display="None" ErrorMessage="COA must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>                
                </tr>                
                <tr>
                    <td>
                        Finance Category</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlFinCat" runat="server" CssClass="required" 
                            DataSourceID="sdsFinCat" DataTextField="FINCAT" DataValueField="FINCATID" 
                            SelectedValue='<%# Bind("FINCATID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqFinCat" runat="server" 
                            ControlToValidate="ddlFinCat" Display="None" 
                            ErrorMessage="COA must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqFinCat_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFinCat">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            <tr>
                <td colspan="3">
                  <hr />
                  </td>
            </tr>
                <tr>
                    <td></td>
                    <td class="HeaderStyle">Same Bank</td>
                    <td class="HeaderStyle">Other Bank</td>
                </tr>
                <tr>
                    <td class="RowStyle">Days of Clearing</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtDoC" runat="server" Text='<%# Eval("DAYOFCLEARING") %>'
                        MaxLength="4" Height="18px" Width="70px"></asp:TextBox></td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtDoCOTH" runat="server" MaxLength="4" Height="18px" Width="70px"
                            Text='<%# Eval("DAYOFCLEARINGOTH") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">Days of Inkaso</td>
                    <td class="AlternatingRowStyle">
                        <asp:TextBox ID="txtDoI" runat="server" Text='<%# Eval("DAYOFINKASO") %>'
                        MaxLength="4" Height="18px" Width="70px"></asp:TextBox></td>
                    <td class="AlternatingRowStyle">
                        <asp:TextBox ID="txtDoIOTH" runat="server" Text='<%# Eval("DAYOFINKASOOTH") %>'
                        MaxLength="4" Height="18px" Width="70px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="RowStyle">Days of Success</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtDoS" runat="server" Text='<%# Eval("DAYOFSUCCESS") %>'
                        MaxLength="4" Height="18px" Width="70px"></asp:TextBox></td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtDoSOTH" runat="server" MaxLength="4" Height="18px" Width="70px"
                            Text='<%# Eval("DAYOFSUCCESSOTH") %>'></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;</td>
                </tr>                                  
            </asp:Panel>
                    <tr>
                        <td colspan="2">
                            &nbsp;<uc7:BtnApprovetNoSPV ID="BtnApprovetNoSPV1" runat="server" />
                            <uc8:BtnRejectNoSPV ID="BtnRejectNoSPV1" runat="server" />
                            <uc3:BtnCancel ID="BtnCancel3" runat="server" />
                        </td>
                    </tr>
            </table>
            &nbsp;
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Bank</td>
                    <td>
                        <asp:DropDownList ID="ddlBankID" runat="server" DataSourceID="sdsBank" DataTextField="BANKNAME" DataValueField="BANKID" SelectedValue='<%# Bind("BANKID") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqBank" runat="server" ControlToValidate="ddlBankID"
                            Display="None" ErrorMessage="Bank must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBank" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBank">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Account No</td>
                    <td>
                        <asp:TextBox ID="txtAccountNo" runat="server" MaxLength="50" Width="200px" Text='<%# Bind("ACCOUNTNO") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqAccountNo" runat="server" ControlToValidate="txtAccountNo" Display="None"
                            ErrorMessage="Account No must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEAccNo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccountNo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Account Name</td>
                    <td>
                        <asp:TextBox ID="txtAccountName" runat="server" CssClass="required" MaxLength="80"
                            Text='<%# Bind("ACCOUNTNAME") %>' Width="200px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqAccountName" runat="server" ControlToValidate="txtAccountName" Display="None"
                                ErrorMessage="Account Name must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEAccountName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAccountName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Bank Branch</td>
                    <td>
                        <asp:TextBox ID="txtBankBranch" runat="server" MaxLength="60" Width="232px" Text='<%# Bind("BANKBRANCH") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqBankBranch" runat="server" ControlToValidate="txtBankBranch" Display="None"
                            ErrorMessage="Bank Branch must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBAnkBranch" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankBranch">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Branch Owner</td>
                    <td>
                        <asp:DropDownList ID="ddlBranchID" runat="server" DataSourceID="sdsBranch" DataTextField="BRANCHNAME" DataValueField="BRANCHID" SelectedValue='<%# Bind("BRANCHID") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqBranchOwner" runat="server"
                            ControlToValidate="ddlBranchID" Display="None" ErrorMessage="Branch Owner must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBranchOwner" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBranchOwner">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        COA</td>
                    <td>
                        <asp:DropDownList ID="ddlCOA" runat="server" CssClass="required" DataSourceID="sdsCOA"
                            DataTextField="COA" DataValueField="COAID" SelectedValue='<%# Bind("COANO") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqCOA" runat="server" ControlToValidate="ddlCOA"
                            Display="None" ErrorMessage="COA must be entry...!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECOA" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCOA">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Finance Category</td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlFinCat" runat="server" CssClass="required" 
                            DataSourceID="sdsFinCat" DataTextField="FINCAT" DataValueField="FINCATID" 
                            SelectedValue='<%# Bind("FINCATID") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="reqFinCat" runat="server" 
                            ControlToValidate="ddlFinCat" Display="None" 
                            ErrorMessage="COA must be entry...!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqFinCat_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFinCat">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                <td colspan="2">
                  <hr />
                &nbsp;</td>
            </tr>
                <tr>
                    <td></td>
                    <td>Same Bank</td>
                    <td>Other Bank</td>
                </tr>
                <tr>
                    <td>Days of Clearing</td>
                    <td>
                        <asp:TextBox ID="txtDoC" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDoCOTH" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Days of Inkaso</td>
                    <td>
                        <asp:TextBox ID="txtDoI" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDoIOTH" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Days of Success</td>
                    <td>
                        <asp:TextBox ID="txtDoS" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDoSOTH" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT ACCOUNTID, BANKID, (SELECT BRANCHID FROM BRANCH WHERE (BRANCHID = BANKACCOUNTX.BRANCHID) AND (Deletests = 0)) AS BRANCHID, ACCOUNTNO, ACCOUNTNAME, BANKBRANCH, (SELECT COAID FROM COA WHERE (COAID = BANKACCOUNTX.COANO) AND (DELETESTS = 0) AND (HARDCODE = 0)) AS COANO, DAYOFCLEARING, DAYOFINKASO, DAYOFSUCCESS, DAYOFCLEARINGOTH, DAYOFINKASOOTH, DAYOFSUCCESSOTH, FINCATID FROM BANKACCOUNTX WHERE (ACCOUNTID = @AccountID)" 
        DeleteCommand="UPDATE BANKAccount SET DELETESTS=1, LastUpdate=getdate(), LastUserId=@UserID WHERE AccountID=@AccountID" 
        UpdateCommand="BankAccountUpdate" InsertCommand="BankAccountAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UserID" />
            <asp:ControlParameter ControlID="fvData" Name="AccountID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="AccountID" Type="Int32" />
            <asp:Parameter Name="BankID" Type="Int32" />
            <asp:Parameter Name="BranchID" Type="Int32" />
            <asp:Parameter Name="AccountNo" Type="String" />
            <asp:Parameter Name="AccountName" Type="String" />
            <asp:Parameter Name="BankBranch" Type="String" />
            <asp:Parameter Name="COANo" Type="String" />
            <asp:Parameter Name="DayOfClearing" Type="Int32" />
            <asp:Parameter Name="DayOfInkaso" Type="Int32" />
            <asp:Parameter Name="DayOfSuccess" Type="Int32" />
            <asp:Parameter Name="DayOfClearingOTH" Type="Int32" />
            <asp:Parameter Name="DayOfInkasoOTH" Type="Int32" />
            <asp:Parameter Name="DayOfSuccessOTH" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
            <asp:Parameter Name="FINCATID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="BankID" Type="Int32" />
            <asp:Parameter Name="BranchID" Type="Int32" />
            <asp:Parameter Name="AccountNo" Type="String" />
            <asp:Parameter Name="AccountName" Type="String" />
            <asp:Parameter Name="BankBranch" Type="String" />
            <asp:Parameter Name="COANo" Type="String" />
            <asp:Parameter Name="DayOfClearing" Type="Int32" />
            <asp:Parameter Name="DayOfInkaso" Type="Int32" />
            <asp:Parameter Name="DayOfSuccess" Type="Int32" />
            <asp:Parameter Name="DayOfClearingOTH" Type="Int32" />
            <asp:Parameter Name="DayOfInkasoOTH" Type="Int32" />
            <asp:Parameter Name="DayOfSuccessOTH" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
            <asp:Parameter Name="FINCATID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="AccountID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCOA" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COA UNION ALL SELECT COAID, COANO, COANO + ' - ' + COANAME AS COA FROM COA WITH (NOLOCK) WHERE (DELETESTS = 0) AND (HARDCODE = 0) ORDER BY COANO">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS BANKID, '[CHOOSE BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKNAME + ' (' + BANKCODE + ')' AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKNAME">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBranch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '[CHOOSE BRANCH]' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' - ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY BRANCHCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFinCat" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS FINCATID, NULL AS FINCATCODE, '[CHOOSE FINANCE CATEGORY]' AS FINCAT UNION ALL SELECT FINCATID, FINCATCODE, FINCATCODE + ' - ' + FINCATNAME AS FINCAT FROM FINANCECATEGORY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY FINCATCODE">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

