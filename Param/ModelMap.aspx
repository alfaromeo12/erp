<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ModelMap.aspx.vb" Inherits="Param_ModelMap" title="Model JF Mapping" %>

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
                            Text='<%# Eval("JFGROUPNAME") %>'></asp:Label></td>
                    <td class="FooterStyle">
                        JF</td>
                    <td class="FooterStyle">
                        (<asp:Label ID="JFCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFCODE") %>'></asp:Label>)
                        <asp:Label ID="JFNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF Address</td>
                    <td colspan="3">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFADDRESS") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        JF City</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFCITY") %>'></asp:Label></td>
                    <td>
                        Zip</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFZIP") %>'></asp:Label></td>
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
                            Text='<%# Eval("MIRRORSTATUSNAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        PKS No.</td>
                    <td>
                        <asp:Label ID="JFPKSNOLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSNO") %>'></asp:Label></td>
                    <td>
                        PKS Date</td>
                    <td>
                        <asp:Label ID="JFPKSDATELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPKSDATE", "{0:dd/MM/yyyy}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        PKS Title</td>
                    <td colspan="3">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFPKSTITLE") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Admin Type</td>
                    <td>
                        (<asp:Label ID="JFADMINTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFADMINTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMINTYPENAME") %>'></asp:Label></td>
                    <td>
                        Admin</td>
                    <td>
                        <asp:Label ID="JFADMINLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFADMIN") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Provison Type</td>
                    <td>
                        (<asp:Label ID="JFPROVISIONTYPELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPE") %>'></asp:Label>)
                        <asp:Label ID="JFPROVISIONTYPENAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISIONTYPENAME") %>'></asp:Label></td>
                    <td>
                        Provision</td>
                    <td>
                        <asp:Label ID="JFPROVISIONLabel" runat="server" Font-Bold="True" Font-Underline="True"
                            Text='<%# Eval("JFPROVISION") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        Early Payment
                    </td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFEARLYPAYMENTNAME") %>'></asp:Label></td>
                    <td>
                        First Payment Type</td>
                    <td>
                        (<asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPE") %>'></asp:Label>)
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFFIRSTPAYMENTTYPENAME") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="ShowDetail" colspan="4">
                        <hr />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList><asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, JF.JFPORTION, JF.JFMIRRORSTATUS, dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS MIRRORSTATUSNAME, JF.JFPKSNO, JF.JFPKSDATE, JF.JFADMINTYPE, dbo.f_getParamGlobalName('JFADMINTYPE', JF.JFADMINTYPE) AS JFADMINTYPENAME, JF.JFADMIN, JF.JFPROVISIONTYPE, dbo.f_getParamGlobalName('JFPROVISIONTYPE', JF.JFPROVISIONTYPE) AS JFPROVISIONTYPENAME, JF.JFPROVISION, JF.JFADDRESS, JF.JFCITY, JF.JFZIP, JF.JFEARLYPAYMENT, dbo.f_getParamGlobalName('JFEARLYPAYMENT', JF.JFEARLYPAYMENT) AS JFEARLYPAYMENTNAME, JF.JFFIRSTPAYMENTTYPE, dbo.f_getParamGlobalName('JFFIRSTPAYMENTTYPE', JF.JFFIRSTPAYMENTTYPE) AS JFFIRSTPAYMENTTYPENAME, JF.JFPKSTITLE FROM JF INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF.JFID = @JFID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DataList ID="dlMerk" runat="server" Caption="MERK/BRAND INFO" DataKeyField="MERKID"
        DataSourceID="sdsMerk" Width="100%">
        <ItemTemplate>
            Merk/Brand ID :
            <asp:Label ID="MERKIDLabel" runat="server" Font-Bold="True" Font-Underline="True"
                Text='<%# Eval("MERKID") %>'></asp:Label>
            Merk/Brand Code :
            <asp:Label ID="MERKCODELabel" runat="server" Font-Bold="True" Font-Underline="True"
                Text='<%# Eval("MERKCODE") %>'></asp:Label><br />
            Merk/Brand Name :
            <asp:Label ID="MERKNAMELabel" runat="server" Font-Bold="True" Font-Underline="True"
                Text='<%# Eval("MERKNAME") %>'></asp:Label><br />
            JF Merk Code (Merk/Brand Maping) :
            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text='<%# Eval("JFMERKCODE") %>'></asp:Label>
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="sdsMerk" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT MERK.MERKID, MERK.MERKCODE, MERK.MERKNAME, MERKJF.JFMERKCODE FROM MERK INNER JOIN MERKJF ON MERK.MERKID = MERKJF.MERKID WHERE (MERK.MERKID = @MERKID) AND (MERKJF.JFID = @JFID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="MERKID" QueryStringField="MERKID" />
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvModel" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" Caption="JF MODEL MAPPING" DataSourceID="sdsModel"
        Width="100%" DataKeyNames="MODELID" RowHeaderColumn="MODELID">
        <Columns>
            <asp:BoundField DataField="MODELID" HeaderText="ID" SortExpression="MODELID" />
            <asp:BoundField DataField="MODELCODE" HeaderText="Model&lt;br&gt;Code" HtmlEncode="False"
                SortExpression="MODELCODE" />
            <asp:BoundField DataField="MODELNAME" HeaderText="Model&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="MODELNAME" />
            <asp:TemplateField HeaderText="JF&lt;br&gt;Model&lt;br&gt;Code" SortExpression="JFMODELCODE">
                <ItemTemplate>
                    <asp:TextBox ID="txtJFModelCode" runat="server" Text='<%# Bind("JFMODELCODE") %>' MaxLength="20"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsModel" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT MODEL.MERKID, MODEL.MODELID, MODEL.MODELCODE, MODEL.MODELNAME, MODELJF.JFID, MODELJF.JFMODELCODE FROM MODEL LEFT OUTER JOIN MODELJF ON MODEL.MODELID = MODELJF.MODELID AND MODEL.Deletests = 0 AND MODELJF.JFID = @JFID WHERE (MODEL.MERKID = @MERKID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
            <asp:QueryStringParameter Name="MERKID" QueryStringField="MERKID" />
        </SelectParameters>
    </asp:SqlDataSource>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
FormatTable("<%=gvModel.ClientID%>")
</script>

    <br />
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCESAve" runat="server" TargetControlID="pnlSave"
        VerticalSide="Bottom">
    </ajaxToolkit:AlwaysVisibleControlExtender>
    <asp:Panel ID="pnlSave" runat="server" CssClass="HeaderStyle" Width="100%">
        <asp:Button ID="btnSave" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
            cursor: pointer; background-repeat: no-repeat;  text-align: left"
            Text="Save" Width="56px" /></asp:Panel>
</asp:Content>

