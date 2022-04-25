<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ProductMitraAdd.aspx.vb" Inherits="Product_ProductMitraAdd" %>

<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="~/UserControl/BtnInsert.ascx" TagPrefix="uc1" TagName="BtnInsert" %>
<%@ Register Src="~/UserControl/BtnDelete.ascx" TagPrefix="uc1" TagName="BtnDelete" %>
<%@ Register Src="~/UserControl/BtnApprovetNoSPV.ascx" TagPrefix="uc1" TagName="BtnApprovetNoSPV" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
  
   <%--<asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>--%>
      
    <asp:HiddenField ID="hidWS" runat="server" />

<%--   <asp:Button ID="btnCopy" runat="server" OnClientClick="return ViewMemo();" Style="cursor: pointer; background-position: right; background-image: url(../Images/Memo.png); background-repeat: no-repeat; text-align: left;"
        Text="Copy Costing" Width="170px" />
 <asp:Button ID="btnPrint" runat="server" 
            Style="background-position: right; background-image: url('../Images/print.jpg'); cursor: pointer; background-repeat: no-repeat; text-align: left" 
            Text="Print" Width="136px" />--%>
   <asp:Panel ID="pnlAppShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgAppData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblAppData" runat="server" CssClass="required">(Show Mitra Header...)</asp:Label>
        </div>
        <input id="Button1" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" noenter /></asp:Panel>
   <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAppData" runat="server" CollapseControlID="pnlAppShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Application Data...)"
        Enabled="True" ExpandControlID="pnlAppShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Application Data...)" ImageControlID="imgAppData" TargetControlID="pnlAppData"
        TextLabelID="lblAppData">
    </ajaxToolkit:CollapsiblePanelExtender>
   <asp:Panel ID="pnlAppData" runat="server" Width="100%">
        <asp:FormView ID="dlAppData" runat="server"  
            DataSourceID="sdsFvMitra" Width="100%">
            <ItemTemplate>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="HeaderStyle">
                   Profile Mitra</td>
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Full Name</td>
                <td>
                    (<asp:Label ID="Label21" runat="server" Font-Underline="True"  
                        Text='<%# Eval("USERID")%>' style="font-weight: bold"></asp:Label>)
                    <asp:Label ID="Label22" runat="server" Font-Underline="True" 
                        Text='<%# Eval("FULLNAME")%>' style="font-weight: bold"></asp:Label></td>
                <td class="AlternatingRowStyle">
                   Id Number</td>
                <td>
                    (<asp:Label ID="Label118" runat="server" Font-Underline="True" 
                        Text='<%# Eval("IDNUMBER")%>' style="font-weight: bold"></asp:Label>)
                </td>
            </tr>
            <tr>
           
                <td class="AlternatingRowStyle">
                    Birth Day</td>
                <td>
                    <asp:Label ID="Label7" runat="server" Font-Underline="True" 
                        Text='<%# Eval("BIRTHDAY", "{0:dd/MM/yyyy}")%>' style="font-weight: bold"></asp:Label></td>
                <td class="AlternatingRowStyle">
                    Email</td>
                <td>
                    (<asp:Label ID="Label1" runat="server" Font-Underline="True" 
                        Text='<%# Eval("EMAIL")%>' style="font-weight: bold"></asp:Label>)
                </td>
                    </tr>
            <tr>
                <td class="AlternatingRowStyle">
                   Address</td>
                <td>
                    (<asp:Label ID="Label3" runat="server" Font-Underline="True" 
                        Text='<%# Eval("ADDRESS")%>' style="font-weight: bold"></asp:Label>)
                </td>
                <td class="AlternatingRowStyle">
                    Mobile Number</td>
                <td>
                    (<asp:Label ID="Label2" runat="server" Font-Underline="True" 
                        Text='<%# Eval("MOBILENO")%>' style="font-weight: bold"></asp:Label>)
                </td>
                <td class="AlternatingRowStyle"></td>
            </tr>
        </table>
            </ItemTemplate>
        </asp:FormView>
     </asp:Panel>

    <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False"/>
   <asp:Panel ID="pnlProductShow" runat="server" CssClass="ShowDetail" Width="100%">
     <div style="float: right; vertical-align: middle">
         <asp:Image ID="imgProductMitra" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
         <asp:Label ID="lblProductMitra" runat="server" CssClass="required">(Show Product Mitra...)</asp:Label>
     </div>
 <input id="Button5" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" noenter /></asp:Panel>
   <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEgvData" runat="server" CollapseControlID="pnlProductShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Costing Detail...)"
        Enabled="True" ExpandControlID="pnlProductShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Product Mitra...)" ImageControlID="imgProductMitra" TargetControlID="pnlData"
        TextLabelID="lblProductMitra">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel ID="pnlData" runat="server" Width="100%">
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
                <asp:BoundField DataField="SERVICETYPENAME" HeaderText="Service&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="SERVICETYPENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="SERVICETYPEDTLNAME" HeaderText="Service&lt;br&gt;Type Detail" HtmlEncode="False"
                    SortExpression="SERVICETYPEDTLNAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ARMADATYPENAME" HeaderText="Armada&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="ARMADATYPENAME">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTBRAND" HeaderText="Product&lt;br&gt;Brand" HtmlEncode="False"
                    SortExpression="PRODUCTBRAND">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="QTY" HeaderText="Quantity&lt;br&gt;Product" HtmlEncode="False"
                    SortExpression="QTY">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRICE" HeaderText="Price&lt;br&gt;" HtmlEncode="False" DataFormatString="{0:N2}"
                    SortExpression="PRICE">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="UNITPRICESEWA" HeaderText="Unit &lt;br&gt;Price" HtmlEncode="False" 
                    SortExpression="UNITPRICESEWA">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="STSPRODUCT" HeaderText="Product&lt;br&gt;Status" HtmlEncode="False" 
                    SortExpression="STSPRODUCT">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="DESCRIPTION" HeaderText="Description&lt;br&gt;Product" HtmlEncode="False" 
                    SortExpression="DESCRIPTION">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Status&lt;br&gt;Active" SortExpression="Active">
                <ItemTemplate>
                    <%#getStatus(DataBinder.Eval(Container.DataItem, "STATUSACTIVE"))%>
                </ItemTemplate>            
                <ItemStyle HorizontalAlign="Left" />
            </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PM.PRODUCTMITRAID
                                  ,PM.PRODUCTMITRACODE
                                  ,PM.MITRAID
                                  ,AUP.USERID
                                  ,PM.SERVICETYPEID
                                  ,ST.SERVICETYPENAME
                                  ,PM.SERVICETYPEDTLID
                                  ,STD.SERVICETYPEDTLNAME
                                  ,PM.ARMADATYPEID
                                  ,ISNULL (MAT.ARMADATYPENAME, '-') ARMADATYPENAME
                                  ,PM.PRODUCTBRAND
								  ,PM.PRICE
								  ,PM.UNITPRICE
								  ,MU3.MASTERUNITCODE AS UNITPRICESEWA
                                  ,PM.IMAGEPRODUCT,PM.STATUSPRODUCT,PG.NAME AS STSPRODUCT
                                  ,PM.STATUSACTIVE,PM.QTY,PM.DESCRIPTION
	                          FROM PRODUCTMITRA PM
                            LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID
                            LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID
                            LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                            LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID
							LEFT OUTER JOIN MASTERUNIT MU3 ON PM.UNITPRICE = MU3.MASTERUNITID
                            LEFT OUTER JOIN PARAMGLOBAL PG ON PM.STATUSPRODUCT = PG.CODE
                        WHERE (PM.DELETESTS = 0) AND AUP.USERID=@USERID AND PG.TYPE ='PRODUCTSTATUS'"> 
        <SelectParameters>
             <asp:QueryStringParameter Name="USERID" QueryStringField="USERID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="USERID" />
        </DeleteParameters>  
    </asp:SqlDataSource>
   
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <%--Desewa--%>
 <table cellpadding=0 cellspacing=0 width="100%">
        <tr>
             <td>
     <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="PRODUCTMITRAID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="995px">
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
                    </tr>
                        <tr>
                        <td>Service Type</td>
                        <td>
                           <asp:TextBox ID="txtServiceType" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPENAME")%>' ReadOnly="True" Width="165px" CssClass="required"></asp:TextBox>
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
                            </tr>
                    <tr>
                      <td>Service Type Detail</td>
                        <td>
                            <asp:TextBox ID="txtServDtl" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPEDTLNAME")%>' ReadOnly="True" Width="165px" CssClass="required"></asp:TextBox>
                            <input
						    id="Button1" noenter onclick="ServDtlFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button2" onclick="ServDtlClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidServDtl" runat="server" Value='<%# Bind("SERVICETYPEDTLID")%>' />
                            <asp:RequiredFieldValidator
                            ID="reqServDtl" runat="server" ControlToValidate="txtServDtl" Display="None" ErrorMessage="Service Type Detail must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEServDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqServDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td>Armada</td>
                        <td>
                            <asp:TextBox ID="txtArmadaType" runat="server" MaxLength="50"  
							Text='<%# Eval("ARMADATYPENAME")%>' ReadOnly="True" Width="165px" ></asp:TextBox>
                            <input
						    id="Button3" noenter onclick="ArmadaTypeFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button4" onclick="ArmadaTypeClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidArmadaType" runat="server" Value='<%# Bind("ARMADATYPEID")%>' />
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
                        Quantity Product</td>
                    <td>
                        <asp:TextBox ID="txtQty" runat="server" Width="150px" MaxLength="500" Text='<%# Bind("QTY")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqQty" runat="server" ControlToValidate="txtQty" Display="None" ErrorMessage="Quantity Product must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEQty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqQty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" ClientIDMode="Static" Width="150px" MaxLength="100" Text='<%# Bind("PRICE", "{0:N2}")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqPrice" runat="server" ControlToValidate="txtPrice" Display="None" ErrorMessage="Price must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPrice" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPrice">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlUnitPrice" runat="server" DataSourceID="sdsUnit" CssClass="required"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITPRICE")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnitCap" runat="server" ControlToValidate="ddlUnitPrice" Display="None" ErrorMessage="Unit Price must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnitCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnitCap">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description Product</td>
                    <td>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Width="150px" MaxLength="500" Text='<%# Bind("DESCRIPTION")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDesc" runat="server" ControlToValidate="txtDesc" Display="None" ErrorMessage="Description Product must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDesc" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDesc">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                <td>
                   Status Active</td>
                <td>
                    <asp:DropDownList ID="ddlActive" runat="server" SelectedValue='<%# Bind("STATUSACTIVE")%>'>
                        <asp:ListItem Selected="True" Value="True">Yes</asp:ListItem>
                        <asp:ListItem Value="False">No</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
                <tr>
                <td>
                        Status</td>
                    <td>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="required" DataTextField="NAME" DataValueField="CODE"
                            DataSourceID="sdsStatus" SelectedValue='<%# Bind("STATUSPRODUCT")%>' Width="239px" Height="23px">
                        </asp:DropDownList>
                    </td> 
                    </tr>
                <tr>
               <td>Image Url</td>
                    <td>
                        <asp:TextBox ID="txtImageUrl" runat="server" Width="264px" MaxLength="500" 
                            Text='<%# Bind("IMAGEURL")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqUrl" runat="server" ControlToValidate="txtImageUrl" Display="None" ErrorMessage="Image URL must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUrl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUrl">
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
                    <td colspan="10" class="FooterStyle">
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Style="background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" Text="Update" ToolTip="Update" Width="75px" />
                        <span onclick="return confirm('Are You Sure You Will Delete This Data ??')" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server"  />
                          </span>
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="10">
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
                        <td>Service Type</td>
                        <td>
                           <asp:TextBox ID="txtServiceType" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPENAME")%>' ReadOnly="True" Width="165px" CssClass="required"></asp:TextBox>
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
                            </tr>
                    <tr>
                      <td>Service Type Detail</td>
                        <td>
                            <asp:TextBox ID="txtServDtl" runat="server" MaxLength="50"  
							Text='<%# Eval("SERVICETYPEDTLNAME")%>' ReadOnly="True" Width="165px" CssClass="required"></asp:TextBox>
                            <input
						    id="Button1" noenter onclick="ServDtlFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button2" onclick="ServDtlClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidServDtl" runat="server" Value='<%# Bind("SERVICETYPEDTLID")%>' />
                            <asp:RequiredFieldValidator
                            ID="reqServDtl" runat="server" ControlToValidate="txtServDtl" Display="None" ErrorMessage="Service Type Detail must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEServDtl" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqServDtl">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td>Armada</td>
                        <td>
                            <asp:TextBox ID="txtArmadaType" runat="server" MaxLength="50"  
							Text='<%# Eval("ARMADATYPENAME")%>' ReadOnly="True" Width="165px"></asp:TextBox>
                            <input
						    id="Button3" noenter onclick="ArmadaTypeFind();" style="background-position: left;
						    background-image: url(../images/search.gif);  width: 45px; cursor: pointer; background-repeat: no-repeat;
						     text-align: right" type="button" value="Find" />
                            <input
							id="Button4" onclick="ArmadaTypeClear();" style="background-position: left;
							background-image:url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						<asp:HiddenField ID="hidArmadaType" runat="server" Value='<%# Bind("ARMADATYPEID")%>' />
                            <%--<asp:RequiredFieldValidator
                            ID="reqArmadaType" runat="server" ControlToValidate="txtArmadaType" Display="None" ErrorMessage="Armada Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEArmadaType" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqArmadaType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>--%>
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
                        Quantity Product</td>
                    <td>
                        <asp:TextBox ID="txtQty" runat="server" Width="150px" MaxLength="500" Text='<%# Bind("QTY")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqQty" runat="server" ControlToValidate="txtQty" Display="None" ErrorMessage="Quantity Product must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEQty" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqQty">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description Product</td>
                    <td>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Width="150px" MaxLength="500" Text='<%# Bind("DESCRIPTION")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqDesc" runat="server" ControlToValidate="txtDesc" Display="None" ErrorMessage="Description Product must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEDesc" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqDesc">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" ClientIDMode="Static" Width="150px" MaxLength="100" Text='<%# Bind("PRICE", "{0:N2}")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqPrice" runat="server" ControlToValidate="txtPrice" Display="None" ErrorMessage="Price must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEPrice" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqPrice">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:DropDownList ID="ddlUnitPrice" runat="server" DataSourceID="sdsUnit" CssClass="required"
                                DataTextField="MASTERUNITCODE" DataValueField="MASTERUNITID" SelectedValue='<%# Bind("UNITPRICE")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqUnitCap" runat="server" ControlToValidate="ddlUnitPrice" Display="None" ErrorMessage="Unit Price must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEUnitCap" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqUnitCap">
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
                         <asp:Panel ID="pnlImg" runat="server" GroupingText="IMAGEPRODUCT" Width="340px">
                     <asp:Image ID="imgProduct" Runat="server" Visible="true" Height="320px" Width="340px" />
                             </asp:Panel>
                        </td>
                </tr>
        </table>
    <asp:SqlDataSource ID="sdsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL 
                                        SELECT CODE, NAME FROM PARAMGLOBAL WHERE TYPE='PRODUCTSTATUS' ORDER BY NAME"></asp:SqlDataSource>
      <asp:SqlDataSource ID="sdsUnit" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS MASTERUNITID, '[ALL]' AS MASTERUNITCODE UNION ALL 
                                        SELECT MASTERUNITID, MASTERUNITCODE FROM MASTERUNIT WHERE (DELETESTS= 0) ORDER BY MASTERUNITCODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFvMitra" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME,AUP.PASSWORD, AUP.ACTIVE,AUP.BIRTHDAY,AUP.GENDER
								,AUP.EMAIL,AUP.MOBILENO,AUP.ADDRESS,AUP.KECAMATANID,KEC.KECAMATANNAME,AUP.KABUPATENID,KAB.KABUPATENNAME
								,AUP.PROVINCEID,P.PROVINCENAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME,AUP.SERVICETYPEID,ST.SERVICETYPENAME
                                ,AUP.BALANCE,AUP.IMAGEPROFILE,AUP.IMAGEKTP,AUP.IMAGESKCK,AUP.IMAGESIM,AUP.IMAGESTNK
                                ,AUP.REGISTERDATE,PG.NAME
                                FROM APPUSERPARTNER AUP 
                                LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID
                                LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID
								LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE
								LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID
								LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID
								LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID
                            WHERE (AUP.DELETESTS=0)  AND AUP.USERID = @USERID AND PG.TYPE = 'GENDER' " >
        <SelectParameters>
             <asp:QueryStringParameter Name="USERID" QueryStringField="USERID" />
            <%--<asp:ControlParameter ControlID="gvData" Name="PRECOSTINGID" PropertyName="SelectedDataKey.Values[0]" />
           <asp:ControlParameter ControlID="gvData" Name="COSTINGHDRID"  PropertyName="SelectedDataKey.Values[1]" />--%>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="USERID" />
        </DeleteParameters>        
       
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PM.PRODUCTMITRAID
                                  ,PM.PRODUCTMITRACODE
                                  ,PM.MITRAID
                                  ,AUP.USERID
                                  ,PM.SERVICETYPEID
                                  ,ST.SERVICETYPENAME
                                  ,PM.SERVICETYPEDTLID
                                  ,STD.SERVICETYPEDTLNAME
                                  ,PM.ARMADATYPEID
                                  ,ISNULL (MAT.ARMADATYPENAME, '-') ARMADATYPENAME
                                  ,PM.PRODUCTBRAND
								  ,PM.PRICE
								  ,PM.UNITPRICE
								  ,MU3.MASTERUNITCODE AS UNITPRICESEWA
                                  ,PM.IMAGEPRODUCT,PM.IMAGEURL,PM.STATUSPRODUCT,PG.NAME AS STSPRODUCT
                                  ,PM.STATUSACTIVE,PM.QTY,PM.DESCRIPTION
	                          FROM PRODUCTMITRA PM
                            LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID
                            LEFT OUTER JOIN SERVICETYPE ST ON PM.SERVICETYPEID = ST.SERVICETYPEID
                            LEFT OUTER JOIN SERVICETYPEDTL STD ON PM.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                            LEFT OUTER JOIN MASTERARMADATYPE MAT ON PM.ARMADATYPEID = MAT.ARMADATYPEID
							LEFT OUTER JOIN MASTERUNIT MU3 ON PM.UNITPRICE = MU3.MASTERUNITID
                            LEFT OUTER JOIN PARAMGLOBAL PG ON PM.STATUSPRODUCT = PG.CODE
                       WHERE (PM.PRODUCTMITRAID = @PRODUCTMITRAID) AND PG.TYPE='PRODUCTSTATUS'" 
          DeleteCommand="UPDATE PRODUCTMITRA SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@UID WHERE PRODUCTMITRAID=@PRODUCTMITRAID" 
          UpdateCommand="PRODUCTMITRAIDUPDATE" InsertCommand="PRODUCTMITRAIDADD" 
          InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PRODUCTMITRAID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="UID" />
            <asp:Parameter Name="PRODUCTMITRAID" />
        </DeleteParameters>
     </asp:SqlDataSource>

    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.elevateZoom-3.0.8.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery.min.js.js"></script>
<script type="text/javascript">
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
    // Armada Type Find
    function ArmadaTypeFind() {
        WinRef = window.open("../ParamGlobal/ArmadaTypeSearch.aspx?Action=Find&SERVICETYPEDTLID=" + GetValueTxtByClientID("<%=strServiceTypeDtlId%>") + "", "ServDtlFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }
    function SetArmadaType(ARMADATYPEID, MASTERARMADATYPE) {
        SetValueTxtByClientID("<%=strArmadaTypeId%>", ARMADATYPEID);
        SetValueTxtByClientID("<%=strArmadaType%>", MASTERARMADATYPE);
    }
    function ArmadaTypeClear() {
        SetValueTxtByClientID("<%=strArmadaTypeId%>", "");
        SetValueTxtByClientID("<%=strArmadaType%>", "");
    }
    </script>
</asp:Content>

