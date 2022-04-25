<%@ Page Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccForResell.aspx.vb" Inherits="Txn_AccForResell" title="Account For JF - RESELL" EnableEventValidation="FALSE" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPResell" runat="server">
    <Services>
    <asp:ServiceReference Path="GHWService.asmx" />
    </Services>
    </asp:ScriptManagerProxy>
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidIsUserBranch" runat="server" />
    <asp:HiddenField ID="txtUID" runat="server" />
    <asp:HiddenField ID="txtAppDate" runat="server" />
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="99%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ACCOUNTNO">Account No.</asp:ListItem>
        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
        <asp:ListItem Value="ACCOUNTNAME">Account Name</asp:ListItem>
        <asp:ListItem Value="CUSTNO">Cust No.</asp:ListItem>
        <asp:ListItem Value="CUSTNOX">Cust No. (Formated)</asp:ListItem>
        <asp:ListItem Value="IDNUMBER">ID Number</asp:ListItem>
        <asp:ListItem Value="REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="CUSTID">CUST ID</asp:ListItem>
        <asp:ListItem Value="ACCID">ACC ID</asp:ListItem>
        <asp:ListItem Value="APPID">APP ID</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Text="Search" CssClass="Search" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Request Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbReqAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbReqDate" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtRequestForm" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqFrom" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtRequestTo" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqTo" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxReqFrom" runat="server" Format="dd/MM/yyyy"
                            PopupButtonID="imgReqFrom" TargetControlID="txtRequestForm">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxReqTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqTo"
                        TargetControlID="txtRequestTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestForm">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Booking Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbBookAll" runat="server" GroupName="rbBook" Text="All" /><asp:RadioButton
                        ID="rbBookFrom" runat="server" GroupName="rbBook" Text="From" />
                    <asp:TextBox ID="txtBookFrom"
                            runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtBookTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom"
                        TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookTo"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Area</td>
                <td>
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" BehaviorID="BehavArea" 
                        Category="AREA" LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownAreabyAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" 
                        BehaviorID="BehavBranch" Category="BRANCH" LoadingText="[Loading Branch...]" 
                        ParentControlID="ddlAreaSearch" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownBranchByAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Loan Type</td>
                <td>
                    <asp:DropDownList ID="ddlLoanTypeSearch" runat="server" DataSourceID="sdsLoanTypeSearch" DataTextField="NAME"
                        DataValueField="CODE">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsLoanTypeSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'LOANTYPE')">
                    </asp:SqlDataSource>
                </td>
                <td>
                    Page Size</td>
                <td>
                    <asp:TextBox ID="txtPageSize" runat="server" CssClass="required" Style="text-align: right"
                        Width="40px"></asp:TextBox><asp:RequiredFieldValidator ID="reqPageSize" runat="server"
                            ControlToValidate="txtPageSize" Display="None" ErrorMessage="PAGE SIZE  must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPageSize" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPageSize">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle">
                    Include Past Due Account?</td>
                <td class="FooterStyle">
                    <asp:CheckBox ID="cbPastDue" runat="server" Text="NO, Do not include past due account" /></td>
                <td class="FooterStyle">
                    Include New Account?</td>
                <td class="FooterStyle">
                    <asp:CheckBox ID="cbNewAcc" runat="server" Text="NO, Do not Include new account" /></td>
            </tr>
            <tr>
                <td>
                    OS Tenor</td>
                <td>
                    <asp:CheckBox ID="cbOSTenor" runat="server" Text="Between" />
                    <asp:TextBox ID="txtTenorFrom" runat="server" Width="40px" style="text-align: right"></asp:TextBox>
                    and
                    <asp:TextBox ID="txtTenorTo" runat="server" Width="40px" style="text-align: right"></asp:TextBox><asp:RequiredFieldValidator
                        ID="reqTenorFrom" runat="server" ControlToValidate="txtTenorFrom" Display="None"
                        ErrorMessage="TENOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETenorFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenorFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:RequiredFieldValidator ID="reqTenorTo" runat="server" ControlToValidate="txtTenorTo"
                        Display="None" ErrorMessage="TENOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETenorTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenorTo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    OS Principal</td>
                <td>
                    <asp:CheckBox ID="cbOSPrincipal" runat="server" Text="Between" />
                    <asp:TextBox ID="txtPrincipalFrom" runat="server" Width="88px" style="text-align: right"></asp:TextBox>
                    and
                    <asp:TextBox ID="txtPrincipalTo" runat="server" Width="88px" style="text-align: right"></asp:TextBox><asp:RequiredFieldValidator
                        ID="reqPrincipalFrom" runat="server" ControlToValidate="txtPrincipalFrom" Display="None"
                        ErrorMessage="PRINCIPAL FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEPrincipalFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPrincipalFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <asp:RequiredFieldValidator ID="reqPrincipalTo" runat="server" ControlToValidate="txtPrincipalTo"
                        Display="None" ErrorMessage="PRINCIPAL TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEPrincipalTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPrincipalTo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    DP Minimum</td>
                <td>
                    <asp:CheckBox ID="cbDPMin" runat="server" />
                    &gt;=<asp:TextBox ID="txtDPMin" runat="server" style="text-align: right" 
                        Width="40px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqDPMin" runat="server" 
                        ControlToValidate="txtDPMin" Display="None" 
                        ErrorMessage="MINIMUM DP  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqDPMin_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDPMin">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    ID/KTP Expired</td>
                <td>
                    <asp:CheckBox ID="cbIDExpired" runat="server" 
                        Text="NO, Do not Include ID/KTP Expired" />
                </td>
            </tr>
            <tr>
                <td>
                    DSR</td>
                <td>
                    <asp:CheckBox ID="cbDSR" runat="server" />
                    &lt;=
                    <asp:TextBox ID="txtDSR" runat="server" style="text-align: right" Width="40px"></asp:TextBox>
                    %<asp:RequiredFieldValidator ID="reqDSR" runat="server" 
                        ControlToValidate="txtDSR" Display="None" ErrorMessage="DSR must be entry...!" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDSR" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqDSR">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Age + Tenor</td>
                <td>
                    <asp:CheckBox ID="cbAge" runat="server" />
                    &lt;=
                    <asp:TextBox ID="txtAge" runat="server" style="text-align: right" Width="40px"></asp:TextBox>
                    Year<asp:RequiredFieldValidator ID="reqAGe" runat="server" 
                        ControlToValidate="txtAge" Display="None" ErrorMessage="AGE  must be entry...!" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAge" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqAGe">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Installment Type</td>
                <td>
                    <asp:DropDownList ID="ddlInstallmentTypeSearch" runat="server" 
                        DataSourceID="sdsInstallmentTypeSearch" DataTextField="NAME" 
                        DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsInstallmentTypeSearch" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[ALL INST. TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'INSTALLMENTTYPE')">
                    </asp:SqlDataSource>
                </td>
                <td>
                    Finance Category</td>
                <td >
                    <asp:DropDownList ID="ddlFinanceCategory" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDFincat" runat="server" 
                        BehaviorID="BehavFinCat" Category="FINCAT" 
                        LoadingText="[Loading Finance Category ...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownFinCatbyAppUserBranch" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlFinanceCategory">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Currency</td>
                <td>
                    <asp:DropDownList ID="ddlCurrencySearch" runat="server" 
                        DataSourceID="sdsCurrency" DataTextField="CURRENCYNAME" 
                        DataValueField="CURRENCYID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCurrency" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        
                        
                        SelectCommand="SELECT NULL AS CURRENCYID, NULL AS CURRENCYCODE, '[ALL CURRENCY]' AS CURRENCYNAME UNION ALL SELECT CURRENCYID, CURRENCYCODE, CURRENCYCODE + ' - ' + CURRENCYNAME AS CURRENCYNAME FROM CURRENCY WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CURRENCYCODE">
                    </asp:SqlDataSource>
                </td>
                <td>
                    Product</td>
                <td>
                    <asp:DropDownList ID="ddlProductID" runat="server" DataTextField="PRODUCTNAME" 
                        DataValueField="PRODUCTID" Width="200px">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDProduct" runat="server" Category="PRODUCT" 
                        Enabled="True" LoadingText="[Loading Product..]" PromptText="[ALL PRODUCT]" 
                        ServiceMethod="GetDropDownProduct" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlProductID">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Obj. Condition</td>
                <td>
                    <asp:DropDownList ID="ddlCondition" runat="server" DataSourceID="sdsCondition" 
                        DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCondition" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[ALL CONDITION]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'CONDITION')">
                    </asp:SqlDataSource>
                </td>
                <td>
                    Obj. Purpose</td>
                <td>
                    <asp:DropDownList ID="ddlPurpose" runat="server" DataTextField="PURPOSENAME" 
                        DataValueField="PURPOSEID" Width="200px">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCCDObjPurpose" runat="server" 
                        Category="ObjPurpose" Enabled="True" LoadingText="[Loading Object Purpose]" 
                        ParentControlID="ddlProductID" PromptText="[ALL PURPOSE]" 
                        ServiceMethod="GetDropDownObjPurposeByProduct" 
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlPurpose">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
            <tr>
                <td>
                    Obj./BPKB Status</td>
                <td>
                    <asp:DropDownList ID="ddlBPKBStatus" runat="server" 
                        DataSourceID="sdsBPKBStatus" DataTextField="NAME" DataValueField="CODE">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsBPKBStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand="SELECT NULL AS CODE, '[ALL STATUS]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'BPKBSTATUS')">
                    </asp:SqlDataSource>
                </td>
                <td>
                    Early Payment</td>
                <td>
                    <asp:RadioButton ID="rbEarlyExclude" runat="server" GroupName="rbPayEarly" 
                        Text="Exclude" />
                    <asp:RadioButton ID="rbEarlyInclude" runat="server" GroupName="rbPayEarly" 
                        Text="Include" />
                </td>
            </tr>
        </table>
    </asp:Panel>
        <asp:UpdatePanel ID="UPGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" Caption="Account for JF - RESELL List" 
                    DataKeyNames="LOCID,ACCID" DataSourceID="sdsGrid" RowHeaderColumn="ACCNO" 
                    Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="VW" SortExpression="ACCID">
                            <ItemTemplate>
                        <img src="../images/view.gif" style="cursor: pointer" onclick="EditApp('<%#eval("LOCID")%>', '<%#eval("APPID")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("APPID")%>" />
                                &nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterTemplate>
                                <asp:CheckBox ID="cbCheck" runat="server" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CHK" SortExpression="ACCID">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbChk" runat="server" />
                                <asp:HiddenField ID="txtAccNo" runat="server" Value='<%# Eval("ACCNO") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ACCNO" HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                            HtmlEncode="False" SortExpression="ACCNO">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REQUESTDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Request&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="REQUESTDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                            SortExpression="BOOKINGDATE">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Next&lt;br&gt;Due Date" 
                            SortExpression="NEXTDUEDATE">
                            <ItemTemplate>
                                <asp:Label ID="lblNextDueDate" runat="server" 
                                    BackColor='<%# System.Drawing.Color.FromName(DataBinder.Eval(Container.DataItem,"DAYDIFFCOLOR").ToString()) %>' 
                                    Font-Bold="True" Text='<%# Bind("NEXTDUEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Days&lt;br&gt;To&lt;br&gt;Due" 
                            SortExpression="DAYDIFF">
                            <ItemTemplate>
                                <asp:Label ID="lblDayDiff" runat="server" 
                                    BackColor='<%# System.Drawing.Color.FromName(DataBinder.Eval(Container.DataItem,"DAYDIFFCOLOR").ToString()) %>' 
                                    Font-Bold="True" Font-Underline="True" Text='<%# Eval("DAYDIFF") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                            HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                        <asp:BoundField DataField="BRANCH" HeaderText="Branch" ReadOnly="True" 
                            SortExpression="BRANCH" />
                        <asp:BoundField DataField="OSPRINCIPAL" DataFormatString="{0:N}" 
                            HeaderText="OS&lt;br&gt;Principal&lt;br&gt;Current" HtmlEncode="False" 
                            SortExpression="OSPRINCIPAL">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OSINTEREST" DataFormatString="{0:N}" 
                            HeaderText="OS&lt;br&gt;Interest&lt;br&gt;Current" HtmlEncode="False" 
                            SortExpression="OSINTEREST">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OSTENOR" HeaderText="OS&lt;br&gt;Ten" 
                            HtmlEncode="False" SortExpression="OSTENOR">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT TOP (500) LOCID, APPID, REQUESTDATE, ACCOUNTNAME, BRANCH, ACCID, IDNUMBER, BOOKINGDATE, ACCNO, CUSTNO, DSR, OSPRINCIPAL, OSINTEREST, OSTENOR, NEXTDUEDATE, DAYDIFF, DAYDIFFCOLOR FROM v_AccountForJFResell WHERE (ACCSTATUS = 1) AND (OSTENOR &gt; 0) AND (OSPRINCIPAL &gt; 0)">
                </asp:SqlDataSource>
                <asp:CheckBox ID="chkAll" runat="server" CssClass="ShowDetail" 
                    Text="Check/UnCheck All" />
            </ContentTemplate>
    </asp:UpdatePanel>


    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <asp:Panel ID="pnlProcess" runat="server" CssClass="RowStyle" Font-Bold="True" GroupingText="JF REQUEST - RESELL"
        Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="4">
                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
                        Style="text-align: center" Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                        </td>
            </tr>
            <tr>
                <td>
                    Join Finance Group</td>
                <td>
                    <asp:DropDownList ID="ddlJFGroup" runat="server" CssClass="required">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJFGroup" runat="server" Category="JFGROUP"
                        LoadingText="[Loading JF Group...]" PromptText="[JF GROUP]" ServiceMethod="GetDropDownJFGroup"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlJFGroup">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqJFGroup" runat="server" ControlToValidate="ddlJFGroup"
                        Display="None" ErrorMessage="JF GROUP must be entry...!" SetFocusOnError="True"
                        ValidationGroup="Save"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEJFGroup" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJFGroup">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Join Finance/Bank</td>
                <td>
                    <asp:DropDownList ID="ddlJF" runat="server" CssClass="required">
                    </asp:DropDownList><asp:Label ID="lblMirror" runat="server" CssClass="ErrHighLight"></asp:Label><ajaxToolkit:CascadingDropDown ID="ajaxCDDJF" runat="server" Category="JF"
                        LoadingText="[Loading JF/Bank...]" ParentControlID="ddlJFGroup" PromptText="[JF/BANK]"
                        ServiceMethod="GetDropDownJFByJFGroup" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJF">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqJF" runat="server" ControlToValidate="ddlJF" Display="None"
                        ErrorMessage="JF/BANK must be entry...!" SetFocusOnError="True" ValidationGroup="Save"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEJF" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJF">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Request Date</td>
                <td>
                    <asp:TextBox ID="txtRequestDate" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                    <asp:Image ID="imgRequestDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" /><asp:RequiredFieldValidator ID="reqRequestDate" runat="server"
                            ControlToValidate="txtRequestDate" Display="None" ErrorMessage="REQUEST DATE must be entry...!"
                            SetFocusOnError="True" ValidationGroup="Save"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCERequestDate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqRequestDate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCERequestDate" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgRequestDate"
                        TargetControlID="txtRequestDate" PopupPosition="TopRight">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEERequestDate" runat="server" Mask="99/99/9999"
                        MaskType="Date" TargetControlID="txtRequestDate">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
                <td>
                    Installment Day</td>
                <td>
                    <asp:TextBox ID="txtInstallmentDay" runat="server" Width="48px"></asp:TextBox>*)leave
                    blank if same with customer</td>
            </tr>
            <tr>
                <td class="HeaderStyle" colspan="4">
                    <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
                        cursor: pointer; background-repeat: no-repeat;  text-align: left"
                        Text="Save" ValidationGroup="Save" Width="56px" /></td>
            </tr>
        </table>
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });

    function pageLoad(sender, args) {
        $find("BehavArea").add_populated(onPopulatedArea);
        $find("BehavBranch").add_populated(onPopulatedBranch);
    }

    function onPopulatedArea() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlAreaSearch.ClientID%>").disabled = true;
        }
    }

    function onPopulatedBranch() {
        if (GetValueTxtByClientID("<%=hidIsUserBranch.ClientID%>") == "1") {
            $get("<%=ddlBranchSearch.ClientID%>").disabled = true;
        }
    }

