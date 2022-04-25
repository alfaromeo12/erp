<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="InsCompanyApp.aspx.vb" Inherits="Param_InsCompanyApp" title="Insurance Company Approval" %>
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
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlSearchMaintenance" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    
    <asp:Panel ID="pnlSearchMaintenance" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="width: 115px">
    <asp:DropDownList ID="ddlInsurance" runat="server">
        <asp:ListItem Value="InsuranceName">Insurance Name</asp:ListItem>
        <asp:ListItem Value="InsuranceCode">Insurance Code</asp:ListItem>
    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 115px">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" 
            CommandName="New" CausesValidation="False" Visible="False" />
            </asp:Panel>
            <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="INSCOMPANYID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Insurance List" RowHeaderColumn="INSURANCECODE">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" 
                    ShowSelectButton="True" >
                <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:CommandField>
                <asp:BoundField DataField="INSURANCECODE" HeaderText="Insurance&lt;br&gt;Code" 
                    SortExpression="INSURANCECODE" HtmlEncode="False" />
                <asp:BoundField DataField="INSURANCENAME" HeaderText="Insurance&lt;br&gt;Name" 
                    SortExpression="INSURANCENAME" HtmlEncode="False" />
                <asp:BoundField DataField="INSURANCEADDRESS" HeaderText="Address" 
                    SortExpression="INSURANCEADDRESS" />
                <asp:BoundField DataField="CITYNAME" HeaderText="City" 
                    SortExpression="CITYNAME" />
                <asp:BoundField DataField="INSURANCEPHONE" HeaderText="Phone" 
                    SortExpression="INSURANCEPHONE" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT INSCOMPANYX.INSCOMPANYID, INSCOMPANYX.INSURANCECODE, INSCOMPANYX.INSURANCENAME, INSCOMPANYX.INSURANCEADDRESS, CITY.CITYNAME, INSCOMPANYX.INSURANCEPHONE FROM INSCOMPANYX LEFT OUTER JOIN CITY ON INSCOMPANYX.CITYID = CITY.CITYID WHERE (INSCOMPANYX.Deletests = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="INSCOMPANYID">        
        <EditItemTemplate>
         <asp:Panel ID="pnlInsuranceCompany" runat="server" Enabled="False">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>               
                <tr>
                    <td>
                        ID</td>
                    <td>
                        <asp:Label ID="lblInsCompanyID" runat="server" 
                            Text='<%# Eval("INSCOMPANYID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Insurance Code</td>
                    <td>
                        <asp:TextBox ID="txtInsuranceCode" runat="server" MaxLength="10" Text='<%# Bind("INSURANCECODE") %>'
                            Width="64px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqInsuranceCode"
                                runat="server" ControlToValidate="txtInsuranceCode" Display="None" 
                            ErrorMessage="Insurance Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                    ID="reqInsuranceCode_ValidatorCalloutExtender" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqInsuranceCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name</td>
                    <td>
                        <asp:TextBox ID="txtInsuranceName" runat="server" CssClass="required" 
                            MaxLength="50" Text='<%# Bind("INSURANCENAME") %>' Width="240px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqInsuranceName" runat="server" 
                            ControlToValidate="txtInsuranceName" Display="None" 
                            ErrorMessage="Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqInsuranceName_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqInsuranceName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td>
                        <asp:TextBox ID="txtInsuranceAddress" runat="server" 
                            Height="40px" Text='<%# Bind("INSURANCEADDRESS") %>' TextMode="MultiLine" 
                            Width="280px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:DropDownList ID="ddlCityID" runat="server" 
                            DataSourceID="sdsCity" DataTextField="CITY" 
                            DataValueField="CITYID" SelectedValue='<%# Bind("CITYID") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        ZIP</td>
                    <td>
                        <asp:TextBox ID="txtInsuranceZIP" runat="server" 
                            MaxLength="15" Text='<%# Bind("INSURANCEZIP") %>' Width="112px"></asp:TextBox>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Phone</td>
                    <td>
                        <asp:TextBox ID="txtInsurancePhone" runat="server" MaxLength="15" 
                            Text='<%# Bind("INSURANCEPHONE") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Fax</td>
                    <td>
                        <asp:TextBox ID="txtInsuranceFax" runat="server" MaxLength="15" 
                            Text='<%# Bind("INSURANCEFAX") %>' Width="112px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        eMail</td>
                    <td>
                        <asp:TextBox ID="txtInsuranceEmail" runat="server" CssClass="required" 
                            MaxLength="50" Text='<%# Bind("INSURANCEEMAIL") %>' Width="240px"></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        Insurance GL</td>
                    <td>                        
                        <asp:DropDownList ID="ddlInsuranceGL" runat="server" DataSourceID="sdsCOA" 
                            DataTextField="COANAME" DataValueField="COAID" 
                            SelectedValue='<%# Bind("INSURANCEGL") %>'>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Active</td>
                    <td>
                        <asp:RadioButton ID="rbActive_Yes" runat="server" 
                            Checked='<%# Bind("ACTIVE") %>' GroupName="rbActive" Text="Yes" />
                        <asp:RadioButton ID="rbActive_No" runat="server" 
                            Checked='<%# IIF(Eval("ACTIVE"),FALSE,TRUE) %>' GroupName="rbActive" 
                            Text="No" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 21px">
                        Agent Flag</td>
                    <td style="height: 21px">
                        <asp:RadioButton ID="rbAgenFlag_Yes" runat="server" 
                            Checked='<%# Bind("AGENTFLAG") %>' GroupName="rbAgentFlag" Text="Yes" />
                        <asp:RadioButton ID="rbAgentFlag_No" runat="server" 
                            Checked='<%# IIF(Eval("AGENTFLAG"),FALSE,TRUE) %>' GroupName="rbAgentFlag" 
                            Text="No" />
                    </td>
                </tr> 
                <tr>
                    <td style="height: 21px">
                        Broker Flag</td>
                    <td style="height: 21px">
                        <asp:RadioButton ID="rbBrokerFlag_Yes" runat="server" 
                            Checked='<%# Bind("BROKERFLAG") %>' GroupName="rbBrokerFlag" Text="Yes" />
                        <asp:RadioButton ID="rbBrokerFlag_No" runat="server" 
                            Checked='<%# IIF(Eval("BROKERFLAG"),FALSE,TRUE) %>' GroupName="rbBrokerFlag" 
                            Text="No" />
                    </td>
                </tr>              
         </asp:Panel>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>            
                <tr>
                    <td colspan="2">
                        &nbsp;<uc7:BtnApprovetNoSPV ID="BtnApprovetNoSPV1" runat="server" />
                        <uc8:BtnRejectNoSPV ID="BtnRejectNoSPV1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS CITYID, NULL AS CITYCODE, '[SELECT CITY]' AS CITY UNION ALL SELECT CITYID, CITYCODE, '(' + CITYCODE + ') ' + CITYNAME AS CITY FROM CITY WITH (nolock) WHERE (DELETESTS = 0) ORDER BY CITYCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT INSCOMPANYID, INSURANCECODE, INSURANCENAME, INSURANCEADDRESS, CITYID, INSURANCEZIP, INSURANCEPHONE, INSURANCEFAX, INSURANCEEMAIL, (SELECT COAID FROM COA WHERE (DELETESTS = 0) AND (COAID = INSCOMPANYX.INSURANCEGL)) AS INSURANCEGL, ACTIVE, AGENTFLAG, BROKERFLAG FROM INSCOMPANYX WHERE (Deletests = 0) AND (INSCOMPANYID = @INSCOMPANYID)" 
        DeleteCommand="UPDATE INSCOMPANY SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID
WHERE INSCOMPANYID= @INSCOMPANYID" 
        UpdateCommand="INSCOMPANYUpdate" InsertCommand="INSCOMPANYAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="INSCOMPANYID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="INSCOMPANYID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="INSCOMPANYID" Type="Int32" />
            <asp:Parameter Name="INSURANCECODE" Type="String" />
            <asp:Parameter Name="INSURANCENAME" Type="String" />
            <asp:Parameter Name="INSURANCEADDRESS" Type="String" />
            <asp:Parameter Name="CITYID" Type="Int32" />
            <asp:Parameter Name="INSURANCEZIP" Type="String" />
            <asp:Parameter Name="INSURANCEPHONE" Type="String" />
            <asp:Parameter Name="INSURANCEFAX" Type="String" />
            <asp:Parameter Name="INSURANCEEMAIL" Type="String" />
            <asp:Parameter Name="INSURANCEGL" Type="Int32" />
            <asp:Parameter Name="ACTIVE" Type="Boolean" />
            <asp:Parameter Name="AGENTFLAG" Type="Boolean" />
            <asp:Parameter Name="BROKERFLAG" Type="Boolean" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="INSURANCECODE" Type="String" />
            <asp:Parameter Name="INSURANCENAME" Type="String" />
            <asp:Parameter Name="INSURANCEADDRESS" Type="String" />
            <asp:Parameter Name="CITYID" Type="Int32" />
            <asp:Parameter Name="INSURANCEZIP" Type="String" />
            <asp:Parameter Name="INSURANCEPHONE" Type="String" />
            <asp:Parameter Name="INSURANCEFAX" Type="String" />
            <asp:Parameter Name="INSURANCEEMAIL" Type="String" />
            <asp:Parameter Name="INSURANCEGL" Type="Int32" />
            <asp:Parameter Name="ACTIVE" Type="Boolean" />
            <asp:Parameter Name="AGENTFLAG" Type="Boolean" />
            <asp:Parameter Name="BROKERFLAG" Type="Boolean" />
            <asp:CookieParameter CookieName="UID" Name="UserID" Type="Int32" />
            <asp:Parameter Name="INSCOMPANYID" Type="Int32" Direction="InputOutput" />
            <asp:Parameter Name="retval" Type="Int32" Direction="InputOutput" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCOA" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS COAID, '[SELECT COA]' AS COANAME UNION ALL SELECT COAID, '(' + COANO + ') ' + COANAME AS COANAME FROM COA WHERE (DELETESTS = 0)">
    </asp:SqlDataSource>

    &nbsp; &nbsp; &nbsp;&nbsp;
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
TabToEnter();
FormatTable("<%=gvData.ClientID%>")
</script>

</asp:Content>

