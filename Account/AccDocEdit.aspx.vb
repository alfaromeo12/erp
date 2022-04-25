
Partial Class Account_AccDocEdit
    Inherits System.Web.UI.Page
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Page.Theme = GetUserTheme(Request.Cookies("UID").Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblMessage.Visible = False
        If Not IsPostBack() Then
            hidAction.Value = Request.QueryString("ACTION")
            ajaxCPECustData.Collapsed = True
            GetData()
            If hidAction.Value = "INQ" Then
                pnlCollEdit.Visible = False
                btnSave.Visible = False
            End If
        End If

        SetObjectValidation(txtBPKBName, False, "uppercase")
        SetObjectValidation(txtBPKBAddress, False, "uppercase")
        SetObjectValidation(txtBPKBCarType, False, "uppercase")
        SetObjectValidation(txtColor, False, "uppercase")
        SetObjectValidation(txtNmFaktur, False, "uppercase")
        SetObjectValidation(txtPoliceNo, False, "uppercase nospace")
        SetObjectValidation(txtCarYear, False, "integer", "[0-9]")
        SetObjectValidation(txtBuildYear, False, "integer", "[0-9]")
        SetObjectValidation(txtCollateralValue, False, "float", "[0-9.]")
        ddlPurpose.Attributes.Add("onchange", "getNeedRoute();")
        ddlType.Attributes.Add("onchange", "getCC();")
        ddlCondition.Attributes.Add("onchange", "ConditionChange();")
        SetObjectValidation(txtCC, False, "integer", "[0-9]")
    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objFN As New FrontEnd
        Try
            Dim dblOBJID As Double
            dblOBJID = hidObjID.Value
            Dim strMerkID As String = ddlMerkID.SelectedValue
            Dim strMOdelID As String = ddlModelID.SelectedValue
            Dim strProductID As String = ddlProductID.SelectedValue
            Dim strObjectTypeID As String = ddlType.SelectedValue
            Dim strPurposeID As String = ddlPurpose.SelectedValue
            Dim strCategoryID As String = ddlKind.SelectedValue


            If Len(Trim(strMerkID)) <= 0 Then strMerkID = Nothing
            If Len(Trim(strMOdelID)) <= 0 Then strMOdelID = Nothing
            If Len(Trim(strProductID)) <= 0 Then strMOdelID = Nothing
            If Len(Trim(strObjectTypeID)) <= 0 Then strObjectTypeID = Nothing
            If Len(Trim(strPurposeID)) <= 0 Then strPurposeID = Nothing
            If Len(Trim(strCategoryID)) <= 0 Then strCategoryID = Nothing
            'objFN.COLLATERALSave(hidLocID.Value, hidAccID.Value, hidDealerID.Value, strProductID, ddlMerkID.SelectedValue, ddlModelID.SelectedValue, _
            '     txtBPKBNo.Text, ConvertDate(txtBPKBDate.Text), txtBPKBAddress.Text, txtBPKBCity.Value, txtBPKBName.Text, _
            '     txtBPKBOwnerID.Text, txtBPKBCarType.Text, txtEngineNo.Text, txtChasisNo.Text, txtCarYear.Text, txtBuildYear.Text, _
            '     ddlCondition.SelectedValue, txtColor.Text, ddlKind.SelectedValue, ddlPurpose.SelectedValue, _
            '     txtPoliceNo.Text, ConvertDate(txtSTNKExpire.Text), ConvertDate(txtSurveyDate.Text), Request.Cookies("UID").Value, _
            '     ddlBindType.SelectedValue, ddlCollType.SelectedValue, ddlSBRank.SelectedValue, hidRoute.Value, dblOBJID)
            If txtKPExpiredDate.Text = "__/__/____" Then
                txtKPExpiredDate.Text = ""
            End If
            If txtSKExpiredDate.Text = "__/__/____" Then
                txtSKExpiredDate.Text = ""
            End If
            If txtSTNKExpire.Text = "__/__/____" Then
                txtSTNKExpire.Text = ""
            End If
            If txtBPKBDate.Text = "__/__/____" Then
                txtBPKBDate.Text = ""
            End If
            If txtSurveyDate.Text = "__/__/____" Then
                txtSurveyDate.Text = ""
            End If

            objFN.COLLATERALSave(hidLocID.Value, hidAccID.Value, hidDealerID.Value, strProductID, strMerkID, strMOdelID, _
                  strObjectTypeID, txtBPKBNo.Text, ConvertDate(txtBPKBDate.Text), txtBPKBAddress.Text, txtBPKBCity.Value, txtBPKBName.Text, _
                  txtBPKBOwnerID.Text, txtBPKBCarType.Text, txtEngineNo.Text, txtChasisNo.Text, txtCarYear.Text, txtBuildYear.Text, _
                  ddlCondition.SelectedValue, txtColor.Text, strCategoryID, strPurposeID, _
                  txtPoliceNo.Text, ConvertDate(txtSTNKExpire.Text), ConvertDate(txtSurveyDate.Text), _
                  Request.Cookies("UID").Value, ddlBindType.SelectedValue, ddlCollType.SelectedValue, _
                  ddlSBRank.SelectedValue, hidRoute.Value, NoComma(txtCollateralValue.Text), txtNoFaktur.Text, txtNmFaktur.Text, ConvertDate(txtKPExpiredDate.Text), ConvertDate(txtSKExpiredDate.Text), txtCC.Text, dblOBJID)
            'hidObjID.Value = dblOBJID
            GetData()
            lblMessage.Visible = True
            lblMessage.Text = "COLLATERAL DATA SAVED COMPLETED..!"

        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR COLLATERAL DATA SAVED : " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
            btnSave.Visible = False
        Finally
            objFN = Nothing
        End Try
        
    End Sub

    Private Function NoComma(ByVal strValue As String) As String
        NoComma = Replace(strValue, ",", "")
    End Function


    Private Sub GetData()       
        Dim objDB As New DBX
        Try
            Dim oSDR As System.Data.SqlClient.SqlDataReader
            Dim oSDRParam As System.Data.SqlClient.SqlDataReader
            oSDR = objDB.CreateSDRFromSQLSelect("SELECT COLLATERAL.LOCID, COLLATERAL.ACCID, COLLATERAL.OBJID,  " & _
                " MERKID, MODELID, CATEGORYID, PURPOSEID, BPKBCITYID, BPKBNO, BPKBNAME, BPKBOWNERID, " & _
                " BPKBCARTYPE, BPKBDATE, BPKBADDRESS, ENGINENO, CHASSISNO, POLICENO, STNKEXPIRED, CARYEAR, BUILDYEAR, " & _
                " CONDITION, COLOR, BINDTYPEID, COLLATERALTYPEID, SBRANKID, SURVEYDATE, DEALERID, " & _
                " PRODUCTID, OBJECTTYPEID, ROUTEID,CC,COLLATERAL.KPEXPIRED,COLLATERAL.SKEXPIRED,COLLATERAL.FAKTURNO,COLLATERAL.FAKTURNAME, COLLATERALVALUE   FROM COLLATERAL WHERE COLLATERAL.LOCID=" & Request.QueryString("LOCID") & " AND COLLATERAL.OBJID=" & Request.QueryString("OBJID"))
            If oSDR.Read Then
                hidLocID.Value = oSDR("LOCID")
                hidAccID.Value = oSDR("ACCID")
                hidObjID.Value = oSDR("OBJID")
                'lblJFMerkCode.Text = oSDR("MFMERKCODE")
                'lblJFModelCode.Text = oSDR("MFMODELCODE")

                txtBPKBNo.Text = oSDR("BPKBNO").ToString()
                txtBPKBName.Text = oSDR("BPKBNAME").ToString()
                txtBPKBOwnerID.Text = oSDR("BPKBOWNERID").ToString()
                txtBPKBAddress.Text = oSDR("BPKBADDRESS").ToString()
                txtBPKBCarType.Text = oSDR("BPKBCARTYPE").ToString()
                txtBPKBCity.Value = oSDR("BPKBCITYID").ToString()
                txtCC.Text = oSDR("CC").ToString
                txtNoFaktur.Text = oSDR("FAKTURNO").ToString
                txtNmFaktur.Text = oSDR("FAKTURNAME").ToString
                If Not String.IsNullOrEmpty(oSDR("BPKBCITYID").ToString()) Then
                    oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT CITYCODE, CITYNAME " & _
                        "  FROM dbo.CITY WITH(NOLOCK) WHERE CITYID=" & oSDR("BPKBCITYID").ToString())
                    If oSDRParam.Read Then
                        txtBPKBCityName.Text = "(" & oSDRParam("CITYCODE").ToString() & ") " & oSDRParam("CITYNAME").ToString()
                    End If
                    oSDRParam.Close()
                    oSDRParam = Nothing
                Else
                    txtBPKBCityName.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("BINDTYPEID").ToString()) Then
                    ddlBindType.SelectedValue = oSDR("BINDTYPEID")
                End If

                If Not String.IsNullOrEmpty(oSDR("COLLATERALTYPEID").ToString()) Then
                    ddlCollType.SelectedValue = oSDR("COLLATERALTYPEID")
                End If
                If Not String.IsNullOrEmpty(oSDR("KPEXPIRED").ToString()) Then
                    txtKPExpiredDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("KPEXPIRED"))
                Else
                    txtKPExpiredDate.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("SKEXPIRED").ToString()) Then
                    txtSKExpiredDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("SKEXPIRED"))
                Else
                    txtSKExpiredDate.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("CATEGORYID").ToString()) Then
                    ajaxCCDObjCategory.SelectedValue = oSDR("CATEGORYID")
                End If
                If Not String.IsNullOrEmpty(oSDR("PURPOSEID").ToString()) Then
                    ajaxCCDObjPurpose.SelectedValue = oSDR("PURPOSEID")
                End If

                hidDealerID.Value = oSDR("DEALERID").ToString()
                If Not String.IsNullOrEmpty(oSDR("DEALERID").ToString()) Then
                    oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT DEALERID, DEALERCODE, DEALERNAME " & _
                        "  FROM dbo.DEALER WITH(NOLOCK) WHERE DEALERID=" & oSDR("DEALERID").ToString())
                    If oSDRParam.Read Then
                        txtDealerID.Text = "(" & oSDRParam("DEALERCODE").ToString() & ") " & oSDRParam("DEALERNAME").ToString()
                    End If
                    oSDRParam.Close()
                    oSDRParam = Nothing
                Else
                    txtDealerID.Text = ""
                End If

                If Not String.IsNullOrEmpty(oSDR("PRODUCTID").ToString()) Then
                    ajaxCCDProduct.SelectedValue = oSDR("PRODUCTID")
                End If
                If Not String.IsNullOrEmpty(oSDR("MERKID").ToString()) Then
                    ajaxCDDMerk.SelectedValue = oSDR("MERKID")
                End If
                If Not String.IsNullOrEmpty(oSDR("MODELID").ToString()) Then
                    ajaxCDDModel.SelectedValue = oSDR("MODELID")
                End If
                If Not String.IsNullOrEmpty(oSDR("OBJECTTYPEID").ToString()) Then
                    ajaxCCDType.SelectedValue = oSDR("OBJECTTYPEID")
                End If

                If Not String.IsNullOrEmpty(oSDR("SBRANKID").ToString()) Then
                    ddlSBRank.SelectedValue = oSDR("SBRANKID")
                End If

                If Not String.IsNullOrEmpty(oSDR("BPKBDATE").ToString()) Then
                    txtBPKBDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("BPKBDATE"))
                Else
                    txtBPKBDate.Text = ""
                End If
                If Not String.IsNullOrEmpty(oSDR("SURVEYDATE").ToString()) Then
                    txtSurveyDate.Text = String.Format("{0:dd/MM/yyyy}", oSDR("SURVEYDATE"))
                Else
                    txtSurveyDate.Text = ""
                End If
                txtPoliceNo.Text = oSDR("POLICENO").ToString()
                txtEngineNo.Text = oSDR("ENGINENO").ToString()
                txtChasisNo.Text = oSDR("CHASSISNO").ToString()
                If Not String.IsNullOrEmpty(oSDR("STNKEXPIRED").ToString()) Then
                    txtSTNKExpire.Text = String.Format("{0:dd/MM/yyyy}", oSDR("STNKEXPIRED"))
                Else
                    txtSTNKExpire.Text = ""
                End If
                txtCarYear.Text = oSDR("CARYEAR").ToString()
                txtBuildYear.Text = oSDR("BUILDYEAR").ToString()
                If Not String.IsNullOrEmpty(oSDR("CONDITION").ToString()) Then
                    ddlCondition.SelectedValue = oSDR("CONDITION")
                End If
                txtColor.Text = oSDR("COLOR").ToString()
                hidRoute.Value = oSDR("ROUTEID").ToString()
                If Not String.IsNullOrEmpty(oSDR("ROUTEID").ToString()) Then
                    oSDRParam = objDB.CreateSDRFromSQLSelect("SELECT ROUTEID, ROUTENO, ROUTENAME" & _
                        "  FROM dbo.ROUTE WITH(NOLOCK) WHERE ROUTEID=" & oSDR("ROUTEID").ToString())
                    If oSDRParam.Read Then
                        txtRoute.Text = "(" & oSDRParam("ROUTENO").ToString() & ") " & oSDRParam("ROUTENAME").ToString()
                    End If
                    oSDRParam.Close()
                    oSDRParam = Nothing
                Else
                    txtRoute.Text = ""
                End If

                If Not String.IsNullOrEmpty(oSDR("COLLATERALVALUE").ToString()) Then
                    txtCollateralValue.Text = String.Format("{0:N}", oSDR("COLLATERALVALUE"))
                Else
                    txtCollateralValue.Text = "0"
                End If

            End If
            fvCollateral.DataBind()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "ERROR LOADING COLLATERAL EDITING: " & ex.Message & "<BR>PLEASE CHECK DETAIL ERROR MESSAGE...!"
        Finally
            objDB.Close()
            objDB = Nothing
        End Try

    End Sub

End Class
