<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ZipCode.aspx.vb" Inherits="Param_ZipCode" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>
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
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ZipCode">Zip Code</asp:ListItem>
        <asp:ListItem Value="Kelurahan">Kelurahan</asp:ListItem>
        <asp:ListItem Value="Kecamatan">Kecamatan</asp:ListItem>
        <asp:ListItem Value="City"></asp:ListItem>
        <asp:ListItem>Wilayah</asp:ListItem>
        <asp:ListItem>Province</asp:ListItem>
    </asp:DropDownList></td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" />
                    </td>
            </tr>
        </table>
<asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CommandName="New" CausesValidation="False" />
        </asp:Panel>
        <asp:Panel ID="pnlData" runat="server">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ZIPID" DataSourceID="sdsGrid" 
            Width="100%" Caption="Zip List" RowHeaderColumn="ZIPCODE">
            <Columns>
                 <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="ZIPCODE" HeaderText="Zip&lt;br&gt;Code" 
                    SortExpression="ZIPCODE" HtmlEncode="False" >
                 <ItemStyle HorizontalAlign="Center" />
                 </asp:BoundField>
                <asp:BoundField DataField="KELURAHAN" HeaderText="Kelurahan" 
                    SortExpression="KELURAHAN" HtmlEncode="False" />
                <asp:BoundField DataField="KECAMATAN" HeaderText="Kecamatan" 
                    SortExpression="KECAMATAN" />
                <asp:BoundField DataField="CITY" HeaderText="City" 
                    SortExpression="CITY" />
                <asp:BoundField DataField="WILAYAH" HeaderText="Wilayah" 
                    SortExpression="WILAYAH" />
                <asp:BoundField DataField="PROVINCE" HeaderText="Province" 
                    SortExpression="PROVINCE" />
                <asp:BoundField DataField="CITYNAME" HeaderText="City&lt;br&gt;Name" 
                    SortExpression="CITYNAME" HtmlEncode="False" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT ZIP.ZIPID, ZIP.ZIPCODE, ZIP.KELURAHAN, ZIP.KECAMATAN, ZIP.CITY, ZIP.WILAYAH, ZIP.PROVINCE, ZIP.CITYID, '(' + CITY.CITYCODE + ') ' + CITY.CITYNAME AS CITYNAME FROM ZIP WITH (NOLOCK) LEFT OUTER JOIN CITY WITH (NOLOCK) ON ZIP.CITYID = CITY.CITYID WHERE (CITY.DELETESTS = 0)"></asp:SqlDataSource>
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
      <asp:FormView ID="fvData" runat="server" DataSourceID="sdsData"
        DefaultMode="Edit" Width="100%" DataKeyNames="ZIPID">
        <InsertItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Zip Code</td>
                    <td>
                        <asp:TextBox ID="txZipCode" runat="server" MaxLength="10" Text='<%# Bind("ZIPCODE") %>'
                            Width="64px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqZipCode"
                                runat="server" ControlToValidate="txZipCode" Display="None" 
                            ErrorMessage="Zip Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqZipCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Kelurahan</td>
                    <td>
                        <asp:TextBox ID="txtKelurahan" runat="server" MaxLength="50" Text='<%# Bind("KELURAHAN") %>'
                            Width="240px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqKelurahanName"
                                runat="server" ControlToValidate="txtKelurahan" Display="None" 
                            ErrorMessage="Kelurahan must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqKelurahanName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Kecamatan</td>
                    <td>
                        <asp:TextBox ID="txtKecamatan" runat="server" 
                            MaxLength="50" Text='<%# Bind("KECAMATAN") %>' Width="240px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqKecamatan" runat="server" 
                            ControlToValidate="txtKecamatan" Display="None" 
                            ErrorMessage="Kecamatan must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqKecamatan_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqKecamatan">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" MaxLength="50" 
                            Text='<%# Bind("CITY") %>' Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCity" runat="server" 
                            ControlToValidate="txtCity" Display="None" 
                            ErrorMessage="City must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCity_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCity">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <input
						id="Button12" noenter onclick="CityFind();" style="background-position: left;
						background-image: url('../images/search.gif'); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button13" onclick="CityClear();" style="background-position: left;
							background-image: url('../images/clear.png'); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidCity" runat="server" Value='<%# Bind("CITYID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Wilayah</td>
                    <td>
                        <asp:TextBox ID="txtWilayah" runat="server" MaxLength="50" 
                            Text='<%# Bind("WILAYAH") %>' Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqWilayah" runat="server" 
                            ControlToValidate="txtWilayah" Display="None" 
                            ErrorMessage="Wilayah must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqWilayah_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqWilayah">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Province</td>
                    <td>
                        <asp:TextBox ID="txtProvince" runat="server" MaxLength="50" 
                            Text='<%# Bind("PROVINCE") %>' Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqProvince" runat="server" 
                            ControlToValidate="txtProvince" Display="None" 
                            ErrorMessage="Province must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqProvince_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProvince">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc7:BtnInsert ID="BtnInsert2" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Zip ID</td>
                    <td>
                        <asp:Label ID="lblZipID" runat="server" Text='<%# Eval("ZIPID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Zip Code</td>
                    <td>
                        <asp:TextBox ID="txZipCode" runat="server" MaxLength="10" Text='<%# Bind("ZIPCODE") %>'
                            Width="64px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqZipCode"
                                runat="server" ControlToValidate="txZipCode" Display="None" 
                            ErrorMessage="Zip Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                    ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqZipCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Kelurahan</td>
                    <td>
                        <asp:TextBox ID="txtKelurahan" runat="server" MaxLength="50" Text='<%# Bind("KELURAHAN") %>'
                            Width="240px" CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqKelurahanName"
                                runat="server" ControlToValidate="txtKelurahan" Display="None" 
                            ErrorMessage="Kelurahan must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender
                                    ID="reqKelurahanName_ValidatorCalloutExtender" runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqKelurahanName">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Kecamatan</td>
                    <td>
                        <asp:TextBox ID="txtKecamatan" runat="server" 
                            MaxLength="50" Text='<%# Bind("KECAMATAN") %>' Width="240px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqKecamatan" runat="server" 
                            ControlToValidate="txtKecamatan" Display="None" 
                            ErrorMessage="Kecamatan must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqKecamatan_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqKecamatan">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        City</td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" MaxLength="50" 
                            Text='<%# Bind("CITY") %>' Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCity" runat="server" 
                            ControlToValidate="txtCity" Display="None" 
                            ErrorMessage="City must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCity_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCity">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <input
						id="Button12" noenter onclick="CityFind();" style="background-position: left;
						background-image: url('../Images/search.gif'); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />
						<input
							id="Button13" onclick="CityClear();" style="background-position: left;
							background-image: url('../Images/clear.png'); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidCity" runat="server" Value='<%# Bind("CITYID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Wilayah</td>
                    <td>
                        <asp:TextBox ID="txtWilayah" runat="server" MaxLength="50" 
                            Text='<%# Bind("WILAYAH") %>' Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqWilayah" runat="server" 
                            ControlToValidate="txtWilayah" Display="None" 
                            ErrorMessage="Wilayah must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqWilayah_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqWilayah">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Province</td>
                    <td>
                        <asp:TextBox ID="txtProvince" runat="server" MaxLength="50" 
                            Text='<%# Bind("PROVINCE") %>' Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqProvince" runat="server" 
                            ControlToValidate="txtProvince" Display="None" 
                            ErrorMessage="Province must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqProvince_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqProvince">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc8:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
        <asp:SqlDataSource ID="sdsData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        SelectCommand="SELECT ZIP.ZIPID, ZIP.ZIPCODE, ZIP.KELURAHAN, ZIP.KECAMATAN, ZIP.CITY, ZIP.WILAYAH, ZIP.PROVINCE, ZIP.CITYID FROM ZIP INNER JOIN CITY ON ZIP.CITYID = CITY.CITYID WHERE (ZIP.ZIPID = @ZIPID) AND (CITY.DELETESTS = 0)" 
        InsertCommand="ZIPAdd" InsertCommandType="StoredProcedure" 
        UpdateCommand="ZIPUpdate" UpdateCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="ZipCode" Type="Single" />
                <asp:Parameter Name="Kelurahan" Type="String" />
                <asp:Parameter Name="Kecamatan" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="Wilayah" Type="String" />
                <asp:Parameter Name="Province" Type="String" />
                <asp:Parameter Name="CityID" Type="Int32" />
                <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvData" Name="ZIPID" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ZIPID" Type="Int32" />
                <asp:Parameter Name="ZipCode" Type="Single" />
                <asp:Parameter Name="Kelurahan" Type="String" />
                <asp:Parameter Name="Kecamatan" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="Wilayah" Type="String" />
                <asp:Parameter Name="Province" Type="String" />
                <asp:Parameter Name="CityID" Type="Int32" />
                <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
            </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript">
    TabToEnter();
    FormatTable("<%=gvData.ClientID%>")
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
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

    function CityFind() {
        WinRef = window.open("../Param/CitySearch.aspx?Action=Find", "CityFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus()
    }

    function SetCity(CityID, City) {
        SetValueTxtByClientID("<%=strCityID%>", CityID);
        SetValueTxtByClientID("<%=strCity%>", City);
    }
    function CityClear(iFind) {
        SetValueTxtByClientID("<%=strCityID%>", "");
        SetValueTxtByClientID("<%=strCity%>", "");
}
</script>
</asp:Content>

