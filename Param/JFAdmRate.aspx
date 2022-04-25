<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFAdmRate.aspx.vb" Inherits="Param_JFAdmRate" title="JF ADMIN AND EFF. RATE SETTING" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlJF" runat="server" Caption="JOIN FINANCE (BANK) INFO" DataKeyField="JFID"
        DataSourceID="sdsJF" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle">
                        JF Group</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                        <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label></td>
                    <td class="FooterStyle">
                        JF</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)
                        <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Address</td>
                    <td colspan="3">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADDRESS") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF City</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCITY") %>'></asp:Label></td>
                    <td>
                        Zip</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFZIP") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Portion</td>
                    <td>
                        <asp:Label ID="JFPORTIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPORTION", "{0:N}") %>'></asp:Label>
                        %</td>
                    <td>
                        Mirror Status</td>
                    <td>
                        <asp:Label ID="MIRRORSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MIRRORSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        PKS No.</td>
                    <td>
                        <asp:Label ID="JFPKSNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSNO") %>'></asp:Label></td>
                    <td>
                        PKS Date</td>
                    <td>
                        <asp:Label ID="JFPKSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        PKS Title</td>
                    <td colspan="3">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPKSTITLE") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td>
                        (<asp:Label ID="JFADMINTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFADMINTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPENAME") %>'></asp:Label></td>
                    <td>
                        Admin</td>
                    <td>
                        <asp:Label ID="JFADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMIN") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Provison Type</td>
                    <td>
                        (<asp:Label ID="JFPROVISIONTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFPROVISIONTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPENAME") %>'></asp:Label></td>
                    <td>
                        Provision</td>
                    <td>
                        <asp:Label ID="JFPROVISIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISION") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Early Payment
                    </td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFEARLYPAYMENTNAME") %>'></asp:Label></td>
                    <td>
                        First Payment Type</td>
                    <td>
                        (<asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, JF.JFPORTION, JF.JFMIRRORSTATUS, dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS MIRRORSTATUSNAME, JF.JFPKSNO, JF.JFPKSDATE, JF.JFADMINTYPE, dbo.f_getParamGlobalName('JFADMINTYPE', JF.JFADMINTYPE) AS JFADMINTYPENAME, JF.JFADMIN, JF.JFPROVISIONTYPE, dbo.f_getParamGlobalName('JFPROVISIONTYPE', JF.JFPROVISIONTYPE) AS JFPROVISIONTYPENAME, JF.JFPROVISION, JF.JFADDRESS, JF.JFCITY, JF.JFZIP, JF.JFEARLYPAYMENT, dbo.f_getParamGlobalName('JFEARLYPAYMENT', JF.JFEARLYPAYMENT) AS JFEARLYPAYMENTNAME, JF.JFFIRSTPAYMENTTYPE, dbo.f_getParamGlobalName('JFFIRSTPAYMENTTYPE', JF.JFFIRSTPAYMENTTYPE) AS JFFIRSTPAYMENTTYPENAME, JF.JFPKSTITLE FROM JF INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF.JFID = @JFID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="imgBtnNew" runat="server" CausesValidation="False" CssClass="New"
        ImageUrl="~/images/add.gif" />
    <asp:GridView ID="gvJFAdmRate" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="ADMIN FEE AND EFF. RATE SETTING" DataKeyNames="JFID,ID"
        DataSourceID="sdsJFAdmRate" Width="100%">
        <Columns>
            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" ShowSelectButton="True" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:CommandField>
            <asp:BoundField DataField="TENORFROMX" HeaderText="Tenor&lt;br&gt;From" SortExpression="TENORFROMX" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="TENORTOX" HeaderText="Tenor&lt;br&gt;To" SortExpression="TENORTOX" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="ADMINTYPENAME" HeaderText="Admin&lt;br&gt;Type" SortExpression="ADMINTYPENAME" HtmlEncode="False" />
            <asp:BoundField DataField="ADMIN" HeaderText="Admin" SortExpression="ADMIN" DataFormatString="{0:N}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="EFFRATE" HeaderText="Eff.&lt;br&gt;Rate" SortExpression="EFFRATE" DataFormatString="{0:N6}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc1:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsJFAdmRate" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JFID, ID, 'x' + TENOROPRFROM + CAST(TENORFROM AS VARCHAR(20)) AS TENORFROMX, 'x' + TENOROPRTO + CAST(TENORTO AS VARCHAR(20)) AS TENORTOX, '(' + CAST(ADMINTYPE AS varchar(10)) + ') ' + dbo.f_getParamGlobalName('JFADMINTYPE', ADMINTYPE) AS ADMINTYPENAME, ADMIN, EFFRATE FROM JFADMRATE WHERE (JFID = @JFID) AND (Deletests = 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="fvTPAdmRate" runat="server" DataKeyNames="JFID,ID" DataSourceID="sdsJFAdmRateEdit"
        DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblID" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("ID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Tenor From <strong><span style="text-decoration: underline">(x)</span></strong></td>
                    <td>
                        <strong><span style="text-decoration: underline">(x)</span></strong>&nbsp;<asp:DropDownList
                            ID="ddlOperatorFrom" runat="server" CssClass="required" DataSourceID="sdsOperator"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("TENOROPRFROM") %>'>
                        </asp:DropDownList><strong><span style="text-decoration: underline"> </span></strong>
                        <asp:TextBox ID="txtTenorFrom" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("TENORFROM") %>' Width="56px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqTenorFrom" runat="server" ControlToValidate="txtTenorFrom" Display="None"
                                ErrorMessage="TENOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><strong><span
                                    style="text-decoration: underline"></span></strong><ajaxToolkit:ValidatorCalloutExtender
                                        ID="ajaxVCETenorFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenorFrom">
                                    </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOperatorFrom" runat="server" ControlToValidate="ddlOperatorFrom"
                            Display="None" ErrorMessage="OPERATOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOperatorFrom" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqOperatorFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Tenor To <strong><span style="text-decoration: underline">(y)</span></strong></td>
                    <td>
                        <strong><span style="text-decoration: underline">(y)</span></strong>
                        <asp:DropDownList ID="ddlOperatorTo" runat="server" CssClass="required" DataSourceID="sdsOperator"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("TENOROPRTO") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtTenorTo" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("TENORTO") %>' Width="56px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqTenorTo" runat="server" ControlToValidate="txtTenorTo" Display="None"
                                ErrorMessage="TENOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCETenorTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenorTo">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOperatorTo" runat="server" ControlToValidate="ddlOperatorTo"
                            Display="None" ErrorMessage="OPERATOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEOperatorTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOperatorTo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td>
                        <asp:DropDownList ID="ddlAdminType" runat="server" CssClass="required" DataSourceID="sdsAdminType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("ADMINTYPE") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqAdminType" runat="server" ControlToValidate="ddlAdminType"
                            Display="None" ErrorMessage="ADMIN TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEAdminType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdminType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin</td>
                    <td>
                        <asp:TextBox ID="txtAdmin" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("ADMIN", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqAdmin" runat="server" ControlToValidate="txtAdmin" Display="None" ErrorMessage="ADMIN must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Effective Rate</td>
                    <td>
                        <asp:TextBox ID="txtEffRate" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("EFFRATE", "{0:N6}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqEffRate" runat="server" ControlToValidate="txtEffRate" Display="None"
                                ErrorMessage="EFFECTIVE RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEEffRate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEffRate">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="2">
                        <uc4:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc5:BtnDelete ID="BtnDelete1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        Tenor From <strong><span style="text-decoration: underline">(x)</span></strong></td>
                    <td>
                        <strong><span style="text-decoration: underline">(x)</span></strong>&nbsp;<asp:DropDownList
                            ID="ddlOperatorFrom" runat="server" CssClass="required" DataSourceID="sdsOperator"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("TENOROPRFROM") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtTenorFrom" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("TENORFROM") %>' Width="56px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqTenorFrom" runat="server" ControlToValidate="txtTenorFrom" Display="None"
                                ErrorMessage="TENOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><strong><span
                                    style="text-decoration: underline"></span></strong><ajaxToolkit:ValidatorCalloutExtender
                                        ID="ajaxVCETenorFrom" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenorFrom">
                                    </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOperatorFrom" runat="server" ControlToValidate="ddlOperatorFrom"
                            Display="None" ErrorMessage="OPERATOR FROM must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOperatorFrom" runat="server" HighlightCssClass="ErrHighLight"
                            TargetControlID="reqOperatorFrom">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Tenor To <strong><span style="text-decoration: underline">(y)</span></strong></td>
                    <td>
                        <strong><span style="text-decoration: underline">(y)</span></strong>
                        <asp:DropDownList ID="ddlOperatorTo" runat="server" CssClass="required" DataSourceID="sdsOperator"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("TENOROPRTO") %>'>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtTenorTo" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("TENORTO") %>' Width="56px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqTenorTo" runat="server" ControlToValidate="txtTenorTo" Display="None"
                                ErrorMessage="TENOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCETenorTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTenorTo">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqOperatorTo" runat="server" ControlToValidate="ddlOperatorTo"
                            Display="None" ErrorMessage="OPERATOR TO must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEOperatorTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqOperatorTo">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td>
                        <asp:DropDownList ID="ddlAdminType" runat="server" CssClass="required" DataSourceID="sdsAdminType"
                            DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("ADMINTYPE") %>'>
                        </asp:DropDownList><asp:RequiredFieldValidator ID="reqAdminType" runat="server" ControlToValidate="ddlAdminType"
                            Display="None" ErrorMessage="ADMIN TYPE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEAdminType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdminType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin</td>
                    <td>
                        <asp:TextBox ID="txtAdmin" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("ADMIN", "{0:N}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqAdmin" runat="server" ControlToValidate="txtAdmin" Display="None" ErrorMessage="ADMIN must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEAdmin" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqAdmin">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Effective Rate</td>
                    <td>
                        <asp:TextBox ID="txtEffRate" runat="server" CssClass="required" Style="text-align: right"
                            Text='<%# Bind("EFFRATE", "{0:N6}") %>' Width="112px"></asp:TextBox><asp:RequiredFieldValidator
                                ID="reqEffRate" runat="server" ControlToValidate="txtEffRate" Display="None"
                                ErrorMessage="EFFECTIVE RATE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEEffRate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEffRate">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="FooterStyle" colspan="2">
                        <uc2:BtnInsert ID="BtnInsert1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsJFAdmRateEdit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        DeleteCommand="UPDATE JFADMRATE SET Deletests = 1, LastUpdate = GETDATE(), LastUserID = @USERID WHERE (JFID = @JFID) AND (ID = @ID)"
        InsertCommand="JFADMRATEAdd" InsertCommandType="StoredProcedure" SelectCommand="SELECT JFID, ID, TENORFROM, TENOROPRFROM, TENORTO, TENOROPRTO, ADMINTYPE, ADMIN, EFFRATE FROM JFADMRATE WITH (NOLOCK) WHERE (JFID = @JFID) AND (ID = @ID)"
        UpdateCommand="JFADMRATEUpdate" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvJFAdmRate" Name="JFID" PropertyName="SelectedDataKey(0)" />
            <asp:ControlParameter ControlID="gvJFAdmRate" Name="ID" PropertyName="SelectedDataKey(1)" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:ControlParameter ControlID="gvJFAdmRate" Name="JFID" PropertyName="SelectedDataKey(0)" />
            <asp:ControlParameter ControlID="gvJFAdmRate" Name="ID" PropertyName="SelectedDataKey(1)" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="gvJFAdmRate" Name="JFID" PropertyName="SelectedDataKey(0)"
                Type="Int32" />
            <asp:ControlParameter ControlID="gvJFAdmRate" Name="ID" PropertyName="SelectedDataKey(1)"
                Type="Int32" />
            <asp:Parameter Name="TENORFROM" Type="Int32" />
            <asp:Parameter Name="TENOROPRFROM" Type="String" />
            <asp:Parameter Name="TENORTO" Type="Int32" />
            <asp:Parameter Name="TENOROPRTO" Type="String" />
            <asp:Parameter Name="ADMINTYPE" Type="Byte" />
            <asp:Parameter Name="ADMIN" Type="Double" />
            <asp:Parameter Name="EFFRATE" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" Type="Int32" />
            <asp:Parameter Name="TENORFROM" Type="Int32" />
            <asp:Parameter Name="TENOROPRFROM" Type="String" />
            <asp:Parameter Name="TENORTO" Type="Int32" />
            <asp:Parameter Name="TENOROPRTO" Type="String" />
            <asp:Parameter Name="ADMINTYPE" Type="Byte" />
            <asp:Parameter Name="ADMIN" Type="Double" />
            <asp:Parameter Name="EFFRATE" Type="Double" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOperator" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT NULL AS CODE, '[OPERATOR]' AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WHERE (TYPE = 'OPERATOR')">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAdminType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[ADMIN TYPE]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'JFADMINTYPE')">
    </asp:SqlDataSource>
    <br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvJFAdmRate.ClientID%>");
</script>
</asp:Content>

