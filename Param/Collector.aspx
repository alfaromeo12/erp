<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="Collector.aspx.vb" EnableEventValidation="false" Inherits="Param_Collector" %>
<%@ Register Src="~/usercontrol/btninsert.ascx" TagPrefix="uc" TagName="BtnInsert" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManagerProxy ID="SMPColl" runat="server">
	<Services>
	<asp:ServiceReference Path="GHWService.asmx" />
	</Services>
	</asp:ScriptManagerProxy>
    <ajaxToolkit:textboxwatermarkextender ID="ajxTBWESearch" runat="server" TargetControlID="txtSearch"
            WatermarkText="%%"></ajaxToolkit:textboxwatermarkextender>
        <asp:CheckBox ID="chkAdd" runat="server" style="display:none" />
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
                            <td style="width: 115px" class="RowStyle">
                                <asp:DropDownList ID="ddlCriteria" runat="server">
                                    <asp:ListItem Value="COLLECTORNAME">Collector Name</asp:ListItem>
                                    <asp:ListItem Value="COLLECTORCODE">Collector Code</asp:ListItem>
                                    <asp:ListItem Value="COLLECTORTITLE">Title</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="RowStyle">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="required"></asp:TextBox><asp:Button
                                    ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
                                    border-right-style: outset; border-left-style: outset; border-bottom-style: outset;"
                                    Text="Search" CausesValidation="False" CssClass="Search" />
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px" class="AlternatingRowStyle">
                                Collector Type
                            </td>
                            <td class="AlternatingRowStyle">
                                <asp:DropDownList ID="ddlCollectType" runat="server" 
                                    DataSourceID="sdsCollectorTypeSearch" DataTextField="NAMETYPE" DataValueField="CODE" 
                                    AutoPostBack="True" />
                                <asp:SqlDataSource ID="sdsCollectorTypeSearch" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT NULL AS CODE, '[DISPLAY ALL]' AS NAMETYPE UNION ALL SELECT CODE, '(' + CODE + ') ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (nolock) WHERE (TYPE = 'COLLECTORTYPE') ORDER BY CODE">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 115px; height: 19px;" class="RowStyle">
                                Collector Title</td>
                            <td class="RowStyle">
                                     
                                <asp:DropDownList ID="ddlCollectorTitleSearch" runat="server" 
                                    AutoPostBack="True" DataSourceID="sdsCollectorTitleSearch" 
                                    DataTextField="COLLECTORTITLENAME" DataValueField="COLLECTORTITLEID" />
                                <asp:SqlDataSource ID="sdsCollectorTitleSearch" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:connection %>" 
                                    SelectCommand="SELECT NULL AS COLLECTORTITLEID, NULL AS COLLECTORTITLECODE, '[DISPLAY ALL]' AS COLLECTORTITLENAME UNION ALL SELECT COLLECTORTITLEID, COLLECTORTITLECODE, '(' + COLLECTORTITLECODE + ')' + COLLECTORTITLENAME AS COLLECTORTITLENAME FROM COLLECTORTITLE WITH (NOLOCK) ORDER BY COLLECTORTITLECODE">
                                </asp:SqlDataSource>
                                     
                            </td>
                        </tr>
                    </table>
                        <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/images/add.gif" 
                                CommandName="New" CausesValidation="False" Height="19px" />
                                </asp:Panel>
                    <asp:Panel ID="pnlData" runat="server">
                    <asp:GridView ID="gvData" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="COLLECTORID" 
                            DataSourceID="sdsGrid" Width="100%" 
                        Caption="Collector List" RowHeaderColumn="COLLECTORID" AllowSorting="True">
                        <Columns>
                            <asp:CommandField ButtonType="Image" ShowSelectButton="True" SelectImageUrl="~/Images/edit.gif">
                                <ItemStyle HorizontalAlign="Center" Width="2px" />
                            </asp:CommandField>
                            <asp:BoundField DataField="COLLECTORID" HeaderText="ID" ReadOnly="True" 
                                SortExpression="COLLECTORID" />
                            <asp:BoundField DataField="COLLECTORCODE" HeaderText="Coll Code" SortExpression="COLLECTORCODE" />
                            <asp:BoundField DataField="COLLECTORNAME" HeaderText="Coll Name" SortExpression="COLLECTORNAME" />
                            <asp:BoundField DataField="NAMETYPE" HeaderText="Type"  SortExpression="NAMETYPE" />
                            <asp:BoundField DataField="COLLECTORTITLENAME" HeaderText="Name"  SortExpression="COLLECTORTITLENAME" />
                        </Columns>
                        <EmptyDataTemplate>
                            <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                        </EmptyDataTemplate>
                    </asp:GridView>
            </asp:Panel>
        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
            
        
        SelectCommand="SELECT CT.COLLECTORID, CT.COLLECTORCODE, AU.UserID, AU.UserName, CT.COLLECTORNAME, CT.COLLECTORTYPE, TY.NAMETYPE, CT.COLLECTORTITLEID, '(' + CL.COLLECTORTITLECODE + ') ' + CL.COLLECTORTITLENAME AS COLLECTORTITLENAME FROM COLLECTOR AS CT WITH (NOLOCK) INNER JOIN APPUSER AS AU WITH (NOLOCK) ON CT.COLLECTORID = AU.UID INNER JOIN (SELECT CODE, '(' + CODE + ') ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'COLLECTORTYPE')) AS TY ON TY.CODE = CT.COLLECTORTYPE INNER JOIN COLLECTORTITLE AS CL WITH (NOLOCK) ON CL.COLLECTORTITLEID = CT.COLLECTORTITLEID WHERE (CT.Deletests = 0)">
        </asp:SqlDataSource>
    <asp:HiddenField ID="lblCollectID" runat="server" />
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
    <asp:Panel ID="pnlCollectorShow" runat="server" CssClass="ShowDetail"  Width="99%">
		<div style="float: right; vertical-align: middle">
			<asp:Image ID="imgCollectorData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			<asp:Label ID="lblCollectorData" runat="server" CssClass="required">(Show Collector Data...)</asp:Label>
		</div>
		<input id="Button2" style="background-position: left top; width: 24px; cursor: pointer;
			background-repeat: no-repeat; height: 16px" type="button" noenter />
    </asp:Panel>
	<ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECollector" runat="server" CollapseControlID="pnlCollectorShow"
		CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Collector Data...)"
		Enabled="True" ExpandControlID="pnlCollectorShow" ExpandedImage="~/images/collapse.jpg"
		ExpandedText="(Hide Collector Data...)" ImageControlID="imgCollectorData" TargetControlID="pnlCollectorData"
		TextLabelID="lblCollectorData">
	</ajaxToolkit:CollapsiblePanelExtender>
      <asp:Panel ID="pnlCollectorData" runat="server"  Width="100%" >
            <table cellpadding="0" cellspacing="0" width="100%">
                  
                <tr  id="CollectRowID">
                    <td width="20%" class="ShowDetail">
                        Collector ID</td>
                    <td class="ShowDetail">
                        <asp:Label ID="lblCollectorID" runat="server" Font-Bold="True" 
                            Font-Underline="True"></asp:Label>
                    </td>
                </tr>
                    <tr>
                        <td width="20%" class="ErrHighLight">
                            Collector Type</td>
                        <td class="ErrHighLight">
                            <asp:DropDownList ID="ddlCollType" runat="server" CssClass="required" 
                                DataTextField="NAME" DataValueField="CODE" 
                                CausesValidation="True" ValidationGroup="Collector">
                            </asp:DropDownList>
                            <ajaxToolkit:CascadingDropDown ID="ajaxCCDType" runat="server" Category="COLLECTORTYPE" 
                                Enabled="True" LoadingText="[Loading Collector Type..]" 
                                PromptText="[SELECT COLLECTOR TYPE]" ServiceMethod="GetDropDownTypeCollector" 
                                ServicePath="~\Param\WebService.asmx" TargetControlID="ddlCollType">
                            </ajaxToolkit:CascadingDropDown>
                            <asp:RequiredFieldValidator ID="reqType" runat="server" 
                                ControlToValidate="ddlCollType" Display="None" 
                                ErrorMessage="TYPE must be entry...!" SetFocusOnError="True" 
                                ValidationGroup="Collector"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEType" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqType">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                    <td width="20%" class="ErrHighLight">
                        Title</td>
                    <td class="ErrHighLight">
                        <asp:DropDownList ID="ddlColTitleType" runat="server"  CssClass="required" 
                            ValidationGroup="Collector">
					    </asp:DropDownList>
					    <ajaxToolkit:CascadingDropDown ID="ajaxCDDTitleType" runat="server" Category="TYPE" 
						    LoadingText="[Loading Collector Title ..]" PromptText="[SELECT COLLECTOR TITLE]" 
						    ServiceMethod="GetDropDownTitleTypeByType" ServicePath="~\Param\WebService.asmx" 
						    TargetControlID="ddlColTitleType" ParentControlID="ddlCollType">
					    </ajaxToolkit:CascadingDropDown>
					    <asp:RequiredFieldValidator ID="reqTypeTitle" runat="server" 
						    ControlToValidate="ddlColTitleType" Display="None" 
						    ErrorMessage="TITLE TYPE must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Collector"></asp:RequiredFieldValidator>
					    <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCETypeTitle" runat="server" 
						    HighlightCssClass="ErrHighLight" TargetControlID="reqTypeTitle">
					    </ajaxToolkit:ValidatorCalloutExtender>
                        
                    </td>
                </tr>
                    <tr id="LoginRow">
                    <td width="20%">
                        User Login</td>
                    <td>
                         <asp:RadioButton ID="rbUseLogin_no" runat="server" onclick="return checkFlag()" 
                            GroupName="rbUseLogin"  Text="No" />
                        <asp:RadioButton ID="rbUseLogin_yes" runat="server" GroupName="rbUseLogin" 
                            onclick="return checkFlag()"  Checked="true" Text="Yes" />
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        User Name/ Coll. ID</td>
                    <td>
                        <asp:DropDownList ID="ddlCollUser" runat="server"
                            DataSourceID="sdsCollUser" Width="300px"  DataValueField="UID" 
                            DataTextField="USERNAME" CssClass="required" >
                        </asp:DropDownList>
                        <asp:TextBox ID="txtCollCodeUser" runat="server" Width="250px" 
                            CssClass="required"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqCollUser" runat="server" 
                            ControlToValidate="ddlCollUser" Display="None" 
                            ErrorMessage="[COLLECTOR COLL ID] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Collector"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCollUser_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" TargetControlID="reqCollUser">
                        </ajaxToolkit:ValidatorCalloutExtender>
                        <asp:RequiredFieldValidator ID="reqCollCodeUser" runat="server" 
                            ControlToValidate="txtCollCodeUser" Display="None" 
                            ErrorMessage="[COLLECTOR CODE USER] must be entry...!" SetFocusOnError="True" 
                            ValidationGroup="Collector"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="reqCollCodeUser_ValidatorCalloutExtender" 
                            runat="server" HighlightCssClass="ErrHighLight" 
                            TargetControlID="reqCollCodeUser">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                    <td width="20%">
                        Collector Name</td>
                    <td>
                        <asp:TextBox ID="txtCollTitleName" runat="server" Width="350px" MaxLength="80" 
                           CssClass="required" ValidationGroup="Collector"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtCollTitleName" 
                                Display="None" ErrorMessage="[COLLECTOR NAME] must be entry...!" 
                                SetFocusOnError="True" ValidationGroup="Collector"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEName" runat="server" 
                            HighlightCssClass="ErrHighLight"
                                TargetControlID="reqName"></ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
                    <tr>
                        <td colspan="2">
                        
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Head Collector</td>
                        <td>
                            <asp:DropDownList ID="ddlCollHead" runat="server" 
                                DataSourceID="sdsCollHead" DataTextField="COLLECTORNAME" 
                                DataValueField="COLLECTORID" 
                                Width="250px" ValidationGroup="Collector">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Collector Group</td>
                        <td>
                            <asp:DropDownList ID="ddlCollGroup" runat="server" CssClass="required" 
                                DataSourceID="sdsCollGroup" DataTextField="COLLGROUPNAME" 
                                DataValueField="COLLGROUPID" 
                                Width="250px" ValidationGroup="Collector">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqGroup" runat="server" 
                                ControlToValidate="ddlCollGroup" Display="None" 
                                ErrorMessage="[COLLECTOR GROUP. ID] must be entry...!" 
                                SetFocusOnError="True" ValidationGroup="Collector"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEGroup" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqGroup">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Collector DPD</td>
                        <td>
                            <asp:DropDownList ID="ddlCollDPD" runat="server" CssClass="required" 
                                DataSourceID="sdsCollDpd" DataTextField="COLLECTORDPDNAME" 
                                DataValueField="COLLECTORDPDID"
                                Width="250px" ValidationGroup="Collector">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqDPD" runat="server" 
                                ControlToValidate="ddlCollDPD" Display="None" 
                                ErrorMessage="[COLLECTOR DPD. ID] must be entry...!" 
                                SetFocusOnError="True" ValidationGroup="Collector"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCEDPD" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqDPD">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                </tr>
                    <tr>
                        <td width="20%">
                            Address</td>
                        <td>
                            <asp:TextBox ID="txtAddress" runat="server" Height="80px" 
                                Text='<%# Bind("ADDRESS") %>' TextMode="MultiLine" Width="368px" 
                                Font-Names="Lucida Sans" Font-Size="8pt"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            City ID</td>
                        <td>
                            <asp:DropDownList ID="ddlCity" runat="server" CssClass="required" 
                                DataSourceID="sdsCollCity" DataTextField="CITYNAME" DataValueField="CITYID" 
                                Width="250px">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqCity" runat="server" 
                                ControlToValidate="ddlCollDPD" Display="None" 
                                ErrorMessage="[COLLECTOR CITY. ID] must be entry...!" 
                                SetFocusOnError="True" ValidationGroup="Collector"></asp:RequiredFieldValidator>
                            <ajaxToolkit:ValidatorCalloutExtender ID="ajaxVCECity" runat="server" 
                                HighlightCssClass="ErrHighLight" TargetControlID="reqCity">
                            </ajaxToolkit:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Zip</td>
                        <td>
                            <asp:TextBox ID="txtZip" runat="server" MaxLength="7" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Phone No</td>
                        <td>
                            <asp:TextBox ID="txtPhone" runat="server" MaxLength="40" 
                                Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Mobile No</td>
                        <td>
                            <asp:TextBox ID="txtMobile" runat="server" MaxLength="40" 
                                Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            Email</td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" MaxLength="60" 
                                 Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
            </table>
     </asp:Panel>
        <asp:Panel ID="pnlCoverageShow" runat="server" CssClass="ShowDetail"  Width="99%">
		    <div style="float: right; vertical-align: middle">
			    <asp:Image ID="imgCoverageData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			    <asp:Label ID="lblCoverageData" runat="server" CssClass="required">(Show Coverage Data...)</asp:Label>
		    </div>
		    <input id="Button3" style="background-position: left top; width: 24px; cursor: pointer;
			    background-repeat: no-repeat; height: 16px" type="button" noenter />
        </asp:Panel>
	    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPECoverage" runat="server" CollapseControlID="pnlCoverageShow"
		    CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Coverage Data...)"
		    Enabled="True" ExpandControlID="pnlCoverageShow" ExpandedImage="~/images/collapse.jpg"
		    ExpandedText="(Hide Coverage Data...)" ImageControlID="imgCoverageData" TargetControlID="pnlCoverageAreaData"
		    TextLabelID="lblCoverageData">
	    </ajaxToolkit:CollapsiblePanelExtender>
                  
	    <asp:Panel ID="pnlCoverageAreaData" runat="server" Width="100%" Font-Bold="True" >
             <asp:UpdatePanel ID="UpdListBox" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0" width="100%" >
			                <tr>
				                <th class="HeaderStyle" colspan="4">
					                Field Collector Coverage Area</th>
			                </tr>
                                <tr>
                                    <td class="AlternatingRowStyle" style="text-align: right">
                                            <asp:ListBox Runat="server" ID="lvbGroup" SelectionMode="Multiple" DataTextField="COLLECTORAREANAME"
                                            DataValueField="COLLECTORAREAID" Height="150px" 
                                            DataSourceID="sdsCollArea" Width="200px" Rows="10" />
                                    </td>
                                    <td class="FooterStyle" style="text-align: center; vertical-align:middle;">  
                                            <p>
                                                <asp:Button ID="btnMove" runat="server" Text=">>" Height="30px" />
                                            </p>
                                            <p>
                                                <asp:Button ID="btnBack" runat="server"   Text="<<" Height="30px"/>
                                            </p>
                                         
                                    </td>
                                    <td class="RowStyle">
                                        
                                            <asp:ListBox ID="lvbGroupDtl" width="200px" Height="150px" runat="server" 
                                                DataSourceID="sdsCollCoverage" DataTextField="COLLECTORAREANAME" 
                                                DataValueField="COLLECTORAREAID" SelectionMode="Multiple" />
                                    </td>
                                </tr>
                            <tr>
                                <td colspan="3">
                                    <hr />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                      <Triggers>
                         <asp:PostBackTrigger ControlID="ddlCollType" />
                       </Triggers>
             </asp:UpdatePanel>
            </asp:Panel>
        <asp:Panel ID="pnlHandlesShow" runat="server" CssClass="ShowDetail"  Width="99%">
		    <div style="float: right; vertical-align: middle">
			    <asp:Image ID="imgHandlesData" runat="server" AlternateText="(Show Details...)" ImageUrl="~/images/expand.jpg" />
			    <asp:Label ID="lblHandlesData" runat="server" CssClass="required">(Show Handles Data...)</asp:Label>
		    </div>
		    <input id="Button1" style="background-position: left top; width: 24px; cursor: pointer;
			    background-repeat: no-repeat; height: 16px" type="button" noenter />
            </asp:Panel>
	    <ajaxToolkit:CollapsiblePanelExtender ID="ajaxCPEHandles" runat="server" CollapseControlID="pnlHandlesShow"
		        CollapsedImage="~/images/expand.jpg" CollapsedText="(Show Coverage Data...)"
		        Enabled="True" ExpandControlID="pnlHandlesShow" ExpandedImage="~/images/collapse.jpg"
		        ExpandedText="(Hide Handles Data...)" ImageControlID="imgHandlesData" TargetControlID="pnlHandlesData"
		        TextLabelID="lblHandlesData">
	        </ajaxToolkit:CollapsiblePanelExtender>
        <asp:Label ID="lblCollectType" style="display:none" runat="server" ></asp:Label>
        <asp:Panel ID="pnlHandlesData" runat="server" CssClass="ShowDetail"  Width="100%">
    	    <asp:UpdatePanel ID="pnlHandlesUp" runat="server" >
                <ContentTemplate>
                <asp:GridView ID="GvwHandles" runat="server"
                    AutoGenerateColumns="False" DataKeyNames="COLLECTORACTIVITYID" DataSourceID="sdsGridHandle"
                     Width="100%" Caption="Collector - Activity List" 
                    RowHeaderColumn="COLLECTORID">
                    <Columns>
                           <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:label ID="lblCollKey" runat="server" Visible="false" 
                                                Text='<% #DataBinder.Eval(Container.DataItem,"COLLECTORACTIVITYID") %>' />
                                    </ItemTemplate>
                            </asp:TemplateField>
                        
                        <asp:BoundField DataField="ACTIVITYNAME" ItemStyle-Font-Bold="true" HeaderText="Activity" SortExpression="ACTIVITYNAME">
                           <ItemStyle Font-Bold="True" />
                           </asp:BoundField>
                        
                       <asp:TemplateField HeaderText="MAX HANDLED">
                            <Itemstyle HorizontalAlign="Center"/> 
                            <ItemTemplate> 
                                <asp:TextBox ID="txtMaxHandled" runat="server"  
                                    Text='<%# Eval("MAXHANDLE") %>' style="text-align:right" ></asp:TextBox> 
                            </ItemTemplate>                                            
                        </asp:TemplateField>    
                       <asp:TemplateField HeaderText="TARGET/MONTH">
                            <Itemstyle HorizontalAlign="Center"/> 
                            <ItemTemplate> 
                                <asp:TextBox ID="txtMaxTarget" runat="server"  
                                    Text='<%# Eval("TARGET") %>'  style="text-align:right" ></asp:TextBox> 
                            </ItemTemplate>                                            
                        </asp:TemplateField>    
                    </Columns>
                    <EmptyDataTemplate>
                        <uc6:NoDataFound ID="NoDataFound1" runat="server" />
                    </EmptyDataTemplate>
                </asp:GridView>
                <br />
            </ContentTemplate>
               <Triggers>
                 <asp:PostBackTrigger ControlID="ddlCollType" />
               </Triggers>
          </asp:UpdatePanel>
        </asp:Panel>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    <asp:SqlDataSource ID="sdsGridHandle" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT COLLECTORACTIVITYID, ACTIVITYNAME, 
		dbo.f_getMaxHandleByCollectorID(@COLLECTORID, COLLECTORACTIVITYID) AS MAXHANDLE, 
		dbo.f_getTargetByCollectorID(@COLLECTORID, COLLECTORACTIVITYID) AS TARGET 
