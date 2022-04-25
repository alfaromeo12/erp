<%@ Page Title="Collector - Warning Letter" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="CollectWarningLetter.aspx.vb" Inherits="Param_CollectWarningLetter" %>
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
                                                        <asp:ListItem Value="PARAMGLOBAL.NAME">Warning Type Name</asp:ListItem>
                                                        <asp:ListItem Value="WARNINGLETTERDAY.WARNTYPE">Warning Type Code</asp:ListItem>
                                                        <asp:ListItem Value="WARNINGLETTERDAY.DAYFROM">Day From</asp:ListItem>
                                                        <asp:ListItem Value="WARNINGLETTERDAY.DAYUNTIL">Day Until</asp:ListItem>
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
                                                 CommandName="New" CausesValidation="False" Height="19px" 
                                             Visible="False" />
                                        </asp:Panel>
                                        <asp:Panel ID="pnlData" runat="server" Width="600px">
                                        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                                            AutoGenerateColumns="False" DataKeyNames="WARNTYPE" 
                                             DataSourceID="sdsGrid" Width="100%" 
                                            Caption="Warning Letter Day List" RowHeaderColumn="WARNTYPE">
                                            <Columns>
                                                  <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                    </asp:CommandField>
                                                <asp:BoundField DataField="WARNTYPE" HeaderText="Warning &lt;br&gt; Type Code" 
                                                    SortExpression="WARNTYPE" HtmlEncode="False" >
                                                  <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                  </asp:BoundField>
                                                <asp:BoundField DataField="WARNTYPENAME" 
                                                      HeaderText="Warning &lt;br&gt; Type Name" 
                                                      SortExpression="WARNTYPENAME" HtmlEncode="False" />
                                                <asp:BoundField DataField="DAYFROM" HeaderText="Day &lt;br&gt; From"  
                                                      SortExpression="DAYFROM" HtmlEncode="False" >
                                                  <ItemStyle HorizontalAlign="Right" />
                                                  </asp:BoundField>
                                                <asp:BoundField DataField="DAYUNTIL" HeaderText="Day&lt;br&gt;Until" 
                                                      ItemStyle-HorizontalAlign="Center" SortExpression="DAYUNTIL" 
                                                      HtmlEncode="False" >
                                                  <ItemStyle HorizontalAlign="Right" />
                                                  </asp:BoundField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                </asp:Panel>
                            <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                
          
          SelectCommand="SELECT WARNINGLETTERDAY.WARNTYPE, dbo.f_getParamGlobalName('WARNTYPE', WARNINGLETTERDAY.WARNTYPE) AS WARNTYPENAME, WARNINGLETTERDAY.DAYFROM, WARNINGLETTERDAY.DAYUNTIL FROM WARNINGLETTERDAY INNER JOIN PARAMGLOBAL ON PARAMGLOBAL.CODE = WARNINGLETTERDAY.WARNTYPE WHERE (PARAMGLOBAL.TYPE = 'WARNTYPE')">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblError" runat="server" Width="600px" 
          Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" 
          Visible="False"></asp:Label>
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
                     <asp:FormView ID="fvCollectDpd" runat="server" DataSourceID="sdsData"
                            DefaultMode="Edit" Width="600px" DataKeyNames="WARNTYPE">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            Warning Type Id</td>
                                        <td>
                                            <asp:Label ID="lblWarningTypeID" runat="server" Text='<%# Bind("WARNTYPE") %>'></asp:Label></td>
                                    </tr>
                                   
                                    <tr>
                                        <td width="20%">
                                            Warning Type Name</td>
                                        <td>
                                            <asp:Label ID="lblWarningTypeNm" runat="server" 
                                                Text='<%# Eval("WARNTYPENAME") %>'></asp:Label>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Day From</td>
                                        <td>
                                            <asp:TextBox ID="txtDayFrom" runat="server" Width="50px" MaxLength="5" 
                                                Text='<%# Bind("DAYFROM") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqDayFrom" runat="server" ControlToValidate="txtDayFrom" 
                                                    Display="None" ErrorMessage="[DAY FROM] must be entry...!" 
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqDayFrom"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                      <tr>
                                        <td width="20%">
                                            Day Until</td>
                                        <td>
                                            <asp:TextBox ID="txtDayUntil" runat="server" Width="50px" MaxLength="5" 
                                                Text='<%# Bind("DAYUNTIL") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqDayUntil" runat="server" ControlToValidate="txtDayUntil" 
                                                    Display="None" ErrorMessage="[DAY UNTIL] must be entry...!" 
                                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEFrom" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqDayUntil"></ajaxToolkit:ValidatorCalloutExtender>
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
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </EditItemTemplate>
                        </asp:FormView>
                    <asp:SqlDataSource ID="sdsData" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT WARNTYPE, dbo.f_getParamGlobalName('WARNTYPE', WARNTYPE) AS WARNTYPENAME, DAYFROM, DAYUNTIL FROM WARNINGLETTERDAY WHERE (WARNTYPE = @WARNTYPE)" 
                    
          UpdateCommand="UPDATE WARNINGLETTERDAY SET DAYFROM = @DAYFROM,DAYUNTIL = @DAYUNTIL, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  (WARNTYPE = @WARNTYPE)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="WARNTYPE" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="DAYFROM" />
                        <asp:Parameter Name="DAYUNTIL" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Name="WARNTYPE" />
                    </UpdateParameters>
                </asp:SqlDataSource>
</asp:Content>

