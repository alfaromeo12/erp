
<%@ Page  Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="ObjStorePlace.aspx.vb" Inherits="Param_ObjStorePlace" Title="Store Place" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsertNoSPV.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdateNoSPV.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>

<%@ Register src="../UserControl/BtnInsert.ascx" tagname="BtnInsert" tagprefix="uc7" %>

<%@ Register src="../UserControl/BtnUpdate.ascx" tagname="BtnUpdate" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
         <asp:MultiView ID="MultiView_Utama" runat="server"> 
             <asp:View ID="View_View" runat="server">   
                         <asp:Label ID="lblCommand" runat="server" Text="Label" Visible="False"></asp:Label>     
                        <asp:Label ID="lblIndex" runat="server" Text="Label" Visible="False"></asp:Label>           
                        <asp:Label ID="lblKey" runat="server" Text="Label" Visible="False"></asp:Label>  
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
                                                <asp:ListItem Value="BranchName">Branch Name</asp:ListItem>
                                                <asp:ListItem Value="BranchCode">Branch Code</asp:ListItem>
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
                                            Area</td>
                                        <td>
                                <asp:DropDownList ID="ddlAreaSearch" runat="server" DataSourceID="sdsAreaSearch"
                                    DataTextField="AREA" DataValueField="AREAID" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsAreaSearch" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                                    SelectCommand="SELECT NULL AS AREAID, 'ALL AREA' AS AREA UNION ALL SELECT AREAID, '(' + AREACODE + ') ' + AREANAME AS AREA FROM AREA WHERE (DELETESTS = 0)">
                                </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlData" runat="server">
                                <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" DataKeyNames="BRANCHID" DataSourceID="sdsGrid" 
                                     Width="100%" Caption="Branch List" RowHeaderColumn="BRANCHID">
                                    <Columns>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnViewStr" runat="server" 
                                                        CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                                         CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/safe.png" 
                                                         OnCommand="btnViewStr_Command" Enabled="True" />
                                        </ItemTemplate><ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BRANCHID" HeaderText="ID" SortExpression="BRANCHID" />
                                        <asp:BoundField DataField="BRANCHCODE" HeaderText="Code" SortExpression="BRANCHCODE" />
                                        <asp:BoundField DataField="BRANCHNAME" HeaderText="Name" SortExpression="BRANCHNAME" />
                                        <asp:BoundField DataField="AREA" HeaderText="Area" SortExpression="AREA" />
                                        <asp:BoundField DataField="BRANCHADDRESS" HeaderText="Address" SortExpression="BRANCHADDR" />
                                        <asp:BoundField DataField="BRANCHCITY" HeaderText="City" SortExpression="BRANCHCITY" />
                                        <asp:BoundField DataField="BRANCHPHONE" HeaderText="Phone" SortExpression="PHONE" />
                                        <asp:BoundField DataField="BRANCHFAX" HeaderText="Fax" SortExpression="BRANCHFAX" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                    </EmptyDataTemplate>
                                </asp:GridView>
                        </asp:Panel>
                    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        SelectCommand="SELECT AREAID, BRANCHID, BRANCHCODE, BRANCHNAME, BRANCHPHONE, BRANCHFAX, BRANCHADDRESS, 
                                            BRANCHCITY, AREA, NEW, Deletests, UPD FROM (SELECT BRANCH_1.BRANCHID, BRANCH_1.AREAID, 
                                            BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, BRANCH_1.BRANCHPHONE, BRANCH_1.BRANCHFAX, 
                                            BRANCH_1.BRANCHADDRESS, BRANCH_1.BRANCHCITY, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREA, CAST(0 AS BIT) AS NEW,
                                            BRANCH_1.Deletests, 
                                            CASE WHEN EXISTS (SELECT 'X' FROM BRANCHX WHERE BRANCH_1.BRANCHID = BRANCHX.BRANCHID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD 
                                        FROM BRANCH AS BRANCH_1 
                                        INNER JOIN AREA WITH (NOLOCK) ON BRANCH_1.AREAID = AREA.AREAID 
                                        WHERE (BRANCH_1.Deletests = 0) 
                                        UNION ALL 
                                        SELECT BRANCHX.BRANCHID, BRANCHX.AREAID, BRANCHX.BRANCHCODE, BRANCHX.BRANCHNAME,
                                             BRANCHX.BRANCHPHONE, BRANCHX.BRANCHFAX, BRANCHX.BRANCHADDRESS, 
                                             BRANCHX.BRANCHCITY, '(' + AREA_1.AREACODE + ') ' + AREA_1.AREANAME AS AREA, 
                                             CAST(1 AS BIT) AS NEW, BRANCHX.Deletests, CAST(0 AS BIT) AS UPD 
                                        FROM BRANCHX 
                                        INNER JOIN AREA AS AREA_1 WITH (NOLOCK) ON BRANCHX.AREAID = AREA_1.AREAID 
                                        WHERE (BRANCHX.Deletests = 0) 
                                            AND (NOT EXISTS (SELECT 'X' AS EXPR1 FROM BRANCH AS BRANCH_2 
                                            WHERE (BRANCHID = BRANCHX.BRANCHID)))) AS BRANCH WHERE (Deletests = 0)">
                    </asp:SqlDataSource>
                    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>

                    
                <script type="text/javascript" src="../include/TableHighLight.js"></script>
                    <script type="text/javascript">
                        FormatTable("<%=gvData.ClientID%>")
                    </script>
           
    </asp:View>
             <asp:View ID="View_Store" runat="server">   
              <asp:FormView ID="fvBranchInfo" runat="server" DataSourceID="sdsBranchInfo" 
                    Width="100%" DataKeyNames="BRANCHID" Caption="Branch Info">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 20%">
                                    <asp:Label ID="LblKodeCabang" runat="server" Text="ID :" Font-Bold="False" Font-Underline="False"></asp:Label>
                                </td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtIDCabang" runat="server"  Text='<%# Eval("BRANCHID") %>' Width="30%" Font-Bold="True" Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    <asp:Label ID="lblCodeCabang" runat="server" Text="Branch Code :" Font-Bold="False" Font-Underline="False"></asp:Label>
                                </td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtCodeCabang" runat="server" Width="70%" Font-Bold="True" Text='<%# Eval("BRANCHCODE") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    <asp:Label ID="lblNamaCabang" runat="server" Text="Branch Name :" Font-Bold="False" Font-Underline="False"></asp:Label>
                                </td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtNamaCabang" runat="server" Width="70%" Font-Bold="True" 
                                        Text='<%# Eval("BRANCHNAME") %>' Font-Underline="True" Height="19px"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 20%">
                                    <asp:Label ID="Label1" runat="server" Text="Branch Area :" Font-Bold="False" Font-Underline="False"></asp:Label>
                                </td>
                                <td style="width: 80%">
                                    <asp:Label ID="txtAreaCabang" runat="server" Width="50%" Font-Bold="True"
                                     Text='<%# Eval("AREA") %>' Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
              </asp:FormView>
                <asp:SqlDataSource ID="sdsBranchInfo" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT AREAID, BRANCHID, BRANCHCODE, BRANCHNAME, BRANCHPHONE, BRANCHFAX, BRANCHADDRESS, 
                                        BRANCHCITY, AREA, NEW, Deletests, UPD FROM (SELECT BRANCH_1.BRANCHID, BRANCH_1.AREAID, 
                                        BRANCH_1.BRANCHCODE, BRANCH_1.BRANCHNAME, BRANCH_1.BRANCHPHONE, BRANCH_1.BRANCHFAX, 
                                        BRANCH_1.BRANCHADDRESS, BRANCH_1.BRANCHCITY, '(' + AREA.AREACODE + ') ' + AREA.AREANAME AS AREA, CAST(0 AS BIT) AS NEW,
                                        BRANCH_1.Deletests, 
                                        CASE WHEN EXISTS (SELECT 'X' FROM BRANCHX WHERE BRANCH_1.BRANCHID = BRANCHX.BRANCHID) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS UPD 
                                    FROM BRANCH AS BRANCH_1 
                                    INNER JOIN AREA WITH (NOLOCK) ON BRANCH_1.AREAID = AREA.AREAID 
                                    WHERE (BRANCH_1.Deletests = 0) 
                                    UNION ALL 
                                    SELECT BRANCHX.BRANCHID, BRANCHX.AREAID, BRANCHX.BRANCHCODE, BRANCHX.BRANCHNAME,
                                         BRANCHX.BRANCHPHONE, BRANCHX.BRANCHFAX, BRANCHX.BRANCHADDRESS, 
                                         BRANCHX.BRANCHCITY, '(' + AREA_1.AREACODE + ') ' + AREA_1.AREANAME AS AREA, 
                                         CAST(1 AS BIT) AS NEW, BRANCHX.Deletests, CAST(0 AS BIT) AS UPD 
                                    FROM BRANCHX 
                                    INNER JOIN AREA AS AREA_1 WITH (NOLOCK) ON BRANCHX.AREAID = AREA_1.AREAID 
                                    WHERE (BRANCHX.Deletests = 0) 
                                        AND (NOT EXISTS (SELECT 'X' AS EXPR1 FROM BRANCH AS BRANCH_2 
                                        WHERE (BRANCHID = BRANCHX.BRANCHID)))) AS BRANCH WHERE (Deletests = 0) AND BRANCHID=@BRANCHID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
               <asp:ImageButton ID="btnNewStore" runat="server" ImageUrl="~/images/add.gif" 
                  CommandName="New" CausesValidation="False" Height="19px" />
                <asp:ImageButton ID="btnBackStore" runat="server" ImageUrl="~/images/backAcc.png" ToolTip="Back"
                  CommandName="Back" CausesValidation="False" Height="19px" />
                <asp:GridView ID="GvStorePlace" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="DOCSAFEID" DataSourceID="sdsSafeGrid" Width="100%" Caption="Store Place List" RowHeaderColumn="DOCSAFECODE">
                <Columns>
                    <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                    </asp:CommandField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnViewShelf" runat="server" CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' 
                                        CommandName="VIEW" ImageAlign="AbsMiddle" ImageUrl="~/Images/books.png" 
                                        OnCommand="btnViewShelf_Command" Enabled="True" />
                            </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="DOCSAFEID" HeaderText="ID" SortExpression="DOCSAFEID" />
                    <asp:BoundField DataField="DOCSAFECODE" HeaderText="Code" SortExpression="DOCSAFECODE" />
                    <asp:BoundField DataField="DOCSAFENAME" HeaderText="Name" SortExpression="DOCSAFECODE" />
                    <asp:BoundField DataField="DOCSAFEDESC" HeaderText="Desc" SortExpression="DOCSAFEDESC" />
                    <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" SortExpression="BRANCHNAME" />
                </Columns>
                <EmptyDataTemplate>
                    <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                </EmptyDataTemplate>
                </asp:GridView>
                   <script type="text/javascript" src="../include/TableHighLight.js"></script>
                    <script type="text/javascript">
                        FormatTable("<%=GvStorePlace.ClientID%>")
                    </script>
                 <asp:Label ID="lblErrorStore" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                <asp:FormView ID="fvDocStore" runat="server" DataSourceID="sdsSafe"
                    DefaultMode="Edit" Width="100%" DataKeyNames="DOCSAFEID">
                    <EditItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocSafe Id</td>
                                <td>
                                    <asp:Label ID="lblDOCSAFEID" runat="server" Text='<%# Eval("DOCSAFEID") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    DocSafe Code</td>
                                <td>
                                    <asp:TextBox ID="txtDocSafeCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("DOCSAFECODE") %>' CssClass="required"></asp:TextBox>
                                    <asp:RequiredFieldValidator
                                        ID="reqCode" runat="server" ControlToValidate="txtDocSafeCode" Display="None" ErrorMessage="[DOCSAFE CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocSafe Name</td>
                                <td>
                                    <asp:TextBox ID="txtDocSafeName" runat="server" Width="264px" MaxLength="50" Text='<%# Bind("DOCSAFENAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqName" runat="server" ControlToValidate="txtDocSafeName" Display="None" ErrorMessage="[DOCSAFE NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <tr>
                                    <td>
                                        DocSafe Description</td>
                                    <td>
                                        <asp:TextBox ID="txtDocSafeDesc" runat="server" MaxLength="1000" 
                                            Text='<%# Bind("DOCSAFEDESC") %>' Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="FooterStyle" colspan="2">
                                        &nbsp;<uc8:BtnUpdate ID="BtnUpdate2" runat="server" />
                                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <hr />
                                    </td>
                                </tr>
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
                                <td>
                                    DocSafe Code</td>
                                <td>
                                    <asp:TextBox ID="txtDocSafeCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("DOCSAFECODE") %>' CssClass="required"></asp:TextBox>
                                    <asp:RequiredFieldValidator
                                        ID="reqCode" runat="server" ControlToValidate="txtDocSafeCode" Display="None" ErrorMessage="[DOCSAFE CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocSafe Name</td>
                                <td>
                                    <asp:TextBox ID="txtDocSafeName" runat="server" Width="264px" MaxLength="70" 
                                        Text='<%# Bind("DOCSAFENAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqName" runat="server" ControlToValidate="txtDocSafeName" Display="None" ErrorMessage="[DOCSAFE NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocSafe Description</td>
                                <td>
                                    <asp:TextBox ID="txtDocSafeDesc" runat="server" 
                                        MaxLength="200" Text='<%# Bind("DOCSAFEDESC") %>' Width="300px"></asp:TextBox>
                                </td>
                            <tr>
                                <td colspan="2">
                                    &nbsp;</td>
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
                <asp:SqlDataSource ID="sdsSafeGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT SF.DOCSAFEID, SF.DOCSAFECODE, SF.DOCSAFENAME, SF.DOCSAFEDESC, 
	                                    (SELECT '(' + BR.BRANCHCODE + ') ' + BR.BRANCHNAME AS Expr1 
		                                    FROM BRANCH WHERE (BRANCHID = SF.BRANCHID) AND (Deletests = 0)) AS BRANCHNAME ,
		                                    BR.BRANCHID, BR.BRANCHCODE
                                    FROM DOCSAFE  AS SF WITH(NOLOCK)
                                    INNER JOIN BRANCH AS BR WITH(NOLOCK) ON BR.BRANCHID = SF.BRANCHID
                                    WHERE (SF.Deletests = 0) AND (BR.BRANCHID = @BRANCHID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsSafe" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT DOCSAFEID, DOCSAFECODE, DOCSAFENAME, DOCSAFEDESC, BRANCHID FROM DOCSAFE AS SF WHERE (Deletests = 0) AND (DOCSAFEID = @DOCSAFEID)" 
                    DeleteCommand="UPDATE DOCSAFE SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (BRANCHID = @BRANCHID) AND (DOCSAFEID=@DOCSAFEID)" 
                    UpdateCommand="DOCSAFEUpdate" InsertCommand="DOCSAFEAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                        <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="DOCSAFEID" Type="Int32" />
                        <asp:Parameter Name="DOCSAFECode" Type="String" />
                        <asp:Parameter Name="DOCSAFEName" Type="String" />
                        <asp:Parameter Name="DOCSAFEDESC" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="DOCSAFECode" Type="String" />
                        <asp:Parameter Name="DOCSAFEName" Type="String" />
                        <asp:Parameter Name="DOCSAFEDesc" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
      </asp:View>
             <asp:View ID="View_DocShelf" runat="server">  
                <asp:FormView ID="fvBranchSafeInfo" runat="server" DataSourceID="sdsBranchAndDoc" 
                    Width="100%" DataKeyNames="DOCSAFEID,BRANCHID" Caption="Branch And Doc Safe Info">
                    <ItemTemplate>
                       <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 15%">
                                    ID Cabang :</td>
                                <td style="width: 35%">
                                    <asp:Label ID="lblIdCabang" runat="server" Font-Bold="True" Text='<%# Eval("BRANCHID") %>' 
                                       Font-Underline="True"></asp:Label>
                                </td>
                                <td style="width: 15%">
                                    Branch Code :</td>
                                <td style="width: 35%">
                                    <asp:Label ID="lblKdCabang_DocSelf" runat="server" Font-Bold="True"  Text='<%# Eval("BRANCHCODE") %>' 
                                        Font-Underline="True"></asp:Label>
                                </td>

                            </tr>
                             <tr>
                                <td style="width: 15%">
                                    Branch Name :</td>
                                <td style="width: 35%">
                                      <asp:Label ID="lblNmCabang_DocSelf" runat="server" Font-Bold="True"  Text='<%# Eval("BRANCHNAME") %>'
                                        Font-Underline="True"></asp:Label>
                                </td>
                                <td style="width: 15%">
                                    Branch Area :</td>
                                <td style="width: 35%">
                                    <asp:Label ID="lblAreaCabang_DocSelf" runat="server"   Text='<%# Eval("AREANAME") %>' 
                                        Font-Bold="True" Font-Underline="True"></asp:Label>
                                    
                                </td>
                            </tr>
                             <tr>
                                <td style="width: 15%">
                                      Doc. Safe Id :</td>
                                <td style="width: 35%">
                                   <asp:Label ID="lblDocSafeID" runat="server" Width="70%" Font-Bold="True" Text='<%# Eval("DOCSAFEID") %>' 
                                        Font-Underline="True"></asp:Label>
                                </td>
                                 <td style="width: 15%">
                                     Doc. Safe</td>
                                <td style="width: 35%">
                                    <asp:Label ID="lblDocSafeName" runat="server" Font-Bold="True" Text='<%# Eval("DOCSAFENAME") %>'
                                        Font-Underline="True"></asp:Label>
                                </td>
                            </tr>
                            
                       </table>
                    </ItemTemplate>
                </asp:FormView>
                  <asp:SqlDataSource ID="sdsBranchAndDoc" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT  SF.DOCSAFEID, SF.DOCSAFECODE,
                                        (SELECT '(' + SF.DOCSAFECODE + ') ' + SF.DOCSAFENAME AS DOCSAFE 
                                            FROM DOCSAFE WHERE (DOCSAFEID =SF.DOCSAFEID) AND (Deletests = 0)) AS DOCSAFENAME  
                                            , BR.BRANCHID,BR.BRANCHNAME,AREA_1.AREAID,AREANAME,BR.BRANCHCODE
                                    FROM DOCSAFE  AS SF WITH(NOLOCK)
                                    INNER JOIN BRANCH AS BR WITH(NOLOCK) ON SF.BRANCHID = BR.BRANCHID
                                    INNER JOIN AREA AS AREA_1 WITH (NOLOCK) ON BR.AREAID = AREA_1.AREAID 
                                    WHERE (SF.Deletests = 0)AND (SF.DOCSAFEID=@DOCSAFEID) ">
                    <SelectParameters>
                         <asp:ControlParameter ControlID="gvData" Name="BRANCHID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                         <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:ImageButton ID="btnNewShelf" runat="server" ImageUrl="~/images/add.gif" 
                                        CommandName="New" CausesValidation="False" />
                 <asp:ImageButton ID="btnBackShelf" runat="server" ImageUrl="~/images/backAcc.png" ToolTip="Back"
                                        CommandName="Back" CausesValidation="False"  Height="19px" />
                  <asp:GridView ID="GvShelf" runat="server" AllowPaging="True" AllowSorting="True"
                                        AutoGenerateColumns="False" DataKeyNames="DOCSHELFID" 
                           DataSourceID="sdsShelfGrid" Width="100%" Caption="Store Shelf List" 
                           RowHeaderColumn="DOCSHELFCODE">
                                    <Columns>
                                        <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                        <ItemStyle HorizontalAlign="Center" Width="30px" /></asp:CommandField>
                                        <asp:BoundField DataField="DOCSHELFID" HeaderText="ID" SortExpression="DOCSHELFID" />
                                        <asp:BoundField DataField="DOCSHELFCODE" HeaderText="Code" SortExpression="DOCSHELFCODE" />
                                        <asp:BoundField DataField="DOCSHELFNAME" HeaderText="Name" SortExpression="DOCSHELFNAME" />
                                        <asp:BoundField DataField="DOCSHELFDESC" HeaderText="Desc" SortExpression="DOCSHELFDESC" />
                                        <asp:BoundField DataField="DOCSAFENAME" HeaderText="Safe Name" SortExpression="DOCSAFENAME" />
                                    </Columns>
                                        <EmptyDataTemplate>
                                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                                        </EmptyDataTemplate>
                   </asp:GridView>
                   <script type="text/javascript" src="../include/TableHighLight.js"></script>
                    <script type="text/javascript">
                        FormatTable("<%=GvShelf.ClientID%>")
                    </script>
                  <asp:Label ID="lblErrorShelf" runat="server" Width="100%" Font-Bold="False" style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
                  <asp:FormView ID="fvDocSelf" runat="server" DataSourceID="sdsShelf"
                    DefaultMode="Edit" Width="100%" DataKeyNames="DOCSHELFID">
                    <EditItemTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocShelf Id</td>
                                <td>
                                    <asp:Label ID="lblDOCSHELFID" runat="server" Text='<%# Eval("DOCSHELFID") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    DocShelf Code</td>
                                <td>
                                    <asp:TextBox ID="txtDocShelfCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("DOCSHELFCODE") %>' CssClass="required"></asp:TextBox>
                                    <asp:RequiredFieldValidator
                                        ID="reqCode" runat="server" ControlToValidate="txtDocShelfCode" Display="None" ErrorMessage="[DOCSHELF CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocShelf Name</td>
                                <td>
                                    <asp:TextBox ID="txtDocShelfName" runat="server" Width="264px" MaxLength="50" Text='<%# Bind("DOCSHELFNAME") %>' CssClass="required"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqName" runat="server" ControlToValidate="txtDocShelfName" Display="None" ErrorMessage="[DOCSHELF NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                                <tr>
                                    <td>
                                        DocShelf Description</td>
                                    <td>
                                        <asp:TextBox ID="txtDocShelfDesc" runat="server" MaxLength="1000" 
                                            Text='<%# Bind("DOCSHELFDESC") %>' Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="FooterStyle" colspan="2">
                                        &nbsp;<uc8:BtnUpdate ID="BtnUpdate3" runat="server" />
                                        <uc2:BtnDelete ID="BtnDelete1" runat="server" />
                                        <uc3:BtnCancel ID="BtnCancel1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <hr />
                                    </td>
                                </tr>
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
                                <td>
                                    DocShelf Code</td>
                                <td>
                                    <asp:TextBox ID="txtDocShelfCode" runat="server" Width="56px" MaxLength="10" Text='<%# Bind("DOCSHELFCODE") %>' CssClass="required"></asp:TextBox>
                                    <asp:RequiredFieldValidator
                                        ID="reqCode" runat="server" ControlToValidate="txtDocShelfCode" Display="None" ErrorMessage="[DOCSHELF CODE] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCECode" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocShelf Name</td>
                                <td>
                                    <asp:TextBox ID="txtDocShelfName" runat="server" Width="264px" MaxLength="50"
                                         Text='<%# Bind("DOCSHELFNAME") %>' CssClass="required">
                                     </asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqName" runat="server" ControlToValidate="txtDocShelfName" Display="None" ErrorMessage="[DOCSHELF NAME] must be entry...!" SetFocusOnError="True"></asp:RequiredFieldValidator><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ajaxVCEName" runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DocShelf Description</td>
                                <td>
                                    <asp:TextBox ID="txtDocShelfDesc" runat="server" MaxLength="1000" 
                                        Text='<%# Bind("DOCSHELFDESC") %>' Width="300px"></asp:TextBox>
                                </td>
                            <tr>
                                <td colspan="2">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2" class="FooterStyle">
                                    &nbsp;<uc7:BtnInsert ID="BtnInsert2" runat="server" />
                                    <uc2:BtnDelete ID="BtnDelete1" runat="server" />
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
                 
                 <asp:SqlDataSource ID="sdsShelfGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT SL.DOCSHELFID, SL.DOCSHELFCODE, SL.DOCSHELFNAME, SL.DOCSHELFDESC, 
	                                    (SELECT '(' + SF.DOCSAFECODE + ') ' + SF.DOCSAFENAME AS DOCSAFE 
		                                    FROM DOCSAFE WHERE (DOCSAFEID = SL.DOCSAFEID) AND (Deletests = 0)) AS DOCSAFENAME 
                                    FROM DOCSHELF  AS SL WITH(NOLOCK)
                                    LEFT OUTER JOIN DOCSAFE AS SF WITH(NOLOCK) ON SL.DOCSAFEID = SF.DOCSAFEID
                                    WHERE (SL.Deletests = 0) AND (SF.DOCSAFEID=@DOCSAFEID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                   <%--     <asp:ControlParameter ControlID="lblDocSafeID" Name="DOCSAFEID" 
                             PropertyName="Text" />Remark Dulu --%>
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:SqlDataSource ID="sdsShelf" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                    SelectCommand="SELECT SL.DOCSHELFID, SL.DOCSHELFCODE, SL.DOCSHELFNAME, SL.DOCSHELFDESC, 
	                                    (SELECT '(' + SF.DOCSAFECODE + ') ' + SF.DOCSAFENAME AS DOCSAFE 
		                                    FROM DOCSAFE WHERE (DOCSAFEID = SL.DOCSAFEID) AND (Deletests = 0)) AS DOCSAFENAME 
                                    FROM DOCSHELF  AS SL WITH(NOLOCK)
                                    LEFT OUTER JOIN DOCSAFE AS SF WITH(NOLOCK) ON SL.DOCSAFEID = SF.DOCSAFEID
                                    WHERE (SF.Deletests = 0) AND (SF.DOCSAFEID=@DOCSAFEID)AND (SL.DOCSHELFID = @DOCSHELFID) " 
                    DeleteCommand="UPDATE DOCSHELF SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (DOCSAFEID=@DOCSAFEID) AND (DOCSHELFID = @DOCSHELFID)" 
                    UpdateCommand="DOCSHELFUpdate" InsertCommand="DOCSHELFAdd" 
                    InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:CookieParameter CookieName="UID" Name="UserID" />
                       <%-- <asp:ControlParameter ControlID="lblDocSafeID" Name="DOCSAFEID" 
                            PropertyName="Text" />--%>
                                <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                        <asp:ControlParameter ControlID="GvShelf" Name="DOCSHELFID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <SelectParameters>
                       <%-- <asp:ControlParameter ControlID="lblDocSafeID" Name="DOCSAFEID" 
                            PropertyName="Text"  />--%>
                        <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                        <asp:ControlParameter ControlID="GvShelf" Name="DOCSHELFID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                    <%--    <asp:ControlParameter ControlID="lblDocSafeID" Name="DOCSAFEID" 
                             PropertyName="Text" Type="Int32" />--%>
                        <asp:Parameter Name="DOCSHELFID" Type="Int32" />
                        <asp:Parameter Name="DOCSHELFCode" Type="String" />
                        <asp:Parameter Name="DOCSHELFName" Type="String" />
                        <asp:Parameter Name="DOCSHELFDesc" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                         <asp:ControlParameter ControlID="GvStorePlace" Name="DOCSAFEID" 
                            PropertyName="SelectedValue" Type="String" DefaultValue="" />
                      <%--  <asp:ControlParameter ControlID="lblDocSafeID" Name="DOCSAFEID" 
                            PropertyName="Text" Type="Int32" />--%>
                        <asp:Parameter Name="DOCSHELFCode" Type="String" />
                        <asp:Parameter Name="DOCSHELFName" Type="String" />
                        <asp:Parameter Name="DOCSHELFDesc" Type="String" />
                        <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                        <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
      </asp:View>
</asp:MultiView>  

</asp:Content>

