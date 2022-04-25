<%@ Page Title="JF Text Setting" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFTextSetting.aspx.vb" Inherits="Param_JFTextSetting" %>

<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:DataList ID="dlJF" runat="server" Caption="JOIN FINANCE (BANK) INFO" DataKeyField="JFID"
        DataSourceID="sdsJF" Width="100%">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="FooterStyle">
                        JF Group</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFGROUPCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPCODE") %>'></asp:Label>)
                        <asp:Label ID="JFGROUPNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label>
                    </td>
                    <td class="FooterStyle">
                        JF</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)
                        <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Address</td>
                    <td colspan="3">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADDRESS") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF City</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCITY") %>'></asp:Label>
                    </td>
                    <td>
                        Zip</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFZIP") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        JF Portion</td>
                    <td>
                        <asp:Label ID="JFPORTIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPORTION", "{0:N}") %>'></asp:Label>
                        %</td>
                    <td>
                        Mirror Status</td>
                    <td>
                        <asp:Label ID="MIRRORSTATUSNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("MIRRORSTATUSNAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        PKS No.</td>
                    <td>
                        <asp:Label ID="JFPKSNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSNO") %>'></asp:Label>
                    </td>
                    <td>
                        PKS Date</td>
                    <td>
                        <asp:Label ID="JFPKSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        PKS Title</td>
                    <td colspan="3">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPKSTITLE") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td>
                        (<asp:Label ID="JFADMINTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFADMINTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPENAME") %>'></asp:Label>
                    </td>
                    <td>
                        Admin</td>
                    <td>
                        <asp:Label ID="JFADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMIN") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Provison Type</td>
                    <td>
                        (<asp:Label ID="JFPROVISIONTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFPROVISIONTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPENAME") %>'></asp:Label>
                    </td>
                    <td>
                        Provision</td>
                    <td>
                        <asp:Label ID="JFPROVISIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISION") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Early Payment
                    </td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFEARLYPAYMENTNAME") %>'></asp:Label>
                    </td>
                    <td>
                        First Payment Type</td>
                    <td>
                        (<asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPENAME") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:HiddenField ID="hidJFID" runat="server" />
    <asp:HiddenField ID="hidACTION" runat="server" />
    <asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, JF.JFPORTION, JF.JFMIRRORSTATUS, dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS MIRRORSTATUSNAME, JF.JFPKSNO, JF.JFPKSDATE, JF.JFADMINTYPE, dbo.f_getParamGlobalName('JFADMINTYPE', JF.JFADMINTYPE) AS JFADMINTYPENAME, JF.JFADMIN, JF.JFPROVISIONTYPE, dbo.f_getParamGlobalName('JFPROVISIONTYPE', JF.JFPROVISIONTYPE) AS JFPROVISIONTYPENAME, JF.JFPROVISION, JF.JFADDRESS, JF.JFCITY, JF.JFZIP, JF.JFEARLYPAYMENT, dbo.f_getParamGlobalName('JFEARLYPAYMENT', JF.JFEARLYPAYMENT) AS JFEARLYPAYMENTNAME, JF.JFFIRSTPAYMENTTYPE, dbo.f_getParamGlobalName('JFFIRSTPAYMENTTYPE', JF.JFFIRSTPAYMENTTYPE) AS JFFIRSTPAYMENTTYPENAME, JF.JFPKSTITLE FROM JF INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF.JFID = @JFID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidJFID" Name="JFID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
              <asp:GridView ID="gvJFText" runat="server" 
        AllowSorting="True" AutoGenerateColumns="False" Caption="JF TEXT SETTING" 
        DataSourceID="sdsJFTextSetting" Width="100%">
                  <Columns>
                      <asp:BoundField DataField="TextID" HeaderText="TextID" 
                          SortExpression="TextID" />
                      <asp:BoundField DataField="FileName" HeaderText="File&lt;br&gt;Name" 
                          HtmlEncode="False" SortExpression="FileName" />
                      <asp:BoundField DataField="FileDesc" HeaderText="File&lt;br&gt;Description" 
                          HtmlEncode="False" SortExpression="FileDesc" />
                      <asp:BoundField DataField="USEFORNAME" HeaderText="Used&lt;br&gt;For" 
                          HtmlEncode="False" SortExpression="USEFORNAME" />
                      <asp:BoundField DataField="FileTypeName" HeaderText="File&lt;br&gt;Type" 
                          HtmlEncode="False" SortExpression="FileTypeName" />
                  </Columns>
                  <EmptyDataTemplate>
                      <uc1:NoDataFound ID="NoDataFound1" runat="server" />
                  </EmptyDataTemplate>
    </asp:GridView>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
    <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>

    <asp:SqlDataSource ID="sdsJFTextSetting" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT TextID, Sort, FileName, FileDesc, UsedFor, FileType, '(' + CAST(UsedFor AS VARCHAR(20)) + ') ' + ISNULL(CASE WHEN UsedFor = 0 THEN 'JF REQUEST' WHEN UsedFor = 1 THEN 'JF REQUEST' WHEN UsedFor = 10 THEN 'Payment' WHEN UsedFor = 20 THEN 'ET JF/BUY BACK' WHEN UsedFor = 60 THEN 'Reconcial' WHEN UsedFor = 14 THEN 'Penalty Paid' WHEN UsedFor = 15 THEN 'Cair' WHEN UsedFor = 17 THEN 'Flagging' WHEN UsedFor = 18 THEN 'Unflaging' WHEN UsedFor = 50 THEN 'DOCUMENT/BPKB' WHEN UsedFor = 20 THEN 'AYDA/Reposes' WHEN UsedFor = 21 THEN 'Asuransi' END, '') AS USEFORNAME, '(' + CAST(FileType AS varchar(20)) + ') ' + ISNULL(CASE WHEN FILETYPE = 1 THEN 'TEXT FILE' WHEN FILETYPE IN (4 , 5 , 6) THEN 'DBF' END, '') AS FileTypeName FROM MOSTextSettingJF WHERE (JoinFinanceID = @JFID) ORDER BY UsedFor, Sort">
        <SelectParameters>
            <asp:ControlParameter ControlID="hidJFID" Name="JFID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="pnlCopy" runat="server" CssClass="ShowDetail" Width="100%">
        <asp:Button ID="btnCopy" runat="server" Text="Copy Setting" 
            style="cursor:pointer" CausesValidation="False" 
            onclientclick="return JFCopySetting();" UseSubmitBehavior="False" />
    </asp:Panel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvJFText.ClientID%>");
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
    function JFCopySetting() {
        var WinRef = window.open("../Param/JFTextSettingCopy.aspx?Action=Copy", "JFTextCopy", "height=370,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        WinRef.focus();
    }
    function JFSetCopySetting(JFID) {
        SetValueTxtByClientID("<%=hidACTION.ClientID%>", "COPY")
        document.forms[0].action = "JFTextSetting.aspx?JFIDCOPY=" + JFID;
        document.forms[0].submit();

    }
</script>
</asp:Content>

