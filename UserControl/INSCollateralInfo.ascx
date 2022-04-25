<%@ Control Language="VB" AutoEventWireup="false" CodeFile="INSCollateralInfo.ascx.vb" Inherits="UserControl_INSCollateralInfo" %>
                <asp:FormView ID="dlCollateral" runat="server" Caption="COLLATERAL INFO" 
        DataKeyField="LOCID" DataSourceID="sdsCollateralInfo" Width="100%" 
    AllowPaging="True">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" style="width:100%;">
                            <tr>
                                <td>
                            Product</td>
                                <td>
                            (<asp:Label ID="Label12" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("PRODUCTCODE") %>'></asp:Label>)
                                    <asp:Label ID="Label13" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                                </td>
                                <td>
                            Condition</td>
                                <td>
                            (<asp:Label ID="CONDITIONLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CONDITION") %>' />)
                                    <asp:Label ID="CONDITIONNAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CONDITIONNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                            Dealer</td>
                                <td colspan="3">
                            (<asp:Label ID="Label10" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("DEALERCODE") %>'></asp:Label>)
                                    <asp:Label ID="Label11" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                            Merk</td>
                                <td>
                            (<asp:Label ID="MERKCODELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("MERKCODE") %>' />)
                                    <asp:Label ID="MERKNAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("MERKNAME") %>' />
                                </td>
                                <td>
                            Model</td>
                                <td>
                            (<asp:Label ID="MODELCODELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("MODELCODE") %>' />)
                                    <asp:Label ID="MODELNAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("MODELNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                            Type Name</td>
                                <td colspan="3">
                                    <asp:Label ID="TYPEALIASLabel0" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("TYPENAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                            Type Alias</td>
                                <td colspan="3">
                                    <asp:Label ID="TYPEALIASLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("TYPEALIAS") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="ErrHighLight">
                            Purpose</td>
                                <td class="ErrHighLight">
                            (<asp:Label ID="PURPOSECODELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("PURPOSECODE") %>' />)
                                    <asp:Label ID="PURPOSENAMELabel" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("PURPOSENAME") %>' />
                                </td>
                                <td class="ErrHighLight">
                            Category</td>
                                <td class="ErrHighLight">
                            (<asp:Label ID="CATEGORYCODELabel" runat="server" 
                            style="font-weight: 700; text-decoration: underline" 
                            Text='<%# Eval("CATEGORYCODE") %>' />
                            )
                                    <asp:Label ID="CATEGORYNAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("CATEGORYNAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                            Route</td>
                                <td colspan="3">
                            (<asp:Label ID="ROUTENOLabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("ROUTENO") %>' />)
                                    <asp:Label ID="ROUTENAMELabel" runat="server" 
                            style="font-weight: bold; text-decoration: underline" 
                            Text='<%# Eval("ROUTENAME") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    
                </asp:FormView>
                <asp:SqlDataSource ID="sdsCollateralInfo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            
                    
    SelectCommand="SELECT ACCOUNT.LOCID, ACCOUNT.ACCID, OBJECTTYPE.TYPEALIAS, MERK.MERKCODE, MERK.MERKNAME, MODEL.MODELCODE, MODEL.MODELNAME, COLLATERAL.CONDITION, dbo.f_getParamGlobalName('CONDITION', COLLATERAL.CONDITION) AS CONDITIONNAME, OBJECTPURPOSE.PURPOSECODE, OBJECTPURPOSE.PURPOSENAME, OBJECTCATEGORY.CATEGORYCODE, OBJECTCATEGORY.CATEGORYNAME, ROUTE.ROUTENO, ROUTE.ROUTENAME, DEALER.DEALERCODE, DEALER.DEALERNAME, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, OBJECTTYPE.TYPENAME FROM OBJECTTYPE WITH (NOLOCK) RIGHT OUTER JOIN ACCOUNT WITH (NOLOCK) RIGHT OUTER JOIN COLLATERAL WITH (NOLOCK) LEFT OUTER JOIN MERK WITH (NOLOCK) ON COLLATERAL.MERKID = MERK.MERKID ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID LEFT OUTER JOIN DEALER WITH (NOLOCK) ON COLLATERAL.DEALERID = DEALER.DEALERID LEFT OUTER JOIN MODEL WITH (NOLOCK) ON COLLATERAL.MODELID = MODEL.MODELID LEFT OUTER JOIN PRODUCT WITH (NOLOCK) ON COLLATERAL.PRODUCTID = PRODUCT.PRODUCTID LEFT OUTER JOIN ROUTE WITH (NOLOCK) ON COLLATERAL.ROUTEID = ROUTE.ROUTEID LEFT OUTER JOIN OBJECTCATEGORY WITH (NOLOCK) ON COLLATERAL.CATEGORYID = OBJECTCATEGORY.CATEGORYID LEFT OUTER JOIN OBJECTPURPOSE WITH (NOLOCK) ON COLLATERAL.PURPOSEID = OBJECTPURPOSE.PURPOSEID ON OBJECTTYPE.OBJECTTYPEID = COLLATERAL.OBJECTTYPEID WHERE (ACCOUNT.LOCID = @LOCID) AND (ACCOUNT.ACCID = @ACCID)">
                    <SelectParameters>
                        <asp:Parameter Name="LOCID" />
                        <asp:Parameter Name="ACCID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            
