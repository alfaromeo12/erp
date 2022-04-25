<%@ Page Title="Param FN - Admin Fee" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" EnableEventValidation="false"  CodeFile="fnAdmin.aspx.vb" Inherits="Param_fnAdmin" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
 
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
                ImageControlID="imgButtonShow" TargetControlID="pnlData" 
                TextLabelID="lblShow"></ajaxToolkit:collapsiblepanelextender>
            <asp:TextBox ID="txtTmpSelectedIndex" runat="Server" style="display:none" Text="0" />    
            <asp:CheckBox ID="chkEditPos" runat="Server" style="display:none" Checked="false" />     
            <asp:HiddenField ID="hidAction" runat="server" /> 
            <asp:HiddenField ID="hidFnFiduciaryID" runat="server" /> 
                    <asp:Panel ID="pnlData" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                         <tr class="HeaderStyle" >
                            <td style="width: 115px" class="ShowDetail">
                                Criteria
                            </td>
                            <td class="ShowDetail">
                                <asp:RadioButton ID="rdbNonDealer" runat="server"  Text="Non Dealer" GroupName="Criteria" />
                                <asp:RadioButton ID="rdbDealer" runat="server"  Text="Dealer" GroupName="Criteria" />
                            </td>
                        </tr>
                        <tr id="divProduct">
                            <td style="width: 115px" class="RowStyle">
                               Product
                            </td>
                            <td class="RowStyle">
                                <asp:DropDownList ID="ddlProduct" runat="server" CssClass="required" 
                                     DataTextField="PRODUCTNAME" 
							        DataValueField="PRODUCTID" DataSourceID="sdsProduct" ValidationGroup="ValSearch"  >
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="reqProduct" runat="server" 
                                        ControlToValidate="ddlProduct" Display="None" 
                                        ErrorMessage="[PRODUCT] must be entry...!" SetFocusOnError="True" 
                                    ValidationGroup="ValSearch"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEProduct" runat="server" 
                                    HighlightCssClass="ErrHighLight" TargetControlID="reqProduct">
                                </ajaxToolkit:ValidatorCalloutExtender>
                                  <asp:SqlDataSource ID="sdsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                    
                                    SelectCommand="SELECT NULL AS PRODUCTID, NULL AS PRODUCTCODE, '[CHOOSE PRODUCT]' AS PRODUCTNAME UNION ALL SELECT PRODUCTID, PRODUCTCODE, PRODUCTCODE + ' - ' + PRODUCTNAME AS PRODUCTNAME FROM PRODUCT WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY PRODUCTCODE">
                                </asp:SqlDataSource>
 
                            </td>
                        </tr>
                         <tr id="divArea">
                            <td style="width: 115px" class="AlternatingRowStyle">
                               Area
                            </td>
                            <td class="AlternatingRowStyle" >
                                <asp:DropDownList ID="ddlArea" runat="server" CssClass="required"  
                                    DataSourceID="sdsArea" DataTextField="AREANAME" DataValueField="AREAID" 
                                    ValidationGroup="ValSearch" >
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="reqArea" runat="server" 
                                       ControlToValidate="ddlArea" Display="None" 
                                        ErrorMessage="[AREA] must be entry...!" SetFocusOnError="True" 
                                    ValidationGroup="ValSearch"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEArea" runat="server" 
                                    HighlightCssClass="ErrHighLight" TargetControlID="reqArea">
                                </ajaxToolkit:ValidatorCalloutExtender>
                                   <asp:SqlDataSource ID="sdsArea" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                    
                                    SelectCommand="SELECT NULL AS AREAID, NULL AS AREACODE, '[CHOOSE AREA]' AS AREANAME UNION ALL SELECT AREAID, AREACODE, AREACODE + ' - ' + AREANAME AS AREANAME FROM AREA WITH (NOLOCK) WHERE (DELETESTS = 0) ORDER BY AREACODE">
                                </asp:SqlDataSource>
                                
                            </td>
                        </tr>
                        <tr id="divDealer" style="display:none" >
                            <td style="width: 115px" class="FooterStyle">
                               Dealer
                            </td>
                            <td class="FooterStyle">
                          <asp:TextBox ID="txtSearchDealer" Width="250px"  Text='<%# Eval("DEALERNAME") %>' 
                                    CssClass="required" runat="server" ValidationGroup="ValSearch"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqSearchDealer" runat="server" 
                                        ControlToValidate="txtSearchDealer" Display="None" 
                                        ErrorMessage="[DEALER. ID] must be entry...!" SetFocusOnError="True" 
                                    ValidationGroup="ValSearch"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCESearchDealer" runat="server" 
                                    HighlightCssClass="ErrHighLight" TargetControlID="reqSearchDealer">
                                </ajaxToolkit:ValidatorCalloutExtender>

                                  <input id="btnFindDealer" noenter onclick="DealerFind();" style="background-position: left;
						background-image: url(../images/search.gif); width: 45px; cursor: pointer; background-repeat: no-repeat;
						 text-align: right" type="button" value="Find" />

                                <input id="btnClearDealer" onclick="DealerClear();" style="background-position: left;
							background-image: url(../images/clear.png); width: 45px; cursor: pointer; background-repeat: no-repeat;
							 text-align: right" type="button" noenter value="Clear" />
						        <asp:HiddenField ID="hidDealer" runat="server" Value='<%# Bind("DEALERID") %>' />
                            </td>
                        </tr>
                        <tr class="FooterStyle" >
                            <td style="width: 115px" class="HeaderStyle">
                                <asp:Button
                                    ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
                                    border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
                                    Text="Search" CssClass="Search" ValidationGroup="ValSearch" />
                            </td>
                            <td>
                                     
                            </td>
                        </tr>
                         <tr>
                             <td style="width: 115px">
                                 &nbsp;</td>
                             <td>
                                 &nbsp;</td>
                         </tr>
                    </table>
                    </asp:Panel>
                <asp:SqlDataSource ID="sdsOperator" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
            SelectCommand="SELECT NULL AS CODE, NULL AS NAME UNION ALL SELECT CODE, NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'OPERATOR')">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT DEALERID, AREAID, PRODUCTID, ADMINID, TENOROPR1, TENORFROM, TENOROPR2, TENORTO, PRINCIPALOPR1, PRINCIPALFROM, PRINCIPALOPR2, PRINCIPALTO, ADMINFEE, REMARK FROM FNADMIN WITH (NOLOCK) WHERE (DeleteSts = 0)" 
            UpdateCommand="FNADMINupdate" UpdateCommandType="StoredProcedure" 
            
            
            DeleteCommand="UPDATE FNADMIN SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE ADMINID=@ADMINID">
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="USERID" />
                        <asp:ControlParameter ControlID="gvData" Name="ADMINID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="ADMINID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="hidDealer" Name="DEALERID" 
                            PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlArea" Name="AREAID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlProduct" Name="PRODUCTID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="TENOROPR1" Type="String" />
                        <asp:Parameter Name="TENORFROM" Type=Int32 />
                        <asp:Parameter Name="TENOROPR2" Type="String" />
                        <asp:Parameter Name="TENORTO" Type="Int32" />
                        <asp:Parameter Name="PRINCIPALOPR1" Type="String" />
                        <asp:Parameter Name="PRINCIPALFROM" Type="Decimal" />
                        <asp:Parameter Name="PRINCIPALOPR2" Type="String" />
                        <asp:Parameter Name="PRINCIPALTO" Type="Decimal" />
                        <asp:Parameter Name="ADMINFEE" Type="Decimal" />
                        <asp:Parameter Name="REMARK" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="RETVAL" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
            CommandName="New" CausesValidation="False" Height="19px" />
        <br />
               <asp:GridView ID="gvData" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BorderWidth="1px"  Caption="Admin List" DataKeyNames="ADMINID" 
                          OnRowCreated="gvData_RowCreated"  OnRowCancelingEdit="gvData_RowCancelingEdit" 
                            OnRowEditing="gvData_RowEditing"
                    Width="99%" DataSourceID="sdsAdmin" >
                        <Columns>
                                <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:label ID="lblAdminIdKey" runat="server" Visible="false" 
                                                Text='<% #DataBinder.Eval(Container.DataItem,"ADMINID") %>' />
                                    </ItemTemplate>
                            </asp:TemplateField>
                               
                              <asp:TemplateField HeaderText="EDIT" ShowHeader="False" > 
                                <Itemstyle  Width="55px" HorizontalAlign="Center" />
                                <ItemTemplate > 
                                    <asp:ImageButton ID="btnEdit" style="cursor:pointer" runat="server"
                                    ImageUrl="~/Images/edit.gif" CausesValidation="False" CommandName="Edit"
                                      Text="Edit" ImageAlign= "Middle" >
                                    </asp:ImageButton> 
                                </ItemTemplate>                                            
                                <EditItemTemplate > 
                                    <asp:ImageButton ID="btnSave" style="cursor:pointer" runat="server" 
                                        ImageUrl="~/Images/Save.gif" 
                                        CommandName="Update" Text="Update"></asp:ImageButton> 
                                    <asp:ImageButton ID="btnCancel" style="cursor:pointer" runat="server" ImageUrl="~/Images/cancel.gif" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:ImageButton> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:ImageButton ID="btnInsert" style="cursor:pointer"  runat="server" 
                                        CommandName="AddNew" Text="Add New" ImageUrl="~/Images/Save.gif" ImageAlign= "Middle"
                                                    OnCommand = "btnInsert_Command">
                                    </asp:ImageButton>  
                                    <asp:ImageButton ID="btnCancelNew" runat="server" CausesValidation="False" 
                                        ImageUrl="~/Images/cancel.gif" onclick="btnCancelNew_Click" 
                                        style="cursor:pointer" Text="Cancel" />
                                </FooterTemplate>                                              
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="DEL" ShowHeader="False" > 
                                <Itemstyle  Width="50px" HorizontalAlign="Center" />
                                <ItemTemplate> 
                                    <asp:ImageButton ID="btnDelete" style="cursor:pointer" runat="server" ImageUrl="~/Images/delete.gif"
                                     CausesValidation="False" CommandName="Delete" Text="Delete" ImageAlign= "Middle" 
                                     OnClientClick="return confirm('Are you sure remove this record ?');" ></asp:ImageButton> 
                                </ItemTemplate> 
                            </asp:TemplateField>       
                            <asp:TemplateField HeaderText="FROM" >
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblOprFrTenor" runat="server" style="text-align:right" Text='<%# Eval("TENOROPR1")%>' ></asp:Label> 
                                </ItemTemplate>                                        
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlOprFrTenor" runat="server"
                                    DataTextField="NAME" DataValueField="CODE" CssClass="required" 
                                        DataSourceID="sdsOperator" SelectedValue='<%# Bind("TENOROPR1") %>' ></asp:DropDownList> 
                                      <asp:RequiredFieldValidator ID="reqOprFrTenor" runat="server" 
						                ControlToValidate="ddlOprFrTenor" Display="None" 
						                ErrorMessage="Operator From Tenor must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOprFrTenor" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqOprFrTenor">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </EditItemTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewOprFrTenor" runat="server" DataSourceID="sdsOperator"
                                          CssClass="required"  DataValueField ='<%# Eval("CODE") %>' 
                                        DataTextField="NAME"></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqNewOprFrTenor" runat="server" 
						                ControlToValidate="ddlNewOprFrTenor" Display="None" 
						                ErrorMessage="Operator From Tenor must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENewOprFrTenor" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqNewOprFrTenor">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </FooterTemplate> 
                            </asp:TemplateField>                                                                                                           
                            <asp:TemplateField > 
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblTenorFrom" runat="server" style="text-align:right" Text='<%# Eval("TENORFROM")%>' ></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtTenorFrom" runat="server" style="text-align:right" 
                                        CssClass="required" Text='<%# Bind("TENORFROM") %>' Width="50px" ></asp:TextBox> 
                                     <asp:RequiredFieldValidator ID="reqtxtTenorFrom" runat="server" 
						                ControlToValidate="txtTenorFrom" Display="None" 
						                ErrorMessage="Tenor From must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEtxtTenorFrom" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqtxtTenorFrom">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </EditItemTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewTenorFrom" runat="server" CssClass="required" 
                                        style="text-align:right" Width="50px" ></asp:TextBox> 
                                       <asp:RequiredFieldValidator ID="reqtxtNewTenorFrom" runat="server" 
						                ControlToValidate="txtNewTenorFrom" Display="None" 
						                ErrorMessage="Tenor From must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEtxtNewTenorFrom" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqtxtNewTenorFrom">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </FooterTemplate> 
                            </asp:TemplateField>                                        
                              <asp:TemplateField HeaderText="TO" >
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblOprToTenor" runat="server" style="text-align:right" Text ='<%# Eval("TENOROPR2")%>'></asp:Label> 
                                </ItemTemplate>                                        
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlOprToTenor" runat="server"  
                                    DataValueField ="CODE" DataTextField="NAME" DataSourceID="sdsOperator" 
                                        SelectedValue='<%# Bind("TENOROPR2") %>'></asp:DropDownList> 
                                </EditItemTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewOprToTenor" runat="server" DataSourceID="sdsOperator" DataValueField ='<%# Eval("CODE")%>' DataTextField="NAME"></asp:DropDownList> 
                                </FooterTemplate> 
                            </asp:TemplateField>    
                             <asp:TemplateField > 
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblTenorTo" runat="server" style="text-align:right" Text='<%# Eval("TENORTO") %>'></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtTenorTo" runat="server"  style="text-align:right" 
                                        Text='<%# Bind("TENORTO") %>' Width="50px" ></asp:TextBox> 
                                </EditItemTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewTenorTo" runat="server" style="text-align:right" 
                                        Width="50px" ></asp:TextBox> 
                                </FooterTemplate> 
                            </asp:TemplateField>  
                              <asp:TemplateField HeaderText="FROM">
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblOprFromPrcipal" runat="server" style="text-align:right" Text='<%# Eval("PRINCIPALOPR1") %>'></asp:Label> 
                                </ItemTemplate>                                        
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlOprFromPrincipal" runat="server" 
                                    CssClass="required" DataValueField ="CODE" DataTextField="NAME" 
                                        DataSourceID="sdsOperator" SelectedValue='<%# Bind("PRINCIPALOPR1") %>'></asp:DropDownList> 
                                    <asp:RequiredFieldValidator ID="reqOprFromPrcipal" runat="server" 
						                ControlToValidate="ddlOprFromPrincipal" Display="None" 
						                ErrorMessage="Operator From Principal must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOprFromPrcipal" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqOprFromPrcipal">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </EditItemTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewOprFromPrcipal" runat="server" CssClass="required" DataSourceID="sdsOperator" DataValueField ='<%# Eval("CODE")%>' DataTextField="NAME"></asp:DropDownList> 
                                       <asp:RequiredFieldValidator ID="reqNewOprFromPrcipal" runat="server" 
						                ControlToValidate="ddlNewOprFromPrcipal" Display="None" 
						                ErrorMessage="Operator From Principal must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENewOprFromPrcipal" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqNewOprFromPrcipal">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </FooterTemplate> 
                            </asp:TemplateField>
                               <asp:TemplateField  > 
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblPrincipalFrom" runat="server" style="text-align:right"  Text='<%# Eval("PRINCIPALFROM","{0:n}") %>'></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtPrincipalFrom" runat="server"  style="text-align:right" 
                                    CssClass="required" Text='<%# Bind("PRINCIPALFROM", "{0:N}") %>' ></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="reqPrincipalFrom" runat="server" 
						                ControlToValidate="txtPrincipalFrom" Display="None" 
						                ErrorMessage="Principal From must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEPrincipalFrom" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqPrincipalFrom">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </EditItemTemplate> 
                                <FooterStyle  HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewPrincipalFrom" runat="server" CssClass="required" style="text-align:right" ></asp:TextBox> 
                                       <asp:RequiredFieldValidator ID="reqNewPrincipalFrom" runat="server" 
						                ControlToValidate="txtNewPrincipalFrom" Display="None" 
						                ErrorMessage="Principal From must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENewPrincipalFrom" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqNewPrincipalFrom">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </FooterTemplate> 
                            </asp:TemplateField>     
                           
                             <asp:TemplateField HeaderText="TO">
                                <Itemstyle HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblOprToPrcipal" runat="server" style="text-align:right" Text='<%# Eval("PRINCIPALOPR2") %>'></asp:Label> 
                                </ItemTemplate>                                        
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlOprToPrincipal" runat="server"  DataValueField ="CODE" 
                                        DataTextField="NAME" DataSourceID="sdsOperator" 
                                        SelectedValue='<%# Bind("PRINCIPALOPR2") %>'></asp:DropDownList> 
                                </EditItemTemplate> 
                                <FooterStyle  HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewOprToPrcipal" runat="server" DataSourceID="sdsOperator" DataValueField ='<%# Eval("CODE")%>' DataTextField="NAME"></asp:DropDownList> 
                                </FooterTemplate> 
                            </asp:TemplateField>
                               <asp:TemplateField > 
                                <Itemstyle  HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblPrincipalTo" runat="server" style="text-align:right" Text='<%# Eval("PRINCIPALTO","{0:n}") %>'></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtPrincipalTo" runat="server"  style="text-align:right" 
                                        Text='<%# Bind("PRINCIPALTO", "{0:N}") %>' ></asp:TextBox> 
                                </EditItemTemplate> 
                                <FooterStyle  HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewPrincipalTo" runat="server"  style="text-align:right" ></asp:TextBox> 
                                </FooterTemplate> 
                            </asp:TemplateField >     
                               <asp:TemplateField >
                                <Itemstyle  HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblFiduciaFee" runat="server" style="text-align:right" Text='<%# Eval("ADMINFEE","{0:n}") %>' ></asp:Label> 
                                </ItemTemplate>                                        
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtAdminFee" runat="server" style="text-align:right" 
                                        Text='<%# Bind("ADMINFEE", "{0:n}") %>' CssClass="required" ></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="reqAdminFee" runat="server" 
						                ControlToValidate="txtAdminFee" Display="None" 
						                ErrorMessage="Fiducia FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEAdminFee" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqAdminFee">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </EditItemTemplate> 
                                <FooterStyle  HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewAdminFee" runat="server" style="text-align:right" Text='<%# Eval("ADMINFEE","{0:n}")%>' ></asp:TextBox> 
                                     <asp:RequiredFieldValidator ID="reqNewAdminFee" runat="server" 
						                ControlToValidate="txtNewAdminFee" Display="None" 
						                ErrorMessage="Fiducia FEE must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENewAdminFee" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqNewAdminFee">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </FooterTemplate> 
                            </asp:TemplateField  >
                               <asp:TemplateField > 
                                <Itemstyle  HorizontalAlign="Right"/>
                                <ItemTemplate> 
                                    <asp:Label ID="lblDescription" runat="server" style="text-align:left" Text='<%# Eval("REMARK") %>'></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtDescription" runat="server" style="text-align:left" 
                                        Text='<%# Bind("REMARK") %>' TextMode="MultiLine" ></asp:TextBox> 
                                </EditItemTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewDescription" runat="server" style="text-align:left" TextMode="MultiLine" ></asp:TextBox> 
                                </FooterTemplate> 
                            </asp:TemplateField>   
                            
                        </Columns>
                          <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
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
    
   

