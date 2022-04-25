<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="FTPAccountInq.aspx.vb" Inherits="FTPDoc_FTPAccountInq" %>
<%@ Register src="../UserControl/NoDataFound.ascx" tagname="NoDataFound" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:HiddenField ID="txtLocID" runat="server" />
	<asp:HiddenField ID="txtAppID" runat="server" />
	<asp:HiddenField ID="txtAction" runat="server" />
    <asp:TextBox ID="txtTmpSelectedIndex" runat="Server" style="display:none" Text="0" /> 
   <asp:Panel ID="pnlCustomerShow" runat="server" CssClass="ShowDetail" 
        Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgCust" runat="server" AlternateText="(Show Details...)" 
                ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblCust" runat="server" CssClass="required">(Show Customer Info...)</asp:Label>
        </div>
        <input id="Button14" style="background-position: left top; width: 24px; cursor: pointer;
			background-repeat: no-repeat; height: 16px" type="button" noenter />
        </asp:Panel>
        <asp:Panel ID="pnlCustomer" runat="server" Width="100%">
            <asp:DataList ID="dlCustomer" runat="server" Caption="CUSTOMER INFO" 
                DataSourceID="sdsCustInfo" Width="100%">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:100%;">
                        <tr>
                            <td class="HeaderStyle">
                                APP ID</td>
                            <td class="FooterStyle">
                                <asp:Label ID="LOCIDLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("LOCID") %>' />
                                &nbsp;-
                                <asp:Label ID="APPIDLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("APPID") %>' />
                            </td>
                            <td class="HeaderStyle">
                                ACC ID</td>
                            <td class="FooterStyle">
                                <asp:Label ID="LOCIDLabel0" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("LOCID") %>' />
                                &nbsp;-
                                <asp:Label ID="ACCIDLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("ACCID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="HeaderStyle">
                                CUST ID</td>
                            <td class="FooterStyle" colspan="3">
                                <asp:Label ID="LOCIDCUSTLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("LOCIDCUST") %>' />
                                &nbsp;-
                                <asp:Label ID="CUSTIDLabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("CUSTID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="ShowDetail">
                                Finance Category</td>
                            <td class="ShowDetail">
                                (<asp:Label ID="Label10" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("FINCATCODE") %>'></asp:Label>)
                                <asp:Label ID="Label11" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("FINCATNAME") %>'></asp:Label>
                            </td>
                            <td>
                                App. Type</td>
                            <td>
                                (<asp:Label ID="APPTYPELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("APPTYPE") %>' />)
                                <asp:Label ID="APPTYPENAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("APPTYPENAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Area</td>
                            <td>
                                (<asp:Label ID="Label6" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("AREACODE") %>'></asp:Label>)
                                <asp:Label ID="Label7" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("AREANAME") %>'></asp:Label>
                            </td>
                            <td>
                                Branch</td>
                            <td>
                                (<asp:Label ID="Label8" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("BRANCHCODE") %>'></asp:Label>)&nbsp;
                                <asp:Label ID="Label9" runat="server" 
                                    style="font-weight: 700; text-decoration: underline" 
                                    Text='<%# Eval("BRANCHNAME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Cust Name</td>
                            <td class="ErrHighLight" colspan="3">
                                <asp:Label ID="CUSTNAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("CUSTNAME") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Cust Type</td>
                            <td>
                                (<asp:Label ID="CUSTTYPELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("CUSTTYPE") %>' />)
                                <asp:Label ID="CUSTTYPENAMELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("CUSTTYPENAME") %>' />
                                &nbsp;</td>
                            <td>
                                Request Date&nbsp;</td>
                            <td>
                                <asp:Label ID="REQUESTDATELabel" runat="server" 
                                    style="font-weight: bold; text-decoration: underline" 
                                    Text='<%# Eval("REQUESTDATE", "{0:dd/MM/yyyy}") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </asp:Panel>
    	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECustomer" runat="server" CollapseControlID="pnlCustomerShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Customer Info...)"
		Enabled="True" ExpandControlID="pnlCustomerShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Customer Info...)" ImageControlID="imgCust" TargetControlID="pnlCustomer"
		TextLabelID="lblCust">
	</ajaxToolkit:CollapsiblePanelExtender>

    <asp:SqlDataSource ID="sdsCustInfo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        SelectCommand="SELECT APPLICATION.REQUESTDATE, APPLICATION.LOCID, APPLICATION.APPID, ACCOUNT.ACCID, CUSTOMER.LOCIDCUST, CUSTOMER.CUSTID, CUSTOMER.CUSTNAME, CUSTOMER.CUSTTYPE, dbo.f_getParamGlobalName('CUSTTYPE', CUSTOMER.CUSTTYPE) AS CUSTTYPENAME, APPLICATION.APPTYPE, dbo.f_getParamGlobalName('APPTYPE', APPLICATION.APPTYPE) AS APPTYPENAME, BRANCH.BRANCHCODE, BRANCH.BRANCHNAME, AREA.AREACODE, AREA.AREANAME, FINANCECATEGORY.FINCATCODE, FINANCECATEGORY.FINCATNAME FROM FINANCECATEGORY WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) INNER JOIN ACCOUNT WITH (NOLOCK) ON CUSTOMER.LOCIDCUST = ACCOUNT.LOCIDCUST AND CUSTOMER.CUSTID = ACCOUNT.CUSTID INNER JOIN APPLICATION WITH (NOLOCK) ON ACCOUNT.LOCID = APPLICATION.LOCID AND ACCOUNT.APPID = APPLICATION.APPID ON FINANCECATEGORY.FINCATID = ACCOUNT.FINCATID LEFT OUTER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID WHERE (APPLICATION.LOCID = @LOCID) AND (APPLICATION.APPID = @APPID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtLocID" Name="LOCID" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtAppID" Name="APPID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:Panel ID="pnlDOCExistingShow" runat="server" CssClass="ShowDetail" 
    Width="99%">
    <div style="float: right; vertical-align: middle">
        <asp:Image ID="imgDocExists" runat="server" AlternateText="(Show Details...)" 
            ImageUrl="~/images/expand.jpg" />
        <asp:Label ID="lblDocExists" runat="server" CssClass="required">(Show Document Existing Info...)</asp:Label>
    </div>
    <input id="btnDocExists" style="background-position: left top; width: 24px; cursor: pointer;
		background-repeat: no-repeat; height: 16px" type="button" noenter />
    </asp:Panel>
    <asp:Panel ID="pnlDocExists" runat="server" Width="100%">
        <asp:GridView ID="GvDocExists" runat="server"  
            AutoGenerateColumns="False" Width="100%" 
            Caption="Document Existing">
            <Columns>
                <asp:TemplateField HeaderText="View" SortExpression="APPID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="View('<%#  Eval("FileName") %>', '<%# Container.DataItemIndex + 1 %>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Save">
                    <ItemTemplate>
                        <img src="../images/download.png" style="cursor: pointer" onclick="ViewDownload('<%#  Eval("FileName") %>', '<%# Container.DataItemIndex + 1 %>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:TemplateField>
                  <asp:TemplateField  HeaderText="No.">
                   <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="File&lt;br&gt;Type"> 
                    <ItemTemplate>
                        <asp:Label ID="lblFileType" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Uploaded&lt;br&gt;File">
                     <ItemTemplate>
                         <asp:Label ID="lblFileUpload" runat="server" Font-Bold="True" 
                             Text='<%# Eval("FileName") %>' />
                     </ItemTemplate>
                     <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                 <asp:BoundField HeaderText="Size&lt;br&gt;(Kb)" DataField="Size" 
                    HtmlEncode="False">
                    <ItemStyle Width="80px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Last&lt;br&gt;Modified" 
                    DataField="LastModifiedDate" HtmlEncode="False" >
                    <ItemStyle Width="150px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Remark">
                    <ItemTemplate>
                        <asp:Label ID="lblRemark" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <uc1:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
           <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight"
	    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
	    Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    </asp:Panel>
   
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEDocExists" runat="server" CollapseControlID="pnlDOCExistingShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Document Existing Info...)"
		Enabled="True" ExpandControlID="pnlDOCExistingShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Document Existing Info...)" ImageControlID="imgDocExists" TargetControlID="pnlDocExists"
		TextLabelID="lblDocExists">
	</ajaxToolkit:CollapsiblePanelExtender>
    <br />
    <br />
    <br />
    
    <br />
    <br />
    <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Width="100%">
  
    <asp:Button ID="btnBack" runat="server" CausesValidation="False" CommandName="Cancel" 
        Style="background-position: left; background-image: url(../images/close.png); 
	    cursor: pointer; background-repeat: no-repeat; text-align: right; " 
        Text="Close" ToolTip="Close"
	    Width="72px" onclientclick="return CloseWindow();"  />
    </asp:Panel>
    <ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" 
                TargetControlID="pnlControl" VerticalSide="Bottom">
	        </ajaxToolkit:AlwaysVisibleControlExtender>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=GvDocExists.ClientID%>");
    

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
  
    function View(FILENAME, NO) {
        var iLOCID = GetValueTxtByClientID("<%=txtLOCID.ClientID%>");
        var iAPPID = GetValueTxtByClientID("<%=txtAPPID.ClientID%>");
        var title = iLOCID + iAPPID + NO;
        var winref = window.open("FTPAccountView.aspx?Action=View" + "&FILE=" + FILENAME + "&LOCID=" + iLOCID + "&APPID=" + iAPPID, title, "height=500,width=450,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
    }
    function ViewDownload(FILENAME, NO) {
        var iLOCID = GetValueTxtByClientID("<%=txtLOCID.ClientID%>");
        var iAPPID = GetValueTxtByClientID("<%=txtAPPID.ClientID%>");
        var title = iLOCID + iAPPID + NO;
        var winref = window.open("FTPAccountView.aspx?Action=Download" + "&FILE=" + FILENAME + "&LOCID=" + iLOCID + "&APPID=" + iAPPID, title, "height=500,width=450,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
        winref.focus();
    }

    function BackPage() {
        window.history.back(-1);
        return false;
    }
    function CloseWindow() {
        close();
    }
    function ShowAlert() {
        alert("TRANSFER DOCUMENT FAILED...! Please see the error detail..!");
    }
</script>


</asp:Content>

