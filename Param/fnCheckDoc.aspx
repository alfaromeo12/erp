<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="fnCheckDoc.aspx.vb" Inherits="Param_fnCheckDoc" %>
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
                    <asp:Panel ID="pnlData" runat="server">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        
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
                      
                       <tr class="FooterStyle" >
                            <td style="width: 115px">
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
                <asp:SqlDataSource ID="sdsBranch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
            SelectCommand="SELECT NULL AS BRANCHID, NULL AS BRANCHCODE, '(' + 'ALL BRANCH' + ')' AS BRANCHNAME UNION ALL SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' - ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY BRANCHCODE">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsCheckDoc" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT CHECKDOCID,PRODUCTID,CD.AREAID,CD.BRANCHID ,
                                ISNULL((SELECT '(' + BR.BRANCHCODE + ') ' + BR.BRANCHNAME AS Expr1 
                                        FROM BRANCH WHERE (BRANCHID = CD.BRANCHID) AND (Deletests = 0)),'(ALL BRANCH)') AS BRANCHNAME 
                                        ,CHECKDOCFEE, REMARK
                                FROM FNCHECKDOC CD WITH(NOLOCK)
                                LEFT JOIN BRANCH AS BR WITH(NOLOCK) ON BR.BRANCHID = CD.BRANCHID
                                WHERE CD.Deletests=0" 
            DeleteCommand="UPDATE FNCHECKDOC SET DELETESTS=1, LASTUPDATE=GETDATE(), LASTUSERID=@USERID WHERE CHECKDOCID=@CHECKDOCID" 
            UpdateCommand="FNCHECKDOCupdate" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="USERID" />
                        <asp:ControlParameter ControlID="gvData" Name="CHECKDOCID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="CHECKDOCID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlArea" Name="AREAID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlProduct" Name="PRODUCTID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="BRANCHID" Type="Int32" />
                        <asp:Parameter Name="CHECKDOCFEE" Type="Decimal" />
                        <asp:Parameter Name="REMARK" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="USERID" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="RETVAL" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
            CommandName="New" CausesValidation="False" Height="19px" />
        <br />
               <asp:GridView ID="gvData" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BorderWidth="1px"  Caption="Check Doc. List" DataKeyNames="CHECKDOCID" 
                        OnRowCancelingEdit="gvData_RowCancelingEdit" 
                         OnRowEditing="gvData_RowEditing" 
                          OnRowCommand="gvData_RowCommand" 
                    Width="100%" DataSourceID="sdsCheckDoc" >
                        <Columns>
                               <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:label ID="lblCheckDocIdKey" runat="server" Visible="false" 
                                                Text='<% #DataBinder.Eval(Container.DataItem,"CHECKDOCID") %>' />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            
                              <asp:TemplateField HeaderText="EDIT" ShowHeader="False" > 
                                <Itemstyle Width="50px" HorizontalAlign="Center" />
                                <ItemTemplate> 
                                    <asp:ImageButton ID="btnEdit" style="cursor:pointer" runat="server" ImageUrl="~/Images/edit.gif" CausesValidation="False" CommandName="Edit" Text="Edit" ImageAlign= "Middle">
                                    </asp:ImageButton> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:ImageButton ID="btnSave" style="cursor:pointer" runat="server" ImageUrl="~/Images/Save.gif" CausesValidation="false"  CommandName="Update" Text="Update"></asp:ImageButton> 
                                    <asp:ImageButton ID="btnCancel" style="cursor:pointer" runat="server" ImageUrl="~/Images/cancel.gif" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:ImageButton> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:ImageButton ID="btnInsert" style="cursor:pointer"  runat="server" 
                                        CausesValidation="true" CommandName="AddNew" Text="Add New" 
                                        ImageUrl="~/Images/Save.gif" ImageAlign= "Middle"
                                                    OnCommand = "btnInsert_Command">
                                    </asp:ImageButton>  
                                    <asp:ImageButton ID="btnCancelNew" runat="server" CausesValidation="False" 
                                        ImageUrl="~/Images/cancel.gif" onclick="btnCancelNew_Click" 
                                        style="cursor:pointer" Text="Cancel" />
                                </FooterTemplate>                                              
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="DEL" ShowHeader="False" HeaderStyle-Width="1%" > 
                                <ItemTemplate> 
                                    <asp:ImageButton ID="btnDelete" style="cursor:pointer" runat="server" ImageUrl="~/Images/delete.gif"
                                     CausesValidation="False" CommandName="Delete" Text="Delete" ImageAlign= "Middle" 
                                     OnClientClick="return confirm('Are you sure remove this record ?');" ></asp:ImageButton> 
                                </ItemTemplate> 


