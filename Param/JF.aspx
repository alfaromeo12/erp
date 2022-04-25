<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JF.aspx.vb" Inherits="Param_JF" title="Join Finance Parameter Entry/Editing" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="FooterStyle">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="JFNAME">JF NAME</asp:ListItem>
        <asp:ListItem Value="JFCODE">JF CODE</asp:ListItem>
    </asp:DropDownList></td>
            <td class="FooterStyle" colspan="3">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
                <asp:Button ID="btnFunctionSearch" runat="server" Text="Search" CausesValidation="False" CssClass="Search" /></td>
        </tr>
        <tr>
            <td class="AlternatingRowStyle">
                JF Group</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:DropDownList ID="ddlJFGroupSearch" runat="server" DataSourceID="sdsJFGroupSearch"
        DataTextField="JFGROUPNAME" DataValueField="JFGROUPID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsJFGroupSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS JFGROUPID, NULL AS JFGROUPCODE, '[DISPLAY ALL]' AS JFGROUPNAME UNION ALL SELECT JFGROUPID, JFGROUPCODE, JFGROUPCODE + ' - ' + JFGROUPNAME AS JFGROUPNAME FROM JFGROUP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY JFGROUPCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowStyle">
                Revolving</td>
            <td class="RowStyle">
                <asp:DropDownList ID="ddlRevolvingSearch" runat="server" DataSourceID="sdsRevolvingSearch"
        DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsRevolvingSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'REVOLVING')">
                </asp:SqlDataSource>
            </td>
            <td class="RowStyle">
                Mirror Status</td>
            <td class="RowStyle">
                <asp:DropDownList ID="ddlMirrorStatusSearch" runat="server" DataSourceID="sdsMirrorStatus"
        DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsMirrorStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFMIRRORSTATUS')">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="FooterStyle">
                Validation Criteria</td>
            <td class="FooterStyle">
                <asp:DropDownList ID="ddlValidCriteriaSearch" runat="server" DataSourceID="sdsValidCriteriaSearch"
        DataTextField="CRNAME" DataValueField="CRID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsValidCriteriaSearch" 
                    runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CRID, NULL AS CRCODE, '[DISPLAY ALL]' AS CRNAME UNION ALL SELECT CRID, CRCODE, CRCODE + ' - ' + CRNAME AS CRNAME FROM VALIDCRITERIA WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CRCODE">
                </asp:SqlDataSource>
            </td>
            <td class="FooterStyle">
                Document Received</td>
            <td class="FooterStyle">
                <asp:DropDownList ID="ddlDocReceived" runat="server" DataSourceID="sdsDocReceivedSearch"
        DataTextField="NAME" DataValueField="CODE">
                </asp:DropDownList><asp:SqlDataSource ID="sdsDocReceivedSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFDOCRECEIVED')">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="AlternatingRowStyle">
                    Bank</td>
                <td class="AlternatingRowStyle" colspan="3">
                    <asp:DropDownList ID="ddlBankSearch" runat="server"  DataSourceID="sdsBankSearch"
                    DataTextField="BANKNAME" DataValueField="BANKID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsBankSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
                        
                        SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[DISPLAY ALL]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, BANKCODE + ' -  ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
                </asp:SqlDataSource>
                </td>
        </tr>
    </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
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
            AutoGenerateColumns="False" Caption="JF/JOIN FINANCE/MULTIFINANCE LIST" DataKeyNames="JFID"
            DataSourceID="sdsGrid" RowHeaderColumn="JFID" Width="100%">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" ImageUrl="~/Images/edit.gif" Text="Select" 
                            Visible='<%# NOT Eval("NEW") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MR" Visible="False">
                    <ItemTemplate>
                        <img src="../Images/car.gif" style="cursor: pointer" alt="JF Merk Mapping : <%#eval("JFID")%>" onclick="MerkJF(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="BR" Visible="False">
                    <ItemTemplate>
                        <img src="../Images/branch.gif" style="cursor: pointer" alt="JF Branch List : <%#eval("JFID")%>" onclick="BranchJF(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="INS" Visible="False">
                    <ItemTemplate>
                        <img src="../Images/insurance.gif" style="cursor: pointer" alt="JF Insurance List : <%#eval("JFID")%>" onclick="InsJF(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate">
                    <ItemTemplate>
                        <img src="../Images/setting.png" style="cursor: pointer" alt="Admin and Rate JF : <%#eval("JFID")%>" onclick="return EditAdmRate(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TnC">
                    <ItemTemplate>
                        <img src="../Images/info.png" style="cursor: pointer" alt='TNC JF : <%#eval("JFID")%>' onclick="return EditTNC(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TXT">
                    <ItemTemplate>
                        <img src="../Images/textfile.png" style="cursor: pointer" alt='Text Setting : <%#eval("JFID")%>' onclick="return EditTxt(<%#eval("JFID")%>)" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
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
        
        
        
        SelectCommand="SELECT JFID, JFCODE, JFNAME, JFPKSNO, JFPKSDATE, JFMIRRORSTATUSNAME, JFGROUPNAME, REVOLVINGNAME, JFPLAFOND, JFPLAFONDUSED, JFGROUPID, JFREVOLVING, JFMIRRORSTATUS, JFDOCRECEIVED, Deletests, NEW, UPD FROM (SELECT JF_1.JFID, JF_1.JFCODE, JF_1.JFNAME, JF_1.JFPKSNO, JF_1.JFPKSDATE, '(' + CAST(JF_1.JFMIRRORSTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF_1.JFMIRRORSTATUS) AS JFMIRRORSTATUSNAME, '(' + JFGROUP.JFGROUPCODE + ') ' + JFGROUP.JFGROUPNAME AS JFGROUPNAME, '(' + CAST(JF_1.JFREVOLVING AS varchar(10)) + ') ' + dbo.f_getParamGlobalName('REVOLVING', JF_1.JFREVOLVING) AS REVOLVINGNAME, JF_1.JFPLAFOND, JF_1.JFPLAFONDUSED, JF_1.JFGROUPID, JF_1.JFREVOLVING, JF_1.JFMIRRORSTATUS, JF_1.JFDOCRECEIVED, JF_1.Deletests, CAST(0 AS BIT) AS NEW, CASE WHEN EXISTS (SELECT 'X' FROM JFX WHERE JFX.JFID = JF_1.JFID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD FROM JF AS JF_1 WITH (NOLOCK) INNER JOIN JFGROUP WITH (NOLOCK) ON JF_1.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF_1.Deletests = 0) UNION ALL SELECT JF.JFID, JF.JFCODE, JF.JFNAME, JF.JFPKSNO, JF.JFPKSDATE, '(' + CAST(JF.JFMIRRORSTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS JFMIRRORSTATUSNAME, '(' + JFGROUP_1.JFGROUPCODE + ') ' + JFGROUP_1.JFGROUPNAME AS JFGROUPNAME, '(' + CAST(JF.JFREVOLVING AS varchar(10)) + ') ' + dbo.f_getParamGlobalName('REVOLVING', JF.JFREVOLVING) AS REVOLVINGNAME, JF.JFPLAFOND, JF.JFPLAFONDUSED, JF.JFGROUPID, JF.JFREVOLVING, JF.JFMIRRORSTATUS, JF.JFDOCRECEIVED, JF.Deletests, CAST(1 AS BIT) AS NEW, CAST(0 AS BIT) AS UPD FROM JFX AS JF WITH (NOLOCK) INNER JOIN JFGROUP AS JFGROUP_1 WITH (NOLOCK) ON JF.JFGROUPID = JFGROUP_1.JFGROUPID WHERE (JF.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JF AS A WHERE (JFID = JF.JFID)))) AS JF_2 WHERE (Deletests = 0)">
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

    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="JFID">
        <EditItemTemplate><table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    JF ID</td>
                <td colspan="3">
                    <asp:Label ID="lblJFID" runat="server" Text='<%# Eval("JFID") %>'></asp:Label></td>
            </tr>
            <tr>
                <td>
                    JF Group</td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlJFGroup" runat="server"  DataSourceID="sdsJFGroup"
        DataTextField="JFGROUPNAME" DataValueField="JFGROUPID" SelectedValue='<%# Bind("JFGROUPID") %>' CssClass="required">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqJFGroup" runat="server" ControlToValidate="ddlJFGroup"
                        Display="None" ErrorMessage="JF GROUP must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEJFGroup" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJFGroup">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    JF Code</td>
                <td colspan="3">
                    <asp:TextBox ID="JFCODETextBox" runat="server" CssClass="disabled" MaxLength="10"
                        Text='<%# Bind("JFCODE") %>' Width="88px" ReadOnly="True"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="JFCODETextBox" Display="None"
                            ErrorMessage="JF CODE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    JF Code From Bank</td>
                <td colspan="3">
                    <asp:TextBox ID="JFCODEFROMBANKTextBox" runat="server" 
                        MaxLength="20" Text='<%# Bind("JFCODEFROMBANK") %>' 
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
                <td colspan="4" class="ShowDetail">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="ErrHighLight">
                    JF Name</td>
                <td colspan="3" class="ErrHighLight">
                    <asp:TextBox ID="JFNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                        Text='<%# Bind("JFNAME") %>' Width="192px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="JFNAMETextBox" Display="None"
                            ErrorMessage="JF NAME must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Address</td>
                <td colspan="3">
                    <asp:TextBox ID="JFADDRESSTextBox" runat="server" MaxLength="100" Text='<%# Bind("JFADDRESS") %>'
                        Width="384px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    City</td>
                <td>
                    <asp:TextBox ID="JFCITYTextBox" runat="server" MaxLength="50" Text='<%# Bind("JFCITY") %>'
                        Width="192px"></asp:TextBox></td>
                <td>
                    Zip</td>
                <td>
                    <asp:TextBox ID="JFZIPTextBox" runat="server" MaxLength="10" Text='<%# Bind("JFZIP") %>'
                        Width="80px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="HeaderStyle">
                    Agreement</td>
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    PKS No</td>
                <td>
                    <asp:TextBox ID="JFPKSNOTextBox" runat="server" MaxLength="50" Text='<%# Bind("JFPKSNO") %>'></asp:TextBox></td>
                <td>
                    PKS Date</td>
                <td>
                    <asp:TextBox ID="JFPKSDATETextBox" runat="server" Text='<%# Bind("JFPKSDATE", "{0:dd/MM/yyyy}") %>'
                        Width="72px"></asp:TextBox><asp:Image
                ID="imgPKSDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEPKSDate" runat="server" Format="dd/MM/yyyy"
                    PopupButtonID="imgPKSDate" TargetControlID="JFPKSDATETextBox">
                            </ajaxToolkit:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    PKS Title</td>
                <td colspan="3">
                    <asp:TextBox ID="JFPKSTITLETextBox" runat="server" MaxLength="150" Text='<%# Bind("JFPKSTITLE") %>'
                        Width="400px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Letter No.</td>
                <td>
                    <asp:TextBox ID="JFLETTERNOTextBox" runat="server" MaxLength="50" Text='<%# Bind("JFLETTERNO") %>'></asp:TextBox></td>
                <td>
                    Notary</td>
                <td>
                    <asp:TextBox ID="JFNOTARYTextBox" runat="server" MaxLength="60" Text='<%# Bind("JFNOTARY") %>'
                        Width="224px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="4" class="ShowDetail">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Revolving Type</td>
                <td>
                    <asp:DropDownList ID="ddlRevolving" runat="server" CssClass="required" DataSourceID="sdsRevolving"
                        DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFREVOLVING") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqRevolving" runat="server" ControlToValidate="ddlRevolving"
                        Display="None" ErrorMessage="REVOLVING  TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCERevolving" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqRevolving">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Commitment Fee</td>
                <td>
                    <asp:TextBox ID="txtCommitmentFee" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFCOMMITFEE", "{0:N}") %>' Width="128px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCommitFee" runat="server" ControlToValidate="txtCommitmentFee" Display="None"
                            ErrorMessage="COMMITMENT FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCECommitFee" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCommitFee">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Plafond</td>
                <td>
                    <asp:TextBox ID="txtPlafond" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFPLAFOND", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqPlafond" runat="server" ControlToValidate="txtPlafond" Display="None"
                            ErrorMessage="FLAFOND must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPlafond" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPlafond">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Plafond Used</td>
                <td>
                    <asp:TextBox ID="txtPlafondUsed" runat="server" CssClass="disabled" ReadOnly="True"
                        Style="text-align: right" Text='<%# Eval("JFPLAFONDUSED", "{0:N}") %>' Width="128px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Mirror Status</td>
                <td>
                    <asp:CheckBox ID="JFMIRRORSTATUSCheckBox" runat="server" Checked='<%# Bind("JFMIRRORSTATUS") %>' Text="Checked if Enabled Mirroring" /></td>
                <td>
                    Payment Type</td>
                <td>
                    <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="required" DataSourceID="sdsPaymentType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFPAYMENTTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqPaymentType" runat="server"
                        ControlToValidate="ddlPaymentType" Display="None" ErrorMessage="PAYMENT TYPE  must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPaymentType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Early Payment</td>
                <td>
                    <asp:CheckBox ID="JFEARLYPAYMENTCheckBox" runat="server" Checked='<%# Bind("JFEARLYPAYMENT") %>' Text="Checked if Enabled Early Payment" /></td>
                <td>
                    First Payment Type</td>
                <td>
                    <asp:DropDownList ID="ddlFirstPaymentType" runat="server" CssClass="required" DataSourceID="sdsFirstPaymentType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFFIRSTPAYMENTTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqFirstPaymentType" runat="server"
                        ControlToValidate="ddlFirstPaymentType" Display="None" ErrorMessage="FIRST PAYMENT TYPE must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEFirstPaymentType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFirstPaymentType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Bank Account Payment</td>
                <td>
                    <asp:DropDownList ID="ddlAccountIDPay" runat="server" CssClass="required" DataSourceID="sdsBankAccount"
                            DataTextField="ACCOUNTNO" DataValueField="ACCOUNTID" SelectedValue='<%# Bind("JFACCOUNTIDPAY") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqBankPayment" runat="server"
                        ControlToValidate="ddlAccountIDPay" Display="None" ErrorMessage="BANK ACCOUNT PAYMENT must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEBankPayment" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankPayment">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Bank Account&nbsp; Dropping</td>
                <td>
                    <asp:DropDownList ID="ddlAccountIDDrop" runat="server" CssClass="required" DataSourceID="sdsBankAccount"
                            DataTextField="ACCOUNTNO" DataValueField="ACCOUNTID" SelectedValue='<%# Bind("JFACCOUNTIDDROP") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqBankDrop" runat="server" ControlToValidate="ddlAccountIDDrop"
                        Display="None" ErrorMessage="BANK DROPPING must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEBankDrop" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankDrop">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Portion</td>
                <td>
                    <asp:TextBox ID="JFPORTIONTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFPORTION", "{0:N}") %>' Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                            ID="reqPortion" runat="server" ControlToValidate="JFPORTIONTextBox" Display="None"
                            ErrorMessage="JF PORTION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPortion" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPortion">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Default Eff. Rate</td>
                <td>
                    <asp:TextBox ID="JFEFFRATEDEFAULTTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFEFFRATEDEFAULT", "{0:N6}") %>' Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                            ID="reqJFEffRateDef" runat="server" ControlToValidate="JFEFFRATEDEFAULTTextBox"
                            Display="None" ErrorMessage="DEFAULT EFF. RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEEffRAteDef" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJFEffRateDef">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    <input type="button" value="Set Eff. Rate" onclick="return EditAdmRate(<%# Eval("JFID") %>);" style="background-position: left; background-image: url(../Images/setting.png); cursor: pointer; background-repeat: no-repeat; text-align: right" />
                    </td>
            </tr>
            <tr>
                <td>
                    Penalty Shared</td>
                <td colspan="3">
                    <asp:TextBox ID="JFPENALTYSHAREDTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFPENALTYSHARED", "{0:N}") %>' Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                            ID="reqPenaltyShare" runat="server" ControlToValidate="JFPENALTYSHAREDTextBox"
                            Display="None" ErrorMessage="PENALTY SHARED must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPenaltyShare" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyShare">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="ErrHighLight">
                    Document Received</td>
                <td class="ErrHighLight">
                    <asp:DropDownList ID="ddlDocReceived" runat="server" CssClass="required" DataSourceID="sdsDocReceived"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFDOCRECEIVED") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqDocReceived" runat="server"
                        ControlToValidate="ddlDocReceived" Display="None" ErrorMessage="DOCUMENT RECEIVED must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEDocReceived" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDocReceived">
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
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Penalty Rate</td>
                <td>
                    <asp:TextBox ID="JFPENALTYRATETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFPENALTYRATE", "{0:N}") %>' Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                            ID="reqPenaltyRate" runat="server" ControlToValidate="JFPENALTYRATETextBox" Display="None"
                            ErrorMessage="PENALTY RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPenaltyRate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyRate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Grace Period</td>
                <td>
                    <asp:TextBox ID="JFGRACEPERIODTextBox" runat="server" CssClass="required" MaxLength="3"
                        Style="text-align: right" Text='<%# Bind("JFGRACEPERIOD") %>' Width="56px"></asp:TextBox>
                    day(s)<asp:RequiredFieldValidator ID="reqGracePeriod" runat="server" ControlToValidate="JFGRACEPERIODTextBox"
                        Display="None" ErrorMessage="GRACE PERIOD must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEGracePeriod" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqGracePeriod">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Working Days</td>
                <td colspan="3">
                    <asp:TextBox ID="JFWORKINGDAYSTextBox" runat="server" CssClass="required" MaxLength="2"
                        Style="text-align: right" Text='<%# Bind("JFWORKINGDAYS") %>' Width="56px"></asp:TextBox>
                    day(s)<asp:RequiredFieldValidator ID="reqWorkDay" runat="server" ControlToValidate="JFWORKINGDAYSTextBox"
                        Display="None" ErrorMessage="WORKING DAYS must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEWorkDay" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqWorkDay">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle">
                    ET(Buy Back)</td>
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    ET Penalty Type</td>
                <td>
                    <asp:DropDownList ID="ddlETPenaltyType" runat="server" CssClass="required" DataSourceID="sdsETPenaltyType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFETPENALTYTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqETPenaltyType" runat="server"
                        ControlToValidate="ddlETPenaltyType" Display="None" ErrorMessage="ET PENALTY TYPE must be entry...!"
                        SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEETPenaltyType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETPenaltyType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    ET Penalty</td>
                <td>
                    <asp:TextBox ID="JFETPENALTYTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFETPENALTY", "{0:N}") %>' Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqETPenalty" runat="server" ControlToValidate="JFETPENALTYTextBox" Display="None"
                            ErrorMessage="ET PENALTY must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEETPenalty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETPenalty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Admin Fee Termination</td>
                <td colspan="3">
                    <asp:TextBox ID="JFADMTERMINATETextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFADMTERMINATE", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqETAdmin" runat="server" ControlToValidate="JFADMTERMINATETextBox" Display="None"
                            ErrorMessage="ET ADMIN FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEETAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETAdmin">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle">
                    JF Admin</td>
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Admin Type</td>
                <td>
                    <asp:DropDownList ID="ddlAdminType" runat="server" CssClass="required" DataSourceID="sdsAdminType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFADMINTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqAdminType" runat="server" ControlToValidate="ddlAdminType"
                        Display="None" ErrorMessage="ADMIN TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEAdminType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdminType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Admin</td>
                <td>
                    <asp:TextBox ID="JFADMINTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFADMIN", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqAdmin" runat="server" ControlToValidate="JFADMINTextBox" Display="None"
                            ErrorMessage="ADMIN FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                            </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="HeaderStyle">
                    JF Provision</td>
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    Prov. Type</td>
                <td>
                    <asp:DropDownList ID="ddlProvisionType" runat="server" CssClass="required" DataSourceID="sdsProvisionType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFPROVISIONTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqProvType" runat="server" ControlToValidate="ddlProvisionType"
                        Display="None" ErrorMessage="PROVISION TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEProvType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProvType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
                <td>
                    Provision</td>
                <td>
                    <asp:TextBox ID="JFPROVISIONTextBox" runat="server" CssClass="required" Style="text-align: right"
                        Text='<%# Bind("JFPROVISION", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqProvision" runat="server" ControlToValidate="JFPROVISIONTextBox" Display="None"
                            ErrorMessage="PROVISION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEProvision" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProvision">
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
                    <asp:DropDownList ID="ddlCOAReceivable" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFRECEIVABLECOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
                <td>
                    Interest</td>
                <td>
                    <asp:DropDownList ID="ddlCOAInterest" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFINTERESTCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>
                    Provision</td>
                <td>
                    <asp:DropDownList ID="ddlCOAProvision" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFPROVISIONCOAID") %>' 
                        Width="250px">                        
                    </asp:DropDownList></td>
                <td>
                    Admin</td>
                <td>
                    <asp:DropDownList ID="ddlCOAAmin" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFADMINCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>
                    Deposit</td>
                <td>
                    <asp:DropDownList ID="ddlCOADeposit" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFDEPOSITCOAID") %>' 
                        Width="250px">
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
                    <asp:DropDownList ID="ddlCOAETPenalty" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFETPENALTYCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
                <td class="AlternatingRowStyle">
                    ET Admin</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlCOAETAdmin" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFETADMINCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    ET Other Fee</td>
                <td class="AlternatingRowStyle">
                    <asp:DropDownList ID="ddlCOAOtherFee" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFETOTHERFEECOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
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
                    <asp:DropDownList ID="ddlCOADebt" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFDEBTCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
                <td>
                    Penalty Shared</td>
                <td>
                    <asp:DropDownList ID="ddlCOASharePenalty" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFPENALTYSHAREDCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>
                    Penalty</td>
                <td>
                    <asp:DropDownList ID="ddlCOAPenalty" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                        DataValueField="COAID" SelectedValue='<%# Bind("JFPENALTYCOAID") %>' 
                        Width="250px">
                    </asp:DropDownList></td>
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
                    <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                    <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                    <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                </td>
            </tr>
        </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        JF Group</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlJFGroup" runat="server"  DataSourceID="sdsJFGroup"
        DataTextField="JFGROUPNAME" DataValueField="JFGROUPID" SelectedValue='<%# Bind("JFGROUPID") %>' CssClass="required">
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqJFGroup" runat="server" ControlToValidate="ddlJFGroup"
                            Display="None" ErrorMessage="JF GROUP must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEJFGroup" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJFGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Code</td>
                    <td colspan="3">
                        <asp:TextBox ID="JFCODETextBox" runat="server" CssClass="required" MaxLength="10"
                            Text='<%# Bind("JFCODE") %>' Width="88px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCode" runat="server" ControlToValidate="JFCODETextBox" Display="None"
                                ErrorMessage="JF CODE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Code From Bank</td>
                    <td colspan="3">
                        <asp:TextBox ID="JFCODEFROMBANKTextBox" runat="server" 
                            MaxLength="20" Text='<%# Bind("JFCODEFROMBANK") %>' 
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
                    <td colspan="4" class="ShowDetail">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="ErrHighLight">
                        JF Name</td>
                    <td colspan="3" class="ErrHighLight">
                        <asp:TextBox ID="JFNAMETextBox" runat="server" CssClass="required" MaxLength="50"
                            Text='<%# Bind("JFNAME") %>' Width="192px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqName" runat="server" ControlToValidate="JFNAMETextBox" Display="None"
                                ErrorMessage="JF NAME must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td colspan="3">
                        <asp:TextBox ID="JFADDRESSTextBox" runat="server" MaxLength="100" Text='<%# Bind("JFADDRESS") %>'
                            Width="384px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:TextBox ID="JFCITYTextBox" runat="server" MaxLength="50" Text='<%# Bind("JFCITY") %>'
                            Width="192px"></asp:TextBox></td>
                    <td>
                        Zip</td>
                    <td>
                        <asp:TextBox ID="JFZIPTextBox" runat="server" MaxLength="10" Text='<%# Bind("JFZIP") %>'
                            Width="80px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        Agreement</td>
                    <td colspan="3" class="FooterStyle">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        PKS No</td>
                    <td>
                        <asp:TextBox ID="JFPKSNOTextBox" runat="server" MaxLength="50" Text='<%# Bind("JFPKSNO") %>'></asp:TextBox></td>
                    <td>
                        PKS Date</td>
                    <td>
                        <asp:TextBox ID="JFPKSDATETextBox" runat="server" Text='<%# Bind("JFPKSDATE", "{0:dd/MM/yyyy}") %>'
                            Width="72px"></asp:TextBox><asp:Image
                ID="imgPKSDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEPKSDate" runat="server" Format="dd/MM/yyyy"
                    PopupButtonID="imgPKSDate" TargetControlID="JFPKSDATETextBox">
                                </ajaxToolkit:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        PKS Title</td>
                    <td colspan="3">
                        <asp:TextBox ID="JFPKSTITLETextBox" runat="server" MaxLength="150" Text='<%# Bind("JFPKSTITLE") %>'
                            Width="400px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Letter No.</td>
                    <td>
                        <asp:TextBox ID="JFLETTERNOTextBox" runat="server" MaxLength="50" Text='<%# Bind("JFLETTERNO") %>'></asp:TextBox></td>
                    <td>
                        Notary</td>
                    <td>
                        <asp:TextBox ID="JFNOTARYTextBox" runat="server" MaxLength="60" Text='<%# Bind("JFNOTARY") %>'
                            Width="224px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="4" class="ShowDetail">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Revolving Type</td>
                    <td>
                        <asp:DropDownList ID="ddlRevolving" runat="server" CssClass="required" DataSourceID="sdsRevolving"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFREVOLVING") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqRevolving" runat="server" ControlToValidate="ddlRevolving"
                            Display="None" ErrorMessage="REVOLVING  TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCERevolving" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqRevolving">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Commitment Fee</td>
                    <td>
                        <asp:TextBox ID="txtCommitmentFee" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("JFCOMMITFEE", "{0:N}") %>' Width="128px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqCommitFee" runat="server" ControlToValidate="txtCommitmentFee" Display="None"
                                ErrorMessage="COMMITMENT FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCECommitFee" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCommitFee">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Plafond</td>
                    <td>
                        <asp:TextBox ID="txtPlafond" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("JFPLAFOND", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqPlafond" runat="server" ControlToValidate="txtPlafond" Display="None"
                                ErrorMessage="FLAFOND must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPlafond" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPlafond">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Plafond Used</td>
                    <td>
                        <asp:TextBox ID="txtPlafondUsed" runat="server" CssClass="disabled" ReadOnly="True"
                            Style="text-align: right" Text='<%# Eval("JFPLAFONDUSED", "{0:N}") %>' Width="128px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Mirror Status</td>
                    <td>
            <asp:CheckBox ID="JFMIRRORSTATUSCheckBox" runat="server" Checked='<%# Bind("JFMIRRORSTATUS") %>' Text="Checked if Enabled Mirroring" /></td>
                    <td>
                        Payment Type</td>
                    <td>
                        <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="required" DataSourceID="sdsPaymentType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFPAYMENTTYPE") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqPaymentType" runat="server"
                            ControlToValidate="ddlPaymentType" Display="None" ErrorMessage="PAYMENT TYPE  must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPaymentType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPaymentType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Early Payment</td>
                    <td>
            <asp:CheckBox ID="JFEARLYPAYMENTCheckBox" runat="server" Checked='<%# Bind("JFEARLYPAYMENT") %>' Text="Checked if Enabled Early Payment" /></td>
                    <td>
                        First Payment Type</td>
                    <td>
                        <asp:DropDownList ID="ddlFirstPaymentType" runat="server" CssClass="required" DataSourceID="sdsFirstPaymentType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFFIRSTPAYMENTTYPE") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqFirstPaymentType" runat="server"
                            ControlToValidate="ddlFirstPaymentType" Display="None" ErrorMessage="FIRST PAYMENT TYPE must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEFirstPaymentType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqFirstPaymentType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Bank Account Payment</td>
                    <td>
                        <asp:DropDownList ID="ddlAccountIDPay" runat="server" CssClass="required" DataSourceID="sdsBankAccount"
                            DataTextField="ACCOUNTNO" DataValueField="ACCOUNTID" SelectedValue='<%# Bind("JFACCOUNTIDPAY") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqBankPayment" runat="server"
                            ControlToValidate="ddlAccountIDPay" Display="None" ErrorMessage="BANK ACCOUNT PAYMENT must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEBankPayment" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankPayment">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Bank Account&nbsp; Dropping</td>
                    <td>
                        <asp:DropDownList ID="ddlAccountIDDrop" runat="server" CssClass="required" DataSourceID="sdsBankAccount"
                            DataTextField="ACCOUNTNO" DataValueField="ACCOUNTID" SelectedValue='<%# Bind("JFACCOUNTIDDROP") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqBankDrop" runat="server" ControlToValidate="ddlAccountIDDrop"
                            Display="None" ErrorMessage="BANK DROPPING must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEBankDrop" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBankDrop">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Portion</td>
                    <td>
            <asp:TextBox ID="JFPORTIONTextBox" runat="server" Text='<%# Bind("JFPORTION", "{0:N}") %>' style="text-align: right" CssClass="required" Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                ID="reqPortion" runat="server" ControlToValidate="JFPORTIONTextBox" Display="None"
                ErrorMessage="JF PORTION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPortion" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPortion">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Default Eff. Rate</td>
                    <td>
            <asp:TextBox ID="JFEFFRATEDEFAULTTextBox" runat="server" Text='<%# Bind("JFEFFRATEDEFAULT", "{0:N6}") %>' style="text-align: right" CssClass="required" Width="72px"></asp:TextBox>%<asp:RequiredFieldValidator
                ID="reqJFEffRateDef" runat="server" ControlToValidate="JFEFFRATEDEFAULTTextBox"
                Display="None" ErrorMessage="DEFAULT EFF. RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEEffRAteDef" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJFEffRateDef">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty Shared</td>
                    <td colspan="3">
            <asp:TextBox ID="JFPENALTYSHAREDTextBox" runat="server" Text='<%# Bind("JFPENALTYSHARED", "{0:N}") %>' style="text-align: right" CssClass="required" Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                ID="reqPenaltyShare" runat="server" ControlToValidate="JFPENALTYSHAREDTextBox"
                Display="None" ErrorMessage="PENALTY SHARED must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPenaltyShare" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyShare">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="ErrHighLight">
                        Document Received</td>
                    <td class="ErrHighLight">
                        <asp:DropDownList ID="ddlDocReceived" runat="server" CssClass="required" DataSourceID="sdsDocReceived"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFDOCRECEIVED") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqDocReceived" runat="server"
                            ControlToValidate="ddlDocReceived" Display="None" ErrorMessage="DOCUMENT RECEIVED must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEDocReceived" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDocReceived">
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
                        JF
                        Penalty</td>
                    <td colspan="3" class="FooterStyle">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Penalty Rate</td>
                    <td>
            <asp:TextBox ID="JFPENALTYRATETextBox" runat="server" Text='<%# Bind("JFPENALTYRATE", "{0:N}") %>' style="text-align: right" CssClass="required" Width="56px"></asp:TextBox>%<asp:RequiredFieldValidator
                ID="reqPenaltyRate" runat="server" ControlToValidate="JFPENALTYRATETextBox" Display="None"
                ErrorMessage="PENALTY RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEPenaltyRate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPenaltyRate">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Grace Period</td>
                    <td>
            <asp:TextBox ID="JFGRACEPERIODTextBox" runat="server" Text='<%# Bind("JFGRACEPERIOD") %>' 
                            style="text-align: right" CssClass="required" MaxLength="3" Width="56px"></asp:TextBox>
                        day(s)<asp:RequiredFieldValidator ID="reqGracePeriod" runat="server" ControlToValidate="JFGRACEPERIODTextBox"
                            Display="None" ErrorMessage="GRACE PERIOD must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEGracePeriod" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqGracePeriod">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Working Days</td>
                    <td colspan="3">
            <asp:TextBox ID="JFWORKINGDAYSTextBox" runat="server" Text='<%# Bind("JFWORKINGDAYS") %>' 
                            style="text-align: right" CssClass="required" MaxLength="2" Width="56px"></asp:TextBox>
                        day(s)<asp:RequiredFieldValidator ID="reqWorkDay" runat="server" ControlToValidate="JFWORKINGDAYSTextBox"
                            Display="None" ErrorMessage="WORKING DAYS must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEWorkDay" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqWorkDay">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        ET(Buy Back)</td>
                    <td colspan="3" class="FooterStyle">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        ET
                        Penalty Type</td>
                    <td>
                        <asp:DropDownList ID="ddlETPenaltyType" runat="server" CssClass="required" DataSourceID="sdsETPenaltyType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFETPENALTYTYPE") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqETPenaltyType" runat="server"
                            ControlToValidate="ddlETPenaltyType" Display="None" ErrorMessage="ET PENALTY TYPE must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEETPenaltyType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETPenaltyType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        ET
                        Penalty</td>
                    <td>
            <asp:TextBox ID="JFETPENALTYTextBox" runat="server" Text='<%# Bind("JFETPENALTY", "{0:N}") %>' style="text-align: right" CssClass="required" Width="64px"></asp:TextBox><asp:RequiredFieldValidator
                ID="reqETPenalty" runat="server" ControlToValidate="JFETPENALTYTextBox" Display="None"
                ErrorMessage="ET PENALTY must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEETPenalty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETPenalty">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Fee Termination</td>
                    <td colspan="3">
            <asp:TextBox ID="JFADMTERMINATETextBox" runat="server" Text='<%# Bind("JFADMTERMINATE", "{0:N}") %>' style="text-align: right" CssClass="required" Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                ID="reqETAdmin" runat="server" ControlToValidate="JFADMTERMINATETextBox" Display="None"
                ErrorMessage="ET ADMIN FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEETAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqETAdmin">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        JF
                        Admin</td>
                    <td colspan="3" class="FooterStyle"><hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td><asp:DropDownList ID="ddlAdminType" runat="server" CssClass="required" DataSourceID="sdsAdminType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFADMINTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqAdminType" runat="server" ControlToValidate="ddlAdminType"
                        Display="None" ErrorMessage="ADMIN TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEAdminType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdminType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Admin</td>
                    <td>
            <asp:TextBox ID="JFADMINTextBox" runat="server" Text='<%# Bind("JFADMIN", "{0:N}") %>' style="text-align: right" CssClass="required" Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                ID="reqAdmin" runat="server" ControlToValidate="JFADMINTextBox" Display="None"
                ErrorMessage="ADMIN FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        JF
                        Provision</td>
                    <td colspan="3" class="FooterStyle">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Prov. Type</td>
                    <td><asp:DropDownList ID="ddlProvisionType" runat="server" CssClass="required" DataSourceID="sdsProvisionType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("JFPROVISIONTYPE") %>'>
                    </asp:DropDownList><asp:RequiredFieldValidator ID="reqProvType" runat="server" ControlToValidate="ddlProvisionType"
                        Display="None" ErrorMessage="PROVISION TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEProvType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProvType">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Provision</td>
                    <td>
            <asp:TextBox ID="JFPROVISIONTextBox" runat="server" Text='<%# Bind("JFPROVISION", "{0:N}") %>' style="text-align: right" CssClass="required" Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                ID="reqProvision" runat="server" ControlToValidate="JFPROVISIONTextBox" Display="None"
                ErrorMessage="PROVISION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                    ID="ajaxVCEProvision" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProvision">
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
                        <asp:DropDownList ID="ddlCOAReceivable" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFRECEIVABLECOAID") %>'>
                        </asp:DropDownList></td>
                    <td>
                        Interest</td>
                    <td>
                        <asp:DropDownList ID="ddlCOAInterest" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFINTERESTCOAID") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Provision</td>
                    <td>
                        <asp:DropDownList ID="ddlCOAProvision" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFPROVISIONCOAID") %>'>
                        </asp:DropDownList></td>
                    <td>
                        Admin</td>
                    <td>
                        <asp:DropDownList ID="ddlCOAAmin" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFADMINCOAID") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Deposit</td>
                    <td>
                        <asp:DropDownList ID="ddlCOADeposit" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFDEPOSITCOAID") %>'>
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
                        <asp:DropDownList ID="ddlCOAETPenalty" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFETPENALTYCOAID") %>'>
                        </asp:DropDownList></td>
                    <td class="AlternatingRowStyle">
                        ET Admin</td>
                    <td class="AlternatingRowStyle">
                        <asp:DropDownList ID="ddlCOAETAdmin" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFETADMINCOAID") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td class="AlternatingRowStyle">
                        ET Other Fee</td>
                    <td class="AlternatingRowStyle">
                        <asp:DropDownList ID="ddlCOAOtherFee" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFETOTHERFEECOAID") %>'>
                        </asp:DropDownList></td>
                    <td class="AlternatingRowStyle">
                    </td>
                    <td class="AlternatingRowStyle">
                    </td>
                </tr>
                <tr>
                    <td>
                        Debt</td>
                    <td>
                        <asp:DropDownList ID="ddlCOADebt" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFDEBTCOAID") %>'>
                        </asp:DropDownList></td>
                    <td>
                        Penalty Shared</td>
                    <td>
                        <asp:DropDownList ID="ddlCOASharePenalty" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFPENALTYSHAREDCOAID") %>'>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Penalty</td>
                    <td>
                        <asp:DropDownList ID="ddlCOAPenalty" runat="server" DataSourceID="sdsCOA" DataTextField="COA"
                            DataValueField="COAID" SelectedValue='<%# Bind("JFPENALTYCOAID") %>'>
                        </asp:DropDownList></td>
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
                    <td colspan="4" style="height: 7px">
                        <uc4:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsPaymentType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFPAYMENTTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBankAccount" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS ACCOUNTID, NULL AS BANKNAME, '[BANK ACCOUNT NO]' AS ACCOUNTNO UNION ALL SELECT BANKACCOUNT.ACCOUNTID, BANK.BANKNAME, BANK.BANKNAME + ' - ' + BANKACCOUNT.ACCOUNTNO AS ACCOUNTNO FROM BANKACCOUNT WITH (NOLOCK) INNER JOIN BANK WITH (NOLOCK) ON BANKACCOUNT.BANKID = BANK.BANKID WHERE (BANKACCOUNT.DELETESTS = 0) ORDER BY BANKNAME">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsJFGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS JFGROUPID, NULL AS JFGROUPCODE, '[JF GROUP]' AS JFGROUPNAME UNION ALL SELECT JFGROUPID, JFGROUPCODE, JFGROUPCODE + ' -  ' + JFGROUPNAME AS JFGROUPNAME FROM JFGROUP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY JFGROUPCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT JFID, (SELECT JFGROUPID FROM JFGROUP WHERE (JFGROUPID = JF.JFGROUPID) AND (Deletests = 0)) AS JFGROUPID, JFCODE, JFNAME, JFADDRESS, JFCITY, JFZIP, (SELECT ACCOUNTID FROM BANKACCOUNT WHERE (ACCOUNTID = JF.JFACCOUNTIDPAY) AND (DELETESTS = 0)) AS JFACCOUNTIDPAY, (SELECT ACCOUNTID FROM BANKACCOUNT AS BANKACCOUNT_1 WHERE (ACCOUNTID = JF.JFACCOUNTIDDROP) AND (DELETESTS = 0)) AS JFACCOUNTIDDROP, JFPORTION, JFEFFRATEDEFAULT, JFPENALTYSHARED, JFPENALTYRATE, JFGRACEPERIOD, JFWORKINGDAYS, JFETPENALTYTYPE, JFETPENALTY, JFADMINTYPE, JFADMIN, JFPROVISIONTYPE, JFPROVISION, JFADMTERMINATE, JFMIRRORSTATUS, JFPAYMENTTYPE, JFEARLYPAYMENT, JFFIRSTPAYMENTTYPE, JFPKSNO, JFPKSDATE, JFPKSTITLE, JFLETTERNO, JFNOTARY, JFPLAFOND, JFPLAFONDUSED, JFREVOLVING, JFCOMMITFEE, JFMINETDEV, JFMAXETDEV, JFDOCRECEIVED, JFINSTALLMENTTYPE, BANKID, (SELECT COAID FROM COA WHERE (COAID = JF.JFRECEIVABLECOAID) AND (DELETESTS = 0)) AS JFRECEIVABLECOAID, (SELECT COAID FROM COA AS COA_10 WHERE (COAID = JF.JFINTERESTCOAID) AND (DELETESTS = 0)) AS JFINTERESTCOAID, (SELECT COAID FROM COA AS COA_9 WHERE (COAID = JF.JFPROVISIONCOAID) AND (DELETESTS = 0)) AS JFPROVISIONCOAID, (SELECT COAID FROM COA AS COA_8 WHERE (COAID = JF.JFADMINCOAID) AND (DELETESTS = 0)) AS JFADMINCOAID, (SELECT COAID FROM COA AS COA_7 WHERE (COAID = JF.JFDEPOSITCOAID) AND (DELETESTS = 0)) AS JFDEPOSITCOAID, (SELECT COAID FROM COA AS COA_6 WHERE (COAID = JF.JFETPENALTYCOAID) AND (DELETESTS = 0)) AS JFETPENALTYCOAID, (SELECT COAID FROM COA AS COA_5 WHERE (COAID = JF.JFETADMINCOAID) AND (DELETESTS = 0)) AS JFETADMINCOAID, (SELECT COAID FROM COA AS COA_4 WHERE (COAID = JF.JFETOTHERFEECOAID) AND (DELETESTS = 0)) AS JFETOTHERFEECOAID, (SELECT COAID FROM COA AS COA_3 WHERE (COAID = JF.JFDEBTCOAID) AND (DELETESTS = 0)) AS JFDEBTCOAID, (SELECT COAID FROM COA AS COA_2 WHERE (COAID = JF.JFPENALTYSHAREDCOAID) AND (DELETESTS = 0)) AS JFPENALTYSHAREDCOAID, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = JF.JFPENALTYCOAID) AND (DELETESTS = 0)) AS JFPENALTYCOAID, (SELECT COAID FROM COA AS COA_11 WHERE (COAID = JF.JFETAMOUNTCOAID) AND (DELETESTS = 0)) AS JFETAMOUNTCOAID, JFCODEFROMBANK FROM JF WHERE (JFID = @JFID) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFX WHERE (JF.JFID = JFID))) UNION ALL SELECT JFID, (SELECT JFGROUPID FROM JFGROUP AS JFGROUP_1 WHERE (JFGROUPID = JFX_1.JFGROUPID) AND (Deletests = 0)) AS JFGROUPID, JFCODE, JFNAME, JFADDRESS, JFCITY, JFZIP, (SELECT ACCOUNTID FROM BANKACCOUNT AS BANKACCOUNT_2 WHERE (ACCOUNTID = JFX_1.JFACCOUNTIDPAY) AND (DELETESTS = 0)) AS JFACCOUNTIDPAY, (SELECT ACCOUNTID FROM BANKACCOUNT AS BANKACCOUNT_1 WHERE (ACCOUNTID = JFX_1.JFACCOUNTIDDROP) AND (DELETESTS = 0)) AS JFACCOUNTIDDROP, JFPORTION, JFEFFRATEDEFAULT, JFPENALTYSHARED, JFPENALTYRATE, JFGRACEPERIOD, JFWORKINGDAYS, JFETPENALTYTYPE, JFETPENALTY, JFADMINTYPE, JFADMIN, JFPROVISIONTYPE, JFPROVISION, JFADMTERMINATE, JFMIRRORSTATUS, JFPAYMENTTYPE, JFEARLYPAYMENT, JFFIRSTPAYMENTTYPE, JFPKSNO, JFPKSDATE, JFPKSTITLE, JFLETTERNO, JFNOTARY, JFPLAFOND, JFPLAFONDUSED, JFREVOLVING, JFCOMMITFEE, JFMINETDEV, JFMAXETDEV, JFDOCRECEIVED, JFINSTALLMENTTYPE, BANKID, (SELECT COAID FROM COA AS COA_11 WHERE (COAID = JFX_1.JFRECEIVABLECOAID) AND (DELETESTS = 0)) AS JFRECEIVABLECOAID, (SELECT COAID FROM COA AS COA_10 WHERE (COAID = JFX_1.JFINTERESTCOAID) AND (DELETESTS = 0)) AS JFINTERESTCOAID, (SELECT COAID FROM COA AS COA_9 WHERE (COAID = JFX_1.JFPROVISIONCOAID) AND (DELETESTS = 0)) AS JFPROVISIONCOAID, (SELECT COAID FROM COA AS COA_8 WHERE (COAID = JFX_1.JFADMINCOAID) AND (DELETESTS = 0)) AS JFADMINCOAID, (SELECT COAID FROM COA AS COA_7 WHERE (COAID = JFX_1.JFDEPOSITCOAID) AND (DELETESTS = 0)) AS JFDEPOSITCOAID, (SELECT COAID FROM COA AS COA_6 WHERE (COAID = JFX_1.JFETPENALTYCOAID) AND (DELETESTS = 0)) AS JFETPENALTYCOAID, (SELECT COAID FROM COA AS COA_5 WHERE (COAID = JFX_1.JFETADMINCOAID) AND (DELETESTS = 0)) AS JFETADMINCOAID, (SELECT COAID FROM COA AS COA_4 WHERE (COAID = JFX_1.JFETOTHERFEECOAID) AND (DELETESTS = 0)) AS JFETOTHERFEECOAID, (SELECT COAID FROM COA AS COA_3 WHERE (COAID = JFX_1.JFDEBTCOAID) AND (DELETESTS = 0)) AS JFDEBTCOAID, (SELECT COAID FROM COA AS COA_2 WHERE (COAID = JFX_1.JFPENALTYSHAREDCOAID) AND (DELETESTS = 0)) AS JFPENALTYSHAREDCOAID, (SELECT COAID FROM COA AS COA_1 WHERE (COAID = JFX_1.JFPENALTYCOAID) AND (DELETESTS = 0)) AS JFPENALTYCOAID, (SELECT COAID FROM COA AS COA_12 WHERE (COAID = JFX_1.JFETAMOUNTCOAID) AND (DELETESTS = 0)) AS JFETAMOUNTCOAID, JFCODEFROMBANK FROM JFX AS JFX_1 WHERE (JFID = @JFID)" 
        DeleteCommand="UPDATE JF SET Deletests = 1, LastUpdate = GETDATE(), LastUserID = @USERID WHERE (JFID = @JFID)" 
        UpdateCommand="JFUpdate" InsertCommand="JFAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="JFID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="JFID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="JFID" Type="Int32" />
            <asp:Parameter Name="JFGROUPID" Type="Int32" />
            <asp:Parameter Name="JFCODE" Type="String" />
            <asp:Parameter Name="JFNAME" Type="String" />
            <asp:Parameter Name="JFADDRESS" Type="String" />
            <asp:Parameter Name="JFCITY" Type="String" />
            <asp:Parameter Name="JFZIP" Type="String" />
            <asp:Parameter Name="JFACCOUNTIDPAY" Type="Int32" />
            <asp:Parameter Name="JFACCOUNTIDDROP" Type="Int32" />
            <asp:Parameter Name="JFPORTION" Type="Double" />
            <asp:Parameter Name="JFEFFRATEDEFAULT" Type="Double" />
            <asp:Parameter Name="JFPENALTYSHARED" Type="Double" />
            <asp:Parameter Name="JFPENALTYRATE" Type="Double" />
            <asp:Parameter Name="JFGRACEPERIOD" Type="Byte" />
            <asp:Parameter Name="JFWORKINGDAYS" Type="Byte" />
            <asp:Parameter Name="JFETPENALTYTYPE" Type="Byte" />
            <asp:Parameter Name="JFETPENALTY" Type="Double" />
            <asp:Parameter Name="JFADMINTYPE" Type="Byte" />
            <asp:Parameter Name="JFADMIN" Type="Double" />
            <asp:Parameter Name="JFPROVISIONTYPE" Type="Byte" />
            <asp:Parameter Name="JFPROVISION" Type="Double" />
            <asp:Parameter Name="JFADMTERMINATE" Type="Decimal" />
            <asp:Parameter Name="JFMIRRORSTATUS" Type="Boolean" />
            <asp:Parameter Name="JFPAYMENTTYPE" Type="Byte" />
            <asp:Parameter Name="JFEARLYPAYMENT" Type="Boolean" />
            <asp:Parameter Name="JFFIRSTPAYMENTTYPE" Type="Byte" />
            <asp:Parameter Name="JFPKSNO" Type="String" />
            <asp:Parameter Name="JFPKSDATE" Type="String"/>
            <asp:Parameter Name="JFPKSTITLE" Type="String" />
            <asp:Parameter Name="JFLETTERNO" Type="String" />
            <asp:Parameter Name="JFNOTARY" Type="String" />
            <asp:Parameter Name="JFPLAFOND" Type="Decimal" />
            <asp:Parameter Name="JFREVOLVING" Type="Int32" />
            <asp:Parameter Name="JFDOCRECEIVED" Type="Int32" />
            <asp:Parameter Name="JFCOMMITFEE" Type="Decimal" />
            <asp:Parameter Name="JFMINETDEV" Type="Decimal" />
            <asp:Parameter Name="JFMAXETDEV" Type="Decimal" />
            <asp:Parameter Name="CRID" Type="Int32" />
            <asp:Parameter Name="JFRECALCRATE" Type="Byte" />
            <asp:Parameter Name="JFRECEIVABLECOAID" Type="Int32" />
            <asp:Parameter Name="JFINTERESTCOAID" Type="Int32" />
            <asp:Parameter Name="JFPROVISIONCOAID" Type="Int32" />
            <asp:Parameter Name="JFADMINCOAID" Type="Int32" />
            <asp:Parameter Name="JFDEPOSITCOAID" Type="Int32" />
            <asp:Parameter Name="JFETPENALTYCOAID" Type="Int32" />
            <asp:Parameter Name="JFETADMINCOAID" Type="Int32" />
            <asp:Parameter Name="JFETOTHERFEECOAID" Type="Int32" />
            <asp:Parameter Name="JFDEBTCOAID" Type="Int32" />
            <asp:Parameter Name="JFPENALTYSHAREDCOAID" Type="Int32" />
            <asp:Parameter Name="JFPENALTYCOAID" Type="Int32" />
            <asp:Parameter Name="JFINSTALLMENTTYPE" Type="INT16" />
            <asp:Parameter Name="BANKID" Type="Int32" />
            <asp:Parameter Name="JFCODEFROMBANK" Type="String" />
            <asp:Parameter Name="JFETAMOUNTCOAID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="RETVAL" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="JFGROUPID" Type="Int32" />
            <asp:Parameter Name="JFCODE" Type="String" />
            <asp:Parameter Name="JFNAME" Type="String" />
            <asp:Parameter Name="JFADDRESS" Type="String" />
            <asp:Parameter Name="JFCITY" Type="String" />
            <asp:Parameter Name="JFZIP" Type="String" />
            <asp:Parameter Name="JFACCOUNTIDPAY" Type="Int32" />
            <asp:Parameter Name="JFACCOUNTIDDROP" Type="Int32" />
            <asp:Parameter Name="JFPORTION" Type="Double" />
            <asp:Parameter Name="JFEFFRATEDEFAULT" Type="Double" />
            <asp:Parameter Name="JFPENALTYSHARED" Type="Double" />
            <asp:Parameter Name="JFPENALTYRATE" Type="Double" />
            <asp:Parameter Name="JFGRACEPERIOD" Type="Byte" />
            <asp:Parameter Name="JFWORKINGDAYS" Type="Byte" />
            <asp:Parameter Name="JFETPENALTYTYPE" Type="Byte" />
            <asp:Parameter Name="JFETPENALTY" Type="Double" />
            <asp:Parameter Name="JFADMINTYPE" Type="Byte" />
            <asp:Parameter Name="JFADMIN" Type="Double" />
            <asp:Parameter Name="JFPROVISIONTYPE" Type="Byte" />
            <asp:Parameter Name="JFPROVISION" Type="Double" />
            <asp:Parameter Name="JFADMTERMINATE" Type="Decimal" />
            <asp:Parameter Name="JFMIRRORSTATUS" Type="Boolean" />
            <asp:Parameter Name="JFPAYMENTTYPE" Type="Byte" />
            <asp:Parameter Name="JFEARLYPAYMENT" Type="Boolean" />
            <asp:Parameter Name="JFFIRSTPAYMENTTYPE" Type="Byte" />
            <asp:Parameter Name="JFPKSNO" Type="String" />
            <asp:Parameter Name="JFPKSDATE" Type="String"/>
            <asp:Parameter Name="JFPKSTITLE" Type="String" />
            <asp:Parameter Name="JFLETTERNO" Type="String" />
            <asp:Parameter Name="JFNOTARY" Type="String" />
            <asp:Parameter Name="JFPLAFOND" Type="Decimal" />
            <asp:Parameter Name="JFREVOLVING" Type="Int32" />
            <asp:Parameter Name="JFDOCRECEIVED" Type="Int32" />
            <asp:Parameter Name="JFCOMMITFEE" Type="Decimal" />
            <asp:Parameter Name="JFMINETDEV" Type="Decimal" />
            <asp:Parameter Name="JFMAXETDEV" Type="Decimal" />
            <asp:Parameter Name="CRID" Type="Int32" />
            <asp:Parameter Name="JFRECALCRATE" Type="Byte" />
            <asp:Parameter Name="JFRECEIVABLECOAID" Type="Int32" />
            <asp:Parameter Name="JFINTERESTCOAID" Type="Int32" />
            <asp:Parameter Name="JFPROVISIONCOAID" Type="Int32" />
            <asp:Parameter Name="JFADMINCOAID" Type="Int32" />
            <asp:Parameter Name="JFDEPOSITCOAID" Type="Int32" />
            <asp:Parameter Name="JFETPENALTYCOAID" Type="Int32" />
            <asp:Parameter Name="JFETADMINCOAID" Type="Int32" />
            <asp:Parameter Name="JFETOTHERFEECOAID" Type="Int32" />
            <asp:Parameter Name="JFDEBTCOAID" Type="Int32" />
            <asp:Parameter Name="JFPENALTYSHAREDCOAID" Type="Int32" />
            <asp:Parameter Name="JFPENALTYCOAID" Type="Int32" />
            <asp:Parameter Name="JFINSTALLMENTTYPE" Type="INT16" />
            <asp:Parameter Name="BANKID" Type="Int32" />
            <asp:Parameter Name="JFCODEFROMBANK" Type="String" />
            <asp:Parameter Name="JFETAMOUNTCOAID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="RETVAL" Type="Int32" />
          </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFirstPaymentType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[FIRST PAYMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFFIRSTPAYMENTTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsETPenaltyType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[ET PENALTY TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFETPENALTYTYPE')">
    </asp:SqlDataSource><asp:SqlDataSource ID="sdsAdminType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[ADMIN TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFADMINTYPE')">
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsProvisionType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[PROVISION TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFPROVISIONTYPE')">
</asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsValidCriteria" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CRID, NULL AS CRCODE, '[VALIDATION CRITERIA NAME]' AS CRNAME UNION ALL SELECT CRID, CRCODE, CRCODE + ' -  ' + CRNAME AS CRNAME FROM VALIDCRITERIA WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY CRCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRevolving" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[REVOLVING]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'REVOLVING')">
    </asp:SqlDataSource><asp:SqlDataSource ID="sdsDocReceived" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[DOC. RECEIVED]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFDOCRECEIVED')">
    </asp:SqlDataSource><asp:SqlDataSource ID="sdsReCalcRate" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS CODE, '[RE-CALCULATE ]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFRECALCRATE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCOA" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS COAID, NULL AS COANO, '[CHOOSE COA]' AS COA UNION ALL SELECT COAID, COANO, COANO + ' - ' + COANAME AS COA FROM COA WITH (NOLOCK) WHERE (DELETESTS = 0) AND (HARDCODE = 0) ORDER BY COANO">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsJFInstType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        
        
        SelectCommand="SELECT NULL AS CODE, '[JF INSTALLMENT TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFINSTALLMENTTYPE')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBank" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS BANKID, NULL AS BANKCODE, '[BANK]' AS BANKNAME UNION ALL SELECT BANKID, BANKCODE, BANKCODE + ' -  ' + BANKNAME AS BANKNAME FROM BANK WITH (NOLOCK) ORDER BY BANKCODE">
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
window.onload=function(){
    TabToEnter();
}
var WinRef;
var oForm = document.getElementById ? document.getElementById("<%=Form.ClientID%>") : document.forms["<%=Form.ClientID%>"]; 
function getObjectbyClientID(ClientID){
    var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
    return(oObject)
}

function EditAdmRate(JFID){
    WinRef = window.open("../Param/JFAdmRate.aspx?Action=Edit&JFID=" + JFID, "JFAdmRate", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    WinRef.focus();
    return false;
}

function EditTNC(JFID) {
    WinRef = window.open("../Param/JFTNCSet.aspx?Action=Edit&JFID=" + JFID, "JFTNCSet", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    WinRef.focus();
    return false;    
}

function BranchJF(JFID){
    WinRef = window.open("../Param/JFBranch.aspx?Action=Edit&JFID=" + JFID, "JFBranch", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    WinRef.focus();
}
function InsJF(JFID){
    WinRef = window.open("../Param/JFIns.aspx?Action=Edit&JFID=" + JFID, "JFIns", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    WinRef.focus();
}

function ShowCriteria(){
    var oCriteria=getObjectbyClientID("<%=strDDLCriteria%>") 
    if (oCriteria.value==""){
        alert("Criteria must be input first..!");
        oCriteria.focus();
        return false;
    }
    WinRef = window.open("../Param/CriteriaView.aspx?Action=View&CRID=" + oCriteria.value, "CrtView", "height=370,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
    WinRef.focus();
    return false;
}

function MerkJF(JFID){
    WinRef = window.open("../Param/MerkMap.aspx?Action=Edit&JFID=" + JFID, "JFBranch", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    WinRef.focus();
}

function EditTxt(JFID) {
    WinRef = window.open("../Param/JFTextSetting.aspx?Action=Edit&JFID=" + JFID, "JFIns", "height=400,width=500,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
    WinRef.focus();
}
</script>

</asp:Content>

