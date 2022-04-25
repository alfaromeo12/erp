<%@ Page Title="" Language="VB" MasterPageFile="~/MXPage.master" AutoEventWireup="false" CodeFile="MitraSearch.aspx.vb" Inherits="Product_MitraSearch" %>
<%@ Register Src="../UserControl/NoDataFound.ascx" TagName="NoDataFound" TagPrefix="uc6" %>
<%@ Register Src="../UserControl/BtnInsert.ascx" TagName="BtnInsert" TagPrefix="uc4" %>
<%@ Register Src="../UserControl/BtnCancelHTML.ascx" TagName="BtnCancelHTML" TagPrefix="uc5" %>
<%@ Register Src="../UserControl/BtnUpdate.ascx" TagName="BtnUpdate" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/BtnDelete.ascx" TagName="BtnDelete" TagPrefix="uc2" %>
<%@ Register Src="../UserControl/BtnCancel.ascx" TagName="BtnCancel" TagPrefix="uc3" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
<style type="text/css">
.modalBackground
{
	background-color: Gray;
	filter: alpha(opacity=50);
	opacity: 0.50;
}

.updateProgress
{
	background-color: #cccccc;
	position: absolute;
	width: 180px;
	height: 65px;
	border-bottom: thin outset;
	border-left: thin outset;
	border-top: thin outset;
	border-right: thin outset;
	font-weight: bold;
}

</style>

<script type="text/javascript" language="javascript">
    var ModalProgress = '<%=ModalProgress.ClientID%>';
