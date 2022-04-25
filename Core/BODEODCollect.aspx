<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BODEODCollect.aspx.vb" Inherits="AppSetting_BODAP" title="BOD ASSET PLEDGE" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <hr />
        <asp:Label ID="lblMsgDAte" runat="server" CssClass="HeaderStyle" Font-Bold="True"
        Text="Date :  "></asp:Label>
    <asp:TextBox ID="txtAppDate" runat="server" CssClass="required" Width="64px"></asp:TextBox><asp:Image
        ID="imgAppDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
        ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEDate" runat="server" Format="dd/MM/yyyy"
            PopupButtonID="imgAppDate" TargetControlID="txtAppDate">
        </ajaxToolkit:CalendarExtender>
    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
        TargetControlID="txtAppDate">
    </ajaxToolkit:MaskedEditExtender>
    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
        Font-Underline="True" Width="100%" style="text-align: center" 
        Visible="False"></asp:Label>
    <hr />
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>

    <asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
    <asp:Button ID="btnProcess" runat="server" 
            Style="cursor: pointer; background-position: right; background-image: url(../Images/menu.gif); background-repeat: no-repeat; text-align: left; " 
            Text="Process" 
            OnClientClick='return (confirm("Are you sure want to Process...?"));' 
            CausesValidation="False" />
        <asp:HiddenField ID="hidTYPE" runat="server" />
        <asp:Literal ID="LiteralWarn" runat="server"></asp:Literal>
        </asp:Panel>
<script type="text/javascript">
    function PrintWarn(WarnType) {
        if (WarnType == "1" || WarnType == "2") {
            var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/sp1batch.rpt&stsprn=1&prompt1=0&prompt2=" + WarnType, "PRINTWARN", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
            winref.focus();

        } else {
            var winref = window.open("../Reports/ReportViewerCrystal.aspx?Report=/Printing/sp3batch.rpt&stsprn=1&prompt1=0&prompt2=" + WarnType, "PRINTWARN", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
            winref.focus();

        }
        return (false);
    }
</script>
</asp:Content>

