<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFApp.aspx.vb" Inherits="Param_JFApp" title="Join Finance Parameter Approval" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<%@ Register src="../UserControl/BtnApprovetNoSPV.ascx" tagname="BtnApprovetNoSPV" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnRejectNoSPV.ascx" tagname="BtnRejectNoSPV" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="JFNAME">JF NAME</asp:ListItem>
        <asp:ListItem Value="JFCODE">JF CODE</asp:ListItem>
    </asp:DropDownList></td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /></td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                JF Group</td>
            <td>
                <asp:DropDownList ID="ddlJFGroupSearch" runat="server" AutoPostBack="True" DataSourceID="sdsJFGroupSearch"
        DataTextField="JFGROUPNAME" DataValueField="JFGROUPID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsJFGroupSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS JFGROUPID, NULL AS JFGROUPCODE, '[DISPLAY ALL]' AS JFGROUPNAME UNION ALL SELECT JFGROUPID, JFGROUPCODE, JFGROUPCODE + ' - ' + JFGROUPNAME AS JFGROUPNAME FROM JFGROUP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY JFGROUPCODE">
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Revolving</td>
            <td>
                <asp:DropDownList ID="ddlRevolvingSearch" runat="server" AutoPostBack="True" DataSourceID="sdsRevolvingSearch"
        DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsRevolvingSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'REVOLVING')">
                </asp:SqlDataSource>
            </td>
            <td>
                Mirror Status</td>
            <td>
                <asp:DropDownList ID="ddlMirrorStatusSearch" runat="server" AutoPostBack="True" DataSourceID="sdsMirrorStatus"
        DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsMirrorStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFMIRRORSTATUS')">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Validation Criteria</td>
            <td>
                <asp:DropDownList ID="ddlValidCriteriaSearch" runat="server" AutoPostBack="True" DataSourceID="sdsValidCriteriaSearch"
        DataTextField="CRNAME" DataValueField="CRID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsValidCriteriaSearch" 
                    runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CRID, NULL AS CRCODE, '[DISPLAY ALL]' AS CRNAME UNION ALL SELECT CRID, CRCODE, CRCODE + ' - ' + CRNAME AS CRNAME FROM VALIDCRITERIA WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CRCODE">
                </asp:SqlDataSource>
            </td>
            <td>
                Document Received</td>
            <td>
                <asp:DropDownList ID="ddlDocReceived" runat="server" AutoPostBack="True" DataSourceID="sdsDocReceivedSearch"
        DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsDocReceivedSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (nOLOCK) WHERE (TYPE = 'JFDOCRECEIVED')">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                    Bank</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlBankSearch" runat="server"  DataSourceID="sdsBankSearch"
                    DataTextField="BANKNAME" DataValueField="BANKID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsBankSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                        
                        SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[DISPLAY ALL]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, BANKCODE + ' - ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
                </asp:SqlDataSource>
                </td>
        </tr>
    </table>

    <br />
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
            AutoGenerateColumns="False" 
            Caption="JF/JOIN FINANCE/MULTIFINANCE APPROVAL LIST" DataKeyNames="JFID"
            DataSourceID="sdsGrid" RowHeaderColumn="JFID" Width="100%">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                    ShowSelectButton="True" >
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:CommandField>
                <asp:BoundField DataField="JFID" HeaderText="JFID" ReadOnly="True" SortExpression="JFID" />
                <asp:BoundField DataField="JFGROUPNAME" HeaderText="JF&lt;br&gt;Group" HtmlEncode="False"
                    ReadOnly="True" SortExpression="JFGROUPNAME" />
                <asp:BoundField DataField="JFCODE" HeaderText="JF&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="JFCODE" />
                <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="JFNAME" />
                <asp:BoundField DataField="JFPKSNO" HeaderText="PKS&lt;br&gt;No." HtmlEncode="False"
                    SortExpression="JFPKSNO" />
                <asp:BoundField DataField="JFPKSDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="PKS&lt;br&gt;Date"
                    HtmlEncode="False" SortExpression="JFPKSDATE">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFMIRRORSTATUSNAME" HeaderText="Mirror&lt;br&gt;Status"
                    HtmlEncode="False" ReadOnly="True" SortExpression="JFMIRRORSTATUSNAME" />
                <asp:BoundField DataField="REVOLVINGNAME" HeaderText="Revolving?" SortExpression="REVOLVINGNAME" />
                <asp:BoundField DataField="JFPLAFOND" DataFormatString="{0:N}" HeaderText="Plafond"
                    SortExpression="JFPLAFOND">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="JFPLAFONDUSED" DataFormatString="{0:N}" HeaderText="Plafond&lt;br&gt;Used"
                    HtmlEncode="False" SortExpression="JFPLAFONDUSED">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT JFX.JFID, JFX.JFCODE, JFX.JFNAME, JFX.JFPKSNO, JFX.JFPKSDATE, 
