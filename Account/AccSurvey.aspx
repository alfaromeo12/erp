<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccSurvey.aspx.vb" Inherits="Account_AccReSurvey" title="Account Re-Survey" MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:FormView ID="fvData" runat="server" AllowPaging="True" 
        Caption="RE-SURVEY COLLATERAL" DataKeyNames="LOCID,OBJID" 
        DataSourceID="sdsAppID" DefaultMode="Edit" Width="100%">
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="25%" class="ErrHighLight">
                        OBJ ID</td>
                    <td width="25%" class="ErrHighLight">
                        <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("LOCID") %>'></asp:Label>
                        &nbsp; -
                        <asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("OBJID") %>'></asp:Label>
                    </td>
                    <td width="25%" class="ErrHighLight">
                        &nbsp;</td>
                    <td style="width: 25%" class="ErrHighLight">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="25%">
                        Cust No.</td>
                    <td width="25%">
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTNO") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        Account No.</td>
                    <td style="width: 25%">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCOUNTNO") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Cust No. (formated)</td>
                    <td width="25%">
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTNOFORMAT") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        Account No. (formated)</td>
                    <td style="width: 25%">
                        <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCOUNTNOFORMAT") %>'></asp:Label>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Cust Type</td>
                    <td width="25%">
                        (<asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTYPENAME") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        Booking Date</td>
                    <td style="width: 25%">
                        <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("BOOKINGDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Cust Name</td>
                    <td colspan="3">
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("ACCOUNTNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Address</td>
                    <td colspan="3">
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTADDRESS") %>'></asp:Label>
                        ,
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTCITY") %>'></asp:Label>
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("CUSTZIP") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        ID Number</td>
                    <td width="25%">
                        <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("IDNUMBER") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        &nbsp;</td>
                    <td style="width: 25%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="25%">
                        Ref. No</td>
                    <td width="25%">
                        <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("REFNO") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        &nbsp;</td>
                    <td style="width: 25%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="4" >
                        OBJECT INFO</td>
                </tr>
                <tr>
                    <td width="25%">
                        Object/BPKB No</td>
                    <td colspan="3" width="25%">
                        <asp:Label ID="Label23" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("BPKBNO") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Object/BPKB Address</td>
                    <td colspan="3" width="25%">
                        <asp:Label ID="Label25" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("BPKBADDRESS") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 19px" width="25%">
                        Product</td>
                    <td colspan="3" style="height: 19px" width="25%">
                        (<asp:Label ID="Label24" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("PRODUCTCODE") %>'></asp:Label>)
                        <asp:Label ID="Label26" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("PRODUCTNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 19px" width="25%">
                        Merk</td>
                    <td style="height: 19px" width="25%">
                        (<asp:Label ID="Label27" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("MERKCODE") %>'></asp:Label>)
                        <asp:Label ID="Label28" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("MERKNAME") %>'></asp:Label>
                    </td>
                    <td style="height: 19px" width="25%">
                        Model</td>
                    <td style="width: 25%; height: 19px;">
                        (<asp:Label ID="Label29" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("MODELCODE") %>'></asp:Label>)
                        <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("MODELNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle" width="25%">
                        First Survey</td>
                    <td class="FooterStyle" colspan="3">
            <hr />
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Date</td>
                    <td width="25%">
                        <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("SURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        Value</td>
                    <td style="width: 25%">
                        <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("COLLATERALVALUE") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle" width="25%">
                        Current Survey</td>
                    <td class="FooterStyle" colspan="3">
            <hr />
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Date</td>
                    <td width="25%">
                        <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("RESURVEYDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                    <td width="25%">
                        Value</td>
                    <td style="width: 25%">
                        <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("RESURVEYVALUE", "{0:N}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle" width="25%">
                        New Survey</td>
                    <td class="FooterStyle" colspan="3">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Re-Survey Date</td>
                    <td colspan="3" width="25%">
                        <asp:TextBox ID="txtSurveyDate" runat="server" CssClass="required" 
                            MaxLength="10" Text='<%# Bind("RESURVEYDATE", "{0:dd/MM/yyyy}") %>' 
                            Width="72px"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="ajaxCESurveyDate" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="imgSurveyDate" TargetControlID="txtSurveyDate">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:MaskedEditExtender ID="ajaxMEESurveyDate" runat="server" Mask="99/99/9999" 
                            MaskType="Date" TargetControlID="txtSurveyDate">
                        </ajaxToolkit:MaskedEditExtender>
                        <asp:Image ID="imgSurveyDate" runat="server" ImageUrl="~/images/grid.gif" 
                            Style="cursor: pointer" ToolTip="Calendar" />
                        <asp:RequiredFieldValidator ID="reqSurveyDate" runat="server" 
                            ControlToValidate="txtSurveyDate" Display="None" 
                            ErrorMessage="[SURVEY DATE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESurveyDate" runat="server" 
                            HighlightCssClass="ErrHighLight" TargetControlID="reqSurveyDate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="25%">
                        Re-Survey Value</td>
                    <td colspan="3" width="25%">
                        <asp:TextBox ID="txtSurveyValue" runat="server" CssClass="required" 
                            Style="text-align: right" Text='<%# Bind("RESURVEYVALUE", "{0:N}") %>' 
                            Width="128px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqSurveyValue" runat="server" 
                            ControlToValidate="txtSurveyValue" Display="None" 
                            ErrorMessage="[SURVEY VALUE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESurveyValue" runat="server" 
                            Enabled="True" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqSurveyValue">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sdsAppID" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT APPLICATION.APPID, CUSTOMER.CUSTID, dbo.f_FormatCustNo(BRANCH.BRANCHCODE, CUSTOMER.CUSTNO) AS CUSTNOFORMAT, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCOUNTNOFORMAT, ACCOUNT.ACCOUNTNO, CUSTOMER.CUSTNO, APPLICATION.ROWLOCK, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTYPENAME, CUSTOMER.CUSTADDRESS, CUSTOMER.CUSTCITY, CUSTOMER.CUSTZIP, CUSTOMER.IDNUMBER, ACCOUNT.REFNO, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, COLLATERAL.SURVEYDATE, COLLATERAL.RESURVEYDATE, COLLATERAL.RESURVEYVALUE, ACCOUNT.OBJECTVALUE, COLLATERAL.BPKBNO, MODEL.MODELCODE, MODEL.MODELNAME, MERK.MERKCODE, MERK.MERKNAME, COLLATERAL.BPKBADDRESS, PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME, COLLATERAL.LOCID, COLLATERAL.OBJID, COLLATERAL.ACCID, COLLATERAL.COLLATERALVALUE FROM ACCOUNT WITH (NOLOCK) INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN COLLATERAL ON ACCOUNT.LOCID = COLLATERAL.LOCID AND ACCOUNT.ACCID = COLLATERAL.ACCID LEFT OUTER JOIN PRODUCT ON COLLATERAL.PRODUCTID = PRODUCT.PRODUCTID LEFT OUTER JOIN MERK ON COLLATERAL.MERKID = MERK.MERKID LEFT OUTER JOIN MODEL ON COLLATERAL.MODELID = MODEL.MODELID LEFT OUTER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)" 
        UpdateCommand="ACCOUNTRESURVEYUpdate" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="LOCID" QueryStringField="LOCID" />
            <asp:QueryStringParameter Name="APPID" QueryStringField="APPID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="LOCID" Type="Int32" />
            <asp:Parameter Name="OBJID" Type="Int64" />
            <asp:Parameter Name="RESURVEYDATE" Type="DateTime"  />
            <asp:Parameter Name="RESURVEYVALUE" Type="Decimal" />
            <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>    
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" /><asp:HiddenField ID="hidObjID" runat="server" />

    <asp:Panel ID="pnlSave" runat="server" CssClass="FooterStyle" Width="100%">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
        <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
            Font-Bold="True" Font-Underline="True" Style="text-align: center" 
            Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
        <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Save" ValidationGroup="ValSave" Width="64px" />
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False"
            Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="88px" /></asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <script type="text/javascript">
    function getObjectbyClientID(ClientID){
        var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject);
    }
    function GetValueTxtByClientID(ClientID){
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
        if (oText)
            return(oText.value);
    }
    
    function ViewDetailAcc(LOCID, APPID){
        var winref = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
        winref.focus();
    }
    function BackEdit(){
    //if ((GetValueTxtByClientID("<%=txtAction.ClientID%>")=="INQ") || (GetValueTxtByClientID("<%=txtAction.ClientID%>")=="PAY")){
        window.history.back(-1);
        return false;
    //}
    return true;
}

    </script>
    
</asp:Content>

