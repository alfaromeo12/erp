<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="OrderDePasar.aspx.vb" Inherits="Order_DePasar" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="hidUID" runat="server" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajaxTBWESearch" runat="server" TargetControlID="txtSearch" WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" Enabled="True" CollapseControlID="pnlShow" ExpandControlID="pnlShow" TargetControlID="pnlData" CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)" ImageControlID="imgButtonShow" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="AUC.FULLNAME">Customer Name</asp:ListItem>
        <asp:ListItem Value="AUP.FULLNAME">Mitra Name</asp:ListItem>
    </asp:DropDownList>
    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox>
    <asp:Button ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="100%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)"
                ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
        <asp:Panel ID="pnlData" runat="server">
             <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Red"
        Style="text-align: center" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%"
            DataKeyNames="ORDERDEPASARCODE" Caption="Order List Header" 
            RowHeaderColumn="ORDERDEPASARCODE">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
              <%--  <asp:BoundField DataField="ORDERDEPASARID" HeaderText="Order ID" Visible="false"
                    SortExpression="ORDERDEPASARID">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>--%>
                <asp:BoundField DataField="ORDERDEPASARCODE" HeaderText="Order&lt;br&gt;Number" HtmlEncode="False" 
                    SortExpression="ORDERDEPASARCODE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Curtomer&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="CUSTOMERNAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="MITRANAME" HeaderText="Mitra&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="MITRANAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ENTITYTYPENAME" HeaderText="Entity&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="ENTITYTYPENAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ARMADANAME" HeaderText="Armada&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="ARMADANAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PAYMENT" HeaderText="Payment&lt;br&gt;Type" HtmlEncode="False" 
                    SortExpression="PAYMENT" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESSFROM" HeaderText="Address&lt;br&gt;From" HtmlEncode="False" 
                    SortExpression="ADDRESSFROM" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESSTO" HeaderText="Address&lt;br&gt;To" HtmlEncode="False" 
                    SortExpression="ADDRESSTO" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
              
               <%-- <asp:BoundField DataField="TOTALQTY" HeaderText="Quantity&lt;br&gt;Order" HtmlEncode="False" 
                    SortExpression="TOTALQTY" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>--%>
                <asp:BoundField DataField="TOTALORDER" HeaderText="Price&lt;br&gt;Order" HtmlEncode="False" DataFormatString="{0:N2}"
                    SortExpression="TOTALORDER" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ORDERDATE" HeaderText="Order&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="ORDERDATE">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
                <asp:BoundField DataField="STATUSORDER" HeaderText="Status&lt;br&gt;" HtmlEncode="False"
                    SortExpression="STATUSORDER" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DISTANCE" HeaderText="Distance&lt;br&gt;" HtmlEncode="False"
                    SortExpression="DISTANCE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NOTES" HeaderText="Notes&lt;br&gt;" HtmlEncode="False"
                    SortExpression="NOTES" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
   
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT DISTINCT ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.MITRAID,AUP.FULLNAME AS MITRANAME
                              ,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME
                              ,ODP.ARMADAID,MA.ARMADANAME,ODP.PAYMENTTYPE
	                          ,PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,(SELECT SUM(QTYORDER) FROM ORDERDEPASAR WHERE ORDERDEPASARCODE=ORDERDEPASARCODE) AS TOTALQTY,
							  (SELECT SUM(TOTAL) FROM ORDERDEPASAR WHERE ORDERDEPASARCODE=ORDERDEPASARCODE) AS TOTALORDER
	                          ,ODP.STATUS,PG2.NAME AS STATUSORDER
                              ,ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE
                              ,ODP.NOTES
                        FROM ORDERDEPASAR ODP
                        LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID
                        LEFT OUTER JOIN APPUSERPARTNER AUP ON ODP.MITRAID = AUP.USERID
                        LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID
                        LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID
                        LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE
                        LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE
                        LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID
                        WHERE PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS'
                        ">
       </asp:SqlDataSource>
    <%--GRID VIEW DETAIL--%>
    <asp:Panel ID="pnlDataDetail" runat="server">
    <asp:GridView ID="gvDataDetail" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGridDetail" Width="100%"
            DataKeyNames="ORDERDEPASARID" Caption="Order List Detail" 
            RowHeaderColumn="ORDERDEPASARID" CellPadding="4" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="ORDERDEPASARID" HeaderText="Order ID" 
                    SortExpression="ORDERDEPASARID">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ORDERDEPASARCODE" HeaderText="Order&lt;br&gt;Number" HtmlEncode="False" 
                    SortExpression="ORDERDEPASARCODE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Curtomer&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="CUSTOMERNAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="FULLNAME" HeaderText="Mitra&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="FULLNAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ENTITYTYPENAME" HeaderText="Entity&lt;br&gt;Type" HtmlEncode="False" 
                    SortExpression="ENTITYTYPENAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ARMADANAME" HeaderText="Armada&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="ARMADANAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Product&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="PRODUCTNAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PAYMENT" HeaderText="Payment&lt;br&gt;Type" HtmlEncode="False" 
                    SortExpression="PAYMENT" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESSFROM" HeaderText="Address&lt;br&gt;From" HtmlEncode="False" 
                    SortExpression="ADDRESSFROM" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESSTO" HeaderText="Address&lt;br&gt;To" HtmlEncode="False" 
                    SortExpression="ADDRESSTO" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PRICE" HeaderText="Price&lt;br&gt;" HtmlEncode="False" DataFormatString="{0:N2}" 
                    SortExpression="PRICE" >
                    <ItemStyle HorizontalAlign="Right" />  
                </asp:BoundField>
                <asp:BoundField DataField="QTYORDER" HeaderText="Quantity&lt;br&gt;Order" HtmlEncode="False" 
                    SortExpression="QTYORDER" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="TOTAL" HeaderText="Total&lt;br&gt;Price" HtmlEncode="False" DataFormatString="{0:N2}"
                    SortExpression="TOTAL" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="ORDERDATE" HeaderText="Order&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="ORDERDATE">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
                <asp:BoundField DataField="STATUSORDER" HeaderText="Status&lt;br&gt;" HtmlEncode="False"
                    SortExpression="STATUSORDER" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DISTANCE" HeaderText="Distance&lt;br&gt;" HtmlEncode="False"
                    SortExpression="DISTANCE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NOTES" HeaderText="Notes&lt;br&gt;" HtmlEncode="False"
                    SortExpression="NOTES" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGridDetail" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.MITRAID,AUP.FULLNAME
                              ,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE
	                          ,PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL
	                          ,ODP.STATUS,PG2.NAME AS STATUSORDER
                              ,ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE
                              ,ODP.NOTES
                        FROM ORDERDEPASAR ODP
                            LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID
                            LEFT OUTER JOIN APPUSERPARTNER AUP ON ODP.MITRAID = AUP.USERID
                            LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID
                            LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID
                            LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE
                            LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE
                            LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID
                        WHERE PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS' AND ODP.ORDERDEPASARCODE=@ORDERDEPASARCODE">
         <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ORDERDEPASARCODE" PropertyName="SelectedValue" />
        </SelectParameters>
       </asp:SqlDataSource>
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="ORDERDEPASARCODE">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                 <tr>
                    <td colspan="6">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Order Id</td>
                    <td>
                        <asp:Label ID="lblOrderID" runat="server" Text='<%# Eval("ORDERDEPASARID")%>'></asp:Label></td>
                </tr>
                 <tr>
                    <td>
                        Order Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Enabled="false" Text='<%# Bind("ORDERDEPASARCODE")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Customer Name</td>
                    <td>
                        <asp:TextBox ID="txtCustomer" runat="server" Enabled="false" ReadOnly="true" Text='<%# Bind("CUSTOMERNAME")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                     <tr>
                    <td>
                        Entity Type</td>
                         <td>
                    <asp:TextBox ID="txtMitra" runat="server" Enabled="false" ReadOnly="true" Text='<%# Bind("ENTITYTYPENAME")%>'
                            Width="180px"></asp:TextBox>
                         </td>
                    <td>
                        Product Name</td>
                    <td>
                        <asp:TextBox ID="txtProduct" runat="server" Enabled="false" ReadOnly="true" Text='<%# Bind("PRODUCTNAME")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" Enabled="false" Text='<%# Bind("PRICE", "{0:N}")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Qty Order</td>
                    <td>
                        <asp:TextBox ID="txtQty" runat="server" Enabled="false" Text='<%# Bind("QTYORDER")%>'
                           Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Payment Type</td>
                    <td>
                        <asp:TextBox ID="txtDuration" runat="server" Enabled="false" Text='<%# Bind("PAYMENT")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Total</td>
                    <td>
                        <asp:TextBox ID="txtNotes" runat="server" Enabled="false" Text='<%# Bind("TOTAL", "{0:N2}")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Order Date</td>
                    <td>
                        <asp:TextBox ID="txtDate" runat="server" Enabled="false" Text='<%# Bind("ORDERDATE", "{0:dd/MM/yyyy}")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Distance</td>
                    <td>
                        <asp:TextBox ID="txtDistance" runat="server" Enabled="false" Text='<%# Bind("DISTANCE")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                       Mitra</td>
                            <td>
                                <asp:DropDownList ID="ddlMitra" runat="server" CssClass="required" DataSourceID="sdsMitra" DataTextField="FULLNAME" DataValueField="USERID" SelectedValue='<%# Bind("MITRAID")%>' Width="180px">
                                </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqMitra" runat="server" ControlToValidate="ddlMitra" Display="None" ErrorMessage="Mitra must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMitra" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMitra">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                    <td>
                       Status</td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="required" DataSourceID="sdsDDLStatus" DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("STATUS")%>' Width="180px">
                                </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqStatus" runat="server" ControlToValidate="ddlStatus" Display="None" ErrorMessage="Status must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEStatus" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqStatus">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                      </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" class="FooterStyle">
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Style="background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" Text="Update" ToolTip="Update" Width="75px" />
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
    </asp:FormView>
      <asp:SqlDataSource ID="sdsDDLStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS CODE, '[STATUS]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ORDERSTATUS') ORDER BY CODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsMitra" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand="  SELECT NULL AS USERID, '[DISPLAY ALL]' AS FULLNAME UNION ALL 
                                                                                                                           SELECT USERID, FULLNAME FROM APPUSERPARTNER WHERE  SERVICETYPEID = 2 AND ACTIVE= 1 AND (DELETESTS= 0) ORDER BY FULLNAME"></asp:SqlDataSource>
   <%-- <asp:SqlDataSource ID="sdsArmada" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT NULL AS ARMADAID, '[SELECT ARMADA NAME]' AS ARMADANAME UNION ALL 
                        SELECT ARMADAID, STD.SERVICETYPEDTLNAME + ' - ' + MA.ARMADANAME  AS ARMADANAME FROM MASTERARMADA MA WITH (NOLOCK) 
                        LEFT OUTER JOIN SERVICETYPEDTL STD ON MA.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                        WHERE (MA.DELETESTS = 0) AND (MA.SERVICETYPEDTLID = 1) ORDER BY ARMADANAME"></asp:SqlDataSource>--%>
    
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT ODP.ORDERDEPASARID,ODP.ORDERDEPASARCODE,ODP.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODP.MITRAID,AUP.FULLNAME AS MITRANAME
                              ,ODP.ENTITYTYPEID,ET.ENTITYTYPENAME,ODP.ARMADAID,MA.ARMADANAME,ODP.PRODUCTID,MP.PRODUCTNAME,MP.PRICE,ODP.PAYMENTTYPE
	                          ,PG.NAME AS PAYMENT,ODP.ADDRESSFROM,ODP.ADDRESSTO,ODP.QTYORDER,ODP.TOTAL
	                          ,ODP.STATUS,PG2.NAME AS STATUSORDER
                              ,ODP.ORDERDATE,ODP.LONGITUDEADDFROM,ODP.LATITUDEADDFROM,ODP.LONGITUDEADDTO,ODP.LATITUDEADDTO,ODP.DISTANCE
                              ,ODP.NOTES
                        FROM ORDERDEPASAR ODP
                            LEFT OUTER JOIN APPUSERCLIENT AUC ON ODP.CUSTOMERID = AUC.UID
                            LEFT OUTER JOIN APPUSERPARTNER AUP ON ODP.MITRAID = AUP.USERID
                            LEFT OUTER JOIN ENTITYTYPE ET ON ODP.ENTITYTYPEID = ET.ENTITYTYPEID
                            LEFT OUTER JOIN MASTERARMADA MA ON ODP.ARMADAID = MA.ARMADAID
                            LEFT OUTER JOIN PARAMGLOBAL PG ON ODP.PAYMENTTYPE = PG.CODE
                            LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODP.STATUS = PG2.CODE
                            LEFT OUTER JOIN MASTERPRODUCT MP ON ODP.PRODUCTID = MP.PRODUCTID
                         WHERE ODP.ORDERDEPASARID=@ORDERDEPASARID AND PG.TYPE='PAYMENTDPSR' AND PG2.TYPE='ORDERSTATUS'" 
        UpdateCommand="ORDERDEPASARUPDATE" InsertCommand="ORDERDEPASARADD" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
       <SelectParameters>
            <asp:ControlParameter ControlID="gvDataDetail" Name="ORDERDEPASARID" PropertyName="SelectedValue" />
        </SelectParameters>
        <%--<DeleteParameters>
            <asp:Parameter Name="UID" />
        </DeleteParameters>--%>
     </asp:SqlDataSource>
   
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">
        FormatTable("<%=gvData.ClientID%>")
</script>
</asp:Content>

