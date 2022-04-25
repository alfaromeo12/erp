<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="BODAssetPledge.aspx.vb" Inherits="AppSetting_BODAP" title="BOD ASSET PLEDGE" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Label ID="lblMsgDAte" runat="server" CssClass="HeaderStyle" Font-Bold="True"
        Text="BOD Date :  "></asp:Label>
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
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <hr />
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEProcess" runat="server" TargetControlID="pnlProcess"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>

    <asp:Panel ID="pnlProcess" runat="server" CssClass="HeaderStyle" Width="100%">
    <asp:Button ID="btnProcess" runat="server" Style="cursor: pointer; background-position: right; background-image: url(../Images/menu.gif); background-repeat: no-repeat; text-align: left; " Text="Process" OnClientClick='return (confirm("Are you sure want to execute BOD Process...?"));' CausesValidation="False" />
        </asp:Panel>
</asp:Content>

