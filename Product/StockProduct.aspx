<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="StockProduct.aspx.vb" Inherits="Product_ViewMitra" %>
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
            DataSourceID="sdsFvProduct" Width="100%">
            <ItemTemplate>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="HeaderStyle">
                   Product Mitra</td>
                <td colspan="3" class="FooterStyle">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Entity Type</td>
                <td>
                    (<asp:Label ID="Label21" runat="server" Font-Underline="True"  
                        Text='<%# Eval("ENTITYTYPEID")%>' style="font-weight: bold"></asp:Label>)
                    <asp:Label ID="Label22" runat="server" Font-Underline="True" 
                        Text='<%# Eval("ENTITYTYPENAME")%>' style="font-weight: bold"></asp:Label></td>
                <td class="AlternatingRowStyle">
                   Product Name</td>
                <td>
                    (<asp:Label ID="Label3" runat="server" Font-Underline="True" 
                        Text='<%# Eval("PRODUCTID")%>' style="font-weight: bold"></asp:Label>)
                    (<asp:Label ID="Label118" runat="server" Font-Underline="True" 
                        Text='<%# Eval("PRODUCTNAME")%>' style="font-weight: bold"></asp:Label>)
                </td>
            </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Service Type</td>
                <td>
                    (<asp:Label ID="Label126" runat="server" Font-Underline="True" 
                        Text='<%# Eval("SERVICETYPEID")%>' style="font-weight: bold"></asp:Label>)
                    <asp:Label ID="Label127" runat="server" Font-Underline="True" 
                        Text='<%# Eval("SERVICETYPENAME")%>' style="font-weight: bold"></asp:Label>
                </td>
                <td class="AlternatingRowStyle">
                    Service Type Detail</td>
                <td>
                    (<asp:Label ID="Label128" runat="server" Font-Underline="True" 
                        Text='<%# Eval("SERVICETYPEDTLID")%>' style="font-weight: bold"></asp:Label>)
                    <asp:Label ID="Label129" runat="server" Font-Underline="True" 
                        Text='<%# Eval("SERVICETYPEDTLNAME")%>' style="font-weight: bold"></asp:Label>
                </td>
                    </tr>
            <tr>
                <td class="AlternatingRowStyle">
                    Ready Stock</td>
                <td>
                    <asp:TextBox ID="txtAwal" ClientIDMode="Static" Enabled="false" runat="server" 
                        Text='<%# Eval("READYSTOCK")%>' ></asp:TextBox>
               </td> 
                <td class="AlternatingRowStyle">
                    Initial Stock</td>
                <td>
                    <asp:Label ID="lblInitial" runat="server" Font-Underline="True" 
                        Text='<%# Eval("INITIALSTOCK")%>' style="font-weight: bold"></asp:Label>
                    <asp:Label ID="lblUnit" runat="server" Font-Underline="True" 
                        Text='<%# Eval("STOCKUNIT")%>' style="font-weight: bold"></asp:Label>
               </td> 
            </tr>
            </table>
            </ItemTemplate>
        </asp:FormView>
     </asp:Panel>
     <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" /><br />
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
        DefaultMode="Edit" Width="100%" DataKeyNames="PRODUCTID">
       <InsertItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
            <tr>
                    <td>
                        Stock out</td>
                    <td>    
                        <asp:TextBox ID="txtOut" runat="server" placeholder="0" ClientIDMode="Static" Width="56px" onKeyup="SumReadyStock(this);" MaxLength="10" Text='<%# Eval("STOCKOUT")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Stock In</td>
                    <td>    
                        <asp:TextBox ID="txtIn" runat="server" placeholder="0" ClientIDMode="Static" Width="56px" MaxLength="10" Text='<%# Eval("STOCKIN")%>' CssClass="required"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                       Ready Stock</td>
                    <td>
                        <asp:TextBox ID="txtReady" Enabled="true" placeholder="0" ClientIDMode="Static" onKeyup="SumStockIndSC(this);" Width="56px" MaxLength="10" runat="server" Text='<%# Eval("READYSTOCK")%>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="FooterStyle">
                        <asp:Button ID="btnSave" runat="server" Style="font-size: 8pt; cursor: pointer; background-position: left top; background-image: url('../images/Save.gif'); background-repeat: no-repeat; text-align: right; " Text="Insert" ToolTip="Insert New Data" Width="75px" OnClick="btnSave_Click" />
                        <%--<uc4:BtnInsert ID="BtnInsert2" runat="server" />--%>
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

    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="PRODUCTNAME">Product Name</asp:ListItem>
        <asp:ListItem Value="STOCKDATE">Stock Date</asp:ListItem>
    </asp:DropDownList><asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
        Text="Search" CausesValidation="False" CssClass="Search" /><br />
<ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
    <tr>
    <td>
                    Stock Date</td>
                <td>
                    <asp:RadioButton ID="rbReqAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbReqDate" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtRequestForm" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgReqFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtRequestTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgReqTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxReqFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqFrom"
                        TargetControlID="txtRequestForm">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxReqTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgReqTo"
                        TargetControlID="txtRequestTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestForm">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRequestTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
    </tr>
    <asp:Panel ID="panelUpdateProgress" runat="server" CssClass="updateProgress">
    <asp:UpdateProgress ID="UpdateProgMaster" DisplayAfter="0" runat="server" >
        <ProgressTemplate>
            <div style="position: relative; top: 30%; text-align: center;" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/wait.gif" 
                ToolTip="Processing" /><br />
                Processing ...
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Panel>
     
    <asp:Panel ID="pnlProductShow" runat="server" CssClass="ShowDetail" Width="100%">
     <div style="float: right; vertical-align: middle">
         <asp:Image ID="imgProductMitra" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
         <asp:Label ID="lblProductMitra" runat="server" CssClass="required">(Show Stock List...)</asp:Label>
     </div>
 <input id="Button5" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" noenter /></asp:Panel>
   <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEgvData" runat="server" CollapseControlID="pnlProductShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Stock List...)"
        Enabled="True" ExpandControlID="pnlProductShow" ExpandedImage="~/images/collapse.jpg"
        ExpandedText="(Hide Stock List...)" ImageControlID="imgProductMitra" TargetControlID="pnlData"
        TextLabelID="lblProductMitra">
    </ajaxToolkit:CollapsiblePanelExtender>
    
    
    <asp:Panel ID="pnlData" runat="server" Width="100%">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="PRODUCTID" Caption="Stock List" RowHeaderColumn="PRODUCTID">
            <Columns>
                <asp:BoundField DataField="PRODUCTCODE" HeaderText="Product&lt;br&gt;Code" HtmlEncode="False" 
                    SortExpression="PRODUCTCODE" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="PRODUCTNAME" HeaderText="Produck&lt;br&gt;Name" HtmlEncode="False" 
                    SortExpression="PRODUCTNAME" >
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="STOCKOUT" HeaderText="Stock&lt;br&gt;Out" HtmlEncode="False"
                    SortExpression="STOCKOUT">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="STOCKIN" HeaderText="Stock&lt;br&gt;In" HtmlEncode="False"
                    SortExpression="STOCKIN">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="READYSTOCK" HeaderText="Ready&lt;br&gt;Stock" HtmlEncode="False"
                    SortExpression="READYSTOCK">
                    <ItemStyle HorizontalAlign="Left"/>
                </asp:BoundField>
                <asp:BoundField DataField="STOCKDATE" HeaderText="Stock&lt;br&gt;Date" HtmlEncode="False"  DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="STOCKDATE" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PS.PRODUCTID
                              ,MP.PRODUCTCODE
	                          ,MP.PRODUCTNAME
                              ,ISNULL(PS.STOCKOUT,0) STOCKOUT
                              ,ISNULL(PS.STOCKIN,0) STOCKIN
                              ,ISNULL(PS.READYSTOCK,0) READYSTOCK
                              ,PS.STOCKDATE
                          FROM PRODUCTSTOCK PS
                                LEFT OUTER JOIN MASTERPRODUCT MP ON PS.PRODUCTID = MP.PRODUCTID
                        WHERE MP.PRODUCTID=@PRODUCTID">
        
        <SelectParameters>
             <asp:QueryStringParameter Name="PRODUCTID" QueryStringField="PRODUCTID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PRODUCTID" />
        </DeleteParameters>    
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsFvProduct" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="SELECT MP.PRODUCTID,MP.PRODUCTCODE,MP.PRODUCTNAME,MP.ENTITYTYPEID,ET.ENTITYTYPENAME
                              ,MP.SERVICETYPEID,ST.SERVICETYPENAME,MP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME
                              ,MP.PRICE,MP.DISCOUNT,MP.DISCOUNTPRICE,MP.CAPACITY,MP.UNITCAPACITY
	                          ,MU.MASTERUNITCODE AS UNITCAP,MP.INITIALSTOCK,MP.UNITSTOCK,MU2.MASTERUNITCODE AS STOCKUNIT
                              ,MP.IMAGEDEPASAR,MP.IMAGEURL,MP.DESCRIPTION,PS.STOCKDATE,PS.READYSTOCK
                          FROM MASTERPRODUCT MP
	                        LEFT OUTER JOIN ENTITYTYPE ET ON MP.ENTITYTYPEID = ET.ENTITYTYPEID
	                        LEFT OUTER JOIN SERVICETYPE ST ON MP.SERVICETYPEID = ST.SERVICETYPEID
                            LEFT OUTER JOIN SERVICETYPEDTL STD ON MP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
						   LEFT OUTER JOIN PRODUCTSTOCK PS ON MP.PRODUCTID = PS.PRODUCTID
                            LEFT OUTER JOIN MASTERUNIT MU ON MP.UNITCAPACITY = MU.MASTERUNITID
                            LEFT OUTER JOIN MASTERUNIT MU2 ON MP.UNITSTOCK = MU2.MASTERUNITID
                           WHERE MP.DELETESTS = 0 AND PS.STOCKDATE = (SELECT MAX(STOCKDATE) FROM PRODUCTSTOCK WHERE PRODUCTID=@PRODUCTID)
						   ORDER BY PS.STOCKDATE">
        <SelectParameters>
             <asp:QueryStringParameter Name="PRODUCTID" QueryStringField="PRODUCTID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="PRODUCTID" />
        </DeleteParameters>    
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT PS.PRODUCTID
	                          ,MP.PRODUCTNAME
                              ,ISNULL(PS.STOCKOUT,0) STOCKOUT
                              ,ISNULL(PS.STOCKIN,0) STOCKIN
                              ,ISNULL(PS.READYSTOCK,0) READYSTOCK
                              ,PS.STOCKDATE
                          FROM PRODUCTSTOCK PS
                                LEFT OUTER JOIN MASTERPRODUCT MP ON PS.PRODUCTID = MP.PRODUCTID
                          WHERE PS.PRODUCTID=@PRODUCTID" 
        DeleteCommand="UPDATE PRODUCTSTOCK SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE STOCKID=@STOCKID"
        InsertCommand="PRODUCTSTOCKADD" InsertCommandType="StoredProcedure">
        <SelectParameters>
             <asp:QueryStringParameter Name="PRODUCTID" QueryStringField="PRODUCTID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="STOCKID" />
        </DeleteParameters>
        <%--<InsertParameters>
            <asp:Parameter Name="STOCKOUT" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>--%>
     </asp:SqlDataSource>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.elevateZoom-3.0.8.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery.min.js.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
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
    //function SumTotalStock(o) {
    //    var a = document.getElementById("txtAwal").value;
    //    var txtB = document.getElementById("txtOut").value;
    //    var c = document.getElementById("txtTotal").value;
    //    var result = toNumeric(a) - toNumeric(txtB);
    //    if (!isNaN(result)) {
    //        c.value = FormatNumber(Math.round(result));
    //    }
    //    SumReadyStock(this);
    //}
    function SumReadyStock(o) {
        var a = document.getElementById("txtAwal").value;
        var txtB = document.getElementById("txtOut").value;
        var c = document.getElementById("txtReady");
        var result = toNumeric(a) - toNumeric(txtB);
        if (a <= 0) {
            window.confirm("stock habis");
        }
        else if (!isNaN(result)) {
            c.value = FormatNumber(Math.round(result));
        }
        SumReadyStock(this);
    }
    function SumStockIndSC(o) {
        var a = document.getElementById("txtAwal").value;
        var txtB = document.getElementById("txtIn").value;
        var c = document.getElementById("txtReady");
        var result = toNumeric(a) + toNumeric(txtB);
        if (!isNaN(result)) {
            c.value = FormatNumber(Math.round(result));
        }
    }
    </script>
</asp:Content>

