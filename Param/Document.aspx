<%@ Page Title="Param DOC - Document" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Document.aspx.vb" Inherits="Param_Document" %>
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
                                    <asp:ListItem Value="DOCNAME">Document Name</asp:ListItem>
                                    <asp:ListItem Value="DOCCODE">Document Code</asp:ListItem>
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
                            <td>
                                Document Type</td>
                            <td>
                                     
                                <asp:DropDownList ID="ddlDocTypeSearch" runat="server" AutoPostBack="True" 
                                    CausesValidation="True" DataSourceID="sdsDocTypeSearch" DataTextField="NAME" 
                                    DataValueField="CODE" ValidationGroup="Application" Width="200px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsDocTypeSearch" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' -  ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'DOCTYPE')">
                                </asp:SqlDataSource>
                                     
                            </td>
                        </tr>
                    </table>
                        <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                CommandName="New" CausesValidation="False" Height="19px" />
                                </asp:Panel>
                                <asp:Panel ID="pnlData" runat="server">
                    <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="DOCID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Document List" RowHeaderColumn="DOCID">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                <ItemStyle HorizontalAlign="Center" Width="25px" />
                            </asp:CommandField>
                            <asp:BoundField DataField="DOCID" HeaderText="ID" 
                                SortExpression="DOCID" HtmlEncode="False" >
                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DOCCODE" HeaderText="Document&lt;br&gt;Code" 
                                SortExpression="DOCCODE" HtmlEncode="False" />
                            <asp:BoundField DataField="DOCNAME" HeaderText="Document&lt;br&gt;Name"  
                                SortExpression="DOCNAME" HtmlEncode="False" />
                            <asp:BoundField DataField="DOCTYPE" HeaderText="Document&lt;br&gt;Type"  
                                SortExpression="DOCTYPE" HtmlEncode="False" />
                            <asp:BoundField DataField="ORDERNUMBER" HeaderText="Order&lt;br&gt;Number"  
                                SortExpression="ORDERNUMBER" HtmlEncode="False" >
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
        SelectCommand="SELECT DC.DOCID, DC.DOCCODE, DC.DOCNAME AS DOCNAME, '(' + GB.CODE + ')' + GB.NAME AS DOCTYPE, DC.ORDERNUMBER FROM [DOCUMENT] AS DC WITH (NOLOCK) LEFT OUTER JOIN PARAMGLOBAL AS GB WITH (NOLOCK) ON DC.DOCTYPE = GB.CODE WHERE (DC.DELETESTS = 0) AND (GB.TYPE = 'DOCTYPE')">
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
    <asp:FormView ID="fvDocument" runat="server" DataSourceID="sdsDocument"
        DefaultMode="Edit" Width="100%" DataKeyNames="DOCID">
            <EditItemTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Doc. Id</td>
                        <td>
                            <asp:Label ID="lblDocID" runat="server" 
                                Text='<%# Eval("DOCID") %>'></asp:Label></td>
                    </tr>
                                   
                    <tr>
                        <td width="20%">
                            Doc. Code</td>
                        <td>
                            <asp:TextBox ID="txtDocCode" runat="server" Text='<%# Bind("DOCCODE") %>' 
                                CssClass="required" MaxLength="10"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtDocCode" 
                                    Display="None" ErrorMessage="[DOCUMENT VALID. CODE] must be entry...!" 
                                    SetFocusOnError="True">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                                HighlightCssClass="ErrHighLight"
                                    TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                        <tr>
                        <td width="20%">
                            Doc. Name</td>
                        <td>
                            <asp:TextBox ID="txtDocName" runat="server" Width="250px" MaxLength="100" 
                                Text='<%# Bind("DOCNAME") %>' CssClass="required"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtDocName" 
                                    Display="None" ErrorMessage="[DOCUMENT NAME] must be entry...!" 
                                    SetFocusOnError="True">
                            </asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                                HighlightCssClass="ErrHighLight"
                                    TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                         <tr>
                        <td width="20%">
                            Doc. Type</td>
                        <td>
                           <asp:DropDownList ID="ddlDocType" Width="200px" runat="server" DataSourceID="sdsDocType"
                                CssClass="required"  SelectedValue ='<%# Bind("DOCTYPE") %>'   DataValueField="CODE" 
                            DataTextField="NAME"></asp:DropDownList> 
                                <asp:RequiredFieldValidator ID="reqType" runat="server" ControlToValidate="ddlDocType" 
                                    Display="None" ErrorMessage="[DOCUMENT TYPE] must be entry...!" 
                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                                HighlightCssClass="ErrHighLight"
                                    TargetControlID="reqType"></ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Doc. Order</td>
                        <td>
                            <asp:TextBox ID="txtDocOrder" runat="server" Width="30px" MaxLength="4" 
                                Text='<%# Bind("ORDERNUMBER") %>'></asp:TextBox>
                         
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
                        Doc. Code</td>
                    <td>
                        <asp:TextBox ID="txtDocCode" runat="server" 
                            Text='<%# Bind("DOCCODE") %>' CssClass="required" MaxLength="10"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCode" runat="server" ControlToValidate="txtDocCode" 
                                Display="None" ErrorMessage="[DOCUMENT VALID. CODE] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECode" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqCode"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        Doc. Name</td>
                    <td>
                        <asp:TextBox ID="txtDocName" runat="server" Width="250px" MaxLength="100" 
                            Text='<%# Bind("DOCNAME") %>' CssClass="required"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtDocName" 
                                Display="None" ErrorMessage="[DOCUMENT VALID. NAME] must be entry...!" 
                                SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCENamee" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Doc. Type</td>
                    <td>
                       <asp:DropDownList ID="ddlDocType" Width="200px" runat="server" DataSourceID="sdsDocType"
                            CssClass="required"  SelectedValue ='<%# Bind("DOCTYPE") %>'   DataValueField="CODE" 
                        DataTextField="NAME"></asp:DropDownList> 
                            <asp:RequiredFieldValidator ID="reqType" runat="server" ControlToValidate="ddlDocType" 
                                Display="None" ErrorMessage="[DOCUMENT TYPE] must be entry...!" 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqType"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        Doc. Order</td>
                    <td>
                        <asp:TextBox ID="txtDocOrder" runat="server" Width="30px" MaxLength="4" 
                            Text='<%# Bind("ORDERNUMBER") %>' ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="reqOrder" runat="server" ControlToValidate="txtDocOrder" 
                        Display="None" ErrorMessage="[DOCUMENT VALID. ORDER] must be entry...!" 
                        SetFocusOnError="True">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEOrder" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqOrder"></ajaxToolkit:ValidatorCalloutExtender>
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
      <asp:SqlDataSource ID="sdsDocument" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                SelectCommand="SELECT DOCID, DOCCODE,DOCNAME,DC.DOCTYPE,
                            '('+ GB.CODE + ')'+ GB.NAME,DC.ORDERNUMBER
                            FROM DOCUMENT DC WITH(NOLOCK) 
                            INNER JOIN PARAMGLOBAL GB WITH(NOLOCK)ON DC.DOCTYPE=GB.CODE 
                            WHERE (Deletests = 0)and GB.TYPE='DOCTYPE' AND DOCID=@DOCID "
                DeleteCommand="UPDATE DOCUMENT SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE (DOCID=@DOCID)" 
                UpdateCommand="DOCUMENTUpdate" InsertCommand="DOCUMENTAdd" 
                InsertCommandType="StoredProcedure" 
        UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvData" Name="DOCID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:CookieParameter CookieName="UID" Name="UserID" />
                    <asp:ControlParameter ControlID="gvData" Name="VALIDDOCID" 
                        PropertyName="SelectedValue" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="gvData" Name="DOCID" 
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="DOCCODE" Type="String" />
                    <asp:Parameter Name="DOCNAME" Type="String" />
                    <asp:Parameter Name="DOCTYPE" Type="Int32" />
                    <asp:Parameter Name="ORDERNUMBER" Type="Int32" />
                    <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                    <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                     <asp:Parameter Name="DOCCODE" Type="String" />
                    <asp:Parameter Name="DOCNAME" Type="String" />
                    <asp:Parameter Name="DOCTYPE" Type="Int32" />
                    <asp:Parameter Name="ORDERNUMBER" Type="Int32" />
                    <asp:CookieParameter CookieName="UID" Name="UserId" Type="Int32" />
                    <asp:Parameter Direction="InputOutput" Name="retval" Type="Int32" />
                </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDocType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                
        SelectCommand="SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'DOCTYPE')" >
    </asp:SqlDataSource>

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
        </script> 
</asp:Content>

