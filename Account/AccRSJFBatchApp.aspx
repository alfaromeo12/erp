<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccRSJFBatchApp.aspx.vb" Inherits="Account_AccRSJFBatchApp" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="txtSPV" runat="server" />
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="100%" CssClass="RowStyle">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    Booking Date</td>
                <td>
                    <asp:TextBox ID="txtTxnDate" runat="server" CssClass="required" Width="72px"></asp:TextBox><asp:Image
                        ID="imgTxnDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtTxnDateTo" runat="server" CssClass="required" Width="72px"></asp:TextBox><asp:Image
                        ID="imgTxnDateTo" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCETxnDate" runat="server" Format="dd/MM/yyyy"
                            PopupButtonID="imgTxnDate" TargetControlID="txtTxnDate">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnDate" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnDate">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="reqTxnDate" runat="server" ControlToValidate="txtTxnDate"
                        Display="None" ErrorMessage="From Booking Date must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETxnDate" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTxnDate">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCETxnDateTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgTxnDateTo"
                        TargetControlID="txtTxnDateTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEETxnDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtTxnDateTo">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="reqTxnDateTo" runat="server" ControlToValidate="txtTxnDateTo"
                        Display="None" ErrorMessage="Booking To Date must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                            ID="ajaxVCETxnDateTo" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqTxnDateTo">
                        </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    JF Group</td>
                <td>
                    <asp:DropDownList ID="ddlJFGroup" runat="server" CssClass="required">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDJFGroup" runat="server" Category="JFGROUP" 
                        LoadingText="[Loading JF Group...]" PromptText="[DISPLAY ALL]" 
                        ServiceMethod="GetDropDownJFGroup" ServicePath="~\Param\WebService.asmx" 
                        TargetControlID="ddlJFGroup">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqJFGroup" runat="server" 
                        ControlToValidate="ddlJFGroup" Display="None" 
                        ErrorMessage="Group must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqJFGroup_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqJFGroup">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td>
                    JF/Bank</td>
                <td>
                    <asp:DropDownList ID="ddlJF" runat="server" CssClass="required">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJF" runat="server" Category="JF"
                        LoadingText="[Loading JF/Bank...]" ParentControlID="ddlJFGroup" PromptText="[DISPLAY ALL]"
                        ServiceMethod="GetDropDownJFByJFGroup" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJF">
                    </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqJF" runat="server" ControlToValidate="ddlJF" 
                        Display="None" ErrorMessage="JF ID must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="reqJF_ValidatorCalloutExtender" 
                        runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqJF">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            </tr>
            <tr>
                <td class="FooterStyle" colspan="2">
                    <asp:Button ID="btnView" runat="server" noenter="" Style="background-position: right;
                        background-image: url(../Images/view.png); cursor: pointer; background-repeat: no-repeat;
                        text-align: left; " Text="View Account" /></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        Caption="Account Reschedule List" DataKeyNames="LOCID,ACCID" DataSourceID="sdsGrid" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" SortExpression="ACCNO">
                <ItemTemplate><a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                    <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" Text='<%# eval("ACCNO") %>'></asp:Label></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="BRANCH" HeaderText="Branch" HtmlEncode="False"
                SortExpression="BRANCH" />
            <asp:BoundField DataField="JFBOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Booking&lt;br&gt;Date"
                HtmlEncode="False" SortExpression="JFBOOKINGDATE" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="ACCOUNTNAME" />
            <asp:BoundField DataField="OSPRINCIPALCURRENT" DataFormatString="{0:N}" HeaderText="OS&lt;BR&gt;Principal"
                HtmlEncode="False" SortExpression="OSPRINCIPALCURRENT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDEFFRATE" HeaderText="Old Eff. Rate" HtmlEncode="False"
                SortExpression="OLDEFFRATE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="OLDINSTALLMENT" DataFormatString="{0:N}" HeaderText="Old&lt;br&gt;Installment"
                HtmlEncode="False" SortExpression="OLDINSTALLMENT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="NEWEFFRATE" HeaderText="New.&lt;br&gt;Eff. Rate" HtmlEncode="False"
                SortExpression="NEWEFFRATE">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="NEWINSTALLMENT" DataFormatString="{0:N}" HeaderText="New&lt;br&gt;Installment"
                HtmlEncode="False" SortExpression="NEWINSTALLMENT">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        
        
        SelectCommand="SELECT TOP (700) ACCOUNT.LOCID, ACCOUNT.ACCID, ACCOUNT.ACCOUNTNAME, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCH, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, ACCOUNT.PRINCIPALTOTAL, ACCOUNT.APPID, ACCOUNTJF.JFBOOKINGDATE, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, RESCHEDULEJF.RSTXNDATE, RESCHEDULEJF.OSTENORCURRENT, RESCHEDULEJF.OSPRINCIPALCURRENT, RESCHEDULEJF.OLDEFFRATE, RESCHEDULEJF.NEWEFFRATE, RESCHEDULEJF.OLDINSTALLMENT, RESCHEDULEJF.NEWINSTALLMENT, RESCHEDULEJF.OLDINTERESTTOTAL, RESCHEDULEJF.NEWINTERESTTOTAL, RESCHEDULEJF.OLDTENOR, RESCHEDULEJF.NEWTENOR, RESCHEDULEJF.OLDPRINCIPAL, RESCHEDULEJF.NEWPRINCIPAL, ACCOUNTJF.JFID FROM ACCOUNT WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN ACCOUNTJF ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN RESCHEDULEJF ON ACCOUNTJF.ACCIDJF = RESCHEDULEJF.ACCIDJF WHERE (ACCOUNT.ACCSTATUS = 1) AND (ACCOUNTJF.JFBOOKINGDATE BETWEEN CONVERT (DATETIME, @BOOKINGDATE1, 103) AND CONVERT (DATETIME, @BOOKINGDATE2, 103)) AND (ACCOUNTJF.JFID = @JFID) AND (RESCHEDULEJF.RSSTATUS = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtTxnDate" Name="BOOKINGDATE1" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtTxnDateTo" Name="BOOKINGDATE2" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlJF" Name="JFID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
        <asp:Panel ID="pnlInit" runat="server" GroupingText="Approval" Width="100%" Font-Bold="True" CssClass="ShowDetail">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="HeaderStyle">
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
                    </td>
                </tr>
                <tr>
                    <td class="HeaderStyle">
                        <asp:Button ID="btnApprove" runat="server" Enabled="False" 
                            OnClientClick="return(confirm(&quot;Are you sure want to APPROVE Reschedule Account..?&quot;));" 
                            Style="background-position: right; background-image: url(../Images/ok.png); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                            Text="Approve" Width="88px" />
                        &nbsp;<asp:Button ID="btnReject" runat="server" CausesValidation="False" 
                            Enabled="False" 
                            OnClientClick="return(confirm(&quot;Are you sure want to REJECT Reschedule Account..?&quot;));" 
                            Style="background-position: right; background-image: url(../Images/stop.png); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                            Text="Reject" Width="88px" />
                        <asp:Button ID="btnPrint" runat="server" Enabled="False" 
                            OnClientClick="return PrintData();" 
                            Style="background-position: right; background-image: url(../Images/print.jpg); cursor: pointer; background-repeat: no-repeat;  text-align: left" 
                            Text="Print Data" Width="136px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlInit"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    var WinRef = null;
    function ViewDetailAcc(LOCID, APPID) {
        WinRef = window.open("../Account/AccInqFrame.aspx?Action=AccInq&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }

    function PrintData() {
        var BOOKINGDATE1 = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtTxnDate.ClientID%>"));
        var BOOKINGDATE2 = ConvertDDMMYYYY(GetValueTxtByClientID("<%=txtTxnDateTo.ClientID%>"));
        var JFID = GetValueTxtByClientID("<%=ddlJF.ClientID%>");
        if (Page_ClientValidate("")) {
            winref = window.open("../Reports/ReportView.aspx?Back=0&RPT=/DLEAS/Reschedule_ApprovalPerJF&BOOKINGDATE1=" + BOOKINGDATE1 + "&BOOKINGDATE2=" + BOOKINGDATE2 + "&JFID=" + JFID, "Reschedule_ApprovalPerJF", "height=450,width=700,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
            winref.focus();
        }
        return false;
    }
    function ConvertDDMMYYYY(sDate) {
        var arrDate = sDate.split("/")
        return (arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]);

    }
</script>
</asp:Content>

