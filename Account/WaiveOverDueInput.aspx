<%@ Page Title="Waive Over Due - Input" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="WaiveOverDueInput.aspx.vb" Inherits="Account_WaiveOverDueInput" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>

<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/InstallmentDataDue.ascx" tagname="InstallmentDataDue" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
   	<asp:HiddenField ID="txtLocID" runat="server" />
		<asp:HiddenField ID="txtAccID" runat="server" />
		<asp:HiddenField ID="txtTxnDate" runat="server" />
		<asp:HiddenField ID="hidFINCATID" runat="server" />
        <asp:HiddenField ID="txtACCOUNTNO" runat="server" />
        <asp:HiddenField ID="txtAction" runat="server" />
		
		<asp:HiddenField ID="hidBookingDate" runat="server" />
	<asp:Panel ID="pnlPayment" runat="server" Width="100%">
		<asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
			<div style="float: right; vertical-align: middle">
				<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
				<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
			</div>
			<input id="Button1" noenter="" style="background-position: left top; width: 24px;
				cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
	
		<asp:Panel ID="pnlAccData" runat="server" Width="100%">
            <uc3:DataAccountFromParamAccID ID="DataAccountFromParamAccID1" runat="server"  />
		</asp:Panel>
		<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEAccData" runat="server" CollapseControlID="pnlAccShow"
			CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Account Data...)" Enabled="True"
			ExpandControlID="pnlAccShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Account Data...)"
			ImageControlID="imgAccData" TargetControlID="pnlAccData" TextLabelID="lblAccData">
		</ajaxToolkit:CollapsiblePanelExtender>
		<asp:Panel ID="pnlLoanShow" runat="server" CssClass="ShowDetail" Width="99%">
			<div style="float: right; vertical-align: middle">
				<asp:Image ID="imgLoanData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
				<asp:Label ID="lblLoanData" runat="server" CssClass="required">(Show Loan Data...)</asp:Label>
			</div>
			<input id="Button5" noenter="" style="background-position: left top; width: 24px;
				cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
		<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPELoanData" runat="server" CollapseControlID="pnlLoanShow"
			CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Loan Data...)" Enabled="True"
			ExpandControlID="pnlLoanShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Loan Data...)"
			ImageControlID="imgLoanData" TargetControlID="pnlLoanData" TextLabelID="lblLoanData">
		</ajaxToolkit:CollapsiblePanelExtender>
		<asp:Panel ID="pnlLoanData" runat="server" Width="100%">
			
		    <uc2:LoanDataFromParamAccID ID="LoanDataFromParamAccID1" runat="server" />
			
		</asp:Panel>
		<asp:Panel ID="pnlInstShow" runat="server" CssClass="ShowDetail" Width="99%">
			<div style="float: right; vertical-align: middle">
				<asp:Image ID="imgInstData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
				<asp:Label ID="lblInstData" runat="server" CssClass="required">(Show Installment Due Data...)</asp:Label>
			</div>
			<input id="Button2" noenter="" style="background-position: left top; width: 24px;
				cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
		<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEInst" runat="server" CollapseControlID="pnlInstShow"
			CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Installment Due Data...)"
			Enabled="True" ExpandControlID="pnlInstShow" ExpandedImage="~/images/collapse.jpg"
			ExpandedText="(Hide Installment Due Data...)" ImageControlID="imgInstData" TargetControlID="pnlInstData"
			TextLabelID="lblInstData">
		</ajaxToolkit:CollapsiblePanelExtender>
		<asp:Panel ID="pnlInstData" runat="server"  Width="100%">
			<uc4:InstallmentDataDue ID="InstallmentDataDue" runat="server" />
		</asp:Panel>
         <asp:Panel ID="pnlNonSPV" runat="server" Width="99%">
		    <table cellpadding="0" cellspacing="0" width="100%">
			    <tr>
				    <td colspan="3" class="required">
					    <hr />
				    </td>
			    </tr>
			    <tr>
			    <td class="ShowDetail" colspan="3" style="text-align: center">
				    WAIVE OVERDUE INPUT</td>
		    </tr>
		    <tr>
			    <td class="HeaderStyle">
				    INSTALLMENT DUE until
				    <asp:Label ID="lblDueUntil" runat="server"></asp:Label>
			    </td>
			    <td class="HeaderStyle">
				    Overdue Values</td>
			    <td class="HeaderStyle" ID="WaiveHead">
				    <asp:Label ID="lblOverdueWaive" runat="server">Waive Overdue Values</asp:Label>
			    </td>
		    </tr>
		    <tr>
			    <td class="RowStyle">
				    <asp:Label ID="lblPrincipalDue" runat="server"></asp:Label> Due (q)</td>
			    <td class="RowStyle">
				    <asp:TextBox ID="txtPrincipalDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
			    <td class="RowStyle" ID="WaivePricipal">
				    <asp:TextBox ID="txtWaivePrincipalDue" runat="server" CssClass="required"
					    Style="text-align: right" ValidationGroup="ViewAcc" 
                         autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqWaivePrincipalDue" runat="server"
						    ControlToValidate="txtWaivePrincipalDue" Display="None" ErrorMessage="Principal Overdue Waive must be entry...!"
						    SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
							    ID="reqWaivePrincipalDue_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqWaivePrincipalDue">
						    </ajaxToolkit:ValidatorCalloutExtender>
			    </td>
		    </tr>
		    <tr>
			    <td class="RowStyle">
				    <asp:Label ID="lblInterestDue" runat="server"></asp:Label> Due (r)</td>
			    <td class="RowStyle">
				    <asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
			    <td class="RowStyle" ID="WaiveInterest">
				    <asp:TextBox ID="txtWaiveInterestDue" runat="server" CssClass="required"
					    Style="text-align: right" ValidationGroup="ViewAcc" 
                        autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqWaiveInterestDue" runat="server"
						    ControlToValidate="txtWaiveInterestDue" Display="None" ErrorMessage="Interest Overdue Waive must be entry...!"
						    SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender
							    ID="reqWaiveInterestDue_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqWaiveInterestDue">
						    </ajaxToolkit:ValidatorCalloutExtender>
			    </td>
		    </tr>
		    <tr>
			    <td class="RowStyle">
				    Installment Due Difference (f)</td>
			    <td class="RowStyle">
				    <asp:TextBox ID="txtInstDiffDue" runat="server" CssClass="disabled" 
                        ReadOnly="True" Style="text-align: right"></asp:TextBox>
                </td>
			    <td class="RowStyle" ID="WaiveInstDue">
				    <asp:TextBox ID="txtWaiveInstDiffDue" runat="server" autocomplete="off" 
                        CssClass="required" Style="text-align: right" ValidationGroup="ViewAcc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqWaiveInstDiffDue" runat="server" 
                        ControlToValidate="txtWaiveInstDiffDue" Display="None" 
                        ErrorMessage="Installment Difference Due Waive must be entry...!" 
                        SetFocusOnError="True" ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqWaiveInstDiffDue_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" 
                        TargetControlID="reqWaiveInstDiffDue">
                    </ajaxToolkit:ValidatorCalloutExtender>
			    </td>
		    </tr>
		        <tr>
                    <td class="RowStyle">
                        Penalty Due (s)</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" 
                            ReadOnly="True" Style="text-align: right"></asp:TextBox>
                    </td>
                    <td ID="WaivePenalty" class="RowStyle">
                        <asp:TextBox ID="txtWaivePenaltyDue" runat="server" autocomplete="off" 
                            CssClass="required" Style="text-align: right" ValidationGroup="ViewAcc"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqWaivePenaltyDue" runat="server" 
                            ControlToValidate="txtWaivePenaltyDue" Display="None" 
                            ErrorMessage="Penalty Overdue Waive must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="ViewAcc"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqWaivePenaltyDue_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqWaivePenaltyDue">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
		    <tr>
			    <td class="FooterStyle">
				    Total Installment Due (z) = (q + r + f + s)</td>
			    <td class="FooterStyle">
				    <asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
			    <td class="FooterStyle" ID="WaiveInstallmentDue">
				    <asp:TextBox ID="txtWaiveInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
		    </tr>
			<tr id="WaiveSPV">
                <td class="FooterStyle">
                    Total Waive</td>
                <td class="FooterStyle">
                    <asp:TextBox ID="txtWaiveTotal" runat="server" CssClass="required" 
                        Style="text-align: right"></asp:TextBox>
                </td>
                
            </tr>
            <tr>
				<td class="RowStyle" valign="top">
					Description</td>
				<td style="height: 24px" class="RowStyle" colspan="2">
					<asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine"
						Width="240px" Height="72px"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td class="HeaderStyle" colspan="3">
				</td>
			</tr>
		</table>
        </asp:Panel>
	</asp:Panel>
    <br />
    <br />
<asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="100%">
  <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                        Font-Bold="True" Style="text-align: center" Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
     <asp:Button ID="btnSave" runat="server" OnClientClick="return ProcessWaiveOD();" 
        Style="background-position: right; background-image: url(../Images/Save.gif); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
        Text="Save" Width="88px" />
    <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
        Style="background-position: right; background-image: url(../Images/cancel.gif); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
        Text="Cancel" Width="88px" />
    <asp:Button ID="btnPrint" runat="server" OnClientClick="return PrintData();" 
        Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
        Text="Print Data" Width="136px" Visible="False" />
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom">
	        </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TabEnter.js"></script>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    window.onload = function () {
        TabToEnter();
        load();
    }

    

    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }

    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }

    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    function load() {
        var sAction = GetValueTxtByClientID("<%=txtAction.ClientID%>");
        var WaiveSPV = getObjectbyClientID("WaiveSPV");
        var WaiveInstallmentDue = getObjectbyClientID("WaiveInstallmentDue");
        var WaivePenalty = getObjectbyClientID("WaivePenalty");
        var WaiveInterest = getObjectbyClientID("WaiveInterest");
        var WaivePrincipal = getObjectbyClientID("WaivePricipal");
        var WaiveInstDue = getObjectbyClientID("WaiveInstDue");
        var WaiveHead = getObjectbyClientID("WaiveHead");
        if (sAction == "INPSPV") {
            WaiveSPV.style.display = "";
            WaiveInstallmentDue.style.display = "none";
            WaivePenalty.style.display = "none";
            WaiveInterest.style.display = "none";
            WaivePrincipal.style.display = "none";
            WaiveInstDue.style.display = "none";
            WaiveHead.style.display = "none";
        } else {
            WaiveSPV.style.display = "none";
            WaiveInstallmentDue.style.display = "";
            WaivePenalty.style.display = "";
            WaiveInterest.style.display = "";
            WaivePrincipal.style.display = "";
            WaiveInstDue.style.display = "";
            WaiveHead.style.display = "";
        }
    }
    function SearchAcc() {
        var winref = window.open("../Pay/SearchAccPay.aspx?Action=Find", "AccFind", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes");
        winref.focus();
        return false;
    }
    function toNumeric(theValue) {
        var ValX = parseFloat(FormatNumberClear(theValue));
        if (isNaN(ValX))
            ValX = 0;
        return (ValX);
    }
   
    function CalcETWaive() {
        
        var InstallmentDue = toNumeric(GetValueTxtByClientID("<%=txtInstallmentDue.ClientID%>"));
        var PrincipalWaive = toNumeric(GetValueTxtByClientID("<%=txtWaivePrincipalDue.ClientID%>"));
        var InterestWaive = toNumeric(GetValueTxtByClientID("<%=txtWaiveInterestDue.ClientID%>"));
        var PenaltyWaive = toNumeric(GetValueTxtByClientID("<%=txtWaivePenaltyDue.ClientID%>"));
        var InstDiffWaive = toNumeric(GetValueTxtByClientID("<%=txtWaiveInstDiffDue.ClientID%>"));

        var oInstallmentWaive = getObjectbyClientID("<%=txtWaiveInstallmentDue.ClientID%>");
        oInstallmentWaive.value = 0;
        oInstallmentWaive.value = FormatNumber(InstallmentDue - PrincipalWaive - InterestWaive - PenaltyWaive - InstDiffWaive, 'True', 2);

    }

      
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }


    function CheckProcess() {
        var sAction = GetValueTxtByClientID("<%=txtAction.ClientID%>");
        var oPenaltyDue = getObjectbyClientID("<%=txtWaivePenaltyDue.ClientID%>");
        var oInterestDue = getObjectbyClientID("<%=txtWaiveInterestDue.ClientID%>");
        var oPrincipalDue = getObjectbyClientID("<%=txtWaivePrincipalDue.ClientID%>");
        var oInstDiffDue = getObjectbyClientID("<%=txtWaiveInstDiffDue.ClientID%>");

        var WaiveInstallmentDue = toNumeric(GetValueTxtByClientID("<%=txtWaiveInstallmentDue.ClientID%>"));
        if (toNumeric(oPenaltyDue.value) == 0 && toNumeric(oInterestDue.value) == 0 && toNumeric(oPrincipalDue.value) == 0 && toNumeric(oInstDiffDue.value) == 0) {
            alert("Amount Waive Must is greater than 0..!");
            //oPrincipalDue.className = "ErrHighLight";
            //oPrincipalDue.focus();
            //oInterestDue.className = "ErrHighLight";
            //oInterestDue.focus();
            //oPenaltyDue.className = "ErrHighLight";
            //oPenaltyDue.focus();
            return false;
        }


        if (sAction == "INPSPV") {
            var oWaiveTotal = getObjectbyClientID("<%=txtWaiveTotal.ClientID%>");
            var InstallmentDue = toNumeric(GetValueTxtByClientID("<%=txtInstallmentDue.ClientID%>"));
            if (toNumeric(oWaiveTotal.value) > InstallmentDue) {
                alert("Waive Total is greater than Installment Due..!");
                oWaiveTotal.className = "ErrHighLight";
                oWaiveTotal.focus();
                return false;
            }
        } else if (sAction == "INP") {
            var oPrincipalWaive = getObjectbyClientID("<%=txtWaivePrincipalDue.ClientID%>");
            var PrincipalDue = toNumeric(GetValueTxtByClientID("<%=txtPrincipalDue.ClientID%>"));
            if (toNumeric(oPrincipalWaive.value) > PrincipalDue) {
                alert("Principal Waive is greater than original Principal..!");
                oPrincipalWaive.className = "ErrHighLight";
                oPrincipalWaive.focus();
                return false;
            }

            var oInterestWaive = getObjectbyClientID("<%=txtWaiveInterestDue.ClientID%>");
            var Interest = toNumeric(GetValueTxtByClientID("<%=txtInterestDue.ClientID%>"));
            if (toNumeric(oInterestWaive.value) > Interest) {
                alert("Interest Waive is greater than original Interest..!");
                oInterestWaive.className = "ErrHighLight";
                oInterestWaive.focus();
                return false;
            }

            var oPenaltyWaive = getObjectbyClientID("<%=txtWaivePenaltyDue.ClientID%>");
            var Penalty = toNumeric(GetValueTxtByClientID("<%=txtPenaltyDue.ClientID%>"));
            if (toNumeric(oPenaltyWaive.value) > Penalty) {
                alert("Penalty Waive is greater than original Penalty..!");
                oPenaltyWaive.className = "ErrHighLight";
                oPenaltyWaive.focus();
                return false;
            }

            var oInstDiffWaive = getObjectbyClientID("<%=txtWaiveInstDiffDue.ClientID%>");
            var InstDiff = toNumeric(GetValueTxtByClientID("<%=txtInstDiffDue.ClientID%>"));
            if (toNumeric(oInstDiffWaive.value) > InstDiff) {
                alert("Installment Difference Waive is greater than original Installment Difference..!");
                oInstDiffWaive.className = "ErrHighLight";
                oInstDiffWaive.focus();
                return false;
            }

        }
        return true;
    }

    function ProcessWaiveOD() {
        if (Page_ClientValidate("")) {
            if (!CheckProcess()) return false;
            
        } else {
            return false;
        }
        return true;
    }
    function PrintData() {
        var VALUEDATE = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtTxnDate.ClientID%>"));
        var LOCID = GetValueTxtByClientID("<%=txtLocID.ClientID%>");
        var ACCID = GetValueTxtByClientID("<%=txtAccID.ClientID%>");
//        if (Page_ClientValidate("")) {
//            var winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/ETAccountInquiry&VALUEDATE=" + VALUEDATE + "&LOCID=" + LOCID + "&ACCID=" + ACCID + "&OTHERFEE=" + OTHERFEE, "ETInquiry", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
//            winref.focus();
//        }
        return false;
    }

    function ConvertDDMMYYYY(sDate) {
        var arrDate = sDate.split("/")
        return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);

    }
</script>

</asp:Content>

