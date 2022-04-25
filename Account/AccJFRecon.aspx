<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccJFRecon.aspx.vb" Inherits="Acc_Recon" title="Generate File Recon" EnableEventValidation="false" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="nodatafound" tagprefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="ShowDetail" colspan="4">
                Generate File Criteria</td>
        </tr>
        <tr>
            <td class="RowStyle" width="10%">
                Date Process</td>
            <td class="RowStyle">
                <asp:TextBox ID="txtDate" runat="server" CssClass="required" Width="72px"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="ajaxCEPayFrom" runat="server" Format="dd/MM/yyyy"
                        PopupButtonID="imgDate" TargetControlID="txtDate">
                    </ajaxToolkit:CalendarExtender>
                <ajaxToolkit:MaskedEditExtender ID="ajaxMEEPayFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                    TargetControlID="txtDate">
                </ajaxToolkit:MaskedEditExtender>
                <asp:Image
                    ID="imgDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer; height: 16px;"
                    ToolTip="Calendar" />
                <asp:RequiredFieldValidator ID="reqDate" runat="server" ControlToValidate="txtDate"
                    Display="None" ErrorMessage="Recon Date  must be entry...!" 
                    SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                        ID="ajaxVCEPayFrom" runat="server" HighlightCssClass="ErrHighLight" 
                    TargetControlID="reqDate">
                    </ajaxToolkit:ValidatorCalloutExtender>
                </td>
            <td class="RowStyle">
                &nbsp;</td>
            <td class="RowStyle">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="FooterStyle" colspan="4">
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsData" Width="100%" 
            DataKeyNames="JFID" 
            RowHeaderColumn="JFID">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/edit.gif" 
                        ShowSelectButton="True"><ItemStyle HorizontalAlign="Center" Width="25px" /></asp:CommandField>
                <asp:BoundField DataField="JFID" HeaderText="JF&lt;br&gt;ID" HtmlEncode="False"
                    ReadOnly="True" SortExpression="JFID" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JFNAME" HeaderText="JF&lt;br&gt;Code" HtmlEncode="False"
                    SortExpression="JFNAME" />
                <asp:BoundField DataField="FileName" HeaderText="File&lt;br&gt;Name" HtmlEncode="False"
                    SortExpression="FileName" />
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
                <asp:SqlDataSource ID="sdsData" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                    SelectCommand="SELECT MOSTextSettingJF.TextID, MOSTextSettingJF.FileName, JF.JFCODE, '(' + JF.JFCODE + ') ' + JF.JFNAME AS JFNAME, JF.JFID FROM MOSTextSettingJF INNER JOIN JF ON MOSTextSettingJF.JoinFinanceID = JF.JFID WHERE (JF.Deletests = 0) AND (MOSTextSettingJF.DeleteSts = 0) AND (MOSTextSettingJF.UsedFor = 60)">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="HeaderStyle" colspan="4">
                <hr />
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlDownload" runat="server" CssClass="ErrHighLight" Visible="False"
        Width="100%">
        File to Download :
        <asp:HyperLink ID="lnkDownload" runat="server" CssClass="required">HyperLink</asp:HyperLink></asp:Panel>
<script type="text/javascript">
function GetValueTxtByClientID(ClientID){
    var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];  
    if (oText)
        return(oText.value);
}

</script>
</asp:Content>

