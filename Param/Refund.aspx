<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Refund.aspx.vb" Inherits="Param_Refund" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="nodatafound" tagprefix="uc6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlDealerInfo" runat="server" DataSourceID="sdsDealer" 
        Width="100%">
        <ItemTemplate>
            <table style="width:100%;" width="100%">
                <tr>
                    <td>
                        Dealer Code</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("DEALERCODE") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Dealer Name</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Alias</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("DEALERALIAS") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Address</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("ADDRESS") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsDealer" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT DEALERID, DEALERCODE, DEALERNAME, DEALERALIAS, ADDRESS FROM DEALER WHERE (Deletests = 0)">
    </asp:SqlDataSource>
    <table style="width: 100%;">
        <tr>
            <td>
                Product
            </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ddlProduct" 
                    DataTextField="PRODUCTNAME" DataValueField="PRODUCTID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="ddlProduct" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    SelectCommand="SELECT PRODUCTID, ' ( ' + PRODUCTCODE + ' ) ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WHERE (Deletests = 0)">
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                                        <asp:GridView ID="gvRefund" ShowFooter="True" runat="server" 
                                            AllowPaging="True" AutoGenerateColumns="False"
                                                BorderWidth="1px"
                                            Width="100%" PageSize="5" style="margin-top: 0px" 
                    DataSourceID="sdsRefund" >
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Chk" >
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkProduct" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField>
                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                            <asp:ImageButton ID="btnDetail" runat="server" 
                                                                ImageUrl="~/Images/detail.gif" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Refund&lt;br&gt;Category" 
                                                        SortExpression="REFUNDCATEGORY">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProduct" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <Itemstyle HorizontalAlign="Right"/>
                                                          
                                                    </asp:TemplateField>                                                                                                  
                                                     <asp:TemplateField HeaderText="Persentage"  
                                                        SortExpression="PERSENTAGE">
                                                        <Itemstyle HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtPersen" runat="server"  Font-Names="Lucida Sans" CssClass="required"
                                                                    Font-Size="Smaller" style="text-align:right" Text='<%# Bind("PERSENTAGE", "Number - {0:N4}") %>' 
                                                                    Width="95%"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="reqPersen" runat="server" 
                                                                ControlToValidate="txtPersen" Display="None" 
                                                                ErrorMessage="[PERSENTAGE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                            <ajaxToolkit:validatorcalloutextender ID="ajaxVCEEndRange" runat="server" 
                                                                HighlightCssClass="ErrHighLight" TargetControlID="reqPersen">
                                                                </ajaxToolkit:validatorcalloutextender>
                                                            </ItemTemplate>
                                                           
                                                    </asp:TemplateField>  
                                                     <asp:TemplateField HeaderText="Amount" SortExpression="AMOUNT">
                                                        <Itemstyle HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAmount" runat="server" Font-Names="Lucida Sans" CssClass="required"
                                                                    Font-Size="Smaller" style="text-align:right" Text='<%# Bind("AMOUNT", "{0:N}") %>' 
                                                                    Width="95%"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqAmount" runat="server" 
                                                                ControlToValidate="txtAmount" Display="None" 
                                                                ErrorMessage="[AMOUNT] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                            <ajaxToolkit:validatorcalloutextender ID="ajaxVCENotaryFee" runat="server" 
                                                                HighlightCssClass="ErrHighLight" TargetControlID="reqAmount">
                                                                </ajaxToolkit:validatorcalloutextender>
                                                            </ItemTemplate>
                                                         
                                                    </asp:TemplateField>    
                                                                                     
                                                </Columns>
                                               
                                                  <EmptyDataTemplate>
                                                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                                </EmptyDataTemplate>  
                                            </asp:GridView>

                                        <asp:SqlDataSource ID="sdsRefund" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:connection %>" 
                                            SelectCommand="SELECT NAME AS REFUNDCATEGORY, 0 AS PERSENTAGE, 0 AS AMOUNT FROM PARAMGLOBAL WHERE (TYPE = 'REFUNDCATEGORY') AND (CODE IN (1, 2, 3))">
                </asp:SqlDataSource>
                                        <br />
          <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" 
            Style="border-right: thin inset; 
		            border-top: thin inset; border-left: thin inset; border-bottom: thin inset" 
            Width="100%" Visible="false" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                          
                            <asp:Button ID="btnSave" runat="server"
                            Style="font-size: 8pt; cursor: pointer; border-top-style: ridge; border-right-style: ridge;
                            border-left-style: ridge; border-bottom-style: ridge;  
                            background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" ValidationGroup="Collector" />
                            <asp:Button ID="btnDelete" runat="server"
                            Style="font-size: 8pt; cursor: pointer; border-top-style: ridge; border-right-style: ridge;
                            border-left-style: ridge; border-bottom-style: ridge;  
                            background-position: left; background-image: url(../images/Delete.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete" 
                                Width="55px" />
                            <asp:Button ID="btnCancel" runat="server"
                            Style="font-size: 8pt; cursor: pointer; border-top-style: ridge; border-right-style: ridge;
                            border-left-style: ridge; border-bottom-style: ridge;  
                            background-position: left; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Back" Width="55px" CausesValidation="False" 
                                ValidationGroup="Collector" />
                        </td>
			        </tr>
                </table>
            </asp:Panel>
          
            <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom"></ajaxToolkit:AlwaysVisibleControlExtender>
            </td>
        </tr>
    </table>
</asp:Content>

