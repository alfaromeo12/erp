<%@ Page Title="" Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="FTPAccountView.aspx.vb" Inherits="FTPDoc_FTPAccountView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
 <asp:HiddenField ID="txtLocID" runat="server" />
	<asp:HiddenField ID="txtAppID" runat="server" />
    <asp:HiddenField ID="txtFileName" runat="server" />
    <asp:HiddenField ID="hidAction" runat="server" />
    <asp:HiddenField ID="hidBRANCHCODE" runat="server" />
    <asp:HiddenField ID="hidCREATEDATE" runat="server" />
	<asp:HiddenField ID="hidCREATEYEAR" runat="server" />
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
</asp:Content>

