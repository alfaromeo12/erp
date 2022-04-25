<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Packet.aspx.vb" Inherits="Param_Packet" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="PACKETNAME">Packet Name</asp:ListItem>
        <asp:ListItem Value="PACKETCODE">Packet Code</asp:ListItem>
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
            DataKeyNames="PACKETID" Caption="Packet List" RowHeaderColumn="PACKETID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/images/edit.gif" ShowSelectButton="True">
                    <ItemStyle Width="20px" HorizontalAlign="Center" />
                </asp:CommandField>
                <asp:BoundField DataField="PACKETID" HeaderText="ID"
                    SortExpression="PACKETID">
                    <ItemStyle HorizontalAlign="Center" Width="60px" />
                </asp:BoundField>
                <asp:BoundField DataField="PACKETCODE" HeaderText="Packet&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="PACKETCODE" />
                <asp:BoundField DataField="PACKETNAME" HeaderText="Packet&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="PACKETNAME" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT PACKETID, PACKETCODE, PACKETNAME FROM PACKET WHERE (Deletests = 0)"></asp:SqlDataSource>
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
        DefaultMode="Edit" Width="100%" DataKeyNames="PacketID">
        <EditItemTemplate>
            <table cellpadding=0 cellspacing=0 width="100%">
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        Packet ID</td>
                    <td>
                        <asp:Label ID="lblPacketID" runat="server" Text='<%# Eval("PacketID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Packet Code</td>
                    <td>
                        <asp:TextBox ID="txtPacketCode" runat="server" Width="56px" MaxLength="10" 
                            Text='<%# Bind("PacketCODE") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqCode" runat="server" ControlToValidate="txtPacketCode" 
                            Display="None" ErrorMessage="Packet Code must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Packet Name</td>
                    <td>
                        <asp:TextBox ID="txtPacketName" runat="server" Width="264px" MaxLength="100" 
                            Text='<%# Bind("PacketNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                            ID="reqName" runat="server" ControlToValidate="txtPacketName" 
                            Display="None" ErrorMessage="Packet Name must be entry...!" 
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
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
                        &nbsp;<uc2:BtnDelete ID="BtnDelete1" runat="server" />
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
                        Packet Code</td>
                    <td>
                        <asp:TextBox ID="txtPacketCode" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("PacketCODE") %>'
                            Width="56px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCode" runat="server"
                                ControlToValidate="txtPacketCode" Display="None" ErrorMessage="Packet Code must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode">
                                </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Packet Name</td>
                    <td>
                        <asp:TextBox ID="txtPacketName" runat="server" CssClass="required" 
                            MaxLength="100" Text='<%# Bind("PacketNAME") %>'
                            Width="264px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqName" runat="server"
                                ControlToValidate="txtPacketName" Display="None" ErrorMessage="Packet Name must be entry...!"
                                SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName">
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
    <asp:SqlDataSource ID="sdsForm" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT PacketID,PacketCODE,PacketNAME FROM Packet WHERE (PacketID = @PacketID) AND DELETESTS = 0" 
        DeleteCommand="UPDATE PACKET SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE PACKETID=@PACKETID" 
        UpdateCommand="PacketUpdate" InsertCommand="PacketAdd" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="PacketID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:CookieParameter CookieName="UID" Name="USERID" />
            <asp:Parameter Name="PACKETID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PacketID" Type="Int32" />
            <asp:Parameter Name="PacketCode" Type="String" />
            <asp:Parameter Name="PacketName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="PacketCode" Type="String" />
            <asp:Parameter Name="PacketName" Type="String" />
            <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>")
</script>
</asp:Content>