</script>
    <br />
    <asp:Panel ID="pnlData" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
    <asp:DropDownList ID="ddlCriteria" runat="server">
        <asp:ListItem Value="FULLNAME">Full Name</asp:ListItem>
        <asp:ListItem Value="USERNAME">User Name</asp:ListItem>
        <asp:ListItem Value="IDNUMBER">Identity Number</asp:ListItem>
        <asp:ListItem Value="EMAIL">Email</asp:ListItem>
    </asp:DropDownList></td>
        <td>
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button
        ID="btnFunctionSearch" runat="server" Style="font-size: 8pt; border-top-style: outset;
        border-right-style: outset; border-left-style: outset; border-bottom-style: outset"
        Text="Search" CssClass="Search" />
    <ajaxToolkit:textboxwatermarkextender id="ajxTBWESearch" runat="server" targetcontrolid="txtSearch"
        watermarktext="%%">
    </ajaxToolkit:textboxwatermarkextender>
                </td>
            </tr>
        </table>
         </asp:Panel>
    <asp:UpdatePanel ID="UPGrid" runat="server">
        <ContentTemplate>
           <%-- <asp:ImageButton ID="imgBtnNew" runat="server" ImageUrl="~/images/add.gif" CausesValidation="False" CssClass="New" />--%>
        <asp:GridView ID="gvData" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="sdsGrid" Width="100%" 
            DataKeyNames="USERID" Caption="Mitra List" RowHeaderColumn="USERID">
            <Columns>
                <asp:TemplateField HeaderText="Set" SortExpression="USERID">
                    <ItemTemplate>
                        <img src="../images/edit.gif" style="cursor: pointer" onclick="SetMitraFind(<%#Eval("USERID")%>, '<%#Eval("FULLNAME")%>')" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="USERID" HeaderText="ID&lt;br&gt;" HtmlEncode="False"
                SortExpression="USERID" />
                <asp:BoundField DataField="USERNAME" HeaderText="User&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="USERNAME" />
            <asp:BoundField DataField="IDNUMBER" HeaderText="Id&lt;br&gt;Number" HtmlEncode="False"
                SortExpression="IDNUMBER" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="FULLNAME" HeaderText="Full&lt;br&gt;Name" HtmlEncode="False"
                SortExpression="FULLNAME">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="NAME" HeaderText="Gender&lt;br&gt;" HtmlEncode="False"
                SortExpression="NAME">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="BIRTHDAY" HeaderText="Birth&lt;br&gt;Day" HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="BIRTHDAY">
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
             <asp:BoundField DataField="PARTNERTYPENAME" HeaderText="Partner&lt;br&gt;Type" HtmlEncode="False"
                SortExpression="PARTNERTYPENAME" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="SERVICETYPENAME" HeaderText="Service&lt;br&gt;Type" HtmlEncode="False"
                SortExpression="SERVICETYPENAME" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="SERVICETYPEDTLNAME" HeaderText="Service&lt;br&gt;Type Detail" HtmlEncode="False"
                SortExpression="SERVICETYPEDTLNAME" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="BALANCE" HeaderText="Balance&lt;br&gt;" HtmlEncode="False" DataFormatString="{0:N}"
                SortExpression="BALANCE" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="EMAIL" HeaderText="Email&lt;br&gt;" HtmlEncode="False"
                SortExpression="EMAIL" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="MOBILENO" HeaderText="Phone&lt;br&gt;Number" HtmlEncode="False"
                SortExpression="MOBILENO" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="PROVINCENAME" HeaderText="Province&lt;br&gt;" HtmlEncode="False"
                SortExpression="PROVINCENAME" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField><asp:BoundField DataField="KABUPATENNAME" HeaderText="Kabupaten&lt;br&gt;" HtmlEncode="False"
                SortExpression="KABUPATENNAME" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="KECAMATANNAME" HeaderText="Kecamantan&lt;br&gt;" HtmlEncode="False"
                SortExpression="KECAMATANNAME" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="ADDRESS" HeaderText="Address&lt;br&gt;" HtmlEncode="False"
                SortExpression="ADDRESS" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="REGISTERDATE" HeaderText="Regiter&lt;br&gt;Date" HtmlEncode="False"  DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="REGISTERDATE" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Active&lt;br&gt;" SortExpression="Active">
                <ItemTemplate>
                    <%#getActive(DataBinder.Eval(Container.DataItem, "Active"))%>
                </ItemTemplate>            
                <ItemStyle HorizontalAlign="Left" />
            </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <uc6:NoDataFound ID="NoDataFound1" runat="server" />
            </EmptyDataTemplate>
        </asp:GridView>
    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
        SelectCommand="SELECT AUP.USERID,AUP.USERNAME,AUP.IDNUMBER,AUP.FULLNAME,AUP.PASSWORD, AUP.ACTIVE,AUP.BIRTHDAY,AUP.GENDER
								,AUP.EMAIL,AUP.MOBILENO,AUP.ADDRESS,AUP.KECAMATANID,KEC.KECAMATANNAME,AUP.KABUPATENID,KAB.KABUPATENNAME
								,AUP.PROVINCEID,P.PROVINCENAME,AUP.PARTNERTYPEID,PT.PARTNERTYPENAME,AUP.SERVICETYPEID,ST.SERVICETYPENAME
                                ,AUP.SERVICETYPEDTLID,STD.SERVICETYPEDTLNAME,AUP.BALANCE,AUP.IMAGEPROFILE,AUP.IMAGEKTP,AUP.IMAGESKCK,AUP.IMAGESIM,AUP.IMAGESTNK
                                ,AUP.REGISTERDATE,PG.NAME
                                FROM APPUSERPARTNER AUP 
                                LEFT OUTER JOIN PROVINCE P ON AUP.PROVINCEID=P.PROVINCEID
                                LEFT OUTER JOIN PARTNERTYPE PT ON AUP.PARTNERTYPEID=PT.PARTNERTYPEID
								LEFT OUTER JOIN PARAMGLOBAL PG ON AUP.GENDER=PG.CODE
								LEFT OUTER JOIN KECAMATAN KEC ON AUP.KECAMATANID=KEC.KECAMATANID
								LEFT OUTER JOIN KABUPATEN KAB ON AUP.KABUPATENID=KAB.KABUPATENID
								LEFT OUTER JOIN SERVICETYPE ST ON AUP.SERVICETYPEID = ST.SERVICETYPEID
                                LEFT OUTER JOIN SERVICETYPEDTL STD ON AUP.SERVICETYPEDTLID = STD.SERVICETYPEDTLID
                        WHERE AUP.Deletests = 0 AND PG.TYPE = 'GENDER'"></asp:SqlDataSource>
    </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Label ID="lblError" runat="server" Width="100%" Font-Bold="False" 
        style="text-align: center" CssClass="ErrHighLight" Visible="False"></asp:Label>
        <ajaxToolkit:AnimationExtender ID="ajaxAEMessage" runat="server" TargetControlID="lblError">
                 <Animations>
                    <OnLoad>
                        <Sequence>
                            <Pulse Duration="0.5" Iterations="0" />
                        </Sequence>
                    </OnLoad>
                </Animations>
                </ajaxToolkit:AnimationExtender>
    <script type="text/javascript" src="../include/jsUpdateProgress.js"></script>
   <ajaxToolkit:ModalPopupExtender ID="ModalProgress" runat="server" TargetControlID="panelUpdateProgress"
		BackgroundCssClass="modalBackground" PopupControlID="panelUpdateProgress"   />
<asp:Panel ID="panelUpdateProgress" runat="server" CssClass="updateProgress">
    <asp:UpdateProgress ID="UpdateProgMaster" DisplayAfter="0" runat="server" >
        <ProgressTemplate>
            <div style="position: relative; top: 30%; text-align: center;" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/wait.gif" 
                ToolTip="Processing" /><br />
                Processing ...
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Panel>
    <script type="text/javascript" src="../include/TableHighLight.js"></script>
    <script type="text/javascript" src="../Scripts/jquery.elevateZoom-3.0.8.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery.min.js.js"></script>
<script type="text/javascript">
    FormatTable("<%=gvData.ClientID%>");
    TabToEnter();
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        FormatTable("<%=gvData.ClientID%>");
    });
    function GetValueTxtByClientID(ClientID) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            return (oText.value);
    }
    function SetValueTxtByClientID(ClientID, sValue) {
        var oText = document.getElementById ? document.getElementById(ClientID) : document.forms[ClientID];
        if (oText)
            oText.value = sValue;
    }
    function SetMitraFind(USERID, APPUSERPARTNER) {
        window.opener.SetMitraFind(USERID, APPUSERPARTNER);
        window.close();
    }
</script>

</asp:Content>

