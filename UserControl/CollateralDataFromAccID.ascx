<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CollateralDataFromAccID.ascx.vb" Inherits="UserControl_CollateralDataFromAccID" %>
		<asp:FormView ID="fvCollateral" runat="server" AllowPaging="True" 
            Caption="CURRENT COLLATERAL DATA" DataSourceID="sdsCollateralData" 
            Width="100%">
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="HeaderStyle">
                            OBJ ID</td>
                        <td class="ShowDetail" colspan="3">
                            <asp:Label ID="Label195" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("LOCID") %>'></asp:Label>
                            &nbsp;-
                            <asp:Label ID="Label196" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("OBJID") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Product</td>
                        <td colspan="3">
                            (<asp:Label ID="Label165" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PRODUCTCODE") %>'></asp:Label>)
                            <asp:Label ID="Label166" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Dealer</td>
                        <td colspan="3">
                            (<asp:Label ID="Label167" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("DEALERCODE") %>'></asp:Label>)
                            <asp:Label ID="Label168" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="FooterStyle">
                            Merk Code</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MERKCODELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MERKCODE") %>'></asp:Label>
                        </td>
                        <td class="FooterStyle">
                            Model Code</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MODELCODELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MODELCODE") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="FooterStyle">
                            Merk Name</td>
                        <td class="FooterStyle">
                            <asp:Label ID="MERKNAMELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("MERKNAME") %>'></asp:Label>
                        </td>
                        <td class="FooterStyle">
                            Model Name</td>
                        <td class="FooterStyle">
                            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("MODELNAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object Type ID</td>
                        <td>
                            <asp:Label ID="Label170" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("OBJECTTYPEID") %>'></asp:Label>
                        </td>
                        <td>
                            Object Type Name</td>
                        <td>
                            <asp:Label ID="Label169" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("TYPENAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Route (Trayek)</td>
                        <td colspan="3">
                            (<asp:Label ID="Label171" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("ROUTENO") %>'></asp:Label>)
                            <asp:Label ID="Label172" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("ROUTENAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Kind/Category</td>
                        <td>
                            (<asp:Label ID="CARKINDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CATEGORYCODE") %>'></asp:Label>)
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("CATEGORYNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Purpose</td>
                        <td>
                            (<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PURPOSECODE") %>'></asp:Label>)
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("PURPOSENAME") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Object//BPKB&nbsp; No</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBNOLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBNO") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight">
                            Object/BPKB Date</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBDATELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ErrHighLight">
                            Object/BPKB Name</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBNAMELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBNAME") %>'></asp:Label>
                        </td>
                        <td class="ErrHighLight">
                            Object/BPKB Owner ID</td>
                        <td class="ErrHighLight">
                            <asp:Label ID="BPKBOWNERIDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBOWNERID") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object/BPKB Address</td>
                        <td colspan="3">
                            <asp:Label ID="BPKBADDRESSLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBADDRESS") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object/BPKB City</td>
                        <td>
                            (<asp:Label ID="BPKBCITYIDLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CITYCODE") %>'></asp:Label>)
                            <asp:Label ID="BPKBCITYIDLabel0" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CITYNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Police No/Object Ref.</td>
                        <td>
                            <asp:Label ID="Label84" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("POLICENO") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            BPKB Car Type (Object Type)</td>
                        <td>
                            <asp:Label ID="BPKBCARTYPELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBCARTYPE") %>'></asp:Label>
                        </td>
                        <td>
                            STNK Expire</td>
                        <td>
                            <asp:Label ID="Label85" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("STNKEXPIRED", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Engine No (Object Ref. 1)</td>
                        <td>
                            <asp:Label ID="ENGINENOLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("ENGINENO") %>'></asp:Label>
                        </td>
                        <td>
                            Chasis No (Object Ref. 2)</td>
                        <td>
                            <asp:Label ID="CHASSISNOLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CHASSISNO") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Car Year</td>
                        <td>
                            <asp:Label ID="CARYEARLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CARYEAR") %>'></asp:Label>
                        </td>
                        <td>
                            Build Year (Object Year)</td>
                        <td>
                            <asp:Label ID="BUILDYEARLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BUILDYEAR") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Object Condition</td>
                        <td>
                            (<asp:Label ID="CONDITIONLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("CONDITION") %>'></asp:Label>)
                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("CONDITIONNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Color</td>
                        <td>
                            <asp:Label ID="COLORLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("COLOR") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Status</td>
                        <td>
                            (<asp:Label ID="BPKBSTATUSLabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("BPKBSTATUS") %>'></asp:Label>)
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("BPKBSTATUSNAME") %>'></asp:Label>
                        </td>
                        <td>
                            Receive Date</td>
                        <td>
                            <asp:Label ID="RECEIVEDATELabel" runat="server" Font-Bold="True" 
                                Font-Underline="True" Text='<%# Eval("RECEIVEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Survey Date</td>
                        <td>
                            <asp:Label ID="Label173" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# Eval("SURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="sdsCollateralData" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            
            
    SelectCommand="SELECT COLLATERAL.LOCID, COLLATERAL.OBJID, COLLATERAL.ACCID, COLLATERAL.MERKID, COLLATERAL.MODELID, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBADDRESS, COLLATERAL.BPKBCITYID, COLLATERAL.BPKBNAME, COLLATERAL.BPKBOWNERID, COLLATERAL.BPKBCARTYPE, COLLATERAL.ENGINENO, COLLATERAL.CHASSISNO, COLLATERAL.CARYEAR, COLLATERAL.BUILDYEAR, COLLATERAL.CONDITION, dbo.f_getParamGlobalName('CONDITION', COLLATERAL.CONDITION) AS CONDITIONNAME, COLLATERAL.COLOR, COLLATERAL.BPKBSTATUS, COLLATERAL.RECEIVEDATE, MERK.MERKCODE, MERK.MERKNAME, MODEL.MODELCODE, MODEL.MODELNAME, dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, COLLATERAL.POLICENO, COLLATERAL.STNKEXPIRED, COLLATERAL.SURVEYDATE, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, DEALER.DEALERCODE, DEALER.DEALERNAME, OBJECTPURPOSE.PURPOSECODE, OBJECTPURPOSE.PURPOSENAME, ROUTE.ROUTENO, ROUTE.ROUTENAME, OBJECTCATEGORY.CATEGORYCODE, OBJECTCATEGORY.CATEGORYNAME, OBJECTTYPE.TYPENAME, OBJECTTYPE.OBJECTTYPEID, CITY.CITYCODE, CITY.CITYNAME FROM COLLATERAL WITH (NOLOCK) LEFT OUTER JOIN CITY ON COLLATERAL.BPKBCITYID = CITY.CITYID LEFT OUTER JOIN OBJECTCATEGORY WITH (NOLOCK) ON COLLATERAL.CATEGORYID = OBJECTCATEGORY.CATEGORYID LEFT OUTER JOIN OBJECTTYPE WITH (NOLOCK) ON COLLATERAL.OBJECTTYPEID = OBJECTTYPE.OBJECTTYPEID LEFT OUTER JOIN PRODUCT WITH (NOLOCK) ON COLLATERAL.PRODUCTID = PRODUCT.PRODUCTID LEFT OUTER JOIN ROUTE ON COLLATERAL.ROUTEID = ROUTE.ROUTEID LEFT OUTER JOIN OBJECTPURPOSE WITH (NOLOCK) ON COLLATERAL.PURPOSEID = OBJECTPURPOSE.PURPOSEID LEFT OUTER JOIN MODEL WITH (NOLOCK) ON COLLATERAL.MERKID = MODEL.MERKID AND COLLATERAL.MODELID = MODEL.MODELID LEFT OUTER JOIN MERK WITH (NOLOCK) ON COLLATERAL.MERKID = MERK.MERKID LEFT OUTER JOIN DEALER WITH (NOLOCK) ON COLLATERAL.DEALERID = DEALER.DEALERID WHERE (COLLATERAL.LOCID = @LOCID) AND (COLLATERAL.ACCID = @ACCID)">
            <SelectParameters>
                <asp:Parameter Name="LOCID" />
                <asp:Parameter Name="ACCID" />
            </SelectParameters>
        </asp:SqlDataSource>
	    