<script type="text/javascript" src="../include/TableHighLight.js"></script>

<script type="text/javascript">
    var iDealer = 0;

    FormatTable("<%=gvData.ClientID%>")
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

    window.onload = function () {
        Load();
    }

    function Load() {
        if (getObjectbyClientID("<%=rdbNonDealer.ClientID%>").checked)
            iDealer = 0;
        else
            iDealer = 1;

        checkFlag();

        var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');
        /*
        if (Action == "LOAD") {
        checkFlag();
        }
        */
        if (Action == "NEW") {
            CheckAddNew(0);
        }
        if (Action == "EDIT") {
            CheckAddNew(1);

        }
        /*
        if (Action == "SEARCH") {
        checkFlag();
        }

        */
    }

    function DealerFind() {
        WinRef = window.open("../Param/DealerFind.aspx?Action=Find", "DealerFind", "height=500,width=650,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable")
        WinRef.focus();
    }

    function SetDealer(DealerID, Dealer) {
        SetValueTxtByClientID("<%=hidDealer.ClientID%>", DealerID);
        SetValueTxtByClientID("<%=txtSearchDealer.ClientID%>", Dealer);
    }

    function DealerClear() {
        SetValueTxtByClientID("<%=hidDealer.ClientID%>", "");
        SetValueTxtByClientID("<%=txtSearchDealer.ClientID%>", "");
    }

    function checkFlag() {
        var rowProduct = getObjectbyClientID("divProduct");
        var rowArea = getObjectbyClientID("divArea");
        var rowDealer = getObjectbyClientID("divDealer");
        var oDivrdbNonDealer = getObjectbyClientID('<%=rdbNonDealer.ClientID%>');
        var oDivrdbDealer = getObjectbyClientID('<%=rdbDealer.ClientID%>');
        var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');

        switch (iDealer.toString()) {
            case "1":

                ValidatorEnable(getObjectbyClientID("<%=reqSearchDealer.ClientID%>"), true);
                ValidatorEnable(getObjectbyClientID("<%=reqProduct.ClientID%>"), false);
                ValidatorEnable(getObjectbyClientID("<%=reqArea.ClientID%>"), false);
                RemoveRequired(getObjectbyClientID("<%=ddlproduct.ClientID%>"));
                RemoveRequired(getObjectbyClientID("<%=ddlArea.ClientID%>"));
                AddRequired(getObjectbyClientID("<%=txtSearchDealer.ClientID%>"));
                rowProduct.style.display = "none";
                rowArea.style.display = "none";
                rowDealer.style.display = "";
                getObjectbyClientID('<%= ddlProduct.ClientID%>').value = "";
                getObjectbyClientID('<%= ddlArea.ClientID%>').value = "";

                break
            case "0":

                ValidatorEnable(getObjectbyClientID("<%=reqSearchDealer.ClientID%>"), false);
                ValidatorEnable(getObjectbyClientID("<%=reqProduct.ClientID%>"), true);
                ValidatorEnable(getObjectbyClientID("<%=reqArea.ClientID%>"), true);
                AddRequired(getObjectbyClientID("<%=ddlproduct.ClientID%>"));
                AddRequired(getObjectbyClientID("<%=ddlArea.ClientID%>"));
                RemoveRequired(getObjectbyClientID("<%=txtSearchDealer.ClientID%>"));
                rowProduct.style.display = "";
                rowArea.style.display = "";
                rowDealer.style.display = "none";
                getObjectbyClientID('<%=hidDealer.ClientID%>').value = "";
                getObjectbyClientID('<%=txtSearchDealer.ClientID%>').value = "";

        }
    }

    function CheckAddNew(add) {

        if (add == "0") { // add
            ValidatorEnable(getObjectbyClientID("<%=oStrreqNewOprFrTenor%>"), true);
            ValidatorEnable(getObjectbyClientID("<%=oStrreqtxtNewTenorFrom%>"), true);
            ValidatorEnable(getObjectbyClientID("<%=oStrreqNewOprFromPrcipal%>"), true);
            ValidatorEnable(getObjectbyClientID("<%=oStrreqNewPrincipalFrom%>"), true);
            AddRequired(getObjectbyClientID("<%=oStrddlNewOprFrTenor%>"));
            AddRequired(getObjectbyClientID("<%=oStrtxtNewTenorFrom%>"));
            AddRequired(getObjectbyClientID("<%=oStrddlNewOprFromPrcipal%>"));
            AddRequired(getObjectbyClientID("<%=oStrtxtNewPrincipalFrom%>"));
        } else { // edit
            if (getObjectbyClientID("<%=oStrreqNewOprFrTenor%>"))
                ValidatorEnable(getObjectbyClientID("<%=oStrreqNewOprFrTenor%>"), false);
            if (getObjectbyClientID("<%=oStrreqtxtNewTenorFrom%>"))
                ValidatorEnable(getObjectbyClientID("<%=oStrreqtxtNewTenorFrom%>"), false);
            if (getObjectbyClientID("<%=oStrreqNewOprFromPrcipal%>"))
                ValidatorEnable(getObjectbyClientID("<%=oStrreqNewOprFromPrcipal%>"), false);
            if (getObjectbyClientID("<%=oStrreqNewPrincipalFrom%>"))
                ValidatorEnable(getObjectbyClientID("<%=oStrreqNewPrincipalFrom%>"), false);

            if (getObjectbyClientID("<%=oStrddlNewOprFrTenor%>"))
                RemoveRequired(getObjectbyClientID("<%=oStrddlNewOprFrTenor%>"));
            if (getObjectbyClientID("<%=oStrtxtNewTenorFrom%>"))
                RemoveRequired(getObjectbyClientID("<%=oStrtxtNewTenorFrom%>"));
            if (getObjectbyClientID("<%=oStrddlNewOprFromPrcipal%>"))
                RemoveRequired(getObjectbyClientID("<%=oStrddlNewOprFromPrcipal%>"));
            if (getObjectbyClientID("<%=oStrtxtNewPrincipalFrom%>"))
                RemoveRequired(getObjectbyClientID("<%=oStrtxtNewPrincipalFrom%>"));
        }

    }
    function RemoveRequired(o) {
        o.className = "";
    }

    function AddRequired(o) {
        o.className = "required";
    }

    function SetCriteria(iCriteria) {

        if (iCriteria != iDealer) {
            if (getObjectbyClientID('<%=gvData.ClientID%>'))
                getObjectbyClientID('<%=gvData.ClientID%>').style.display = "none";
            if (getObjectbyClientID('<%=btnNew.ClientID%>'))
                getObjectbyClientID('<%=btnNew.ClientID%>').style.display = "none";
        }
        iDealer = iCriteria;
    }

    /*
    function ConfirmSave() {
    if (Page_ClientValidate("")) {

    if (!(confirm('Are you sure save this data?'))) {
    return (false);
    } else {
    return (true);
    }

    } else {
    return (false);
    }

     

    } */ 
</script>
</asp:Content>

