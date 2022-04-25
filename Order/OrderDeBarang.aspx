<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="OrderDeBarang.aspx.vb" Inherits="Transportasi_Transportasi" %>
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
        <asp:ListItem Value="NUMBERPLATE">Plat Number</asp:ListItem>
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
            DataKeyNames="ORDERID" Caption="Order List" 
            RowHeaderColumn="ORDERID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="ORDERID" HeaderText="Order ID" Visible="false"
                    SortExpression="ORDERID">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="ORDERCODE" HeaderText="Order&lt;br&gt;Number" HtmlEncode="False" 
                    SortExpression="ORDERCODE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="FULLNAME" HeaderText="Curtomer&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="FULLNAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="MITRANAME" HeaderText="Mitra&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="MITRANAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ARMADANAME" HeaderText="Armada&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="ARMADANAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NUMBERPLATE" HeaderText="Plat&lt;br&gt;Number" HtmlEncode="False" 
                    SortExpression="NUMBERPLATE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PICKUPLOC" HeaderText="Pick Up&lt;br&gt;Location" HtmlEncode="False" 
                    SortExpression="PICKUPLOC" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DESTINATIONLOC" HeaderText="Destination&lt;br&gt;Location" HtmlEncode="False" 
                    SortExpression="DESTINATIONLOC" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="PRICE" HeaderText="Price&lt;br&gt;" HtmlEncode="False" DataFormatString="{0:N2}" 
                    SortExpression="PRICE" >
                    <ItemStyle HorizontalAlign="Right" />  
                </asp:BoundField>
                <asp:BoundField DataField="TYPE" HeaderText="Item&lt;br&gt;Type" HtmlEncode="False" 
                    SortExpression="TYPE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="WEIGHT" HeaderText="Weight&lt;br&gt;" HtmlEncode="False" 
                    SortExpression="WEIGHT" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DISTANCE" HeaderText="Distance&lt;br&gt;" HtmlEncode="False" 
                    SortExpression="DISTANCE" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DURATION" HeaderText="Duration&lt;br&gt;" HtmlEncode="False" 
                    SortExpression="DURATION" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NOTES" HeaderText="Notes&lt;br&gt;" HtmlEncode="False" 
                    SortExpression="NOTES" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ORDERDATE" HeaderText="Order&lt;br&gt;Date" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="ORDERDATE">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
                <asp:BoundField DataField="ORDERTIME" HeaderText="Order&lt;br&gt;Time" HtmlEncode="False" 
                    SortExpression="ORDERTIME">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
                <asp:BoundField DataField="NAME" HeaderText="Status&lt;br&gt;" HtmlEncode="False"
                    SortExpression="NAME" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CANCELORDERNAME" HeaderText="Reason&lt;br&gt;" HtmlEncode="False"
                    SortExpression="CANCELORDERNAME" >
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
        SelectCommand="SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME,ODB.MITRAID,AUP.FULLNAME AS MITRANAME,ISNULL(CO.CANCELORDERNAME,'-') AS CANCELORDERNAME
                              ,ODB.ARMADAID,MA.ARMADANAME,AUP.NUMBERPLATE,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE
                              ,ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME,ODB.ORDERTIME,ODB.TYPE,ODB.WEIGHT
                       FROM ORDERDEBARANG ODB
                          LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID
                          LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID
                          LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID
                          LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE
						  LEFT OUTER JOIN CANCELORDERLIST COL ON ODB.ORDERCODE = COL.ORDERCODE
						  LEFT OUTER JOIN CANCELORDER CO ON COL.CANCELORDERID = CO.CANCELORDERID
                      WHERE PG.TYPE = 'ORDERSTATUS'">
       </asp:SqlDataSource>
    <asp:FormView ID="fvData" runat="server" DataSourceID="sdsForm"
        DefaultMode="Edit" Width="100%" DataKeyNames="ARMADAID">
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
                        <asp:Label ID="lblOrderID" runat="server" Text='<%# Eval("ORDERID")%>'></asp:Label></td>
                </tr>
                 <tr>
                    <td>
                        Order Code</td>
                    <td>
                        <asp:TextBox ID="txtCode" runat="server" Enabled="false" Text='<%# Bind("ORDERCODE")%>'
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
                        Mitra Name</td>
                    <td>
                        <asp:DropDownList ID="ddlMitra" runat="server" DataSourceID="sdsMitra" CssClass="required"
                                DataTextField="FULLNAME" DataValueField="USERID" SelectedValue='<%# Bind("MITRAID")%>'>
                            </asp:DropDownList><asp:RequiredFieldValidator
                            ID="reqMitra" runat="server" ControlToValidate="ddlMitra" Display="None" ErrorMessage="Mitra Name must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEMitra" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqMitra">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                    <td>
                        Armada Name</td>
                    <td>
                        <asp:TextBox ID="txtArmada" runat="server" Enabled="false" ReadOnly="true" Text='<%# Bind("ARMADANAME")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Pick Up Location</td>
                    <td>
                        <asp:TextBox ID="txtPickUp" runat="server" TextMode="MultiLine" MaxLength="20" Enabled="false" Text='<%# Bind("PICKUPLOC")%>'
                            Width="250px"></asp:TextBox>
                    </td>
                    <td>
                        Destination Location</td>
                    <td>
                        <asp:TextBox ID="txtDesti" runat="server" TextMode="MultiLine" Enabled="false" Text='<%# Bind("DESTINATIONLOC")%>'
                            Width="250px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Price</td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" Enabled="false" Text='<%# Bind("PRICE")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Distance</td>
                    <td>
                        <asp:TextBox ID="txtDistance" runat="server" Enabled="false" Text='<%# Bind("DISTANCE")%>'
                           Width="56px"></asp:TextBox>
                    </td>
                       </tr>
                <tr>
                    <td>
                        Duration</td>
                    <td>
                        <asp:TextBox ID="txtDuration" runat="server" Enabled="false" Text='<%# Bind("DURATION")%>'
                            Width="180px"></asp:TextBox>
                    </td>
                    <td>
                        Notes</td>
                    <td>
                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Enabled="false" Text='<%# Bind("NOTES")%>'
                            Width="250px"></asp:TextBox>
                    </td>
                    </tr>
                <tr>
                    <td>
                        Order Date</td>
                    <td>
                        <asp:TextBox ID="txtDate" runat="server" Enabled="false" Text='<%# Bind("ORDERDATE", "{0:dd/MM/yyyy}")%>'
                            Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        Order Time</td>
                    <td>
                        <asp:TextBox ID="txtTime" runat="server" Enabled="false" Text='<%# Bind("ORDERTIME")%>'
                            Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
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
                    <td colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" class="FooterStyle">
                        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Style="background-position: left; background-image: url(../images/Save.gif); background-repeat: no-repeat; text-align: right;" Text="Update" ToolTip="Update" Width="75px" />
                       <%--<uc1:BtnUpdate ID="BtnUpdate1" runat="server" />--%>
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
                 

    <asp:SqlDataSource ID="sdsMitra" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS USERID, '[DISPLAY ALL]' AS FULLNAME UNION ALL 
                                                                                                                           SELECT USERID, FULLNAME FROM APPUSERPARTNER WHERE  SERVICETYPEDTLID = 1 AND ACTIVE= 1 AND (DELETESTS= 0) ORDER BY FULLNAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDDLStatus" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand=" SELECT NULL AS CODE, '[STATUS]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'ORDERSTATUS') ORDER BY CODE"></asp:SqlDataSource>
    
    
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT ODB.ORDERID,ODB.ORDERCODE,ODB.CUSTOMERID,AUC.FULLNAME AS CUSTOMERNAME,ODB.MITRAID,AUP.FULLNAME
                              ,ODB.ARMADAID,MA.ARMADANAME,ODB.PICKUPLOC,ODB.DESTINATIONLOC,ODB.PRICE,ODB.DISTANCE
                              ,ODB.DURATION,ODB.ORDERDATE,ODB.NOTES,ODB.STATUS,PG.NAME,ORDERTIME
                       FROM ORDERDEBARANG ODB
                          LEFT OUTER JOIN APPUSERCLIENT AUC ON ODB.CUSTOMERID = AUC.UID
                          LEFT OUTER JOIN APPUSERPARTNER AUP ON ODB.MITRAID = AUP.USERID
                          LEFT OUTER JOIN MASTERARMADA MA ON ODB.ARMADAID = MA.ARMADAID
                          LEFT OUTER JOIN PARAMGLOBAL PG ON ODB.STATUS = PG.CODE
                      WHERE ORDERID=@ORDERID AND PG.TYPE = 'ORDERSTATUS'" 
        UpdateCommand="ORDERDEBARANGUPDATE" InsertCommand="ORDERDEBARANGADD" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:connection.ProviderName %>">
       <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="ORDERID" PropertyName="SelectedValue" />
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