window.onload=function(){
    TenorCheck();
    PrincipalCheck();
    fCheck("<%=cbDSR.ClientID%>", "<%=txtDSR.ClientID%>");
    fCheck("<%=cbAge.ClientID%>", "<%=txtAge.ClientID%>");
    fCheck("<%=cbDPMin.ClientID %>", "<%=txtDPMin.ClientID%>");
    getMirrorStatus();
}
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

function EditApp(LOCID, APPID){
    //window.location="AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID
    var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    winref.focus();
}
function TenorCheck(){
    var oTenor=getObjectbyClientID("<%=cbOSTenor.ClientID%>");
    var oTenorFrom=getObjectbyClientID("<%=txtTenorFrom.ClientID%>");
    var oTenorTo=getObjectbyClientID("<%=txtTenorTo.ClientID%>");
    if (oTenor.checked){
        oTenorFrom.readOnly=false;
        oTenorFrom.className="required";    
        oTenorTo.readOnly=false;
        oTenorTo.className="required";
    }else{
        oTenorFrom.readOnly=true;
        oTenorFrom.className="disabled";    
        oTenorTo.readOnly=true;
        oTenorTo.className="disabled";
    }
}
function PrincipalCheck(){
    var oPrincipal=getObjectbyClientID("<%=cbOSPrincipal.ClientID%>");
    var oPrincipalFrom=getObjectbyClientID("<%=txtPrincipalFrom.ClientID%>");
    var oPrincipalTo=getObjectbyClientID("<%=txtPrincipalTo.ClientID%>");
    if (oPrincipal.checked){
        oPrincipalFrom.readOnly=false;
        oPrincipalFrom.className="required";    
        oPrincipalTo.readOnly=false;
        oPrincipalTo.className="required";
    }else{
        oPrincipalFrom.readOnly=true;
        oPrincipalFrom.className="disabled";    
        oPrincipalTo.readOnly=true;
        oPrincipalTo.className="disabled";
    }
}
function fCheck(oCheck, oValue){
    var oDSRC=getObjectbyClientID(oCheck);
    var oDSR=getObjectbyClientID(oValue);
    if (oDSRC.checked){
        oDSR.readOnly=false;
        oDSR.className="required";    
    }else{
        oDSR.readOnly=true;
        oDSR.className="disabled";    
    }
}

