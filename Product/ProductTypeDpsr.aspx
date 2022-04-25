<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ProductTypeDpsr.aspx.vb" Inherits="Product_Product" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="PRODUCTDPSRCODE">Product Code</asp:ListItem>
        <asp:ListItem Value="PRODUCTDPSRNAME">Product Name</asp:ListItem>
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
            DataKeyNames="PRODUCTDPSRID" Caption="Product Type De-Pasar List" RowHeaderColumn="PRODUCTDPSRID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="PRODUCTDPSRID" HeaderText="ID" 
                    SortExpression="PRODUCTDPSRID">
                    <ItemStyle HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTDPSRCODE" HeaderText="Product&lt;br&gt;Code" HtmlEncode="False" 
                    SortExpression="PRODUCTDPSRCODE" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTDPSRNAME" HeaderText="Product&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PRODUCTDPSRNAME">
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
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT DPSR.PRODUCTDPSRID
                              ,DPSR.PRODUCTDPSRCODE
                              ,DPSR.PRODUCTDPSRNAME
                              ,DPSR.SERVICETYPEDTLID
	                          ,ST.SERVICETYPENAME
	                          ,STD.SERVICETYPEDTLNAME
                          FROM PRODUCTDPSR DPSR
                          LEFT OUTER JOIN SERVICETYPEDTL STD ON DPSR.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                          LEFT OUTER JOIN SERVICETYPE ST ON STD.SERVICETYPEID = ST. SERVICETYPEID
                       WHERE (DPSR.DELETESTS = 0)"></asp:SqlDataSource>
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
     <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="PRODUCTDPSRID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Product ID</td>
                    <td>
                        <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("PRODUCTDPSRID")%>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtProductCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("PRODUCTDPSRCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtProductCode" Display="None" ErrorMessage="Product Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtProductName" runat="server" Width="200px" MaxLength="100" Text='<%# Bind("PRODUCTDPSRNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtProductName" Display="None" ErrorMessage="Product Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Service Type Detail</td>
                        <td>
                            <asp:DropDownList ID="ddlService" runat="server" DataSourceID="sdsServiceType" CssClass="required"
                                DataTextField="SERVICETYPEDTLNAME" DataValueField="SERVICETYPEDTLID" SelectedValue='<%# Bind("SERVICETYPEDTLid")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqService" runat="server" ControlToValidate="ddlService" Display="None" ErrorMessage="Service Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEService" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqService">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc1:BtnUpdate ID="BtnUpdate1" runat="server" />
                        <span onclick="return confirm('Are You Sure You Will Delete This Data ??')" />
                        <uc2:BtnDelete ID="BtnDelete1" runat="server"  />
                          </span>
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                  <tr>
                    <td>
                        Product Code</td>
                    <td>
                        <asp:TextBox ID="txtProductCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("PRODUCTDPSRCODE")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtProductCode" Display="None" ErrorMessage="Product Code must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtProductName" runat="server" Width="200px" MaxLength="100" Text='<%# Bind("PRODUCTDPSRNAME")%>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtProductName" Display="None" ErrorMessage="Product Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                        <td>Service Type Detail</td>
                        <td>
                            <asp:DropDownList ID="ddlService" runat="server" DataSourceID="sdsServiceType" CssClass="required"
                                DataTextField="SERVICETYPEDTLNAME" DataValueField="SERVICETYPEDTLID" SelectedValue='<%# Bind("SERVICETYPEDTLid")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                                ID="reqService" runat="server" ControlToValidate="ddlService" Display="None" ErrorMessage="Service Type must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEService" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqService">
                                </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <uc4:BtnInsert ID="BtnInsert2" runat="server" />
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
                   
    
    <asp:SqlDataSource ID="sdsServiceType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
                        SelectCommand=" SELECT NULL AS SERVICETYPEDTLID, '[DISPLAY ALL]' AS SERVICETYPEDTLNAME UNION ALL 
                                        SELECT SERVICETYPEDTLID, SERVICETYPEDTLNAME FROM SERVICETYPEDTL WHERE (DELETESTS= 0) ORDER BY SERVICETYPEDTLNAME"></asp:SqlDataSource>
      <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT DPSR.PRODUCTDPSRID
                              ,DPSR.PRODUCTDPSRCODE
                              ,DPSR.PRODUCTDPSRNAME
                              ,DPSR.SERVICETYPEDTLID
                              ,STD.SERVICETYPEDTLNAME
                          FROM PRODUCTDPSR DPSR
                          LEFT OUTER JOIN SERVICETYPEDTL STD ON DPSR.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                       WHERE (PRODUCTDPSRID = @PRODUCTDPSRID)" 
          DeleteCommand="UPDATE PRODUCTDPSR SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE PRODUCTDPSR=@PRODUCTDPSR" 
          UpdateCommand="PRODUCTDPSRUPDATE" InsertCommand="PRODUCTDPSRADD" 
          InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PRODUCTDPSRID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="PRODUCTDPSRID" />
        </DeleteParameters>
          <UpdateParameters>
            <asp:Parameter Name="PRODUCTDPSRID" Type="Int32" />
            <asp:Parameter Name="PRODUCTDPSRCODE" Type="String" />
            <asp:Parameter Name="PRODUCTDPSRNAME" Type="String" />
            <asp:Parameter Name="SERVICETYPEDTLID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="PRODUCTDPSRCODE" Type="String" />
            <asp:Parameter Name="PRODUCTDPSRNAME" Type="String" />
            <asp:Parameter Name="SERVICETYPEDTLID" Type="Int32" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
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
    
</script>
</asp:Content>

