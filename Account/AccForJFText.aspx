<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccForJFText.aspx.vb" Inherits="Account_AccForJFText" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Literal ID="LiteralJF" runat="server"></asp:Literal>
                    <asp:Label ID="lblMessage" runat="server" 
        CssClass="ErrHighLight" Font-Bold="True"
                        Style="text-align: center" Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
</asp:Content>

