<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccEdit.aspx.vb" Inherits="Account_AccEdit" title="Account Edit" MaintainScrollPositionOnPostback="true"%>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" />
    <uc1:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
        runat="server" />
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="HeaderStyle" colspan="4" style="text-align: center">
                ACCOUNT EDITING</td>
        </tr>
        <tr>
            <td class="RowStyle">
                Country<br />
                <span style="background-color: #FFCC00">(Negara)</span></td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="COUNTRYNAME"
                    DataValueField="COUTRYID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS COUTRYID, NULL AS COUNTRYCODE, '[COUNTRY]' AS COUNTRYNAME UNION ALL SELECT COUNTRYID, COUNTRYCODE, COUNTRYCODE + ' - ' + COUNTRYNAME AS COUNTRYNAME FROM COUNTRY WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY COUNTRYCODE">
                </asp:SqlDataSource>
                &nbsp;</td>
        </tr>
        <tr>
            <td >
                Type of Use<br />
                <span style="background-color: #FFCC00">(Jenis Penggunaan)</span></td>
            <td colspan="3">
                <asp:DropDownList ID="ddlTOU" runat="server" DataSourceID="sdsTOU" DataTextField="TOUNAME"
                    DataValueField="TYPEOFUSEID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsTOU" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS TYPEOFUSEID, NULL AS TOUCODE, '[TYPE OF USE]' AS TOUNAME UNION ALL SELECT TYPEOFUSEID, TOUCODE, TOUCODE + ' - ' + TOUNAME AS TOUNAME FROM TYPEOFUSE WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY TOUCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td  class="RowStyle">
                Orientation of Use<br />
                <span style="background-color: #FFCC00">(Orientasi Penggunaan)</span></td>
            <td colspan="3"  class="RowStyle">
                <asp:DropDownList ID="ddlOOU" runat="server" DataSourceID="sdsOOU" DataTextField="OOUNAME"
                    DataValueField="ORIENTATIONOFUSEID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsOOU" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS ORIENTATIONOFUSEID, NULL AS OOUCODE, '[ORIENTATION OF USE]' AS OOUNAME UNION ALL SELECT ORIENTATIONOFUSEID, OOUCODE, OOUCODE + ' - ' + OOUNAME AS OOUNAME FROM ORIENTATIONOFUSE WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY OOUCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowSyle">
                &nbsp;</td>
            <td class="RowSyle" colspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="RowStyle">
                Debitur Category<br />
                <span style="background-color: #FFCC00">(Kategori Debitur)</span></td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:DropDownList ID="ddlDebiturCategory" runat="server" DataSourceID="sdsDebiturCategory"
                    DataTextField="DEBITURCATNAME" DataValueField="DEBITURCATID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsDebiturCategory" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS DEBITURCATID, NULL AS DEBITURCATCODE, '[DEBITUR CATEGORY]' AS DEBITURCATNAME UNION ALL SELECT DEBITURCATID, DEBITURCATCODE, DEBITURCATCODE + ' - ' + DEBITURCATNAME AS Expr1 FROM DEBITURCATEGORY WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY DEBITURCATCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowSyle">
                Portfolio Category<br />
                <span style="background-color: #FFCC00">(Kategori Portofolio)</span></td>
            <td class="RowSyle" colspan="3">
                <asp:DropDownList ID="ddlPortofolioCategory" runat="server" DataSourceID="sdsPortfolioCategory"
                    DataTextField="PORTFOLIOCATNAME" DataValueField="PORTFOLIOCATID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsPortfolioCategory" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS PORTFOLIOCATID, NULL AS PORTFOLIOCATCODE, '[PORTFOLIO CATEGORY]' AS PORTFOLIOCATNAME UNION ALL SELECT PORTFOLIOCATID, PORTFOLIOCATCODE, PORTFOLIOCATCODE + ' - ' + PORTFOLIOCATNAME AS PORTFOLIOCATNAME FROM PORTFOLIOCATEGORY WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY PORTFOLIOCATCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowStyle">
                Credit Type<br />
                <span style="background-color: #FFCC00">(Jenis Kredit)</span></td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:DropDownList ID="ddlCreditType" runat="server" DataSourceID="sdsCreditType"
                    DataTextField="CREDITTYPENAME" DataValueField="CREDITTYPEID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsCreditType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS CREDITTYPEID, NULL AS CREDITTYPECODE, '[CREDIT TYPE]' AS CREDITTYPENAME UNION ALL SELECT CREDITTYPEID, CREDITTYPECODE, CREDITTYPECODE + ' - ' + CREDITTYPENAME AS CREDITTYPENAME FROM CREDITTYPE WITH (nOLOCK) WHERE (DELETESTS = 0) ORDER BY CREDITTYPECODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowSyle">
                Credit Attribute<br />
                <span style="background-color: #FFCC00">(Sifat Kredit)</span></td>
            <td class="RowSyle" colspan="3">
                <asp:DropDownList ID="ddlCreditAttribute" runat="server" DataSourceID="sdsCreditAttribute"
                    DataTextField="CREDITATTRNAME" DataValueField="CREDITATTRIBUTEID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsCreditAttribute" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS CREDITATTRIBUTEID, NULL AS CREDITATTRCODE, '[CREDIT ATTRIBUTE]' AS CREDITATTRNAME UNION ALL SELECT CREDITATTRIBUTEID, CREDITATTRCODE, CREDITATTRCODE + ' - ' + CREDITATTRNAME AS CREDITATTRNAME FROM CREDITATTRIBUTE WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY CREDITATTRCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="RowStyle">
                Credit Category<br />
                <span style="background-color: #FFCC00">(Golongan Kredit)</span></td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:DropDownList ID="ddlCreditCategory" runat="server" DataSourceID="sdsCreditCategory"
                    DataTextField="CREDITCATNAME" DataValueField="CREDITCATID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsCreditCategory" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                    SelectCommand="SELECT NULL AS CREDITCATID, NULL AS CREDITCATCODE, '[CREDIT CATEGORY]' AS CREDITCATNAME UNION ALL SELECT CREDITCATID, CREDITCATCODE, CREDITCATCODE + ' - ' + CREDITCATNAME AS CREDITCATNAME FROM CREDITCATEGORY WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY CREDITCATCODE">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="FooterStyle" colspan="4">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>

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
        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClientClick="return BackEdit();"
            Style="background-position: right; background-image: url(../Images/back.png);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Back" Width="88px" /></asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEBorrow" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <script type="text/javascript">
    function getObjectbyClientID(ClientID){
        var oObject=document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return(oObject)
    }
    function GetValueTxtByClientID(ClientID){
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
        if (oText)
            return(oText.value);
    }
    
    function ViewDetailAcc(LOCID, APPID){
        var winfer = window.open("AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes, resizable");
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

