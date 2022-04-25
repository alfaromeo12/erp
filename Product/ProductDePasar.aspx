<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ProductDePasar.aspx.vb" Inherits="Product_Product" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="PRODUCTCODE">Product Code</asp:ListItem>
        <asp:ListItem Value="PRODUCTNAME">Product Name</asp:ListItem>
        <asp:ListItem Value="ENTITYTYPENAME">Entity Name</asp:ListItem>
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
            DataKeyNames="PRODUCTID" Caption="Product List" RowHeaderColumn="PRODUCTID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="Stock&lt;BR&gt;">
                                 <ItemTemplate>
                                     <img src="../Images/new.png" onclick='StockProduct("<%#Eval("PRODUCTID")%>")' />
                                 </ItemTemplate>
                                 <ItemStyle HorizontalAlign="Center" Width="25px" />
                             </asp:TemplateField>
                <asp:BoundField DataField="PRODUCTID" HeaderText="ID" 
                    SortExpression="PRODUCTID">
                    <ItemStyle HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTCODE" HeaderText="Product&lt;br&gt;Detail Code" HtmlEncode="False" 
                    SortExpression="PRODUCTCODE" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ENTITYTYPENAME" HeaderText="Entity&lt;br&gt;Type Name" HtmlEncode="False"
                    SortExpression="ENTITYTYPENAME">
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
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PRODUCTNAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description&lt;br&gt;" HtmlEncode="False"
                    SortExpression="DESCRIPTION">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <%--<asp:BoundField DataField="PROVINCENAME" HeaderText="Province&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PROVINCENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESSSTORE" HeaderText="Store&lt;br&gt;Address" HtmlEncode="False"
                    SortExpression="ADDRESSSTORE">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="STORENAME" HeaderText="Store&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="STORENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>--%>
                <asp:BoundField DataField="INITIALSTOCK" HeaderText="Stock&lt;br&gt;" HtmlEncode="False"
                    SortExpression="INITIALSTOCK">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="STOCKUNIT" HeaderText="Unit&lt;br&gt;Stock" HtmlEncode="False"
                    SortExpression="STOCKUNIT">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRICE" HeaderText="Price&lt;br&gt;" HtmlEncode="False" DataFormatString="{0:N0}"
                    SortExpression="PRICE">
                    <ItemStyle HorizontalAlign="Right"/>
                </asp:BoundField>
                <asp:BoundField DataField="DISCOUNT" HeaderText="Discount&lt;br&gt;%" HtmlEncode="False"
                    SortExpression="DISCOUNT">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="DISCOUNTPRICE" HeaderText="Discount&lt;br&gt;Price" HtmlEncode="False" DataFormatString="{0:N0}"
                    SortExpression="DISCOUNTPRICE">
                    <ItemStyle HorizontalAlign="Right"/>
                </asp:BoundField>
                <asp:BoundField DataField="CAPACITY" HeaderText="Capacity&lt;br&gt;" HtmlEncode="False"
                    SortExpression="CAPACITY">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="UNITCAP" HeaderText="Unit&lt;br&gt;Capacity" HtmlEncode="False"
                    SortExpression="UNITCAP">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME
                              ,MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME
                              ,MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY
	                          ,MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT
                              ,MP.IMAGEDEPASAR,MP.IMAGEURL,MP.DESCRIPTION
                          FROM MASTERPRODUCT MP
	                        LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID
	                        LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID
                            LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                            LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID
                            LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID
                         WHERE (MP.DELETESTS = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="PRODUCTID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Product ID</td>
                    <td>
                        <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("PRODUCTID")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtProductCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("PRODUCTCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtProductCode" Display="None" ErrorMessage="Product Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Entity Type</td>
                    <td>
                        <asp:DropDownList ID="ddlEntity" runat="server" CssClass="required" DataSourceID="sdsEntity" DataTextField="ENTITYTYPENAME" DataValueField="ENTITYTYPEID" SelectedValue='<%# Bind("ENTITYTYPEID")%>' Width="180px">
                                </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqEntity" runat="server" ControlToValidate="ddlEntity" Display="None" ErrorMessage="Entity must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEEntity" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEntity">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Service Type</td>
                        <td>
                           <asp:TextBox ID="txtServiceType" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPENAME")%>' ReadOnly="True" Width="100px" CssClass="required"></asp:TextBox>
                            <input
						    id="Button7" noenter onclick="ServiceFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button8" onclick="ServiceClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidService" runat="server" Value='<%# Bind("SERVICETYPEID")%>' />
                            <asp:RequiredFieldValidator
                            ID="reqGroup" runat="server" ControlToValidate="txtServiceType" Display="None" ErrorMessage="Service Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajakVCEGroup" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                      <td>Service Type Detail</td>
                        <td>
                            <asp:TextBox ID="txtServDtl" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPEDTLNAME")%>' ReadOnly="True" Width="100px" CssClass="required"></asp:TextBox>
                            <input
						    id="Button1" noenter onclick="ServDtlFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button2" onclick="ServDtlClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 47px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidServDtl" runat="server" Value='<%# Bind("SERVICETYPEDTLID")%>' />
                            <asp:RequiredFieldValidator
                            ID="reqServDtl" runat="server" ControlToValidate="txtServDtl" Display="None" ErrorMessage="Service Type Detail must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEServDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqServDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                 <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtProductName" runat="server" Width="200px" MaxLength="100" Text='<%# Bind("PRODUCTNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtProductName" Display="None" ErrorMessage="Product Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                   
                     <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDes" runat="server" Width="195px" TextMode="MultiLine" MaxLength="500" Text='<%# Bind("DESCRIPTION")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>  
                <tr>
                    <td>
                       Capacity</td>
                    <td>
                        <asp:TextBox ID="txtMinCap" runat="server" Width="150px" MaxLength="30" 
                            Text='<%# Bind("CAPACITY")%>' CssClass="required" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinCap" runat="server" ControlToValidate="txtMinCap" Display="None" 
                            ErrorMessage="Minimum Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            <asp:DropDownList ID="DdlMinCap" runat="server" DataSourceID="sdsUnit" CssClass="required" Width="45px"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITCAPACITY")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnitCap" runat="server" ControlToValidate="ddlMinCap" Display="None" ErrorMessage="Unit Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnitCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnitCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Initial Stock</td>
                    <td>
                        <asp:TextBox ID="txtInitial" runat="server" Width="150px" Text='<%# Bind("INITIALSTOCK")%>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqInitial" runat="server" ControlToValidate="txtInitial" Display="None" ErrorMessage="Initial Stock must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEInitial" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInitial">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlStock" runat="server" DataSourceID="sdsUnit" CssClass="required" Width="45px"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITSTOCK")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnit" runat="server" ControlToValidate="ddlStock" Display="None" ErrorMessage="Unit Stock must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnit" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnit">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>  
                <tr>
                    <td>
                        Ready Stock</td>
                    <td>
                        <asp:TextBox ID="txtReady" runat="server" Width="200px" Text='<%# Bind("READYSTOCK")%>' Enabled="false"></asp:TextBox>
                    </td>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" ClientIDMode="Static" Width="200px" MaxLength="100" Text='<%# Bind("PRICE", "{0:N2}")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Discount %</td>
                    <td>
                        <asp:TextBox ID="txtDiscount" runat="server" Width="200px" ClientIDMode="Static" MaxLength="100" onKeyup="SumDiscount(this);" Text='<%# Bind("DISCOUNT")%>' CssClass="required"></asp:TextBox>
                    </td>
                    <td>
                        Discount</td>
                    <td>
                        <asp:TextBox ID="txtDisAfter" runat="server" Width="200px" ClientIDMode="Static" Enabled="false" MaxLength="100" onKeyup="SumDiscount(this);"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Discount After PrIce</td>
                    <td>
                        <asp:TextBox ID="txtDiscPrice" runat="server" Enabled="true" ClientIDMode="Static" Width="200px" MaxLength="100" Text='<%# Bind("DISCOUNTPRICE", "{0:N2}")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>   
                <tr>
                    <td>
                        Image Url</td>
                    <td>
                        <asp:TextBox ID="txtImageUrl" runat="server" Width="200px" MaxLength="100" Text='<%# Bind("IMAGEURL")%>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqUrl" runat="server" ControlToValidate="txtImageUrl" Display="None" ErrorMessage="Image URL must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEUrl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUrl">
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
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtProductCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("PRODUCTCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtProductCode" Display="None" ErrorMessage="Product Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                     <td>
                        Entity Type</td>
                    <td>
                        <asp:DropDownList ID="ddlEntity" runat="server" CssClass="required" DataSourceID="sdsEntity" DataTextField="ENTITYTYPENAME" DataValueField="ENTITYTYPEID" SelectedValue='<%# Bind("ENTITYTYPENAME")%>' Width="180px">
                                </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqEntity" runat="server" ControlToValidate="ddlEntity" Display="None" ErrorMessage="Entity must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEEntity" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqEntity">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Service Type</td>
                        <td>
                           <asp:TextBox ID="txtServiceType" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPENAME")%>' ReadOnly="True" Width="100px" CssClass="required"></asp:TextBox>
                            <input
						    id="Button7" noenter onclick="ServiceFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button8" onclick="ServiceClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidService" runat="server" Value='<%# Bind("SERVICETYPEID")%>' />
                            <asp:RequiredFieldValidator
                            ID="reqGroup" runat="server" ControlToValidate="txtServiceType" Display="None" ErrorMessage="Service Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajakVCEGroup" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                      <td>Service Type Detail</td>
                        <td>
                            <asp:TextBox ID="txtServDtl" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPEDTLNAME")%>' ReadOnly="True" Width="100px" CssClass="required"></asp:TextBox>
                            <input
						    id="Button1" noenter onclick="ServDtlFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button2" onclick="ServDtlClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 47px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidServDtl" runat="server" Value='<%# Bind("SERVICETYPEDTLID")%>' />
                            <asp:RequiredFieldValidator
                            ID="reqServDtl" runat="server" ControlToValidate="txtServDtl" Display="None" ErrorMessage="Service Type Detail must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEServDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqServDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                 <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtProductName" runat="server" Width="200px" MaxLength="100" Text='<%# Bind("PRODUCTNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtProductName" Display="None" ErrorMessage="Product Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                     <td>
                        Description</td>
                    <td>
                        <asp:TextBox ID="txtDes" runat="server" Width="195px" TextMode="MultiLine" MaxLength="500" Text='<%# Bind("DESCRIPTION")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                     <td>
                       Capacity</td>
                    <td>
                        <asp:TextBox ID="txtMinCap" runat="server" Width="150px"
                            Text='<%# Bind("CAPACITY")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqMinCap" runat="server" ControlToValidate="txtMinCap" Display="None" 
                            ErrorMessage="Minimum Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMinCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMinCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="DdlMinCap" runat="server" DataSourceID="sdsUnit" CssClass="required" Width="45px"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITCAPACITY")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnitCap" runat="server" ControlToValidate="ddlMinCap" Display="None" ErrorMessage="Unit Capacity must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnitCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnitCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Initial Stock</td>
                    <td>
                        <asp:TextBox ID="txtInitial" runat="server" Width="150px" Text='<%# Bind("INITIALSTOCK")%>' CssClass="required"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="reqInitial" runat="server" ControlToValidate="txtInitial" Display="None" ErrorMessage="Initial Stock must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEInitial" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqInitial">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlStock" runat="server" DataSourceID="sdsUnit" CssClass="required" Width="45px"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITSTOCK")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnit" runat="server" ControlToValidate="ddlStock" Display="None" ErrorMessage="Unit Stock must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnit" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnit">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" ClientIDMode="Static" Width="200px" MaxLength="100" Text='<%# Bind("PRICE", "{0:N2}")%>' CssClass="required"></asp:TextBox>
                    </td>
                    <td>
                        Discount %</td>
                    <td>
                        <asp:TextBox ID="txtDiscount" runat="server" Width="200px" ClientIDMode="Static" MaxLength="100" onKeyup="SumDiscount(this);" Text='<%# Bind("DISCOUNT")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Discount</td>
                    <td>
                        <asp:TextBox ID="txtDisAfter" runat="server" Width="200px" ClientIDMode="Static" Enabled="false" MaxLength="100" onKeyup="SumDiscount(this);"></asp:TextBox>
                    </td>
                    <td>
                        Discount PrIce</td>
                    <td>
                        <asp:TextBox ID="txtDiscPrice" runat="server" Enabled="true" ClientIDMode="Static" Width="200px" MaxLength="100" Text='<%# Bind("DISCOUNTPRICE", "{0:N2}")%>' CssClass="required"></asp:TextBox>
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
                         <asp:Panel ID="pnlImg" runat="server" GroupingText="IMAGE" Width="400px">
                     <asp:Image ID="imgProduct" Runat="server" Visible="true" Height="280px" Width="400px" />
                             </asp:Panel>
                        </td>
                </tr>
        </table> 
    <asp:SqlDataSource ID="sdsUnit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS MASTERUNITID, '[ALL]' AS MASTERUNITCODE UNION ALL 
                                        SELECT MASTERUNITID, MASTERUNITCODE FROM MASTERUNIT WHERE (DELETESTS= 0) ORDER BY MASTERUNITCODE"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsEntity" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand=" SELECT NULL AS ENTITYTYPEID, '[DISPLAY ALL]' AS ENTITYTYPENAME UNION ALL 
                                        SELECT ENTITYTYPEID, ENTITYTYPENAME FROM ENTITYTYPE 
                        WHERE (DELETESTS= 0) ORDER BY ENTITYTYPENAME"></asp:SqlDataSource>
      <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME
                                  ,MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME
                                  ,MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY
	                              ,MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT
                                  ,MP.IMAGEDEPASAR,MP.IMAGEURL,MP.DESCRIPTION,PS.READYSTOCK
                        FROM MASTERPRODUCT MP
	                            LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID
	                            LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID
                                LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                                LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID
                                LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID
						        LEFT OUTER JOIN PRODUCTSTOCK PS ON MP.PRODUCTID = PS.PRODUCTID
                       WHERE (MP.PRODUCTID = @PRODUCTID) 
					   AND PS.STOCKDATE = (SELECT MAX(STOCKDATE) FROM PRODUCTSTOCK WHERE PRODUCTID = @PRODUCTID)" 
          DeleteCommand="UPDATE MASTERPRODUCT SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE PRODUCTID=@PRODUCTID" 
          UpdateCommand="MASTERPRODUCTUPDATE" InsertCommand="MASTERPRODUCTADD" 
          InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PRODUCTID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="PRODUCTID" />
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
    function SumDiscount(o) {
        var a = document.getElementById("txtPrice").value;
        var txtB = document.getElementById("txtDiscount").value;
        var c = document.getElementById("txtDisAfter");
        var d = toNumeric(txtB) / 100;
        var result = toNumeric(a) * toNumeric(d);
        if (!isNaN(result)) {
            c.value = Math.round(result * 1000) / 1000;
        }
        SumPricedSC(this);
    }
    function SumPricedSC(o) {
        var a = document.getElementById("txtPrice").value;
        var txtB = document.getElementById("txtDisAfter").value;
        var c = document.getElementById("txtDiscPrice");
        var result = toNumeric(a) - toNumeric(txtB);
        if (!isNaN(result)) {
            c.value = Math.round(result * 1000) / 1000;
        }
    }
    //Service Type Find
    function ServiceFind() {
        WinRef = window.open("../ParamGlobal/ServicetypeSearch.aspx?Action=Find", "ServiceFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }
    function SetService(SERVICETYPEID, SERVICETYPE) {
        SetValueTxtByClientID("<%=strServiceTypeId%>", SERVICETYPEID);
        SetValueTxtByClientID("<%=strServiceType%>", SERVICETYPE);
    }
    function ServiceClear() {
        SetValueTxtByClientID("<%=strServiceTypeId%>", "");
        SetValueTxtByClientID("<%=strServiceType%>", "");

    }
    // Service Type Detail Find
    function ServDtlFind() {
        WinRef = window.open("../ParamGlobal/ServicetypeDtlSearch.aspx?Action=Find&SERVICETYPEID=" + GetValueTxtByClientID("<%=strServiceTypeId%>") + "", "ServDtlFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }
    function SetServDtl(SERVICETYPEDTLID, SERVICETYPEDTL) {
        SetValueTxtByClientID("<%=strServiceTypeDtlId%>", SERVICETYPEDTLID);
        SetValueTxtByClientID("<%=strServiceTypeDtl%>", SERVICETYPEDTL);
    }
    function ServDtlClear() {
        SetValueTxtByClientID("<%=strServiceTypeDtlId%>", "");
        SetValueTxtByClientID("<%=strServiceTypeDtl%>", "");
    }
    //Mitra Find
    //function MitraFind() {
    //    WinRef = window.open("../Product/MitraSearch.aspx?Action=Find", "MitraFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
    //   WinRef.focus();
    //}
    // function SetMitraFind(USERID, APPUSERPARTNER) {
    //   SetValueTxtByClientID("<%=strUserID%>", USERID);
    //     SetValueTxtByClientID("<%=strMitra%>", APPUSERPARTNER);
    //  }
    // function MitraClear() {
    //    SetValueTxtByClientID("<%=strUserID%>", "");
    //  SetValueTxtByClientID("<%=strMitra%>", "");
    // }
    //Province Find
    function ProvinceFind() {
        WinRef = window.open("../ParamGlobal/ProvinceSearch.aspx?Action=Find", "ProvinceFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }
    function SetProvice(PROVINCEID, PROVINCE) {
        SetValueTxtByClientID("<%=strProvID%>", PROVINCEID);
        SetValueTxtByClientID("<%=strProvince%>", PROVINCE);
    }
    function ProvinceClear() {
        SetValueTxtByClientID("<%=strProvID%>", "");
        SetValueTxtByClientID("<%=strProvince%>", "");
    }
    function StockProduct(ProductId) {
        var WinRef = window.open("../Product/StockProduct.aspx?Action=View&PRODUCTID=" + ProductId + "", "height=400,width=600,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
        return (false);
    }
</script>
</asp:Content>

