<%@ Page Title="Account JF from Term and Condition" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="AccForTnC.aspx.vb" Inherits="Account_AccForTnC" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%" >
        <tr >
            <td  colspan="4">
                    <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" Font-Bold="True"
                        Style="text-align: center" Visible="False" Width="100%"></asp:Label>
                 <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" 
                        TargetControlID="lblMessage">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
                        </td>
        </tr>
        <tr >
            <td  class="HeaderStyle">
                Bank</td>
            <td  class="ShowDetail">
                <asp:DropDownList ID="ddlBank" runat="server" CssClass="required">
                </asp:DropDownList>
                <ajaxToolkit:CascadingDropDown ID="ajaxCDDJFGroup" runat="server" Category="Bank"
                        LoadingText="[Loading Bank..]" PromptText="[CHOOSE BANK]" ServiceMethod="GetDropDownBank"
                        ServicePath="~\Param\WebService.asmx" TargetControlID="ddlBank">
                </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqBank" runat="server"
                            ControlToValidate="ddlBank" Display="None" ErrorMessage="BANK must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
                                ID="reqBank_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqBank">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
            <td  class="HeaderStyle">
                JF (Join Finance)</td>
            <td  class="ShowDetail">
                <asp:DropDownList ID="ddlJF" runat="server" CssClass="required">
                </asp:DropDownList>
                <ajaxToolkit:CascadingDropDown ID="ajaxCDDJF" runat="server" Category="JF"
                        LoadingText="[Loading JF/Bank...]" ParentControlID="ddlBank" PromptText="[CHOOSE JF]"
                        ServiceMethod="GetDropDownJFByBank" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJF">
                </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqJF" runat="server"
                            ControlToValidate="ddlJF" Display="None" ErrorMessage="JF (Join Finance) must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
                                ID="reqJF_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqJF">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
        </tr>
        <tr >
            <td  class="RowStyle">
                JF T &amp; C</td>
            <td  class="RowStyle">
                <asp:DropDownList ID="ddlJFTNC" runat="server" CssClass="required">
                </asp:DropDownList>
                <ajaxToolkit:CascadingDropDown ID="ajaxCCDJFTNC" runat="server" Category="JFTNC"
                        LoadingText="[Loading JF/Bank...]" ParentControlID="ddlJF" PromptText="[CHOOSE JF TNC]"
                        ServiceMethod="GetDropDownJFTNCbyJFID" ServicePath="~\Param\WebService.asmx"
                        TargetControlID="ddlJFTNC">
                </ajaxToolkit:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="reqTNC" runat="server"
                            ControlToValidate="ddlJFTNC" Display="None" ErrorMessage="JF T &amp; C must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
                                ID="reqTNC_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqTNC">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
            <td  class="RowStyle">
                JF Request Type</td>
            <td  class="RowStyle">
                    <asp:DropDownList ID="ddlJFRequestType" runat="server" 
                    DataSourceID="sdsJFRequestType" DataTextField="NAME"
                        DataValueField="CODE" CssClass="required">
                </asp:DropDownList><asp:SqlDataSource ID="sdsJFRequestType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                    SelectCommand="SELECT NULL AS CODE, '[JF REQUEST TYPE]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'JFREQUESTTYPE')">
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="reqJFRequestType" runat="server"
                            ControlToValidate="ddlJFRequestType" Display="None" ErrorMessage="JF REQUEST TYPE must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
                                ID="reqJFRequestType_ValidatorCalloutExtender" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqJFRequestType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
        </tr>
        <tr >
            <td  class="AlternatingRowStyle">
                Request Date</td>
            <td  class="AlternatingRowStyle">
                    <asp:TextBox ID="txtRequestDate" runat="server" CssClass="required" 
                        Width="72px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="ajaxCERequestDate" runat="server" 
                    Format="dd/MM/yyyy" PopupButtonID="imgRequestDate"
                        TargetControlID="txtRequestDate" PopupPosition="TopRight">
                    </ajaxToolkit:CalendarExtender>
                    <ajaxToolkit:MaskedEditExtender ID="ajaxMEERequestDate" runat="server" Mask="99/99/9999"
                        MaskType="Date" TargetControlID="txtRequestDate">
                    </ajaxToolkit:MaskedEditExtender>
                    <asp:Image ID="imgRequestDate" runat="server" ImageUrl="~/images/grid.gif" Style="cursor: pointer"
                        ToolTip="Calendar" />
                    <asp:RequiredFieldValidator ID="reqRequestDate" runat="server"
                            ControlToValidate="txtRequestDate" Display="None" ErrorMessage="REQUEST DATE must be entry...!"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                <ajaxToolkit:ValidatorCalloutExtender
                                ID="ajaxVCERequestDate" runat="server" 
                        HighlightCssClass="ErrHighLight" TargetControlID="reqRequestDate">
                            </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
            <td  class="AlternatingRowStyle">
                Installment Day</td>
            <td  class="AlternatingRowStyle">
                    <asp:TextBox ID="txtInstallmentDay" runat="server" Width="48px"></asp:TextBox>
                *)</td>
        </tr>
        <tr id="trLoan">
                <td  class="RowStyle">
                    Loan Type</td>
                <td  class="RowStyle">
                    <asp:DropDownList ID="ddlLoanType" runat="server" DataSourceID="sdsLoanType" DataTextField="NAME"
                        DataValueField="CODE">
                    </asp:DropDownList><asp:SqlDataSource ID="sdsLoanType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                        
                        
                        SelectCommand="SELECT NULL AS CODE, '[SAME WITH CUSTOMER]' AS NAME UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAME FROM PARAMGLOBAL WHERE (TYPE = 'LOANTYPE')">
                    </asp:SqlDataSource>
                    *)</td>
                <td  class="RowStyle">
                    Tenor</td>
                <td  class="RowStyle">
                    <asp:TextBox ID="txtTenor" runat="server" Style="text-align: right" 
                        Width="56px"></asp:TextBox>*)</td>
            </tr>
        <tr id="trRate">
                <td  class="AlternatingRowStyle">
                    Use Rate</td>
                <td  class="AlternatingRowStyle">
                    <asp:RadioButton ID="rbJFRate" runat="server" GroupName="UseRate" 
                        Text="Join Finance Rate" />
                    <asp:RadioButton ID="rbCustRate" runat="server" GroupName="UseRate" 
                        Text="Customer Rate" /></td>
                <td  class="AlternatingRowStyle">
                </td>
                <td  class="AlternatingRowStyle">
                </td>
            </tr>
        <tr >
            <td  class="FooterStyle" colspan="4">
                    *) leave
                    blank if same with customer</td>
        </tr>
        <tr >
            <td  class="HeaderStyle">
                    <asp:Button ID="btnProcess" runat="server" Style="background-position: right; background-image: url(../Images/Save.gif);
                        cursor: pointer; background-repeat: no-repeat;  text-align: left"
                        Text="Process" />
            </td>
            <td  colspan="3" class="ShowDetail">
                <hr />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function getObjectbyClientID(ClientID) {
            var oObject = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            return (oObject)
        }
        function GetValueTxtByClientID(ClientID) {
            var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
            if (oText)
                return (oText.value);
        }

        function JFRequestChange() {
            var iJFReq = GetValueTxtByClientID("<%=ddlJFRequestType.ClientID%>");
            var oLoan = getObjectbyClientID("trLoan");
            var oRate = getObjectbyClientID("trRate");

            if (iJFReq == "1") {
                oLoan.style.display = "";
                oRate.style.display = "";
            } else {
                oLoan.style.display = "none";
                oRate.style.display = "none";
            }
            

        }
    </script>
</asp:Content>

