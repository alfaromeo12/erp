<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="OrderDesewa.aspx.vb" Inherits="Transportasi_Transportasi" %>
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
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%"
            DataKeyNames="ORDERDESEWAID" Caption="Order DeSewa List" 
            RowHeaderColumn="ORDERDESEWAID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="ORDERDESEWAID" HeaderText="Order ID" Visible="false"
                    SortExpression="ORDERDESEWAID">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ORDERDESEWACODE" HeaderText="Order&lt;br&gt;Number" HtmlEncode="False" 
                    SortExpression="ORDERNUMBER" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Customer&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="CUSTOMERNAME" >
                <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="MITRANAME" HeaderText="Partner&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="MITRANAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTBRAND" HeaderText="Product&lt;br&gt;Brand" HtmlEncode="False"
                    SortExpression="PRODUCTBRAND" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="STARTDATE" HeaderText="Start&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="STARTDATE" >
                    <ItemStyle HorizontalAlign="Left" />  
                </asp:BoundField>
                <asp:BoundField DataField="ENDDATE" HeaderText="End&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="ENDDATE" >
                    <ItemStyle HorizontalAlign="Left" />  
                </asp:BoundField>
                <asp:BoundField DataField="DURATION" HeaderText="Duration&lt;br&gt;" HtmlEncode="False"
                    SortExpression="DURATION" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ADDRESSCUSTOMER" HeaderText="Address&lt;br&gt;Customer" HtmlEncode="False"
                    SortExpression="ADDRESSCUSTOMER" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="QTYORDER" HeaderText="Quantity&lt;br&gt;Order" HtmlEncode="False"
                    SortExpression="QTYORDER" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PAYMENTSEWA" HeaderText="Payment&lt;br&gt;Type" HtmlEncode="False"
                    SortExpression="PAYMENTSEWA" >
                    <ItemStyle HorizontalAlign="Left" />  
                </asp:BoundField>
                <asp:BoundField DataField="PRICE" HeaderText="Price&lt;br&gt;" HtmlEncode="False" DataFormatString="{0:N2}" 
                    SortExpression="PRICE" >
                    <ItemStyle HorizontalAlign="Right" />  
                </asp:BoundField>
                <asp:BoundField DataField="TOTALPRICE" HeaderText="Total&lt;br&gt;Proce" HtmlEncode="False" DataFormatString="{0:N2}" 
                    SortExpression="TOTALPRICE" >
                    <ItemStyle HorizontalAlign="Right" />  
                </asp:BoundField>
                <asp:BoundField DataField="NOTES" HeaderText="Notes&lt;br&gt;" HtmlEncode="False"
                    SortExpression="NOTES" >
                    <ItemStyle HorizontalAlign="Left" />  
                </asp:BoundField>
                <asp:BoundField DataField="ORDERDATE" HeaderText="Order&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="ORDERDATE">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
                <asp:BoundField DataField="STATUSSEWA" HeaderText="Status&lt;br&gt;" HtmlEncode="False"
                    SortExpression="STATUSSEWA" >
                    <ItemStyle HorizontalAlign="Left" />  
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
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
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT ODS.ORDERDESEWAID
                              ,ODS.ORDERDESEWACODE
                              ,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND
                              ,ODS.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME
                              ,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME
                              ,ODS.ORDERDATE
                              ,ODS.STARTDATE
                              ,ODS.ENDDATE
                              ,ODS.DURATION
                              ,ODS.QTYORDER
                              ,ODS.ADDRESSCUSTOMER
                              ,PM.PRICE
                              ,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA
                              ,ODS.TOTALPRICE
                              ,ODS.STATUS,PG3.NAME AS STATUSSEWA
                              ,ODS.NOTES
                          FROM ORDERDESEWA ODS
                          LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID
                          LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID
                          LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID
                          LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE
                          LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE
                          WHERE PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS'">
       </asp:SqlDataSource>
   <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="ORDERDESEWAID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                 <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Order Id</td>
                    <td>
                        <asp:Label ID="lblOrderID" runat="server" Text='<%# Eval("ORDERDESEWAID")%>'></asp:Label></td>
                </tr>
                 <tr>
                    <td>
                        Order Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Enabled="false" Text='<%# Bind("ORDERDESEWACODE")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Customer Name</td>
                    <td>
                        <asp:TextBox ID="txtCustomer" runat="server" Enabled="false" ReadOnly="true" Text='<%# Bind("FULLNAME")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                     <tr>
                    <td>
                        Mitra Name</td>
                    <td>
                        <asp:TextBox ID="txtMitra" runat="server" Enabled="false" ReadOnly="true" Text='<%# Bind("MITRANAME")%>'>
                            </asp:TextBox>
                    </td>
                         <td>
                        Address Customer</td>
                    <td>
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" MaxLength="500" Enabled="false" Text='<%# Bind("ADDRESSCUSTOMER")%>'
                            Height="50px" Width="300px"></asp:TextBox>
                    </td>
                         </tr>
                <tr>
                    <td>
                        Start Date</td>
                    <td>
                        <asp:TextBox ID="txtStart" runat="server" Enabled="false" Text='<%# Bind("STARTDATE", "{0:dd/MM/yyyy}")%>'
                            Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        End Date</td>
                    <td>
                        <asp:TextBox ID="txtEnd" runat="server" Enabled="false" Text='<%# Bind("ENDDATE", "{0:dd/MM/yyyy}")%>'
                            Width="100px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                       Quantity Order</td>
                    <td>
                        <asp:TextBox ID="txtPickUp" runat="server" MaxLength="20" Enabled="false" Text='<%# Bind("QTYORDER")%>'
                            Width="100px"></asp:TextBox>
                    </td>
                    <td>
                       </tr>
                <tr>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" Enabled="false" Text='<%# Bind("PRICE", "{0:N2}")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Payment Type</td>
                    <td>
                        <asp:TextBox ID="txtPayment" runat="server" Enabled="false" Text='<%# Bind("PAYMENTSEWA")%>'
                           Width="56px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Total Price</td>
                    <td>
                        <asp:TextBox ID="txtDuration" runat="server" Enabled="false" Text='<%# Bind("TOTALPRICE", "{0:N2}")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Order Date</td>
                    <td>
                        <asp:TextBox ID="txtDate" runat="server" Enabled="false" Text='<%# Bind("ORDERDATE", "{0:dd/MM/yyyy}")%>'
                            Width="100px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Notes</td>
                    <td>
                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Enabled="false" Text='<%# Bind("NOTES")%>'
                            Width="250px"></asp:TextBox>
                    </td>
                    <td>
                       Status</td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="required" DataSourceID="sdsDDLStatus" DataTextField="NAME" DataValueField="CODE" SelectedValue='<%# Bind("STATUS")%>' Width="100px">
                                </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqStatus" runat="server" ControlToValidate="ddlStatus" Display="None" ErrorMessage="Status must be entry..!"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEStatus" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqStatus">
                            </ajaxToolkit:ValidatorCalloutExtender>
                            </td>
                         </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4" class="FooterStyle">
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Style="background-position: left; background-image: url('../images/Save.gif'); background-repeat: no-repeat; text-align: right; height: 26px;" Text="Update" ToolTip="Update" Width="75px" />
                       <%--<uc1:BtnUpdate ID="BtnUpdate1" runat="server" />--%>
                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsMitra" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS USERID, '[DISPLAY ALL]' AS FULLNAME UNION ALL 
                                                                                                                           SELECT USERID, FULLNAME FROM APPUSERPARTNER WHERE  SERVICETYPEID = 3 AND ACTIVE= 1 AND (DELETESTS= 0) ORDER BY FULLNAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDDLStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS CODE, '[STATUS]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ORDERSTATUS') ORDER BY CODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT ODS.ORDERDESEWAID
                              ,ODS.ORDERDESEWACODE
                              ,ODS.PRODUCTMITRAID,PM.PRODUCTBRAND
                              ,ODS.CUSTOMERID,AUC.FULLNAME
                              ,AUP.USERID,ISNULL (AUP.FULLNAME, '-') AS MITRANAME
                              ,ODS.ORDERDATE
                              ,ODS.STARTDATE
                              ,ODS.ENDDATE
                              ,ODS.QTYORDER
                              ,ODS.ADDRESSCUSTOMER
                              ,PM.PRICE
                              ,ODS.PAYMENTTYPE,PG2.NAME AS PAYMENTSEWA
                              ,ODS.TOTALPRICE
                              ,ODS.NOTES
                              ,ODS.STATUS,PG3.NAME AS STATUSSEWA
                          FROM ORDERDESEWA ODS
                          LEFT OUTER JOIN PRODUCTMITRA PM ON ODS.PRODUCTMITRAID = PM.PRODUCTMITRAID
                          LEFT OUTER JOIN APPUSERCLIENT AUC ON ODS.CUSTOMERID = AUC.UID
                          LEFT OUTER JOIN APPUSERPARTNER AUP ON PM.MITRAID = AUP.USERID
                          LEFT OUTER JOIN PARAMGLOBAL PG2 ON ODS.PAYMENTTYPE = PG2.CODE
                          LEFT OUTER JOIN PARAMGLOBAL PG3 ON ODS.STATUS = PG3.CODE
                          WHERE ODS.ORDERDESEWAID=@ORDERDESEWAID AND PG2.TYPE='PAYMENT' AND PG3.TYPE='ORDERSTATUS'" 
        UpdateCommand="ORDERDESEWAUPDATE" InsertCommand="ORDERDESEWAGADD" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
       <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ORDERDESEWAID" PropertyName="SelectedValue" />
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