FROM COLLECTORACTIVITY AS CV WITH (NOLOCK) 
WHERE (COLLECTORTYPE = @COLLECTORTYPE) AND (Deletests = 0)
IF @@ROWCOUNT&lt;=0
	BEGIN
		SELECT COLLECTORACTIVITYID, ACTIVITYNAME, 0 AS MAXHANDLE,
		0 AS TARGET from COLLECTORACTIVITY where COLLECTORTYPE=@COLLECTORTYPE and Deletests=0
		
	END">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="COLLECTORID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="hidCollectorType" Name="COLLECTORTYPE" 
                PropertyName="Value" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:Panel ID="pnlControl" runat="server" CssClass="HeaderStyle" Style="border-right: thin inset; 
		            border-top: thin inset; border-left: thin inset; border-bottom: thin inset" Width="99%" Visible="false" >
                <table cellpadding="0" cellspacing="0" width="100%">
			        <tr>
				        <td>
                            <asp:Label ID="lblMessage" runat="server" CssClass="ErrHighLight" 
			                    Font-Bold="True" Font-Underline="True" Style="text-align: center" 
			                    Visible="False" Width="100%"></asp:Label>
                                <ajaxToolkit:AnimationExtender ID="ajaxAEMessageDtl" runat="server" TargetControlID="lblMessage">
                                     <Animations>
                                        <OnLoad>
                                            <Sequence>
                                                <Pulse Duration="0.5" Iterations="0" />
                                            </Sequence>
                                        </OnLoad>
                                    </Animations>
                                    </ajaxToolkit:AnimationExtender>
                            <asp:Button ID="btnSave" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Save.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Save" ToolTip="Save" 
                                Width="55px" ValidationGroup="Collector" 
                                onclientclick="return CheckUserSPVCollSave();" />
                            <asp:Button ID="btnDelete" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../images/Delete.gif); 
                            background-repeat: no-repeat; text-align: right;" Text="Delete" ToolTip="Delete" 
                                Width="55px" onclientclick="return CheckUserSPVCollDel();" />
                            <asp:Button ID="btnCancel" runat="server"
                            Style="font-size: 8pt; cursor: pointer; background-position: left; background-image: url(../Images/back.png);
                            cursor: pointer; background-repeat: no-repeat;  text-align: right"
                            Text="Back" Width="55px" CausesValidation="False" 
                                ValidationGroup="Collector" />
                        </td>
			        </tr>
                </table>
            </asp:Panel>
         
        	<ajaxToolkit:AlwaysVisibleControlExtender ID="ajaxAVCEControl" runat="server" TargetControlID="pnlControl"
		            VerticalSide="Bottom">
	            </ajaxToolkit:AlwaysVisibleControlExtender>
     <asp:SqlDataSource ID="sdsCollTitle" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, NULL AS COLLECTORTITLECODE, '[CHOOSE TITLE]' AS NAMETYPE UNION ALL SELECT COLLECTORTITLEID, COLLECTORTITLECODE, COLLECTORTITLECODE + ' -  ' + COLLECTORTITLENAME AS COLLECTORTITLENAME FROM COLLECTORTITLE WITH (NOLOCK) ORDER BY COLLECTORTITLECODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollUser" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        SelectCommand="SELECT NULL AS UID, NULL AS USERID, '[CHOOSE USER NAME]' AS USERNAME UNION ALL SELECT UserID, UserID AS USERID, UserID + ' - ' + UserName AS USERNAME FROM APPUSER WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY USERID">
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidCollectorType" runat="server" />
    <asp:SqlDataSource ID="sdsCollGroup" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS COLLGROUPID, NULL AS COLLGROUPCODE, '[CHOOSE COLLECTOR GROUP]' AS COLLGROUPNAME UNION ALL SELECT COLLGROUPID, COLLGROUPCODE, COLLGROUPCODE + ' - ' + COLLGROUPNAME AS COLLGROUPNAME FROM COLLECTORGROUP WITH (NOLOCK) WHERE (Deletests = 0) ORDER BY COLLGROUPCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollHead" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS COLLECTORID, '[CHOOSE COLLECTOR HEAD]' AS COLLECTORNAME UNION ALL SELECT CT.COLLECTORID, CT.COLLECTORNAME FROM COLLECTOR AS CT WITH (NOLOCK) INNER JOIN COLLECTORTITLE AS CL WITH (NOLOCK) ON CT.COLLECTORTITLEID = CL.COLLECTORTITLEID AND CL.SUPERVISOR = 1 WHERE (CT.Deletests = 0) ORDER BY COLLECTORNAME">
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidAction" runat="server" />
    <asp:SqlDataSource ID="sdsTitleType" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CODE, '[SELECT TYPE]' AS NAMETYPE UNION ALL SELECT CODE, CODE + ' - ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (nolock) WHERE (TYPE = 'COLLECTORTYPE') ORDER BY CODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollDpd" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS COLLECTORDPDID, NULL AS COLLECTORDPDCODE, '[CHOOSE COLLECTOR DPD]' AS COLLECTORDPDNAME UNION ALL SELECT COLLECTORDPDID, COLLECTORDPDCODE, COLLECTORDPDCODE + ' - ' + COLLECTORDPDNAME AS COLLECTORDPDNAME FROM COLLECTORDPD WHERE (Deletests = 0) ORDER BY COLLECTORDPDCODE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollCity" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        SelectCommand="SELECT NULL AS CITYID, NULL AS CITYCODE, '[CHOOSE CITY]' AS CITYNAME UNION ALL SELECT CITYID, CITYCODE, CITYCODE + ' - ' + CITYNAME AS CITYNAME FROM CITY WITH (NOLOCK) WHERE (DELETESTS = 0)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollArea" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        
        
        
        
        SelectCommand="SELECT COLLECTORAREAID, COLLECTORAREANAME AS COLLECTORAREANAME FROM COLLECTORAREA WITH (NOLOCK) WHERE (Deletests = 0) AND (NOT EXISTS (SELECT 'X' AS Expr1 FROM COLLECTORCOVERAGE WHERE (COLLECTORAREAID = COLLECTORAREA.COLLECTORAREAID) AND (Deletests = 0) AND (COLLECTORID = @COLLECTORID))) ORDER BY COLLECTORAREANAME">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="COLLECTORID" 
                PropertyName="SelectedValue" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollCoverage" runat="server" 
        ConnectionString="<%$ ConnectionStrings:connection %>" 
        
        SelectCommand="SELECT CG.COLLECTORAREAID, CR.COLLECTORAREANAME AS COLLECTORAREANAME FROM COLLECTORCOVERAGE AS CG WITH (NOLOCK) INNER JOIN COLLECTORAREA AS CR WITH (NOLOCK) ON CR.COLLECTORAREAID = CG.COLLECTORAREAID WHERE (CG.COLLECTORID = @COLLECTORID) AND (CG.Deletests = 0) ORDER BY COLLECTORAREANAME">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvData" Name="COLLECTORID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCollector" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
                SelectCommand="SELECT CT.COLLECTORID, CT.COLLECTORNAME, AU.UID, AU.UserID, AU.UserName, CT.USERLOGIN, CT.COLLECTORTYPE AS CODE, TY.NAMETYPE, CT.COLLECTORTITLEID, '(' + CL.COLLECTORTITLECODE + ') ' + CL.COLLECTORTITLENAME AS COLLECTORTITLENAME, CT.COLLECTORDPDID, CD.COLLECTORDPDNAME, CT.COLLGROUPID, '(' + CG.COLLGROUPCODE + ')' + CG.COLLGROUPNAME AS COLLGROUPNAME, CT.ADDRESS, CT.ZIP, CT.PHONENO, CT.MOBILENO, CT.EMAIL, CT.CITYID, '(' + CI.CITYCODE + ')' + CI.CITYNAME AS COLLGROUPNAME FROM COLLECTOR AS CT WITH (NOLOCK) LEFT OUTER JOIN APPUSER AS AU WITH (NOLOCK) ON CT.COLLECTORID = AU.UID AND AU.Deletests = 0 INNER JOIN (SELECT CODE, '(' + CODE + ') ' + NAME AS NAMETYPE FROM PARAMGLOBAL WITH (NOLOCK) WHERE (TYPE = 'COLLECTORTYPE')) AS TY ON TY.CODE = CT.COLLECTORTYPE INNER JOIN COLLECTORTITLE AS CL WITH (NOLOCK) ON CL.COLLECTORTITLEID = CT.COLLECTORTITLEID INNER JOIN COLLECTORDPD AS CD WITH (NOLOCK) ON CT.COLLECTORDPDID = CD.COLLECTORDPDID INNER JOIN COLLECTORGROUP AS CG WITH (NOLOCK) ON CT.COLLGROUPID = CG.COLLGROUPID INNER JOIN CITY AS CI WITH (NOLOCK) ON CI.CITYID = CT.CITYID WHERE (CT.COLLECTORID = @COLLECTORID)" 
                
        DeleteCommand="UPDATE COLLECTOR SET DELETESTS = 1, LASTUSERID = @UserID, LASTUPDATE = GETDATE() WHERE  (COLLECTORID=@COLLECTORID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTORID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:CookieParameter CookieName="UID" Name="UserID" />
                    <asp:ControlParameter ControlID="gvData" Name="COLLECTORID" 
                        PropertyName="SelectedValue" />
                </DeleteParameters>
                
    </asp:SqlDataSource>
    <script type="text/javascript" src="../include/TabEnter.js"></script>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript">
        FormatTable("<%=GvwHandles.ClientID%>")
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
            var oDivDatahdl = getObjectbyClientID('<%=pnlHandlesData.ClientID%>');
            if (Action == "LOAD") {
                HideAllPanel();
            }
            if (Action == "NEW") {
                displayRowID();
                HidePanelStaf();
                checkFlag();
            }
            if (Action == "EDIT") {
                checkFlag();
                CheckCoverageArea();
                oDivDatahdl.style.display = "";
            }
            if (Action == "SAVE") {
                HideAllPanel();
            }
            if (Action == "SEARCH") {
                HideAllPanel();
            }
            if (Action == "DELETE") {
                HideAllPanel();
            }
            if (Action == "ERROR") {
                checkFlag();
                CheckCoverageArea();
                oDivDatahdl.style.display = "";
            }
        }

        function HideAllPanel() {
            var oDivDatahdl = getObjectbyClientID('<%=pnlHandlesData.ClientID%>');
            var oDivDataCvrg = getObjectbyClientID('<%=pnlCoverageAreaData.ClientID%>');
            var oDivDataColl = getObjectbyClientID('<%=pnlCollectorData.ClientID%>');
            var oDivShowhdl = getObjectbyClientID('<%=pnlHandlesShow.ClientID%>');
            var oDivshowCvrg = getObjectbyClientID('<%=pnlCoverageShow.ClientID%>');
            var oDivshowColl = getObjectbyClientID('<%=pnlCollectorShow.ClientID%>');
            var oDivCtrlColl = getObjectbyClientID('<%=pnlControl.ClientID%>');

            if (oDivDatahdl)
                oDivDatahdl.style.display = "none";

            if (oDivDataCvrg)
                oDivDataCvrg.style.display = "none";

            if (oDivShowhdl)
                oDivShowhdl.style.display = "none";

            if (oDivshowCvrg)
                oDivshowCvrg.style.display = "none";

            if (oDivshowColl)
                oDivshowColl.style.display = "none";

            if (oDivDataColl)
                oDivDataColl.style.display = "none";

            if (oDivCtrlColl)
                oDivCtrlColl.style.display = "none";
        }

        function HidePanelStaf() {
            var oDivDatahdl = getObjectbyClientID('<%=pnlHandlesData.ClientID%>');
            var oDivDataCvrg = getObjectbyClientID('<%=pnlCoverageAreaData.ClientID%>');
            var oDivShowhdl = getObjectbyClientID('<%=pnlHandlesShow.ClientID%>');
            var oDivshowCvrg = getObjectbyClientID('<%=pnlCoverageShow.ClientID%>');

            if (oDivDatahdl)
                oDivDatahdl.style.display = "none";

            if (oDivDataCvrg)
                oDivDataCvrg.style.display = "none";

            if (oDivShowhdl)
                oDivShowhdl.style.display = "none";

            if (oDivshowCvrg)
                oDivshowCvrg.style.display = "none";

        }

        function CheckCoverageArea() {
            var Title = GetValueTxtByClientID('<%=ddlColTitleType.ClientID%>');
            if (Title)
                IsSupervisor(Title);
        }

        function IsLogin() {
            var Title = GetValueTxtByClientID('<%=rbUseLogin_no.ClientID%>');
            var oddlCollUser = getObjectbyClientID("<%=ddlCollUser.ClientID%>");
            var otxtCollCode = getObjectbyClientID("<%=txtCollCodeUser.ClientID%>");
            if (Title == "0") {
                otxtCollCode.style.display = "";
                oddlCollUser.style.display = "none";
            }
            else {
                otxtCollCode.style.display = "none";
                oddlCollUser.style.display = "";
            }
        }

        function IsSupervisor(Title) {
            if (Title != "") {
                ret = GHWService.IsSupervisor(Title, OnCompleteTitle, OnTimeOutTitle, OnErrorTitle);
            }
        }
        function OnCompleteTitle(arg) {
            var oddlCollType = GetValueTxtByClientID('<%=ddlCollType.ClientID%>');
            var oDivDatahdl = getObjectbyClientID('<%=pnlHandlesData.ClientID%>');
            var oDivDataCvrg = getObjectbyClientID('<%=pnlCoverageAreaData.ClientID%>');
            var oDivShowhdl = getObjectbyClientID('<%=pnlHandlesShow.ClientID%>');
            var oDivshowCvrg = getObjectbyClientID('<%=pnlCoverageShow.ClientID%>');
            if (arg == "0") {
                if (oddlCollType == "1") {
                    oDivDataCvrg.style.display = "none";
                    oDivshowCvrg.style.display = "none";
                }
            }
            else {
                oDivDatahdl.style.display = "none";
                oDivDataCvrg.style.display = "none";
                oDivShowhdl.style.display = "none";
                oDivshowCvrg.style.display = "none";
            }
            displayRow(arg)
        }

        function OnTimeOutTitle(arg) {
            alert("TimeOut encountered when calling IsSupervisor.");
        }

        function OnErrorTitle(arg) {
            alert("Error encountered when calling IsSupervisor.");
        }

        function displayRow(arg) {
            var row = getObjectbyClientID("LoginRow");
            var oDivstrddlCollUser = getObjectbyClientID("<%=ddlCollUser.ClientID%>");
            var oDivstrtxtCollCodeUser = getObjectbyClientID('<%=txtCollCodeUser.ClientID%>');
            if (arg == "0") {
                row.style.display = "";
                if (getObjectbyClientID("<%=rbUseLogin_Yes.ClientID%>").checked) {
                    //alert('yes check');
                    oDivstrddlCollUser.style.display = "";
                    oDivstrtxtCollCodeUser.style.display = "none";
                    ValidatorEnable(getObjectbyClientID("<%=reqCollUser.ClientID%>"), true);
                    ValidatorEnable(getObjectbyClientID("<%=reqCollCodeUser.ClientID%>"), false);
                } else {
                    //alert('no check');
                    oDivstrtxtCollCodeUser.style.display = "";
                    oDivstrddlCollUser.style.display = "none";
                    ValidatorEnable(getObjectbyClientID("<%=reqCollUser.ClientID%>"), false);
                    ValidatorEnable(getObjectbyClientID("<%=reqCollCodeUser.ClientID%>"), true);
                }

            }
            else {
                //alert('spv');
                row.style.display = "none";
                oDivstrddlCollUser.style.display = "";
                oDivstrtxtCollCodeUser.style.display = "none";
                ValidatorEnable(getObjectbyClientID("<%=reqCollUser.ClientID%>"), true);
                ValidatorEnable(getObjectbyClientID("<%=reqCollCodeUser.ClientID%>"), false);
            }
        }
        function displayRowID() {
            var row = getObjectbyClientID("CollectRowID");
            row.style.display = "none";
        }

        function checkFlag() {
            var id = "0"
            if (getObjectbyClientID("<%=rbUseLogin_Yes.ClientID%>").checked)
                id = "1";

            var oDivstrddlCollUser = getObjectbyClientID("<%=ddlCollUser.ClientID%>");
            var oDivstrtxtCollCodeUser = getObjectbyClientID('<%=txtCollCodeUser.ClientID%>');
            var oDivstrRbUserNo = getObjectbyClientID('<%=rbUseLogin_No.ClientID%>');
            var oDivstrRbUserYes = getObjectbyClientID('<%=rbUseLogin_Yes.ClientID%>');
            switch (id) {
                case "0":
                  //  alert('no');
                    oDivstrtxtCollCodeUser.style.display = "";
                    oDivstrddlCollUser.style.display = "none";
                    oDivstrRbUserNo.style.display = "";
                    oDivstrddlCollUser.selectedIndex = 0;
                    getObjectbyClientID("<%=rbUseLogin_No.ClientID%>").checked = true;
                    ValidatorEnable(getObjectbyClientID("<%=reqCollUser.ClientID%>"), false);
                    ValidatorEnable(getObjectbyClientID("<%=reqCollCodeUser.ClientID%>"), true);
                    break
                case "1":
                  //  alert('yes');
                    oDivstrtxtCollCodeUser.style.display = "none";
                    oDivstrddlCollUser.style.display = "";
                    oDivstrRbUserYes.style.display = "";
                    getObjectbyClientID("<%=rbUseLogin_Yes.ClientID%>").checked = true;
                    oDivstrddlCollUser.options.length != 0;
                    ValidatorEnable(getObjectbyClientID("<%=reqCollUser.ClientID%>"), true);
                    ValidatorEnable(getObjectbyClientID("<%=reqCollCodeUser.ClientID%>"), false);
                    break
            }
        }
        function checkType(opt) {
            var oDivDataCvrg = getObjectbyClientID('<%=pnlCoverageAreaData.ClientID%>');
            var oDivshowCvrg = getObjectbyClientID('<%=pnlCoverageShow.ClientID%>');
            var oDdlCollType = GetValueTxtByClientID('<%=ddlCollType.ClientID%>');
            var oDivDatahdl = getObjectbyClientID('<%=pnlHandlesData.ClientID%>');
            var oDivShowhdl = getObjectbyClientID('<%=pnlHandlesShow.ClientID%>');
            if (opt == "1") {
                ValidatorEnable(getObjectbyClientID("<%=reqTypeTitle.ClientID%>"), false);
                if (oDdlCollType == "1") {

                    if (oDivDataCvrg)
                        oDivDataCvrg.style.display = "none";
                    if (oDivshowCvrg)
                        oDivshowCvrg.style.display = "none";
                    if (oDivDatahdl)
                        oDivDatahdl.style.display = "";
                    if (oDivShowhdl)
                        oDivShowhdl.style.display = "";
                } else {

                    if (oDivDataCvrg)
                        oDivDataCvrg.style.display = "";
                    if (oDivshowCvrg)
                        oDivshowCvrg.style.display = "";
                    if (oDivDatahdl)
                        oDivDatahdl.style.display = "";
                    if (oDivShowhdl)
                        oDivShowhdl.style.display = "";

                }

            } else {
                ValidatorEnable(getObjectbyClientID("<%=reqTypeTitle.ClientID%>"), true);
            }
        }

        function CheckUserSPVCollSave() {
            if (Page_ClientValidate) {
                if (Page_ClientValidate("")) {
                    var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
                    if (RetVal.Login == 1)
                        return (true);
                    else
                        return (false);
                } else {
                    return (false);
                }
            }
        }

        function CheckUserSPVCollDel() {
            var RetVal = window.showModalDialog("../Home/UserLoginSPV.aspx", "SPVAuthor", "dialogWidth:300px;dialogHeight:200px;center:yes;edge:raised;help:no;status:no;");
            if (RetVal.Login == 1)
                return (true);
            else
                return (false);
        }

    </script>       
   
</asp:Content>
