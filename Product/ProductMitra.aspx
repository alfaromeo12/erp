<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ProductMitra.aspx.vb" Inherits="Product_ProductMitra" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="PRODUCTMITRACODE">Product Mitra Code</asp:ListItem>
        <asp:ListItem Value="ARMADATYPENAME">Product Mitra Name</asp:ListItem>
        <asp:ListItem Value="SERVICETYPENAME">Service Type</asp:ListItem>
        <asp:ListItem Value="SERVICETYPEDTLNAME">Service Type Detail</asp:ListItem>
        <asp:ListItem Value="FULLNAME">Mitra Name</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />

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
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="PRODUCTMITRAID" Caption="Product Mitra List" RowHeaderColumn="PRODUCTMITRAID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="PRODUCTMITRAID" HeaderText="ID&lt;br&gt;" HtmlEncode="False" 
                    SortExpression="PRODUCTMITRAID" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTMITRACODE" HeaderText="Product&lt;br&gt;Mitra Code" HtmlEncode="False" 
                    SortExpression="PRODUCTMITRACODE" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="FULLNAME" HeaderText="Mitra&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="FULLNAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="SERVICETYPENAME" HeaderText="Service&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="SERVICETYPENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="SERVICETYPEDTLNAME" HeaderText="Service&lt;br&gt;Type Detail" HtmlEncode="False"
                    SortExpression="SERVICETYPEDTLNAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ARMADATYPENAME" HeaderText="Product&lt;br&gt;Mitra Name" HtmlEncode="False"
                    SortExpression="ARMADATYPENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTBRAND" HeaderText="Product&lt;br&gt;Brand" HtmlEncode="False"
                    SortExpression="PRODUCTBRAND">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="MINCAPACITY" HeaderText="Minimum&lt;br&gt;Capacity" HtmlEncode="False"
                    SortExpression="MINCAPACITY">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="UNITMINCAPACITYCODE" HeaderText="Unit Minimum&lt;br&gt;Capacity" HtmlEncode="False" 
                    SortExpression="UNITMINCAPACITYCODE">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="MAXCAPACITY" HeaderText="Maximum&lt;br&gt;Capacity" HtmlEncode="False"
                    SortExpression="MAXCAPACITY">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="UNITMAXCAPACITYCODE" HeaderText="Unit Maximum&lt;br&gt;Capacity" HtmlEncode="False" 
                    SortExpression="UNITMAXCAPACITYCODE">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESS" HeaderText="Address&lt;br&gt;" HtmlEncode="False" 
                    SortExpression="ADDRESS">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PM.PRODUCTMITRAID,PM.PRODUCTMITRACODE,PM.MITRAID,AUP.FULLNAME,AUP.ADDRESS,PM.SERVICETYPEID,ST.SERVICETYPENAME
                              ,PM.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,PM.ARMADATYPEID,MAT.ARMADATYPENAME,PM.PRODUCTBRAND,PM.MINCAPACITY
                              ,PM.UNITMINCAPACITY,MU.MASTERUNITCODE AS UNITMINCAPACITYCODE,PM.MAXCAPACITY,PM.UNITMAXCAPACITY
	                          ,MU2.MASTERUNITCODE AS UNITMAXCAPACITYCODE,PM.IMAGEPRODUCT
                        FROM PRODUCTMITRA PM
	                          LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID
	                          LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID
	                          LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
	                          LEFT OUTER JOIN MASTERUNIT MU ON PM.UNITMINCAPACITY = MU.MASTERUNITID
	                          LEFT OUTER JOIN MASTERUNIT MU2 ON PM.UNITMINCAPACITY = MU2.MASTERUNITID
                              LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID
                        WHERE (PM.DELETESTS = 0)"></asp:SqlDataSource>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <table cellpadding=0 cellspacing=0 width="100%">
        <tr>
             <td>
     <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="PRODUCTMITRAID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Product Mitra ID</td>
                    <td>
                        <asp:Label ID="lblProductMitraID" runat="server" Text='<%# Eval("PRODUCTMITRAID")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Product Mitra Code</td>
                    <td>
                        <asp:TextBox ID="txtProductMitraCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("PRODUCTMITRACODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtProductMitraCode" Display="None" ErrorMessage="Product Mitra Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Mitra Name</td>
                    <td>
                        <asp:TextBox ID="txtMitra" runat="server" MaxLength="200" Enabled="false" CssClass="required"
                            ReadOnly="true" Text='<%# Bind("FULLNAME")%>' Width="150px"></asp:TextBox>
                        <input
						    id="Button11" noenter onclick="MitraFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                        <input
							id="Button12" onclick="MitraClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 47px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
                        <asp:HiddenField ID="hidMitra" runat="server" Value='<%# Bind("MITRAID")%>' />
                    </td>
                </tr>
                <tr>
                        <td>Service Type</td>
                        <td>
                            <asp:DropDownList ID="ddlService" runat="server" DataSourceID="sdsServiceType" CssClass="required" Width="150px"
                                DataTextField="SERVICETYPENAME" DataValueField="SERVICETYPEID" SelectedValue='<%# Bind("SERVICETYPEID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqService" runat="server" ControlToValidate="ddlService" Display="None" ErrorMessage="Service Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEService" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqService">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                        <td>Service Type Detail</td>
                        <td>
                            <asp:DropDownList ID="ddlServDtl" runat="server" DataSourceID="sdsServiceDtl" CssClass="required" Width="150px"
                                DataTextField="SERVICETYPEDTLNAME" DataValueField="SERVICETYPEDTLID" SelectedValue='<%# Bind("SERVICETYPEDTLID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqType" runat="server" ControlToValidate="ddlServDtl" Display="None" ErrorMessage="Service Type Detail must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td>Armada Type</td>
                        <td>
                            <asp:DropDownList ID="ddlArmadaType" runat="server" DataSourceID="sdsArmadaType" CssClass="required" Width="150px"
                                DataTextField="ARMADATYPENAME" DataValueField="ARMADATYPEID" SelectedValue='<%# Bind("ARMADATYPEID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlArmadaType" Display="None" ErrorMessage="Armada Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ValidatorCalloutExtender2" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    <td>
                        Product Brand</td>
                    <td>
                        <asp:TextBox ID="txtBrand" runat="server" Width="150px" MaxLength="500" Text='<%# Bind("PRODUCTBRAND")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqBrand" runat="server" ControlToValidate="txtBrand" Display="None" ErrorMessage="Product Brand must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBrand" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBrand">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                       Min Capacity</td>
                    <td>
                        <asp:TextBox ID="txtMinCap" runat="server" Width="85px" MaxLength="30" 
                            Text='<%# Bind("MINCAPACITY")%>' CssClass="required" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinCap" runat="server" ControlToValidate="txtMinCap" Display="None" 
                            ErrorMessage="Minimum Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlMinCap" runat="server" DataSourceID="sdsUnit" CssClass="required"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITMAXCAPACITY")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnitCap" runat="server" ControlToValidate="ddlMinCap" Display="None" ErrorMessage="Unit Max Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnitCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnitCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                       Max Capacity</td>
                    <td>
                        <asp:TextBox ID="txtMaxCap" runat="server" Width="85px" MaxLength="30" 
                            Text='<%# Bind("MAXCAPACITY")%>' CssClass="required" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDim" runat="server" ControlToValidate="txtMaxCap" Display="None" 
                            ErrorMessage="Maximum Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDim" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDim">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="sdsUnit" CssClass="required"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITMAXCAPACITY")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnit" runat="server" ControlToValidate="ddlUnit" Display="None" ErrorMessage="Unit Max Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnit" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnit">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                <td>Upload Image</td>
                         <td>
                             <asp:Panel ID="pnlProduct" runat="server" CssClass="FooterStyle" Font-Bold="True" GroupingText="IMAGE UPLOAD (*.jpg)" Width="264px">
                                 <asp:FileUpload ID="FileImageArtWork" runat="server" CssClass="required" Font-Size="Medium" size="75" Width="100%" />
                                 <asp:Label ID="lblError" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label>
                             </asp:Panel>
                         </td>
                    <td>Address</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" Enabled="false" Height="100px" MaxLength="255" Text='<%# Bind("ADDRESS")%>' TextMode="MultiLine" Width="239px"></asp:TextBox>
                      </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" class="FooterStyle">
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Style="background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" Text="Update" ToolTip="Update" Width="75px" />
                        <span onclick="return confirm('Are You Sure You Will Delete This Data ??')" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server"  />
                          </span>
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
                 <tr>
                    <td>
                        Product Mitra Code</td>
                    <td>
                        <asp:TextBox ID="txtProductMitraCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("PRODUCTMITRACODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtProductMitraCode" Display="None" ErrorMessage="Product Mitra Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Mitra Name</td>
                    <td>
                        <asp:TextBox ID="txtMitra" runat="server" MaxLength="20" Enabled="false" CssClass="required" Width="150px"
                            ReadOnly="true" Text='<%# Bind("FULLNAME")%>'></asp:TextBox>
                        <input
						    id="Button11" noenter onclick="MitraFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                        <input
							id="Button12" onclick="MitraClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 47px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
                        <asp:HiddenField ID="hidMitra" runat="server" Value='<%# Bind("MITRAID")%>' />
                    </td>
                </tr>
                <tr>
                        <td>Service Type</td>
                        <td>
                            <asp:DropDownList ID="ddlService" runat="server" DataSourceID="sdsServiceType" CssClass="required" Width="150px"
                                DataTextField="SERVICETYPENAME" DataValueField="SERVICETYPEID" SelectedValue='<%# Bind("SERVICETYPEID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqService" runat="server" ControlToValidate="ddlService" Display="None" ErrorMessage="Service Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEService" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqService">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                        <td>Service Type Detail</td>
                        <td>
                            <asp:DropDownList ID="ddlServDtl" runat="server" DataSourceID="sdsServiceDtl" CssClass="required" Width="150px"
                                DataTextField="SERVICETYPEDTLNAME" DataValueField="SERVICETYPEDTLID" SelectedValue='<%# Bind("SERVICETYPEDTLID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqType" runat="server" ControlToValidate="ddlServDtl" Display="None" ErrorMessage="Service Type Detail must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td>Armada Type</td>
                        <td>
                            <asp:DropDownList ID="ddlArmadaType" runat="server" DataSourceID="sdsArmadaType" CssClass="required" Width="150px"
                                DataTextField="ARMADATYPENAME" DataValueField="ARMADATYPEID" SelectedValue='<%# Bind("ARMADATYPEID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlArmadaType" Display="None" ErrorMessage="Armada Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ValidatorCalloutExtender1" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                </tr>
                <tr>
                    <td>
                        Product Brand</td>
                    <td>
                        <asp:TextBox ID="txtBrand" runat="server" Width="150px" MaxLength="500" Text='<%# Bind("PRODUCTBRAND")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqBrand" runat="server" ControlToValidate="txtBrand" Display="None" ErrorMessage="Product Brand must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEBrand" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqBrand">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                       Min Capacity</td>
                    <td>
                        <asp:TextBox ID="txtMinCap" runat="server" Width="85px" MaxLength="30" 
                            Text='<%# Bind("MINCAPACITY")%>' CssClass="required" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinCap" runat="server" ControlToValidate="txtMinCap" Display="None" 
                            ErrorMessage="Minimum Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlMinCap" runat="server" DataSourceID="sdsUnit" CssClass="required"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITMAXCAPACITY")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnitCap" runat="server" ControlToValidate="ddlMinCap" Display="None" ErrorMessage="Unit Max Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnitCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnitCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    </tr>
                <tr>
                    <td>
                       Max Capacity</td>
                    <td>
                        <asp:TextBox ID="txtMaxCap" runat="server" Width="85px" MaxLength="30" 
                            Text='<%# Bind("MAXCAPACITY")%>' CssClass="required" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDim" runat="server" ControlToValidate="txtMaxCap" Display="None" 
                            ErrorMessage="Maximum Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDim" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDim">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="sdsUnit" CssClass="required"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITMAXCAPACITY")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnit" runat="server" ControlToValidate="ddlUnit" Display="None" ErrorMessage="Unit Max Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnit" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnit">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                <td>Address</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" Enabled="false" Height="100px" MaxLength="255" Text='<%# Bind("ADDRESS")%>' TextMode="MultiLine" Width="239px"></asp:TextBox>
                      </td>
                    </tr>
                 <tr>
                     <td>Upload Image</td>
                         <td>
                             <asp:Panel ID="pnlProduct" runat="server" CssClass="FooterStyle" Font-Bold="True" GroupingText="IMAGE UPLOAD (*.jpg)" Width="264px">
                                 <asp:FileUpload ID="FileImageArtWork" runat="server" CssClass="required" Font-Size="Medium" size="75" Width="100%" />
                                 <asp:Label ID="lblError" runat="server" CssClass="ErrHighLight" Visible="False"></asp:Label>
                             </asp:Panel>
                         </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" class="FooterStyle">
                        <asp:Button ID="btnSave" runat="server" Style="font-size: 8pt; cursor: pointer; background-position: left top; background-image: url('../images/Save.gif'); background-repeat: no-repeat; text-align: right; height: 22px;" Text="Insert" ToolTip="Insert New Data" Width="75px" OnClick="btnSave_Click" />
                        <uc3:BtnCancel ID="BtnCancel2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>
                   </td>
           <td></td>
                    <td>
                         <asp:Panel ID="pnlImg" runat="server" GroupingText="IMAGEPRODUCT" Width="300px">
                     <asp:Image ID="imgProduct" Runat="server" Visible="true" Height="240px" Width="340px" />
                             </asp:Panel>
                        </td>
                </tr>
        </table>
     <asp:SqlDataSource ID="sdsServiceDtl" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS SERVICETYPEDTLID, '[ALL]' AS SERVICETYPEDTLNAME UNION ALL 
                                        SELECT SERVICETYPEDTLID, SERVICETYPEDTLNAME FROM SERVICETYPEDTL WHERE (DELETESTS= 0) ORDER BY SERVICETYPEDTLNAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsServiceType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS SERVICETYPEID, '[DISPLAY ALL]' AS SERVICETYPENAME UNION ALL 
                                        SELECT SERVICETYPEID, SERVICETYPENAME FROM SERVICETYPE WHERE (DELETESTS= 0) ORDER BY SERVICETYPENAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUnit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS MASTERUNITID, '[ALL]' AS MASTERUNITCODE UNION ALL 
                                        SELECT MASTERUNITID, MASTERUNITCODE FROM MASTERUNIT WHERE (DELETESTS= 0) ORDER BY MASTERUNITCODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsArmadaType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS ARMADATYPEID, '[DISPLAY ALL]' AS ARMADATYPENAME UNION ALL 
                                        SELECT ARMADATYPEID, ARMADATYPENAME FROM MASTERARMADATYPE WHERE (DELETESTS= 0) ORDER BY ARMADATYPENAME"></asp:SqlDataSource>  
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PM.PRODUCTMITRAID,PM.PRODUCTMITRACODE,PM.MITRAID,AUP.FULLNAME,AUP.ADDRESS,PM.SERVICETYPEID,ST.SERVICETYPENAME
                              ,PM.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,PM.ARMADATYPEID,MAT.ARMADATYPENAME,PM.PRODUCTBRAND,PM.MINCAPACITY
                              ,PM.UNITMINCAPACITY,MU.MASTERUNITCODE AS UNITMINCAPACITYCODE,PM.MAXCAPACITY,PM.UNITMAXCAPACITY
	                          ,MU2.MASTERUNITCODE AS UNITMAXCAPACITYCODE,PM.IMAGEPRODUCT
                        FROM PRODUCTMITRA PM
	                          LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID
	                          LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID
	                          LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
	                          LEFT OUTER JOIN MASTERUNIT MU ON PM.UNITMINCAPACITY = MU.MASTERUNITID
	                          LEFT OUTER JOIN MASTERUNIT MU2 ON PM.UNITMINCAPACITY = MU2.MASTERUNITID
                              LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID
                       WHERE (PRODUCTMITRAID = @PRODUCTMITRAID)" 
          DeleteCommand="UPDATE PRODUCTMITRA SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE PRODUCTMITRAID=@PRODUCTMITRAID" 
          UpdateCommand="PRODUCTMITRAIDUPDATE" InsertCommand="PRODUCTMITRAIDADD" 
          InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PRODUCTMITRAID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="PRODUCTMITRAID" />
        </DeleteParameters>
     </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.elevateZoom-3.0.8.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery.min.js.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
    $(function () {
        var oImage1 = document.getElementById("Image1").value
        $("[id*=Image1]").elevateZoom({
            cursor: 'pointer',
            imageCrossfade: true,
            loadingIcon: 'loading.gif'
        });
    });
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    //Mitra Find
    function MitraFind() {
        WinRef = window.open("../Product/MitraSearch.aspx?Action=Find", "MitraFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }
    function SetMitraFind(USERID, FULLNAME,ADDRESS, APPUSERPARTNER) {
        SetValueTxtByClientID("<%=strUserID%>", USERID);
        SetValueTxtByClientID("<%=strFullName%>", FULLNAME);
        SetValueTxtByClientID("<%=strAddress%>", ADDRESS);
        SetValueTxtByClientID("<%=strMitra%>", APPUSERPARTNER);
    }
    function MitraClear() {
        SetValueTxtByClientID("<%=strUserID%>", "");
        SetValueTxtByClientID("<%=strFullName%>", "");
        SetValueTxtByClientID("<%=strAddress%>", "");
        SetValueTxtByClientID("<%=strMitra%>", "");
    }
</script>
</asp:Content>

