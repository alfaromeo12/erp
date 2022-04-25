<%@ Page Title="Collector Group" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="CollectGroup.aspx.vb" Inherits="Param_CollectGroup" %>
<%@ Register Src="~/usercontrol/btncancel.ascx" TagPrefix="uc" TagName="BtnCancel" %>
<%@ Register Src="~/usercontrol/btninsert.ascx" TagPrefix="uc" TagName="BtnInsert" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>
<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
<ajaxToolkit:textboxwatermarkextender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
                                WatermarkText="%%"></ajaxToolkit:textboxwatermarkextender>
                               <asp:Label ID="lblCommand" runat="server" Text="Label" Visible="False"></asp:Label>     
                                <asp:Label ID="lblIndex" runat="server" Text="Label" Visible="False"></asp:Label>           
                                <asp:Label ID="lblKey" runat="server" Text="Label" Visible="False"></asp:Label>  
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
                                                        <asp:ListItem Value="COLLGROUPNAME">Collector Group Name</asp:ListItem>
                                                        <asp:ListItem Value="COLLGROUPCODE">Collector Group Code</asp:ListItem>
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
                                                <td colspan="2">
                                                    <hr />
                                                </td>
                                            </tr>
                                        </table>
                                            <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                                 CommandName="New" CausesValidation="False" Height="19px" />
                                       </asp:Panel>
                                       <asp:Panel ID="pnlData" runat="server">
                                        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                                            AutoGenerateColumns="False" DataKeyNames="COLLGROUPID" 
                                             DataSourceID="sdsGrid" Width="100%" 
                                            Caption="Collector Group List" RowHeaderColumn="COLLGROUPID">
                                            <Columns>
                                                <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                </asp:CommandField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnViewDtl" runat="server" 
                                                                CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' ToolTip="Collector Group Detail.."
                                                                 CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/CollGroupDtl.png" 
                                                                 OnCommand="btnViewDtl_Command" Enabled="True" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="COLLGROUPID" HeaderText="ID" ReadOnly="True" 
                                                    SortExpression="COLLGROUPID" />
                                                <asp:BoundField DataField="COLLGROUPCODE" 
                                                    HeaderText="Collector&lt;br&gt;Group Code" SortExpression="COLLGROUPCODE" 
                                                    HtmlEncode="False" />
                                                <asp:BoundField DataField="COLLGROUPNAME" 
                                                    HeaderText="Collector&lt;br&gt;Group Name"  SortExpression="COLLGROUPNAME" 
                                                    HtmlEncode="False" />
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                </asp:Panel>
                            <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                
        SelectCommand="SELECT COLLGROUPID, COLLGROUPCODE, COLLGROUPNAME AS COLLGROUPNAME FROM COLLECTORGROUP WITH (nolock) WHERE (Deletests = 0)">
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
                     <asp:FormView ID="fvCollectGroup" runat="server" DataSourceID="sdsCollectGroup"
                            DefaultMode="Edit" Width="100%" DataKeyNames="COLLGROUPID">
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%">
                                            Collector Group. Id</td>
                                        <td>
                                            <asp:Label ID="lblCollDPDID" runat="server" Text='<%# Eval("COLLGROUPID") %>'></asp:Label></td>
                                    </tr>
                                   
                                    <tr>
                                        <td width="20%">
                                            Collector Group. Code</td>
                                        <td>
                                            <asp:TextBox ID="txtCollCode" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("COLLGROUPCODE") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtCollCode" 
                                                    Display="None" ErrorMessage="[COLLECTOR GROUP. CODE] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Collector Group. Name</td>
                                        <td>
                                            <asp:TextBox ID="txtCollName" runat="server" Width="250px" MaxLength="50" 
                                                Text='<%# Bind("COLLGROUPNAME") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollName" 
                                                    Display="None" ErrorMessage="[COLLECTOR GROUP. NAME] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                   <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
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
                                            Collector Group. Code</td>
                                        <td>
                                            <asp:TextBox ID="txtCollCode" runat="server" Width="50px" MaxLength="10" 
                                                Text='<%# Bind("COLLGROUPCODE") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtCollCode" 
                                                    Display="None" ErrorMessage="[COLLECTOR GROUP. CODE] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td width="20%">
                                            Collector Group. Name</td>
                                        <td>
                                            <asp:TextBox ID="txtCollName" runat="server" Width="250px" MaxLength="50" 
                                                Text='<%# Bind("COLLGROUPNAME") %>' CssClass="required"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollName" 
                                                    Display="None" ErrorMessage="[COLLECTOR GROUP. NAME] must be entry...!" 
                                                    SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                                HighlightCssClass="ErrHighLight"
                                                 TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr />
                                        </td>
                                    </tr>
                                      <tr>
                                        <td colspan="2" class="FooterStyle">
                                            <uc7:BtnInsert ID="BtnInsert1" runat="server" />
                                            <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>
                    <asp:SqlDataSource ID="sdsCollectGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT  COLLGROUPID,COLLGROUPCODE ,COLLGROUPNAME FROM COLLECTORGROUP WHERE (Deletests = 0) AND (COLLGROUPID = @COLLGROUPID)" 
                    DeleteCommand="UPDATE COLLECTORGROUP SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  (COLLGROUPID = @COLLGROUPID)" 
                    UpdateCommand="COLLECTORGROUPUpdate" InsertCommand="COLLECTORGROUPAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="COLLGROUPCODE" Type="String" />
                        <asp:Parameter Name="COLLGROUPNAME" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="COLLGROUPCODE" Type="String" />
                        <asp:Parameter Name="COLLGROUPNAME" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="COLLGROUPID" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                
             
                <asp:Panel ID="pnlGroupDtl" runat="server" Visible="false">
                      <asp:FormView ID="fvCollectGrpDtl" runat="server" 
                          DataSourceID="sdsCollGroupInfo" Width="100%" Caption="Collector Group Detail" 
                          DataKeyNames="COLLGROUPID">
                            <ItemTemplate>
                                  <table cellpadding="0" cellspacing="0" width="100%">
                                      <tr>
                                            <td width="20%">
                                                Collector Group ID :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCollGrpId" runat="server" Font-Bold="true" Font-Underline="true"  Text='<%# Eval("COLLGROUPID") %>'></asp:Label>
                                            </td>
                                      </tr>
                                      <tr>
                                            <td width="20%">
                                                Collector Group Name :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCollGrpNm" runat="server" Font-Bold="true" Font-Underline="true" Text='<%# Eval("COLLGROUPNAME") %>'></asp:Label>
                                            </td>
                                      </tr>
                                  </table>
                            </ItemTemplate>
                      </asp:FormView>
                      <asp:UpdatePanel ID="UpdListBox" runat="server">
                        <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
                               <tr>
                                <td colspan="3">
                                    <hr />
                                </td>
                            </tr>
                             <tr>
                                    <td class="ShowDetail" style="text-align: center">
                                        
                                           Branch List</td>
                                    <td width="40" class="FooterStyle">  
                                         &nbsp;</td>
                                    <td class="ShowDetail" style="text-align: center">
                                        
                                           Branch Selected</td>
                             </tr>
                               <tr>
                                   <td style="text-align: right">
                                       <asp:ListBox ID="lvbBranch" Runat="server" DataSourceID="sdsBranchInfo" 
                                           DataTextField="BRANCHNAME" DataValueField="BRANCHID" Height="150px" Rows="10" 
                                           SelectionMode="Multiple" Width="250px" />
                                   </td>
                                   <td class="FooterStyle" style="vertical-align: middle; text-align: center;" 
                                       width="40">
                                       <p style="vertical-align: middle">
                                           <asp:Button ID="btnMove" runat="server"  Text="&gt;&gt;" />
                                       </p>
                                       <p>
                                           <asp:Button ID="btnBack" runat="server"  Text="&lt;&lt;" />
                                       </p>
                                   </td>
                                   <td>
                                       <asp:ListBox ID="lvbGroupDtl" runat="server" DataSourceID="sdsGroupDtl" 
                                           DataTextField="BRANCHNAME" DataValueField="BRANCHID" Height="150px" 
                                           SelectionMode="Multiple" width="250px" />
                                   </td>
                               </tr>
                            <tr>
                                <td colspan="3">
                                    <hr />
                                </td>
                            </tr>
                                <tr>
                                <td colspan="3" class="FooterStyle">
                                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
                                    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
                                    Visible="False" Width="100%"></asp:Label>
                            <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="lblMessage">
                                 <Animations>
                                    <OnLoad>
                                        <Sequence>
                                            <Pulse Duration="0.5" Iterations="0" />
                                        </Sequence>
                                    </OnLoad>
                                </Animations>
                                </ajaxToolkit:AnimationExtender>

                                    <asp:Button ID="btnSave" runat="server"
                                    Style="font-size: 8pt; cursor: pointer;   
                                    background-position: left; background-image: url(../images/Save.gif); 
                                    background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                        Width="55px" />
    
                                   <asp:Button ID="btnCancel" runat="server"
                                    Style="font-size: 8pt; cursor: pointer;  
                                    background-position: left; background-image: url(../Images/back.png);
                                    cursor: pointer; background-repeat: no-repeat;  text-align: right"
                                    Text="Back" Width="55px" />
                                </td>
                            </tr>
                       </table>
                       </ContentTemplate>
                      </asp:UpdatePanel>    
                <asp:SqlDataSource ID="sdsCollGroupInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    
                          SelectCommand="SELECT COLLGROUPID, COLLGROUPCODE, '(' + COLLGROUPCODE + ') ' + COLLGROUPNAME AS COLLGROUPNAME FROM COLLECTORGROUP WITH (NOLOCK) WHERE (COLLGROUPID = @COLLGROUPID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsBranchInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                 
                          SelectCommand="SELECT BRANCHID, BRANCHCODE, BRANCHCODE + ' - ' + BRANCHNAME AS BRANCHNAME FROM BRANCH WITH (NOLOCK) WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM COLLECTORGROUPDTL WITH (NOLOCK) WHERE (BRANCHID = BRANCH.BRANCHID) AND (Deletests = 0) AND (COLLGROUPID = @COLLGROUPID))) ORDER BY BRANCHCODE">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                          PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>   
                <asp:SqlDataSource ID="sdsGroupDtl" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                    
                          SelectCommand="SELECT BRC.BRANCHID, BRC.BRANCHCODE, (SELECT BRC.BRANCHCODE + ' - ' + BRC.BRANCHNAME AS BRANCHNAME FROM COLLECTORGROUPDTL WITH (NOLOCK) WHERE (BRANCHID = BRC.BRANCHID) AND (Deletests = 0) AND (COLLGROUPID = @COLLGROUPID)) AS BRANCHNAME FROM BRANCH AS BRC INNER JOIN COLLECTORGROUPDTL AS CGD ON BRC.BRANCHID = CGD.BRANCHID WHERE (CGD.Deletests = 0) AND (CGD.COLLGROUPID = @COLLGROUPID) ORDER BY BRC.BRANCHCODE">
                   <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsCollGroupDtl" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT CD.BRANCHID, BR.BRANCHCODE, BR.BRANCHCODE + ' - ' + BR.BRANCHNAME AS BRANCHNAME FROM COLLECTORGROUPDTL AS CD WITH (NOLOCK) INNER JOIN BRANCH AS BR WITH (NOLOCK) ON BR.BRANCHID = CD.BRANCHID WHERE (CD.Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM COLLECTORGROUPDTL WITH (nOLOCK) WHERE (BRANCHID = CD.BRANCHID) AND (Deletests = 0) AND (COLLGROUPID = @COLLGROUPID))) ORDER BY BR.BRANCHCODE" 
                    DeleteCommand="UPDATE COLLECTORGROUPDTL SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  (COLLGROUPID = @COLLGROUPID) AND (BRANCHID = @BRANCHID)" 
                    UpdateCommand="COLLECTORGROUPDTLAdd" InsertCommand="COLLECTORGROUPDTLAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="lvbGroupDtl" Name="BRANCHID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="lvbGroupDtl" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                          <asp:ControlParameter ControlID="gvData" Name="COLLGROUPID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="lvbGroupDtl" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                </asp:Panel>  
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

    function MoveItem(ctrlSource, ctrlTarget) {
        var Source = document.getElementById(ctrlSource);
        var Target = document.getElementById(ctrlTarget);
        if ((Source != null) && (Target != null)) {
            while (Source.options.selectedIndex >= 0) {
                var newOption = new Option(); // Create a new instance of ListItem
                newOption.text = Source.options[Source.options.selectedIndex].text;
                newOption.value = Source.options[Source.options.selectedIndex].value;

                Target.options[Target.length] = newOption; //Append the item in Target
                Target.options.add = newOption;
                Source.remove(Source.options.selectedIndex);  //Remove the item from Source
                
            }
        }

    }
       
    </script>

</asp:Content>

