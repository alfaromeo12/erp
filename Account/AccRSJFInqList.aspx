<%@ Page Title="Reschedule Join Finance Inquiry List" Language="VB" MasterPageFile="~/MXPageNoBusy.master" AutoEventWireup="false" CodeFile="AccRSJFInqList.aspx.vb" Inherits="Account_AccRSJFInqList" EnableEventValidation="FALSE"  MaintainScrollPositionOnPostback="true" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <asp:Panel ID="pnlShow" runat="server" CssClass="ShowDetail" Width="99%">
        <div style="float: right; vertical-align: middle">
            <asp:Image ID="imgButtonShow" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
            <asp:Label ID="lblShow" runat="server">(Show Search Criteria...)</asp:Label>
        </div>
        <input id="btnX" style="background-position: left top; width: 24px; cursor: pointer;
            background-repeat: no-repeat; height: 16px" type="button" /></asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEData" runat="server" CollapseControlID="pnlShow"
        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Search Criteria...)" Enabled="True"
        ExpandControlID="pnlShow" ExpandedImage="~/images/collapse.jpg" ExpandedText="(Hide Search Criteria...)"
        ImageControlID="imgButtonShow" TargetControlID="pnlData" TextLabelID="lblShow">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:HiddenField ID="txtAction" runat="server" />
    <asp:Panel ID="pnlData" runat="server" GroupingText="Search Criteria" Width="99%">
        <table cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="ACCOUNT.ACCOUNTNO">Account No.</asp:ListItem>
        <asp:ListItem Value="ACCNOX">Account No. (Formated)</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCOUNTNAME">Account Name</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTNO">Cust No.</asp:ListItem>
        <asp:ListItem Value="CUSTNOX">Cust No. (Formated)</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.IDNUMBER">ID Number</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.REFNO">Reference No.</asp:ListItem>
        <asp:ListItem Value="CUSTOMER.CUSTID">CUST ID</asp:ListItem>
        <asp:ListItem Value="ACCOUNT.ACCID">ACC ID</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.BPKBNO">Object/BPKB No</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.POLICENO">Police No.</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.ENGINENO">Engine No.</asp:ListItem>
        <asp:ListItem Value="COLLATERAL.CHASSISNO">Chassis No.</asp:ListItem>
    </asp:DropDownList></td>
                <td colspan="3">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Text="Search" CssClass="Search" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
        WatermarkText="%%">
    </ajaxToolkit:TextBoxWatermarkExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Reschedule Txn Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbRSAll" runat="server" GroupName="rbReq" Text="All" /><asp:RadioButton
                        ID="rbRSFrom" runat="server" GroupName="rbReq" Text="From" />
                    <asp:TextBox ID="txtRSFrom" runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgRSFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />
                    To
                    <asp:TextBox ID="txtRSTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgRSTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCERSFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgRSFrom"
                        TargetControlID="txtRSFrom">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCERSTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgRSTo"
                        TargetControlID="txtRSTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRSFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEDateTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtRSTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Booking Date</td>
                <td colspan="3">
                    <asp:RadioButton ID="rbBookAll" runat="server" GroupName="rbBook" Text="All" /><asp:RadioButton
                        ID="rbBookFrom" runat="server" GroupName="rbBook" Text="From" />
                    <asp:TextBox ID="txtBookFrom"
                            runat="server" Width="72px"></asp:TextBox><asp:Image
                        ID="imgBookFrom" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" />&nbsp;
                    To
                    <asp:TextBox ID="txtBookTo" runat="server" Width="72px"></asp:TextBox><asp:Image ID="imgBookTo" runat="server" ImageUrl="~/images/grid.gif" style="cursor: pointer" ToolTip="Calendar" /><ajaxToolkit:CalendarExtender ID="ajaxCEBookFrom" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookFrom"
                        TargetControlID="txtBookFrom">
                        </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:CalendarExtender ID="ajaxCEBookTo" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgBookTo"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookFrom" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookFrom">
                    </ajaxToolkit:MaskedEditExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEEBookTo" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtBookTo">
                    </ajaxToolkit:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Area</td>
                <td>
                    <asp:DropDownList ID="ddlAreaSearch" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDArea" runat="server" Category="AREA"
                        LoadingText="[Loading Area ...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    Branch</td>
                <td>
                    <asp:DropDownList ID="ddlBranchSearch" runat="server">
                    </asp:DropDownList>
                    <ajaxToolkit:CascadingDropDown ID="ajaxCDDBranch" runat="server" Category="BRANCH"
                        LoadingText="[Loading Branch...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownBranchByArea"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBranchSearch" ParentControlID="ddlAreaSearch">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
             <tr>
                <td>
                    JF Group</td>
                <td>
                    <asp:DropDownList ID="ddlJFGroup" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJFGroup" runat="server" Category="JFGROUP"
                        LoadingText="[Loading JF Group...]" PromptText="[DISPLAY ALL]" ServiceMethod="GetDropDownJFGroup"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlJFGroup">
                    </ajaxToolkit:CascadingDropDown>
                </td>
                <td>
                    JF/Bank</td>
                <td>
                    <asp:DropDownList ID="ddlJF" runat="server">
                    </asp:DropDownList><ajaxToolkit:CascadingDropDown ID="ajaxCDDJF" runat="server" Category="JF"
                        LoadingText="[Loading JF/Bank...]" ParentControlID="ddlJFGroup" PromptText="[DISPLAY ALL]"
                        ServiceMethod="GetDropDownJFByJFGroup" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJF">
                    </ajaxToolkit:CascadingDropDown>
                </td>
            </tr>
              <tr>
                  <td>
                      Reschedule Type</td>
                  <td>
                      <asp:DropDownList ID="ddlRSTypeSearch" runat="server" DataSourceID="sdsRSType" 
                          DataTextField="NAME" DataValueField="CODE">
                      </asp:DropDownList>
                      <asp:SqlDataSource ID="sdsRSType" runat="server" 
                          ConnectionString="<%$ ConnectionStrings:connection %>" 
                          SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'RSTYPE')">
                      </asp:SqlDataSource>
                  </td>
                  <td>
                      <asp:Label ID="lblWOStatus" runat="server" Text="Reschedule Status" 
                          Visible="False"></asp:Label>
                  </td>
                  <td>
                      <asp:DropDownList ID="ddlWOStatusSearch" runat="server" 
                          DataSourceID="sdsWOStatus" DataTextField="NAME" DataValueField="CODE" 
                          Visible="False">
                      </asp:DropDownList>
                      <asp:SqlDataSource ID="sdsWOStatus" runat="server" 
                          ConnectionString="<%$ ConnectionStrings:connection %>" 
                          SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAME UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAME FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'WOSTATUS')">
                      </asp:SqlDataSource>
                  </td>
              </tr>
        </table>
    </asp:Panel>
           <asp:UpdatePanel ID="UPGrid" runat="server">
               <ContentTemplate>
                   <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True" 
                       AutoGenerateColumns="False" Caption="Reschedule List" 
                       DataKeyNames="LOCID,ACCID,RSID" DataSourceID="sdsGrid" Width="99%">
                       <Columns>
                           <asp:TemplateField>
                               <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="ShowWO('<%#eval("LOCID")%>', '<%#eval("ACCID")%>', '<%#eval("RSID")%>' , '<%#eval("ACCIDJF")%>','<%#eval("APPID")%>')" alt="Edit : <%#eval("LOCID")%> - <%#eval("ACCID")%>" />
                               </ItemTemplate>
                               <ItemStyle HorizontalAlign="Center" Width="20px" />
                           </asp:TemplateField>
                           <asp:BoundField DataField="BRANCHNAME" HeaderText="Branch" HtmlEncode="False" 
                               SortExpression="BRANCHNAME" />
                           <asp:TemplateField HeaderText="Acc. No.&lt;br&gt;(Formated)" 
                               SortExpression="ACCNO">
                               <ItemTemplate>
                                   <a href="#" onclick='ViewDetailAcc(<%# eval("LOCID") %>, <%# eval("APPID") %>)'>
                                   <asp:Label ID="lblAccNo" runat="server" Font-Bold="True" 
                                       Text='<%# eval("ACCNO") %>'></asp:Label>
                                   </a>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:BoundField DataField="ACCOUNTNAME" HeaderText="Account&lt;br&gt;Name" 
                               HtmlEncode="False" SortExpression="ACCOUNTNAME" />
                           <asp:BoundField DataField="RSTXNDATE" DataFormatString="{0:dd/MM/yyyy}" 
                               HeaderText="RS&lt;br&gt;Txn Date" HtmlEncode="False" SortExpression="RSTXNDATE">
                           <ItemStyle HorizontalAlign="Center" />
                           </asp:BoundField>
                           <asp:BoundField DataField="BOOKINGDATE" DataFormatString="{0:dd/MM/yyyy}" 
                               HeaderText="Booking&lt;br&gt;Date" HtmlEncode="False" 
                               SortExpression="BOOKINGDATE">
                           <ItemStyle HorizontalAlign="Center" />
                           </asp:BoundField>
                           <asp:BoundField DataField="OSPRINCIPALCURRENT" DataFormatString="{0:N}" 
                               HeaderText="OS Principal&lt;br&gt;Current" HtmlEncode="False" 
                               SortExpression="OSPRINCIPALCURRENT">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="OLDEFFRATE" HeaderText="Old Eff.&lt;br&gt;Rate" 
                               HtmlEncode="False" SortExpression="OLDEFFRATE">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="NEWEFFRATE" HeaderText="New Eff.&lt;br&gt;Rate" 
                               HtmlEncode="False" SortExpression="NEWEFFRATE">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="OLDINSTALLMENT" DataFormatString="{0:N}" 
                               HeaderText="Old&lt;br&gt;Installment" HtmlEncode="False" 
                               SortExpression="OLDINSTALLMENT">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="NEWINSTALLMENT" DataFormatString="{0:N}" 
                               HeaderText="New&lt;br&gt;Installment" HtmlEncode="False" 
                               SortExpression="NEWINSTALLMENT">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="OLDTENOR" HeaderText="Old&lt;br&gt;Ten" 
                               HtmlEncode="False" SortExpression="OLDTENOR" />
                           <asp:BoundField DataField="NEWTENOR" HeaderText="New&lt;br&gt;Ten" 
                               HtmlEncode="False" SortExpression="NEWTENOR" />
                           <asp:BoundField DataField="OLDPRINCIPAL" DataFormatString="{0:N}" 
                               HeaderText="Old&lt;br&gt;Principal" HtmlEncode="False" 
                               SortExpression="OLDPRINCIPAL">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="NEWPRINCIPAL" DataFormatString="{0:N}" 
                               HeaderText="New&lt;br&gt;Principal" HtmlEncode="False" 
                               SortExpression="NEWPRINCIPAL">
                           <ItemStyle HorizontalAlign="Right" />
                           </asp:BoundField>
                           <asp:BoundField DataField="RSSTATUSNAME" HeaderText="RS&lt;br&gt;Status" 
                               HtmlEncode="False" SortExpression="RSSTATUSNAME" />
                           <asp:BoundField DataField="RSTYPENAME" HeaderText="RS&lt;br&gt;Type" 
                               HtmlEncode="False" SortExpression="RSTYPENAME" />
                       </Columns>
                       <EmptyDataTemplate>
                           <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                       </EmptyDataTemplate>
                   </asp:GridView>
                   <asp:SqlDataSource ID="sdsGrid" runat="server" 
                       ConnectionString="<%$ ConnectionStrings:connection %>" 
                       
                       SelectCommand="SELECT TOP (500) ACCOUNT.APPID, ACCOUNT.ACCOUNTNAME, ACCOUNT.BOOKINGDATE, ACCOUNT.REFNO, dbo.f_FormatAccNo(BRANCH.BRANCHCODE, ACCOUNT.ACCOUNTNO) AS ACCNO, '(' + BRANCH.BRANCHCODE + ') ' + BRANCH.BRANCHNAME AS BRANCHNAME, RESCHEDULEJF.ACCIDJF, RESCHEDULEJF.RSID, RESCHEDULEJF.RSTXNDATE, RESCHEDULEJF.OSPRINCIPALCURRENT, RESCHEDULEJF.OSTENORCURRENT, RESCHEDULEJF.OLDEFFRATE, RESCHEDULEJF.NEWEFFRATE, RESCHEDULEJF.OLDINSTALLMENT, RESCHEDULEJF.NEWINSTALLMENT, RESCHEDULEJF.RSSTATUS, dbo.f_getParamGlobalName('WoStatus', RESCHEDULEJF.RSSTATUS) AS RSSTATUSNAME, RESCHEDULEJF.OLDTENOR, RESCHEDULEJF.NEWTENOR, RESCHEDULEJF.OLDPRINCIPAL, RESCHEDULEJF.NEWPRINCIPAL, ACCOUNTJF.LOCID, ACCOUNTJF.ACCID, dbo.f_getParamGlobalName('RSTYPE', RESCHEDULEJF.RSTYPE) AS RSTYPENAME FROM ACCOUNT WITH (NOLOCK) INNER JOIN CUSTOMER WITH (NOLOCK) ON ACCOUNT.LOCIDCUST = CUSTOMER.LOCIDCUST AND ACCOUNT.CUSTID = CUSTOMER.CUSTID INNER JOIN AREA WITH (NOLOCK) INNER JOIN BRANCH WITH (NOLOCK) ON AREA.AREAID = BRANCH.AREAID ON ACCOUNT.BRANCHID = BRANCH.BRANCHID INNER JOIN ACCOUNTJF ON ACCOUNT.LOCID = ACCOUNTJF.LOCID AND ACCOUNT.ACCID = ACCOUNTJF.ACCID INNER JOIN RESCHEDULEJF ON ACCOUNTJF.ACCIDJF = RESCHEDULEJF.ACCIDJF INNER JOIN JF ON ACCOUNTJF.JFID = JF.JFID INNER JOIN JFGROUP ON JF.JFGROUPID = JFGROUP.JFGROUPID WHERE (ACCOUNTJF.JFACCSTATUS = 1)">
                   </asp:SqlDataSource>
               </ContentTemplate>
    </asp:UpdatePanel>
<script type="text/javascript" src="../include/TableHighLight.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
    function getObjectbyClientID(ClientID) {
        var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        return (oObject)
    }
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    function ShowWO(LOCID, ACCID, RSID, ACCIDJF, APPID) {
        
        window.location = "AccRSJFDisplay.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&ACCID=" + ACCID + "&RSID=" + RSID + "&ACCIDJF=" + ACCIDJF + "&APPID=" + APPID
        return false;
    }
    function ViewDetailAcc(LOCID, APPID) {
        var winref = window.open("../Account/AccInqFrame.aspx?Action=" + GetValueTxtByClientID("<%=txtAction.ClientID%>") + "&LOCID=" + LOCID + "&APPID=" + APPID, "AccView", "height=500,width=750,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable");
        winref.focus();
    }
</script>
</asp:Content>