'(' + CAST(JFX.JFMIRRORSTATUS AS VARCHAR(10)) + ') ' 
+ dbo.f_getParamGlobalName('JFMIRRORSTATUS', JFX.JFMIRRORSTATUS) AS JFMIRRORSTATUSNAME, 
'(' + JFGROUP.JFGROUPCODE + ') ' + JFGROUP.JFGROUPNAME AS JFGROUPNAME, 
'(' + CAST(JFX.JFREVOLVING AS varchar(10)) + ') ' 
+ dbo.f_getParamGlobalName('REVOLVING', JFX.JFREVOLVING) AS REVOLVINGNAME, 
JFX.JFPLAFOND, JFX.JFPLAFONDUSED
FROM JFX WITH (NOLOCK) INNER JOIN JFGROUP 
WITH (NOLOCK) ON JFX.JFGROUPID = JFGROUP.JFGROUPID">
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

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm" Width="100%" 
        DataKeyNames="JFID">
        <ItemTemplate>
            <asp:Panel ID="pnlApproval" runat="server" Enabled="False">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            JF ID</td>
                        <td colspan="3">
                            <asp:Label ID="lblJFID" runat="server" Text='<%# Eval("JFID") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            JF Group</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlJFGroup" runat="server" CssClass="required" 
                                DataSourceID="sdsJFGroup" DataTextField="JFGROUPNAME" 
                                DataValueField="JFGROUPID" SelectedValue='<%# Bind("JFGROUPID") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqJFGroup" runat="server" 
                                ControlToValidate="ddlJFGroup" Display="None" 
                                ErrorMessage="JF GROUP must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEJFGroup" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqJFGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            JF Code</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFCODETextBox" runat="server" CssClass="disabled" 
                                MaxLength="10" ReadOnly="True" Text='<%# Bind("JFCODE") %>' Width="88px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" 
                                ControlToValidate="JFCODETextBox" Display="None" 
                                ErrorMessage="JF CODE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            JF Code From Bank</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFCODEFROMBANKTextBox" runat="server" CssClass="disabled" 
                                MaxLength="20" ReadOnly="True" Text='<%# Bind("JFCODEFROMBANK") %>' 
                                Width="88px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Bank</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlBank" runat="server"  DataSourceID="sdsBank"
                            DataTextField="BANKNAME" DataValueField="BANKID" 
                                SelectedValue='<%# Bind("BANKID") %>' CssClass="required">
                            </asp:DropDownList><asp:RequiredFieldValidator ID="reqBank" runat="server" ControlToValidate="ddlBank"
                                Display="None" ErrorMessage="BANK must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCEBank" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBank">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail" colspan="4">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            JF Name</td>
                        <td class="ErrHighLight" colspan="3">
                            <asp:TextBox ID="JFNAMETextBox" runat="server" CssClass="required" 
                                MaxLength="50" Text='<%# Bind("JFNAME") %>' Width="192px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" 
                                ControlToValidate="JFNAMETextBox" Display="None" 
                                ErrorMessage="JF NAME must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFADDRESSTextBox" runat="server" MaxLength="100" 
                                Text='<%# Bind("JFADDRESS") %>' Width="384px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            City</td>
                        <td>
                            <asp:TextBox ID="JFCITYTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("JFCITY") %>' Width="192px"></asp:TextBox>
                        </td>
                        <td>
                            Zip</td>
                        <td>
                            <asp:TextBox ID="JFZIPTextBox" runat="server" MaxLength="10" 
                                Text='<%# Bind("JFZIP") %>' Width="80px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            Agreement</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            PKS No</td>
                        <td>
                            <asp:TextBox ID="JFPKSNOTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("JFPKSNO") %>'></asp:TextBox>
                        </td>
                        <td>
                            PKS Date</td>
                        <td>
                            <asp:TextBox ID="JFPKSDATETextBox" runat="server" 
                                Text='<%# Bind("JFPKSDATE", "{0:dd/MM/yyyy}") %>' Width="72px"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="ajaxCEPKSDate" runat="server" Format="dd/MM/yyyy" 
                                PopupButtonID="imgPKSDate" TargetControlID="JFPKSDATETextBox">
                            </ajaxToolkit:CalendarExtender>
                            <ajaxToolkit:MaskedEditExtender ID="ajaxMEEPKSDate" runat="server" Mask="99/99/9999" 
                                MaskType="Date" TargetControlID="JFPKSDATETextBox">
                            </ajaxToolkit:MaskedEditExtender>
                            <asp:Image ID="imgPKSDate" runat="server" ImageUrl="~/images/grid.gif" 
                                Style="cursor: pointer" ToolTip="Calendar" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            PKS Title</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFPKSTITLETextBox" runat="server" MaxLength="150" 
                                Text='<%# Bind("JFPKSTITLE") %>' Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Letter No.</td>
                        <td>
                            <asp:TextBox ID="JFLETTERNOTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("JFLETTERNO") %>'></asp:TextBox>
                        </td>
                        <td>
                            Notary</td>
                        <td>
                            <asp:TextBox ID="JFNOTARYTextBox" runat="server" MaxLength="60" 
                                Text='<%# Bind("JFNOTARY") %>' Width="224px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="ShowDetail" colspan="4">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Revolving Type</td>
                        <td>
                            <asp:DropDownList ID="ddlRevolving" runat="server" CssClass="required" 
                                DataSourceID="sdsRevolving" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFREVOLVING") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqRevolving" runat="server" 
                                ControlToValidate="ddlRevolving" Display="None" 
                                ErrorMessage="REVOLVING  TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCERevolving" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqRevolving">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Commitment Fee</td>
                        <td>
                            <asp:TextBox ID="txtCommitmentFee" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFCOMMITFEE", "{0:N}") %>' 
                                Width="128px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCommitFee" runat="server" 
                                ControlToValidate="txtCommitmentFee" Display="None" 
                                ErrorMessage="COMMITMENT FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECommitFee" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqCommitFee">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Plafond</td>
                        <td>
                            <asp:TextBox ID="txtPlafond" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFPLAFOND", "{0:N}") %>' 
                                Width="112px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqPlafond" runat="server" 
                                ControlToValidate="txtPlafond" Display="None" 
                                ErrorMessage="FLAFOND must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPlafond" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqPlafond">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Plafond Used</td>
                        <td>
                            <asp:TextBox ID="txtPlafondUsed" runat="server" CssClass="disabled" 
                                ReadOnly="True" Style="text-align: right" 
                                Text='<%# Eval("JFPLAFONDUSED", "{0:N}") %>' Width="128px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Mirror Status</td>
                        <td>
                            <asp:CheckBox ID="JFMIRRORSTATUSCheckBox" runat="server" 
                                Checked='<%# Bind("JFMIRRORSTATUS") %>' Text="Checked if Enabled Mirroring" />
                        </td>
                        <td>
                            Payment Type</td>
                        <td>
                            <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="required" 
                                DataSourceID="sdsPaymentType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFPAYMENTTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqPaymentType" runat="server" 
                                ControlToValidate="ddlPaymentType" Display="None" 
                                ErrorMessage="PAYMENT TYPE  must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPaymentType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Early Payment</td>
                        <td>
                            <asp:CheckBox ID="JFEARLYPAYMENTCheckBox" runat="server" 
                                Checked='<%# Bind("JFEARLYPAYMENT") %>' 
                                Text="Checked if Enabled Early Payment" />
                        </td>
                        <td>
                            First Payment Type</td>
                        <td>
                            <asp:DropDownList ID="ddlFirstPaymentType" runat="server" CssClass="required" 
                                DataSourceID="sdsFirstPaymentType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFFIRSTPAYMENTTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqFirstPaymentType" runat="server" 
                                ControlToValidate="ddlFirstPaymentType" Display="None" 
                                ErrorMessage="FIRST PAYMENT TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEFirstPaymentType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqFirstPaymentType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Bank Account Payment</td>
                        <td>
                            <asp:DropDownList ID="ddlAccountIDPay" runat="server" CssClass="required" 
                                DataSourceID="sdsBankAccount" DataTextField="ACCOUNTNO" 
                                DataValueField="ACCOUNTID" SelectedValue='<%# Bind("JFACCOUNTIDPAY") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqBankPayment" runat="server" 
                                ControlToValidate="ddlAccountIDPay" Display="None" 
                                ErrorMessage="BANK ACCOUNT PAYMENT must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBankPayment" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqBankPayment">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Bank Account&nbsp; Dropping</td>
                        <td>
                            <asp:DropDownList ID="ddlAccountIDDrop" runat="server" CssClass="required" 
                                DataSourceID="sdsBankAccount" DataTextField="ACCOUNTNO" 
                                DataValueField="ACCOUNTID" SelectedValue='<%# Bind("JFACCOUNTIDDROP") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqBankDrop" runat="server" 
                                ControlToValidate="ddlAccountIDDrop" Display="None" 
                                ErrorMessage="BANK DROPPING must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEBankDrop" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqBankDrop">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Portion</td>
                        <td>
                            <asp:TextBox ID="JFPORTIONTextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFPORTION", "{0:N}") %>' Width="56px"></asp:TextBox>
                            %<asp:RequiredFieldValidator ID="reqPortion" runat="server" 
                                ControlToValidate="JFPORTIONTextBox" Display="None" 
                                ErrorMessage="JF PORTION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPortion" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqPortion">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Default Eff. Rate</td>
                        <td>
                            <asp:TextBox ID="JFEFFRATEDEFAULTTextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFEFFRATEDEFAULT", "{0:N6}") %>' 
                                Width="72px"></asp:TextBox>
                            %<asp:RequiredFieldValidator ID="reqJFEffRateDef" runat="server" 
                                ControlToValidate="JFEFFRATEDEFAULTTextBox" Display="None" 
                                ErrorMessage="DEFAULT EFF. RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEEffRAteDef" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqJFEffRateDef">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Penalty Shared</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFPENALTYSHAREDTextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFPENALTYSHARED", "{0:N}") %>' 
                                Width="56px"></asp:TextBox>
                            %<asp:RequiredFieldValidator ID="reqPenaltyShare" runat="server" 
                                ControlToValidate="JFPENALTYSHAREDTextBox" Display="None" 
                                ErrorMessage="PENALTY SHARED must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPenaltyShare" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyShare">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Document Received</td>
                        <td class="ErrHighLight">
                            <asp:DropDownList ID="ddlDocReceived" runat="server" CssClass="required" 
                                DataSourceID="sdsDocReceived" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFDOCRECEIVED") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqDocReceived" runat="server" 
                                ControlToValidate="ddlDocReceived" Display="None" 
                                ErrorMessage="DOCUMENT RECEIVED must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDocReceived" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqDocReceived">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            JF Installment Type</td>
                        <td>
                           <asp:DropDownList ID="ddlJFInstType" runat="server" CssClass="required" 
                                DataSourceID="sdsJFInstType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFINSTALLMENTTYPE") %>'>
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF Penalty</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Penalty Rate</td>
                        <td>
                            <asp:TextBox ID="JFPENALTYRATETextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFPENALTYRATE", "{0:N}") %>' 
                                Width="56px"></asp:TextBox>
                            %<asp:RequiredFieldValidator ID="reqPenaltyRate" runat="server" 
                                ControlToValidate="JFPENALTYRATETextBox" Display="None" 
                                ErrorMessage="PENALTY RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPenaltyRate" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyRate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Grace Period</td>
                        <td>
                            <asp:TextBox ID="JFGRACEPERIODTextBox" runat="server" CssClass="required" 
                                MaxLength="3" Style="text-align: right" 
                                Text='<%# Bind("JFGRACEPERIOD", "{0:N}") %>' Width="56px"></asp:TextBox>
                            day(s)<asp:RequiredFieldValidator ID="reqGracePeriod" runat="server" 
                                ControlToValidate="JFGRACEPERIODTextBox" Display="None" 
                                ErrorMessage="GRACE PERIOD must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEGracePeriod" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqGracePeriod">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Working Days</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFWORKINGDAYSTextBox" runat="server" CssClass="required" 
                                MaxLength="2" Style="text-align: right" 
                                Text='<%# Bind("JFWORKINGDAYS", "{0:N}") %>' Width="56px"></asp:TextBox>
                            day(s)<asp:RequiredFieldValidator ID="reqWorkDay" runat="server" 
                                ControlToValidate="JFWORKINGDAYSTextBox" Display="None" 
                                ErrorMessage="WORKING DAYS must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEWorkDay" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqWorkDay">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            ET(Buy Back)</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            ET Penalty Type</td>
                        <td>
                            <asp:DropDownList ID="ddlETPenaltyType" runat="server" CssClass="required" 
                                DataSourceID="sdsETPenaltyType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFETPENALTYTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqETPenaltyType" runat="server" 
                                ControlToValidate="ddlETPenaltyType" Display="None" 
                                ErrorMessage="ET PENALTY TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEETPenaltyType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqETPenaltyType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            ET Penalty</td>
                        <td>
                            <asp:TextBox ID="JFETPENALTYTextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFETPENALTY", "{0:N}") %>' 
                                Width="64px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqETPenalty" runat="server" 
                                ControlToValidate="JFETPENALTYTextBox" Display="None" 
                                ErrorMessage="ET PENALTY must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEETPenalty" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqETPenalty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Admin Fee Termination</td>
                        <td colspan="3">
                            <asp:TextBox ID="JFADMTERMINATETextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFADMTERMINATE", "{0:N}") %>' 
                                Width="112px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqETAdmin" runat="server" 
                                ControlToValidate="JFADMTERMINATETextBox" Display="None" 
                                ErrorMessage="ET ADMIN FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEETAdmin" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqETAdmin">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF Admin</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Admin Type</td>
                        <td>
                            <asp:DropDownList ID="ddlAdminType" runat="server" CssClass="required" 
                                DataSourceID="sdsAdminType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFADMINTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqAdminType" runat="server" 
                                ControlToValidate="ddlAdminType" Display="None" 
                                ErrorMessage="ADMIN TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAdminType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqAdminType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Admin</td>
                        <td>
                            <asp:TextBox ID="JFADMINTextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFADMIN", "{0:N}") %>' Width="112px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqAdmin" runat="server" 
                                ControlToValidate="JFADMINTextBox" Display="None" 
                                ErrorMessage="ADMIN FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAdmin" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF Provision</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Prov. Type</td>
                        <td>
                            <asp:DropDownList ID="ddlProvisionType" runat="server" CssClass="required" 
                                DataSourceID="sdsProvisionType" DataTextField="NAME" DataValueField="CODE" 
                                SelectedValue='<%# Bind("JFPROVISIONTYPE") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqProvType" runat="server" 
                                ControlToValidate="ddlProvisionType" Display="None" 
                                ErrorMessage="PROVISION TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEProvType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqProvType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>
                            Provision</td>
                        <td>
                            <asp:TextBox ID="JFPROVISIONTextBox" runat="server" CssClass="required" 
                                Style="text-align: right" Text='<%# Bind("JFPROVISION", "{0:N}") %>' 
                                Width="112px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqProvision" runat="server" 
                                ControlToValidate="JFPROVISIONTextBox" Display="None" 
                                ErrorMessage="PROVISION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEProvision" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqProvision">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="HeaderStyle">
                            JF COA</td>
                        <td class="FooterStyle" colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Receivable</td>
                        <td>
                            <asp:DropDownList ID="ddlCOAReceivable" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFRECEIVABLECOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Interest</td>
                        <td>
                            <asp:DropDownList ID="ddlCOAInterest" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFINTERESTCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Provision</td>
                        <td>
                            <asp:DropDownList ID="ddlCOAProvision" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFPROVISIONCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Admin</td>
                        <td>
                            <asp:DropDownList ID="ddlCOAAmin" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFADMINCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Deposit</td>
                        <td>
                            <asp:DropDownList ID="ddlCOADeposit" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFDEPOSITCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="AlternatingRowStyle">
                            ET Penalty</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlCOAETPenalty" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFETPENALTYCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="AlternatingRowStyle">
                            ET Admin</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlCOAETAdmin" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFETADMINCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="AlternatingRowStyle">
                            ET Other Fee</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlCOAOtherFee" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFETOTHERFEECOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="AlternatingRowStyle">
                            ET Value</td>
                        <td class="AlternatingRowStyle">
                            <asp:DropDownList ID="ddlCOAETValue" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFETAMOUNTCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Debt</td>
                        <td>
                            <asp:DropDownList ID="ddlCOADebt" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFDEBTCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Penalty Shared</td>
                        <td>
                            <asp:DropDownList ID="ddlCOASharePenalty" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFPENALTYSHAREDCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Penalty</td>
                        <td>
                            <asp:DropDownList ID="ddlCOAPenalty" runat="server" DataSourceID="sdsCOA" 
                                DataTextField="COA" DataValueField="COAID" 
                                SelectedValue='<%# Bind("JFPENALTYCOAID") %>' Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
                <uc7:BtnApprovetNoSPV ID="BtnApprovetNoSPV1" runat="server" />
                <uc8:BtnRejectNoSPV ID="BtnRejectNoSPV1" runat="server" />
                <uc3:BtnCancel ID="BtnCancel3" runat="server" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsPaymentType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFPAYMENTTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBankAccount" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS ACCOUNTID, NULL AS BANKNAME, '[BANK ACCOUNT NO]' AS ACCOUNTNO UNION ALL SELECT BANKACCOUNT.ACCOUNTID, BANK.BANKNAME, BANK.BANKNAME + ' - ' + BANKACCOUNT.ACCOUNTNO AS ACCOUNTNO FROM BANKACCOUNT WITH (NOLOCK) INNER JOIN BANK WITH (NOLOCK) ON BANKACCOUNT.BANKID = BANK.BANKID WHERE (BANKACCOUNT.DELETESTS = 0) ORDER BY BANKNAME">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsJFGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS JFGROUPID, NULL AS JFGROUPCODE, '[JF GROUP]' AS JFGROUPNAME UNION ALL SELECT JFGROUPID, JFGROUPCODE, '(' + JFGROUPCODE + ') ' + JFGROUPNAME AS JFGROUPNAME FROM JFGROUP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY JFGROUPCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        
        SelectCommand="SELECT JFID, (SELECT JFGROUPID FROM JFGROUP WHERE (JFGROUPID = JFX.JFGROUPID) AND (Deletests = 0)) AS JFGROUPID, JFCODE, JFNAME, JFADDRESS, JFCITY, JFZIP, (SELECT ACCOUNTID FROM BANKACCOUNT WHERE (ACCOUNTID = JFX.JFACCOUNTIDPAY) AND (DELETESTS = 0)) AS JFACCOUNTIDPAY, (SELECT ACCOUNTID FROM BANKACCOUNT AS BANKACCOUNT_1 WHERE (ACCOUNTID = JFX.JFACCOUNTIDDROP) AND (DELETESTS = 0)) AS JFACCOUNTIDDROP, JFPORTION, JFEFFRATEDEFAULT, JFPENALTYSHARED, JFPENALTYRATE, JFGRACEPERIOD, JFWORKINGDAYS, JFETPENALTYTYPE, JFETPENALTY, JFADMINTYPE, JFADMIN, JFPROVISIONTYPE, JFPROVISION, JFADMTERMINATE, JFMIRRORSTATUS, JFPAYMENTTYPE, JFEARLYPAYMENT, JFFIRSTPAYMENTTYPE, JFPKSNO, JFPKSDATE, JFPKSTITLE, JFLETTERNO, JFNOTARY, JFPLAFOND, JFPLAFONDUSED, JFREVOLVING, JFCOMMITFEE, JFMINETDEV, JFMAXETDEV, JFDOCRECEIVED, JFINSTALLMENTTYPE, BANKID, (SELECT COAID FROM COA WHERE (COAID = JFX.JFRECEIVABLECOAID) AND (DELETESTS = 0)) AS JFRECEIVABLECOAID, (SELECT COAID FROM COA AS COA_10 WHERE (COAID = JFX.JFINTERESTCOAID) AND (DELETESTS = 0)) AS JFINTERESTCOAID, (SELECT COAID FROM COA AS COA_9 WHERE (COAID = JFX.JFPROVISIONCOAID) AND (DELETESTS = 0)) AS JFPROVISIONCOAID, (SELECT COAID FROM COA AS COA_8 WHERE (COAID = JFX.JFADMINCOAID) AND (DELETESTS = 0)) AS JFADMINCOAID, (SELECT COAID FROM COA AS COA_7 WHERE (COAID = JFX.JFDEPOSITCOAID) AND (DELETESTS = 0)) AS JFDEPOSITCOAID, (SELECT COAID FROM COA AS COA_6 WHERE (COAID = JFX.JFETPENALTYCOAID) AND (DELETESTS = 0)) AS JFETPENALTYCOAID, (SELECT COAID FROM COA AS COA_5 WHERE (COAID = JFX.JFETADMINCOAID) AND (DELETESTS = 0)) AS JFETADMINCOAID, (SELECT COAID FROM COA AS COA_4 WHERE (COAID = JFX.JFETOTHERFEECOAID) AND (DELETESTS = 0)) AS JFETOTHERFEECOAID, (SELECT COAID FROM COA AS COA_3 WHERE (COAID = JFX.JFDEBTCOAID) AND (DELETESTS = 0)) AS JFDEBTCOAID, (SELECT COAID FROM COA AS COA_2 WHERE (COAID = JFX.JFPENALTYSHAREDCOAID) AND (DELETESTS = 0)) AS JFPENALTYSHAREDCOAID, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = JFX.JFPENALTYCOAID) AND (DELETESTS = 0)) AS JFPENALTYCOAID, (SELECT COAID FROM COA AS COA_11 WHERE (COAID = JFX.JFETAMOUNTCOAID) AND (DELETESTS = 0)) AS JFETAMOUNTCOAID, JFCODEFROMBANK FROM JFX WHERE (JFID = @JFID)" >
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="JFID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFirstPaymentType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[FIRST PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFFIRSTPAYMENTTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsETPenaltyType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[ET PENALTY TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFETPENALTYTYPE')">
    </asp:SqlDataSource><asp:SqlDataSource ID="sdsAdminType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[ADMIN TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFADMINTYPE')">
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsProvisionType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[PROVISION TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFPROVISIONTYPE')">
</asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidCriteria" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CRID, NULL AS CRCODE, '[VALIDATION CRITERIA NAME]' AS CRNAME UNION ALL SELECT CRID, CRCODE, '(' + CRCODE + ') ' + CRNAME AS CRNAME FROM VALIDCRITERIA WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CRCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRevolving" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[REVOLVING]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'REVOLVING')">
    </asp:SqlDataSource><asp:SqlDataSource ID="sdsDocReceived" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[DOC. RECEIVED]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFDOCRECEIVED')">
    </asp:SqlDataSource><asp:SqlDataSource ID="sdsReCalcRate" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[RE-CALCULATE ]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFRECALCRATE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCOA" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
    SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COA UNION ALL SELECT COAID, COANO, COANO + ' ' + COANAME AS COA FROM COA WITH (NOLOCK) WHERE (DELETESTS = 0) AND (HARDCODE = 0) ORDER BY COANO">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsJFInstType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
    
        SelectCommand="SELECT NULL AS CODE, '[JF INSTALLMENT TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFINSTALLMENTTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, '(' + BANKCODE + ') ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
window.onload=function(){
    TabToEnter();
}
var oForm = document.getElementById ? document.getElementById("<%=Form.ClientID%>") : document.forms["<%=Form.ClientID%>"]; 
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}

function EditAdmRate(JFID){
    window.open("../Param/JFAdmRate.aspx?Action=Edit&JFID=" + JFID,"JFAdmRate", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
    return false;
}
function BranchJF(JFID){
    window.open("../Param/JFBranch.aspx?Action=Edit&JFID=" + JFID,"JFBranch", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
}
function InsJF(JFID){
    window.open("../Param/JFIns.aspx?Action=Edit&JFID=" + JFID,"JFIns", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
}

function ShowCriteria(){
    var oCriteria=getObjectbyClientID("<%=strDDLCriteria%>") 
    if (oCriteria.value==""){
        alert("Criteria must be input first..!");
        oCriteria.focus();
        return false;
    }
    window.open("../Param/CriteriaView.aspx?Action=View&CRID=" + oCriteria.value,"CrtView", "height=370,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
    return false;
}

function MerkJF(JFID){
    window.open("../Param/MerkMap.aspx?Action=Edit&JFID=" + JFID,"JFBranch", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
}
</script>

</asp:Content>