<HeaderStyle Width="1%"></HeaderStyle>


                                <Itemstyle HorizontalAlign="Center" />
                            </asp:TemplateField>       
                            <asp:TemplateField HeaderText="Branch" >
                                <ItemTemplate> 
                                    <asp:Label ID="lblBranchID" runat="server" 
                                        Text='<%# Bind("BRANCHNAME") %>' ></asp:Label> 
                                </ItemTemplate>                                        
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlBranch" runat="server"
                                    DataTextField="BRANCHNAME" DataValueField="BRANCHID" 
                                        SelectedValue='<%# Bind("BRANCHID") %>' DataSourceID="sdsBranch" ></asp:DropDownList> 
                                    
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewBranch" runat="server" DataSourceID="sdsBranch"  
                                        SelectedValue ='<%# Bind("BRANCHID") %>'   DataValueField="BRANCHID" 
                                        DataTextField="BRANCHNAME"></asp:DropDownList> 
                                </FooterTemplate> 
                            </asp:TemplateField>                                                                                                           
                            <asp:TemplateField HeaderText="Document Fee" > 
                                <ItemTemplate> 
                                    <asp:Label ID="lblDocFee" runat="server" style="text-align:right" 
                                        Text='<%# Eval("CHECKDOCFEE","{0:n}") %>' ></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtDocFee" runat="server" style="text-align:right" 
                                        CssClass="required" Text='<%# Bind("CHECKDOCFEE", "{0:n}") %>' ></asp:TextBox> 
                                     <asp:RequiredFieldValidator ID="reqtxtDocFee" runat="server" 
						                ControlToValidate="txtDocFee" Display="None" 
						                ErrorMessage="DOC Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEtxtDocFee" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqtxtDocFee">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewDocFee" runat="server" CssClass="required" 
                                        style="text-align:right" ></asp:TextBox> 
                                       <asp:RequiredFieldValidator ID="reqtxtNewDocFee" runat="server" 
						                ControlToValidate="txtNewDocFee" Display="None" 
						                ErrorMessage="DOC Fee must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator>
					                <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEtxtNewDocFee" runat="server" 
						                HighlightCssClass="ErrHighLight" TargetControlID="reqtxtNewDocFee">
					                </ajaxToolkit:ValidatorCalloutExtender>
                                </FooterTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>


                                <Itemstyle HorizontalAlign="Right"/>
                            </asp:TemplateField>                                        
                               <asp:TemplateField HeaderText="Remark" > 
                                <ItemTemplate> 
                                    <asp:Label ID="lblDescription" runat="server"  style="text-align:left" Text='<%# Eval("REMARK") %>'></asp:Label> 
                                </ItemTemplate>                                            
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtDescription" runat="server" Width="208px" 
                                        style="text-align:left" MaxLength="100" Text='<%# Bind("REMARK") %>' 
                                        Height="36px" TextMode="MultiLine" ></asp:TextBox> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewDescription" runat="server" Width="205px" 
                                        MaxLength="100" style="text-align:left" TextMode="MultiLine" Height="39px" ></asp:TextBox> 
                                </FooterTemplate> 
                                <FooterStyle HorizontalAlign="Right"/>


                                <Itemstyle  HorizontalAlign="Right"/>
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
        var Action = GetValueTxtByClientID('<%=hidAction.ClientID%>');

        if (Action == "NEW") {
            CheckAddNew(0);
        }
        if (Action == "EDIT") {
            CheckAddNew(1);

        }
      
    }



    function CheckAddNew(add) {
        if (add == "0") { // add
            ValidatorEnable(getObjectbyClientID("<%=oStrreqtxtNewDocFee%>"), true);
            AddRequired(getObjectbyClientID("<%=oStrtxtNewDocFee%>"));
           
        } else { // edit
            if (getObjectbyClientID("<%=oStrreqtxtNewDocFee%>"))
                ValidatorEnable(getObjectbyClientID("<%=oStrreqtxtNewDocFee%>"), false);
            if (getObjectbyClientID("<%=oStrtxtNewDocFee%>"))
                RemoveRequired(getObjectbyClientID("<%=oStrtxtNewDocFee%>"));
        }
    }
    function RemoveRequired(o) {
        o.className = "";
    }

    function AddRequired(o) {
        o.className = "required";
    }
</script>
</asp:Content>

