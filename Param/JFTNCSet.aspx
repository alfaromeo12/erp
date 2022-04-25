<%@ Page Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="JFTNCSet.aspx.vb" Inherits="Param_JFTNCSet" title="JF TNC SETTING" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc5" %>
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
    </asp:DataList>
    <asp:HiddenField ID="hidJFID" runat="server" />
    <asp:SqlDataSource ID="sdsJF" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT JF.JFID, JF.JFCODE, JF.JFNAME, JFGROUP.JFGROUPCODE, JFGROUP.JFGROUPNAME, JF.JFPORTION, JF.JFMIRRORSTATUS, dbo.f_getParamGlobalName('JFMIRRORSTATUS', JF.JFMIRRORSTATUS) AS MIRRORSTATUSNAME, JF.JFPKSNO, JF.JFPKSDATE, JF.JFADMINTYPE, dbo.f_getParamGlobalName('JFADMINTYPE', JF.JFADMINTYPE) AS JFADMINTYPENAME, JF.JFADMIN, JF.JFPROVISIONTYPE, dbo.f_getParamGlobalName('JFPROVISIONTYPE', JF.JFPROVISIONTYPE) AS JFPROVISIONTYPENAME, JF.JFPROVISION, JF.JFADDRESS, JF.JFCITY, JF.JFZIP, JF.JFEARLYPAYMENT, dbo.f_getParamGlobalName('JFEARLYPAYMENT', JF.JFEARLYPAYMENT) AS JFEARLYPAYMENTNAME, JF.JFFIRSTPAYMENTTYPE, dbo.f_getParamGlobalName('JFFIRSTPAYMENTTYPE', JF.JFFIRSTPAYMENTTYPE) AS JFFIRSTPAYMENTTYPENAME, JF.JFPKSTITLE FROM JF INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (JF.JFID = @JFID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
        </SelectParameters>
    </asp:SqlDataSource>
              <asp:UpdatePanel ID="UpdListBoxF" runat="server" 
        UpdateMode="Conditional">
                  <ContentTemplate>
                      <table cellpadding="0" cellspacing="0" width="100%">
                          <tr>
                              <th class="HeaderStyle" colspan="3">
                                  Term and Condition</th>
                          </tr>
                          <tr style="vertical-align: middle">
                              <td class="FooterStyle">
                                  TNC List</td>
                              <td style="vertical-align: middle" width="20px" class="FooterStyle">
                                  &nbsp;</td>
                              <td class="FooterStyle">
                                  TNC Selected</td>
                          </tr>
                          <tr style="vertical-align: middle">
                              <td>
                                  <asp:ListBox ID="lvbTNCSrc" Runat="server" DataSourceID="sdsTNCSrc" 
                                      DataTextField="JFTNCNAME" DataValueField="JFTNCID" Height="150px" Rows="10" 
                                      SelectionMode="Multiple" Width="250px" />
                                  <asp:SqlDataSource ID="sdsTNCSrc" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:connection %>" 
                                      SelectCommand="SELECT JFTNCID, '(' + JFTNCCODE + ') ' + JFTNCNAME AS JFTNCNAME FROM JFTNC WITH (NOLOCK) WHERE (DeleteSts = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM JFREQUESTTNC WITH (NOLOCK) WHERE (DeleteSts = 0) AND (JFTNCID = JFTNC.JFTNCID) AND (JFID = @JFID)))">
                                      <SelectParameters>
                                          <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                              </td>
                              <td style="vertical-align: middle" width="20px">
                                  <p>
                                      <asp:Button ID="btnMoveTNC" runat="server" Text="&gt;&gt;" />
                                      <asp:Button ID="btnBackTNC" runat="server" Text="&lt;&lt;" />
                                  </p>
                                  <p>
                                      &nbsp;
                                  </p>
                              </td>
                              <td>
                                  <asp:ListBox ID="lvbTNCDest" runat="server" DataSourceID="sdsTNCDest" 
                                      DataTextField="JFTNCNAME" DataValueField="JFTNCID" Height="150px" 
                                      SelectionMode="Multiple" width="250px" />
                                  <asp:SqlDataSource ID="sdsTNCDest" runat="server" 
                                      ConnectionString="<%$ ConnectionStrings:connection %>" 
                                      SelectCommand="SELECT JFREQUESTTNC.JFTNCID, '(' + JFTNC.JFTNCCODE + ') ' + JFTNC.JFTNCNAME AS JFTNCNAME FROM JFREQUESTTNC WITH (NOLOCK) INNER JOIN JFTNC WITH (NOLOCK) ON JFREQUESTTNC.JFTNCID = JFTNC.JFTNCID WHERE (JFREQUESTTNC.DeleteSts = 0) AND (JFREQUESTTNC.JFID = @JFID)">
                                      <SelectParameters>
                                          <asp:QueryStringParameter Name="JFID" QueryStringField="JFID" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                              </td>
                          </tr>
                          <tr>
                              <td width="10%">
                                  &nbsp;</td>
                              <td width="5%">
                                  &nbsp;</td>
                              <td width="85%">
                                  &nbsp;</td>
                          </tr>
                          <tr>
                              <td>
                              </td>
                          </tr>
                          <tr>
                              <td colspan="3">
                                  <hr />
                              </td>
                          </tr>
                      </table>
                  </ContentTemplate>
            </asp:UpdatePanel>

    <asp:Label ID="lblError" runat="server" Font-Bold="False"
        Style="text-align: center" Width="100%" CssClass="ErrHighLight"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>              
    <asp:Button ID="btnSave" runat="server" Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" 
                Text="Save" ToolTip="Save" Width="70px" 
        onclientclick="return CheckUserSPVSaveTNC();" />
    <br />
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    function CheckUserSPVSaveTNC() {
        var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
        if (RetVal.Login == 1)
            return (true);
        else
            return (false);
    }
</script>
</asp:Content>

