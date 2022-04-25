<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CollateralDataFromOBJID.ascx.vb" Inherits="UserControl_CollateralDataFromOBJID" %>
                <asp:SqlDataSource ID="sdsCollateralData" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    
    SelectCommand="SELECT COLLATERAL.LOCID, COLLATERAL.OBJID, COLLATERAL.ACCID, COLLATERAL.MERKID, COLLATERAL.MODELID, COLLATERAL.BPKBNO, COLLATERAL.BPKBDATE, COLLATERAL.BPKBADDRESS, COLLATERAL.BPKBCITYID, COLLATERAL.BPKBNAME, COLLATERAL.BPKBOWNERID, COLLATERAL.BPKBCARTYPE, COLLATERAL.ENGINENO, COLLATERAL.CHASSISNO, COLLATERAL.CARYEAR, COLLATERAL.BUILDYEAR, COLLATERAL.CONDITION, dbo.f_getParamGlobalName('CONDITION', COLLATERAL.CONDITION) AS CONDITIONNAME, COLLATERAL.COLOR, COLLATERAL.BPKBSTATUS, COLLATERAL.RECEIVEDATE, MERK.MERKCODE, MERK.MERKNAME, MODEL.MODELCODE, MODEL.MODELNAME, dbo.f_getParamGlobalName('BPKBSTATUS', COLLATERAL.BPKBSTATUS) AS BPKBSTATUSNAME, COLLATERAL.POLICENO, COLLATERAL.STNKEXPIRED, COLLATERAL.SURVEYDATE, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, DEALER.DEALERCODE, DEALER.DEALERNAME, OBJECTPURPOSE.PURPOSECODE, OBJECTPURPOSE.PURPOSENAME, ROUTE.ROUTENO, ROUTE.ROUTENAME, OBJECTCATEGORY.CATEGORYCODE, OBJECTCATEGORY.CATEGORYNAME, OBJECTTYPE.TYPENAME, OBJECTTYPE.OBJECTTYPEID, CITY.CITYCODE, CITY.CITYNAME, COLLATERAL.FAKTURNO, COLLATERAL.KPEXPIRED, COLLATERAL.SKEXPIRED, COLLATERAL.CC, COLLATERAL.BLOCKINGSTS, CASE WHEN COLLATERAL.BLOCKINGSTS = 1 THEN 'YES' ELSE 'NO' END AS BLOCKINGSTSNAME, COLLATERAL.DELIVERDATE, COLLATERAL.FAKTURNAME, COLLATERAL.COLLATERALVALUE, SBRANK.SBRANKCODE, SBRANK.SBRANKNAME, COLLATERAL.IDCOLLATERAL, COLLATERALTYPE.CTCODE, COLLATERALTYPE.CTNAME, COLLATERAL.RELEASEDATE, COLLATERAL.RESURVEYDATE, COLLATERAL.RESURVEYVALUE FROM COLLATERAL WITH (NOLOCK) LEFT OUTER JOIN COLLATERALTYPE WITH (NOLOCK) ON COLLATERAL.COLLATERALTYPEID = COLLATERALTYPE.COLLATERALTYPEID LEFT OUTER JOIN SBRANK WITH (NOLOCK) ON COLLATERAL.SBRANKID = SBRANK.SBRANKID LEFT OUTER JOIN CITY WITH (NOLOCK) ON COLLATERAL.BPKBCITYID = CITY.CITYID LEFT OUTER JOIN OBJECTCATEGORY WITH (NOLOCK) ON COLLATERAL.CATEGORYID = OBJECTCATEGORY.CATEGORYID LEFT OUTER JOIN OBJECTTYPE WITH (NOLOCK) ON COLLATERAL.OBJECTTYPEID = OBJECTTYPE.OBJECTTYPEID LEFT OUTER JOIN PRODUCT WITH (NOLOCK) ON COLLATERAL.PRODUCTID = PRODUCT.PRODUCTID LEFT OUTER JOIN ROUTE ON COLLATERAL.ROUTEID = ROUTE.ROUTEID LEFT OUTER JOIN OBJECTPURPOSE WITH (NOLOCK) ON COLLATERAL.PURPOSEID = OBJECTPURPOSE.PURPOSEID LEFT OUTER JOIN MODEL WITH (NOLOCK) ON COLLATERAL.MERKID = MODEL.MERKID AND COLLATERAL.MODELID = MODEL.MODELID LEFT OUTER JOIN MERK WITH (NOLOCK) ON COLLATERAL.MERKID = MERK.MERKID LEFT OUTER JOIN DEALER WITH (NOLOCK) ON COLLATERAL.DEALERID = DEALER.DEALERID WHERE (COLLATERAL.LOCID = @LOCID) AND (COLLATERAL.OBJID = @OBJID)">
                    <SelectParameters>
                        <asp:Parameter Name="LOCID" />
                        <asp:Parameter Name="OBJID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DataList ID="dlCollateral" runat="server" 
                    Caption=" DETAIL COLLATERAL DATA" DataSourceID="sdsCollateralData" 
                    Width="100%">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    Object/BPKB Status</td>
                                <td>
                                    (<asp:Label ID="BPKBSTATUSLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("BPKBSTATUS") %>'></asp:Label>)
                                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("BPKBSTATUSNAME") %>'></asp:Label>
                                </td>
                                <td>
                                    Blocking Status</td>
                                <td>
                                    <asp:Label ID="Label177" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("BLOCKINGSTSNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Object/BPKB Receive</td>
                                <td>
                                    <asp:Label ID="Label179" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("RECEIVEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                    Deliver Date</td>
                                <td>
                                    <asp:Label ID="Label190" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("DELIVERDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Release Date</td>
                                <td>
                                    <asp:Label ID="Label191" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("RELEASEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle" colspan="4">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="HeaderStyle">
                                    OBJ ID</td>
                                <td class="ShowDetail" colspan="3">
                                    <asp:Label ID="Label175" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("LOCID") %>'></asp:Label>
                                    &nbsp;-
                                    <asp:Label ID="Label174" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("OBJID") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="ShowDetail">
                                    Object Info</td>
                                <td class="FooterStyle" colspan="3">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Product</td>
                                <td class="FooterStyle" colspan="3">
                                    (<asp:Label ID="Label165" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("PRODUCTCODE") %>'></asp:Label>)
                                    <asp:Label ID="Label166" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Dealer</td>
                                <td class="FooterStyle" colspan="3">
                                    (<asp:Label ID="Label167" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("DEALERCODE") %>'></asp:Label>)
                                    <asp:Label ID="Label168" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("DEALERNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="FooterStyle">
                                    Merk ID</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="MERKIDLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("MERKID") %>'></asp:Label>
                                </td>
                                <td class="FooterStyle">
                                    Model ID</td>
                                <td class="FooterStyle">
                                    <asp:Label ID="MODELIDLabel" runat="server" Font-Bold="True" 
                                        Font-Underline="True" Text='<%# Eval("MODELID") %>'></asp:Label>
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
                                <td class="ShowDetail">
                                    Document Info</td>
                                <td colspan="3">
                                    <hr />
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
                                <td class="ShowDetail">
                                    Faktur Info</td>
                                <td colspan="3">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Faktur No</td>
                                <td>
                                    <asp:Label ID="Label186" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("FAKTURNO") %>'></asp:Label>
                                </td>
                                <td>
                                    Faktur Name</td>
                                <td>
                                    <asp:Label ID="Label187" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("FAKTURNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="ShowDetail">
                                    BI Info</td>
                                <td colspan="3">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ID Collateral</td>
                                <td>
                                    <asp:Label ID="Label183" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("IDCOLLATERAL") %>'></asp:Label>
                                </td>
                                <td>
                                    Collateral Type</td>
                                <td>
                                    (<asp:Label ID="Label184" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("CTCODE") %>'></asp:Label>)
                                    <asp:Label ID="Label185" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("CTNAME") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SB Rank</td>
                                <td>
                                    (<asp:Label ID="Label188" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("SBRANKCODE") %>'></asp:Label>)
                                    <asp:Label ID="Label189" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("SBRANKNAME") %>'></asp:Label>
                                </td>
                                <td>
                                    Survey Date</td>
                                <td>
                                    <asp:Label ID="Label173" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("SURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Collateral Value</td>
                                <td>
                                    <asp:Label ID="Label180" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("COLLATERALVALUE", "{0:N}") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="ShowDetail">
                                    Route/Trayek Info</td>
                                <td colspan="3">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Route</td>
                                <td>
                                    (<asp:Label ID="Label171" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("ROUTENO") %>'></asp:Label>)
                                    <asp:Label ID="Label172" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("ROUTENAME") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    SK Expired</td>
                                <td>
                                    <asp:Label ID="Label181" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("SKEXPIRED", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                    KP Expired</td>
                                <td>
                                    <asp:Label ID="Label182" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("KPEXPIRED", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="ShowDetail">
                                    Re-Survey</td>
                                <td class="FooterStyle" colspan="3">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Re-Survey Date</td>
                                <td>
                                    <asp:Label ID="Label192" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("RESURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                                <td>
                                    Re-Survey Value</td>
                                <td>
                                    <asp:Label ID="Label193" runat="server" Font-Bold="True" Font-Underline="True" 
                                        Text='<%# Eval("RESURVEYVALUE", "{0:N}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                