function getMirrorStatus(){
    var JFID=GetValueTxtByClientID("<%=ddlJF.ClientID%>")
    if (JFID!=""){
        ret = GHWService.GetMirrorStatus(JFID, OnCompleteJF, OnTimeOutJF, OnErrorJF);
    }
}
function OnCompleteJF(arg) {
    var oMirror=getObjectbyClientID("<%=lblMirror.ClientID%>")
    var oDay=getObjectbyClientID("<%=txtInstallmentDay.ClientID%>")
    if (arg=="1"){
        oMirror.innerHTML="MIRRORING";
        oDay.value="";
        oDay.readOnly=true;
        oDay.className="disabled";
    }
    else{
        oMirror.innerHTML="NON MIRRORING";
        oDay.readOnly=false;
        oDay.className="";
    }
}

function OnTimeOutJF(arg) {
    alert("TimeOut encountered when calling GetMirrorStatus.");
}

function OnErrorJF(arg) {
    alert("Error encountered when calling GetMirrorStatus.");
}

function SelectRow(oCb) {
    if (oCb.checked)
        oCb.parentElement.parentElement.className = "SelectedRowStyle";
    else
        oCb.parentElement.parentElement.className = "";
}
function CheckAll() {
    var chk = getObjectbyClientID("<%=chkAll.ClientID%>");
    var sCheck = "<%=strCheckBox%>";
    var arrCheck = sCheck.split(",");
    var oCheck;
    var nLen = arrCheck.length - 1;
    if (nLen > 0) {
        for (var i = 0; i < nLen; i++) {
            oCheck = getObjectbyClientID(arrCheck[i].toString());
            if (oCheck) {
                oCheck.checked = chk.checked;
                if (oCheck.checked)
                    oCheck.parentElement.parentElement.className = "SelectedRowStyle";
                else
                    oCheck.parentElement.parentElement.className = "";
            }
        }
    }
}
</script>

</asp:Content>

