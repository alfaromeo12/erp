<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccBICondition.aspx.vb" Inherits="Account_AccBICondition" title="Account BI Condition Entry" MaintainScrollPositionOnPostback="true"%>
 
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:HiddenField ID="hidLocID" runat="server" />
    <asp:HiddenField ID="hidAccID" runat="server" /><asp:HiddenField ID="hidObjID" runat="server" />
    <uc1:DataAccountFromParamAccID ID="ctlDataAccountFromParamAccID" 
        runat="server" />
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="HeaderStyle" colspan="4" style="text-align: center">
                BI CONDITION</td>
        </tr>
        <tr>
            <td class="RowStyle">
                BI Condition Date</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:TextBox ID="txtConditionDate" runat="server" CssClass="required" MaxLength="10"
                    Width="72px"></asp:TextBox><asp:Image ID="imgConditionDate" runat="server" ImageUrl="~/images/grid.gif"
                        Style="cursor: pointer" ToolTip="Calendar" /><asp:RequiredFieldValidator ID="reqConditionDate"
                            runat="server" ControlToValidate="txtConditionDate" Display="None" ErrorMessage="[CONDITION DATE] must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCEConditionDate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqConditionDate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                <ajaxToolkit:CalendarExtender ID="ajaxCECondtionDate" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgConditionDate"
                    TargetControlID="txtConditionDate">
                </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:MaskedEditExtender ID="ajaxMEEConditionDate" runat="server" Mask="99/99/9999" MaskType="Date"
                    TargetControlID="txtConditionDate">
                </ajaxToolkit:MaskedEditExtender>
            </td>
        </tr>
        <tr>
            <td class="RowStyle">
                BI Condition</td>
            <td class="AlternatingRowStyle" colspan="3">
                <asp:DropDownList ID="ddlCondition" runat="server" CssClass="required" DataSourceID="sdsBICondition"
                    DataTextField="CONDITIONBINAME" DataValueField="CONDITIONBIID">
                </asp:DropDownList><asp:SqlDataSource ID="sdsBICondition" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT NULL AS CONDITIONBIID, NULL AS CONDITIONBICODE, '[BI CONDITION]' AS CONDITIONBINAME UNION ALL SELECT CONDITIONBIID, CONDITIONBICODE, '(' + CONDITIONBICODE + ') ' + CONDITIONBINAME AS Expr1 FROM CONDITIONBI WHERE (DELETESTS = 0) ORDER BY CONDITIONBICODE">
                </asp:SqlDataSource>
                <asp:RequiredFieldValidator ID="reqCondition" runat="server" ControlToValidate="ddlCondition"
                    Display="None" ErrorMessage="[CONDITION must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCECondition" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCondition">
                    </ajaxToolkit:ValidatorCalloutExtender>
            </td>
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
            Text="Save" Width="64px" />
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
        return(oObject)
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
        window.history.back(-1);
        return (false);
    }

    </script>
    
</asp:Content>

