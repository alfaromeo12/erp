<%@ Page Title="Waive OverDue- Inquiry" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="WaiveOverDueInq.aspx.vb" Inherits="Account_WaiveOverDueInq" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register src="../UserControl/DataAccountFromParamAccID.ascx" tagname="DataAccountFromParamAccID" tagprefix="uc2" %>
<%@ Register src="../UserControl/LoanDataFromParamAccID.ascx" tagname="LoanDataFromParamAccID" tagprefix="uc3" %>
<%@ Register src="../UserControl/InstallmentDataDue.ascx" tagname="InstallmentDataDue" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

	<asp:Panel ID="pnlPayment" runat="server" Width="100%">
		<asp:Panel ID="pnlAccShow" runat="server" CssClass="ShowDetail" Width="99%">
			<div style="float: right; vertical-align: middle">
				<asp:Image ID="imgAccData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
				<asp:Label ID="lblAccData" runat="server" CssClass="required">(Show Account Data...)</asp:Label>
			</div>
			<input id="Button1" noenter="" style="background-position: left top; width: 24px;
				cursor: pointer; background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
		<asp:HiddenField ID="txtLocID" runat="server" />
		<asp:HiddenField ID="txtAccID" runat="server" />
		<asp:HiddenField ID="txtTxnDate" runat="server" />
		<asp:HiddenField ID="hidFINCATID" runat="server" />
        <asp:HiddenField ID="txtACCOUNTNO" runat="server" />
        <asp:HiddenField ID="txtAction" runat="server" />
		<asp:HiddenField ID="hidBookingDate" runat="server" />
		<asp:HiddenField ID="hidWAIVEID" runat="server" />
		<asp:Panel ID="pnlAccData" runat="server" Width="100%">
		    <uc2:DataAccountFromParamAccID ID="DataAccountFromParamAccID1" runat="server" />
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
			<uc3:LoanDataFromParamAccID ID="LoanDataFromParamAccID1" runat="server" />
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
		<asp:Panel ID="pnlInstData" runat="server" Width="100%">
			<uc4:InstallmentDataDue ID="InstallmentDataDue1" runat="server" />
		</asp:Panel>
         <asp:DataList ID="dlWaiveOverDue" runat="server" Width="100%" 
            Caption="WAIVE OVER DUE" DataSourceID="sdsWaiveOD">
            <ItemTemplate>
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="30%" style="height: 19px">
                        Waive OverDue ID</td>
                    <td style="height: 19px">
                        <asp:Label ID="Label62" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("WAIVEODID") %>'></asp:Label>
                        &nbsp;</td>
                    <td style="height: 19px">
                        Waive Txn Date</td>
                    <td style="height: 19px">
                        <asp:Label ID="Label63" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("WAIVEDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Waive Status</td>
                    <td>
                        <asp:Label ID="Label64" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("WAIVESTATUSNM") %>'></asp:Label>
                        <asp:Label ID="Label67" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("WAIVESTATUS") %>' Visible="False"></asp:Label>
                    </td>
                    <td>
                        Waive Status Date</td>
                    <td>
                        <asp:Label ID="Label65" runat="server" Font-Bold="True" Font-Underline="True" 
                            Text='<%# Eval("STATUSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
                    <tr>
                        <td>
                            With SPV Menu?</td>
                        <td colspan="3">
                            <asp:Label ID="Label66" runat="server" Font-Bold="True" Font-Underline="True" 
                                Text='<%# IIF(Eval("FLAGSPV")=true,"Yes", "No") %>'></asp:Label>
                        </td>
                    </tr>
            </table>
            </ItemTemplate>
        </asp:DataList>
	    <asp:SqlDataSource ID="sdsWaiveOD" runat="server" 
            ConnectionString="<%$ ConnectionStrings:connection %>" 
            
            SelectCommand="SELECT WAIVEODID, WAIVEDATE, WAIVESTATUS, '(' + CAST(WAIVESTATUS AS VARCHAR(10)) + ') ' + dbo.f_getParamGlobalName('WAIVESTATUS', WAIVESTATUS) AS WAIVESTATUSNM, STATUSDATE, FLAGSPV FROM WAIVEOD WHERE (LOCID = @LOCID) AND (ACCID = @ACCID) AND (WAIVEODID = @WAIVEODID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtLocID" Name="LOCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtAccID" Name="ACCID" PropertyName="Value" />
                <asp:ControlParameter ControlID="hidWAIVEID" Name="WAIVEODID" 
                    PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:Panel ID="pnlNonSPV" runat="server" Width="99%">
		    <table cellpadding="0" cellspacing="0" width="100%">
			    <tr>
				    <td colspan="3" class="required">
					    <hr />
				    </td>
			    </tr>
                
			    <tr>
			    <td class="ShowDetail" colspan="3" style="text-align: center">
				    DETAIL WAIVE OVERDUE</td>
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
				    <asp:TextBox ID="txtWaivePrincipalDue" runat="server" CssClass="disabled"
					    Style="text-align: right" ValidationGroup="ViewAcc" 
                         autocomplete="off" ReadOnly="True"></asp:TextBox>
			    </td>
		    </tr>
		    <tr>
			    <td class="RowStyle">
				    <asp:Label ID="lblInterestDue" runat="server"></asp:Label> Due (r)</td>
			    <td class="RowStyle">
				    <asp:TextBox ID="txtInterestDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
			    <td class="RowStyle" ID="WaiveInterest">
				    <asp:TextBox ID="txtWaiveInterestDue" runat="server" CssClass="disabled"
					    Style="text-align: right" ValidationGroup="ViewAcc" 
                        autocomplete="off" ReadOnly="True"></asp:TextBox>
			    </td>
		    </tr>
		        <tr>
                    <td class="RowStyle">
                        Installment Due Difference (f)</td>
                    <td class="RowStyle">
                        <asp:TextBox ID="txtInstDiffDue" runat="server" CssClass="disabled" 
                            ReadOnly="True" Style="text-align: right"></asp:TextBox>
                    </td>
                    <td ID="WaivePenalty0" class="RowStyle">
                        <asp:TextBox ID="txtWaiveInstDiffDue" runat="server" autocomplete="off" 
                            CssClass="disabled" ReadOnly="True" Style="text-align: right" 
                            ValidationGroup="ViewAcc"></asp:TextBox>
                    </td>
                </tr>
		    <tr>
			    <td class="RowStyle">
				    Penalty Due (s)</td>
			    <td class="RowStyle">
				    <asp:TextBox ID="txtPenaltyDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
			    <td class="RowStyle" ID="WaivePenalty">
				    <asp:TextBox ID="txtWaivePenaltyDue" runat="server" CssClass="disabled"
					    Style="text-align: right" ValidationGroup="ViewAcc" autocomplete="off" 
                        ReadOnly="True"></asp:TextBox>
			    </td>
		    </tr>
		    <tr>
			    <td class="FooterStyle">
				    Total Installment Due (z) = (q + r + s)</td>
			    <td class="FooterStyle">
				    <asp:TextBox ID="txtInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
			    <td class="FooterStyle" ID="WaiveInstallmentDue">
				    <asp:TextBox ID="txtWaiveInstallmentDue" runat="server" CssClass="disabled" ReadOnly="True"
					    Style="text-align: right"></asp:TextBox></td>
		    </tr>
            <tr>
				<td class="RowStyle" valign="top">
					Description</td>
				<td style="height: 24px" class="RowStyle" colspan="2">
					<asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine"
						Width="240px" Height="72px" CssClass="disabled" ReadOnly="True"></asp:TextBox>
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
    <br />
    <br />
<asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Style="border-right: thin inset;
    border-top: thin inset; border-left: thin inset; border-bottom: thin inset" Width="99%">
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
   <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
        Style="background-position: right; background-image: url(../Images/back.png); cursor: pointer; background-repeat: no-repeat; text-align: left; " 
        Text="Back" ToolTip="Cancel" Width="88px" />
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom">
	        </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TabEnter.js"></script>

</asp:Content>

