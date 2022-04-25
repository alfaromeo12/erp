<%@ Page Title="Collector DPD" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectDPD.aspx.vb" Inherits="Param_CollectDPD" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
      <ajaxToolkit:textboxwatermarkextender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
                                WatermarkText="%%"></ajaxToolkit:textboxwatermarkextender>
                            <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail">
                                <div style="float: right; vertical-align: middle">
                                    <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
                                    <asp:Label ID="lblShow" runat="server">(Show Details...)</asp:Label>
                                </div>
                                <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
                                        background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
                                <ajaxToolkit:collapsiblepanelextender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
                                    CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Detail...)" Enabled="True"
                                    ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Detail...)"
                                    ImageControlID="imgButtonShow" TargetControlID="pnlSearchMaintenance" 
                                    TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
                                     
                                     <asp:Panel ID="pnlSearchMaintenance" runat="server">
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="width: 115px">
                                                    <asp:DropDownList ID="ddlCriteria" runat="server">
                                                        <asp:ListItem Value="COLLECTORDPDNAME">Collector DPD Name</asp:ListItem>
                                                        <asp:ListItem Value="COLLECTORDPDCODE">Collector DPD Code</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                                                        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
                                                        border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
                                                        Text="Search" CausesValidation="False" CssClass="Search" />
                                                    &nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 115px">
                                                    &nbsp;</td>
                                                <td>
                                     
                                                </td>
                                            </tr>
                                        </table>
                                            <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                                 CommandName="New" CausesValidation="False" Height="19px" />
                                        </asp:Panel>
                                        <asp:Panel ID="pnlData" runat="server">
                                        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                                            AutoGenerateColumns="False" DataKeyNames="COLLECTORDPDID" 
                                             DataSourceID="sdsGrid" Width="100%" 
                                            Caption="Collector DPD List" RowHeaderColumn="COLLECTORDPDID">
                                            <Columns>
                                                  <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                    </asp:CommandField>
                                                  <asp:BoundField DataField="COLLECTORDPDID" HeaderText="ID" ReadOnly="True" 
                                                      SortExpression="COLLECTORDPDID" />
                                                <asp:BoundField DataField="COLLECTORDPDCODE" HeaderText="DPD Code" 
                                                      SortExpression="COLLECTORDPDCODE" >
                                                  </asp:BoundField>
                                                <asp:BoundField DataField="COLLECTORDPDNAME" HeaderText="DPD Name"  SortExpression="COLLECTORDPDNAME" />
                                                <asp:BoundField DataField="DPDFROM" HeaderText="DPD From" 
                                                      ItemStyle-HorizontalAlign="Center" SortExpression="DPDFROM" >
                                                  <ItemStyle HorizontalAlign="Center" />
                                                  </asp:BoundField>
                                                <asp:BoundField DataField="DPDTO" HeaderText="DPD To" 
                                                      ItemStyle-HorizontalAlign="Center" SortExpression="DPDTO" >
                                                  <ItemStyle HorizontalAlign="Center" />
                                                  </asp:BoundField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                </asp:Panel>
                            <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                SelectCommand="SELECT COLLECTORDPDID,COLLECTORDPDCODE, '(' + COLLECTORDPDCODE + ') ' + COLLECTORDPDNAME as COLLECTORDPDNAME,DPDFROM,DPDTO 
                                                FROM COLLECTORDPD WHERE (DELETESTS = 0)">
                            </asp:SqlDataSource>
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
                            <script type="text/javascript" src="../include/TableHighLight.js"></script>
                                <script type="text/javascript">
                                    FormatTable("<%=gvData.ClientID%>")
                            </script>
                     <asp:FormView ID="fvCollectDpd" runat="server" DataSourceID="sdsCollectDpd"
                            DefaultMode="Edit" Width="100%" DataKeyNames="COLLECTORDPDID">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            Collector DPD. Id</td>
                                        <td>
                                            <asp:Label ID="lblCollDPDID" runat="server" Text='<%# Eval("COLLECTORDPDID") %>'></asp:Label></td>
                                    </tr>
                                   
                                    <tr>
                                        <td width="20%">
                                            Collector DPD. Code</td>
                                        <td>
                                            <asp:TextBox ID="txtCollCode" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("COLLECTORDPDCODE") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtCollCode" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD. CODE] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Collector DPD. Name</td>
                                        <td>
                                            <asp:TextBox ID="txtCollName" runat="server" Width="250px" MaxLength="50" 
                                                Text='<%# Bind("COLLECTORDPDNAME") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollName" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD. NAME] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                      <tr>
                                        <td width="20%">
                                            DPD From</td>
                                        <td>
                                            <asp:TextBox ID="txtCollFrom" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("DPDFROM") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqFrom" runat="server" ControlToValidate="txtCollFrom" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD From] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEFrom" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqFrom"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            DPD To</td>
                                        <td>
                                            <asp:TextBox ID="txtCollTo" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("DPDTO") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqTo" runat="server" ControlToValidate="txtCollTo" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD To] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCETo" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqTo"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" >
                                            <hr />
                                        </td>
                                    </tr>
                                </tr>
                                    <tr>
                                        <td class="FooterStyle" colspan="2">
                                            &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                                            <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </EditItemTemplate>
                             <InsertItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            Collector DPD. Code</td>
                                        <td>
                                            <asp:TextBox ID="txtCollCode" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("COLLECTORDPDCODE") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtCollCode" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD. CODE] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Collector DPD. Name</td>
                                        <td>
                                            <asp:TextBox ID="txtCollName" runat="server" Width="250px" MaxLength="50" 
                                                Text='<%# Bind("COLLECTORDPDNAME") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollName" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD. NAME] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                      <tr>
                                        <td width="20%">
                                            DPD From</td>
                                        <td>
                                            <asp:TextBox ID="txtCollFrom" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("DPDFROM") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqFrom" runat="server" ControlToValidate="txtCollFrom" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD From] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEFrom" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqFrom"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            DPD To</td>
                                        <td>
                                            <asp:TextBox ID="txtCollTo" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("DPDTO") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqTo" runat="server" ControlToValidate="txtCollTo" 
                                                    Display="None" ErrorMessage="[COLLECTOR DPD To] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCETo" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqTo"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="FooterStyle">
                                            <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>
                    <asp:SqlDataSource ID="sdsCollectDPD" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT  COLLECTORDPDID,COLLECTORDPDCODE ,COLLECTORDPDNAME,DPDFROM,DPDTO FROM COLLECTORDPD WHERE (Deletests = 0) AND (COLLECTORDPDID = @COLLECTORDPDID)" 
                    DeleteCommand="UPDATE COLLECTORDPD SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  (COLLECTORDPDID = @COLLECTORDPDID)" 
                    UpdateCommand="COLLECTORDPDUpdate" InsertCommand="COLLECTORDPDAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORDPDID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORDPDID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLECTORDPDID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="COLLECTORDPDCODE" Type="String" />
                        <asp:Parameter Name="COLLECTORDPDNAME" Type="String" />
                        <asp:Parameter Name="DPDFROM" Type="Int32" />
                        <asp:Parameter Name="DPDTO" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="COLLECTORDPDCODE" Type="String" />
                        <asp:Parameter Name="COLLECTORDPDNAME" Type="String" />
                        <asp:Parameter Name="DPDFROM" Type="Int32" />
                        <asp:Parameter Name="DPDTO" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
</asp:Content>

