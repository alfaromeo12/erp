function Err() {
	/*********************************************************************
	Method:   Err.clear
	Purpose:  Clear values from Error object
	Inputs:   none
	Returns:  undefined
	*********************************************************************/
	this.clear = function () {
		this.source = new Object;
		this.type = new Object;
		this.format = new String;
	}
	/*********************************************************************
	Method:   Err.add
	Purpose:  Adds error to Error object
	Inputs:   oSource - source element object
	vType   - integer value of error type (or custom string)
	sFormat - optional date format
	Returns:  undefined
	*********************************************************************/
	this.add = function (oSource, vType, sFormat) {
		this.source = oSource;
		this.type = vType;
		this.format = sFormat;
	}
	/*********************************************************************
	Method:   Err.raise
	Purpose:  Gives visual warning to user about all errors contained in
	the Error object
	Inputs:   none
	Returns:  undefined
	*********************************************************************/
	this.raise = function () {
		//modi utk stop process
		var hProc = document.getElementById('hProc');
		if (hProc) {
			hProc.value = "0";
		}
		if (document.all) {
			if (document.all.loadingmsgX)
				document.all.loadingmsgX.style.visibility = 'hidden';
		} else {
			var oLoading = document.getElementById('loadingmsgX');
			if (oLoading)
				oLoading.style.visibility = 'hidden';
		}
		var oElement = this.source;
		var sLang;
		//var sNym = oElement.getAttribute("nym");
		var sNym = funcs.getAttr(oElement, "nym");
		// if type is not a number, it must be a custom error message
		//var sMsg = (typeof this.type == "string") ? this.type : oElement.getAttribute("msg");
		var sMsg = (typeof this.type == "string") ? this.type : funcs.getAttr(oElement, "msg");

		oElement.paint();
		if (oElement.select)
			oElement.select();
		if (sMsg)
			alert(sMsg);
		else {
			// Walk through object hierarchy to find applicable language
			var oParent = oElement;
			/*if (oParent.getAttribute("lang"))
			sLang = oParent.getAttribute("lang").substring(0, 2).toLowerCase();*/
			if (funcs.getAttr(oParent, "lang"))
				sLang = funcs.getAttr(oParent, "lang").substring(0, 2).toLowerCase();

			while (!sLang || !_validation.messages[sLang]) {
				oParent = oParent.parentElement;
				if (oParent) {
					/*if (oParent.getAttribute("lang"))
					sLang = oParent.getAttribute("lang").substring(0, 2).toLowerCase();*/
					if (funcs.getAttr(oParent, "lang"))
						sLang = funcs.getAttr(oParent, "lang").substring(0, 2).toLowerCase();
				}
				else
				// Default language is English
					sLang = "en";
			}
			sMsg = _validation.messages[sLang][this.type];
			alert(((sNym) ? sNym + ": " : "") + sMsg + ((this.format)
				? " " + this.format.reformat(sLang, this.type) : ""));
		}

		// Perform onvalidatefocus event handler for invalid field
		if (oElement.onvalidatefocus)
			oElement.onvalidatefocus();

		// Give invalid field focus
		oElement.focus();
		// Clear the Err object
		this.clear();
	}

	// Define the working object model
	this.clear();
}

var funcs = {
	getAttr: function (ele, attr) {
		var result = (ele.getAttribute && ele.getAttribute(attr)) || null;
		if (!result) {
			var attrs = ele.attributes;
			var length = attrs.length;
			for (var i = 0; i < length; i++)
				if (attrs[i].nodeName === attr)
					result = attrs[i].nodeValue;
		}
		return result;
	}
};
/*====================================================================
Function: Validation
Purpose:  Custom object constructor.
Inputs:   None
Returns:  undefined
====================================================================*/
function Validation() {
	// Define global constants for calls to error message arrays
	this.REQUIRED = 0;
	this.INTEGER = 1;
	this.FLOAT = 2;
	this.DATE = 3;
	this.AMOUNT = 4;
	this.MASK = 5;
	this.LEN = 6;

	// Create error message dictionary
	this.messages = new Array;

	// Prototype the date tokens for each language
	Array.prototype.DD = new String;
	Array.prototype.MM = new String;
	Array.prototype.YYYY = new String;

	//English
	this.messages["en"] = new Array(
		"This Field must be Entered",
		"Please Enter Integer Value",
		"Enter the correct number value",
		"Enter the correct Date",
		"Masukkan Nilai Uang dengan dua angka belakang titik",
		"Enter values of ",
		"");
	with (this.messages["en"]) {
		DD = "Day";
		MM = "Month";
		YYYY = "Year";
	}

	/*********************************************************************
	Method:   Validation.setDefault
	Purpose:  Set value for variable v if v is zero, empty string or
	undefined
	Inputs:   v - variable (passed by value)
	d - default value
	Returns:  v or d
	*********************************************************************/
	this.setDefault = function (v, d) {
		return (v) ? v : d;
	}
	/*********************************************************************
	Method:   Validation.isDate
	Purpose:  Check that value is a date of the correct format
	Inputs:   oElement - form element
	sFormat  - string format
	Returns:  boolean
	*********************************************************************/
	this.isDate = function (oElement, sFormat) {

		var sDate = oElement.value;

		//Additional

		//var ss=sDate.split("/");
		//alert(ss.ubound());

		if (sDate.indexOf("/") == -1) {
			oElement.value = sDate.substr(0, 2) + "/" + sDate.substr(2, 2) + "/" + sDate.substr(4, 4);
			sDate = oElement.value;
		}

		var aDaysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

		// Fetch the date separator from the user's input
		var sSepDate = sDate.charAt(sDate.search(/\D/));
		// Fetch the date separator from the format
		var sSepFormat = sFormat.charAt(sFormat.search(/[^MDY]/i));
		// Compare separators
		if (sSepDate != sSepFormat)
			return false;

		// Fetch the three pieces of the date from the user's input and the format
		var aValueMDY = sDate.split(sSepDate, 3);
		var aFormatMDY = sFormat.split(sSepFormat, 3);
		var iDay, iMonth, iYear;

		// Validate that all pieces of the date are numbers
		if (!_validation.isNum(aValueMDY[0])
			|| !_validation.isNum(aValueMDY[1])
			|| !_validation.isNum(aValueMDY[2]))
			return false;

		// Assign day, month, year based on format
		switch (aFormatMDY[0].toUpperCase()) {
			case "YYYY":
				iYear = aValueMDY[0];
				break;
			case "MM":
				iMonth = aValueMDY[0];
				break;
			case "DD":
				iDay = aValueMDY[0];
				break;

			default:
				return false;
		}
		switch (aFormatMDY[1].toUpperCase()) {
			case "YYYY":
				iYear = aValueMDY[1];
				break;
			case "MM":
				iMonth = aValueMDY[1];
				break;
			case "DD":
				iDay = aValueMDY[1];
				break;

			default:
				return false;
		}
		switch (aFormatMDY[2].toUpperCase()) {
			case "YYYY":
				iYear = aValueMDY[2];
				break;
			case "MM":
				iMonth = aValueMDY[2];
				break;
			case "DD":
				iDay = aValueMDY[2];
				break;

			default:
				return false;
		}
		//yEAR BOLEH 2 DIGIT JADI DI REMARK
		// Require 4 digit year
		//if(oElement.form.getAttribute("year4")!=null && iYear.length!=4)
		//	return false;

		// Process pivot date and update field

		/*var iPivot=_validation.setDefault(oElement.getAttribute("pivot"),
		oElement.form.getAttribute("pivot"));*/
		var iPivot = _validation.setDefault(funcs.getAttr(oElement, "pivot"),
			funcs.getAttr(oElement.form, "pivot"));
		if (iPivot && iPivot.length == 2 && iYear.length == 2) {
			iYear = ((iYear > iPivot) ? 19 : 20).toString() + iYear;
			var sValue = aFormatMDY.join(sSepFormat).replace(/DD/i, iDay);
			sValue = sValue.replace(/MM/i, iMonth).replace(/YYYY/i, iYear);
			oElement.value = sValue;
		}

		// Check for leap year
		var iDaysInMonth = (iMonth != 2) ? aDaysInMonth[iMonth - 1] :
			((iYear % 4 == 0 && iYear % 100 != 0 || iYear % 400 == 0) ? 29 : 28);

		return (iDay != null && iMonth != null && iYear != null
				&& iMonth < 13 && iMonth > 0 && iDay > 0 && iDay <= iDaysInMonth);
	}
	/********************************************
	Method:   Validation.isNum
	Purpose:  Check that parameter is a number
	Inputs:   v - string value
	Returns:  boolean
	********************************************/
	this.isNum = function (v) {

		if (v != null) {
			return (v.toString() && !/\D/.test(v));
		}
	}
	/*********************************************************************
	Method:   Validation.setup
	Purpose:  Set up methods and event handlers for all forms and elements
	Inputs:   none
	Returns:  undefined
	*********************************************************************/
	this.setup = function () {
	    // Fan through forms on page to perform initializations
	    var i, iForms = document.forms.length;
	    for (i = 0; i < iForms; i++) {
	        var oForm = document.forms[i];
	        if (!oForm.bProcessed) {
	            /*********************************************
	            Method:   Form.markRequired
	            Purpose:  Mark all required fields for a form
	            Inputs:   none
	            Returns:  undefined
	            *********************************************/
	            oForm.markRequired = function () {
	                var i, iElements = this.elements.length;
	                var sMarkHTML, sMarkWhere;
	                for (i = 0; i < iElements; i++) {
	                    var oElement = this.elements[i];
	                    // Perform onmark event handler
	                    if (oElement.onmark && oElement.onmark() == false) {
	                        continue;
	                    }
	                    //alert(oElement("required"));
	                    //if (oElement.getAttribute("required") != null) {
	                    if (funcs.getAttr(oElement, "required") != null) {
	                        //sMarkHTML = this.getAttribute("insert");
	                        sMarkHTML = funcs.getAttr(this, "insert");
	                        //sMarkWhere = this.getAttribute("mark");
	                        sMarkWhere = funcs.getAttr(this, "mark");

	                        if (sMarkHTML) {
	                            switch (sMarkWhere.toLowerCase()) {
	                                case "before":
	                                    sMarkWhere = "beforeBegin";
	                                    break;
	                                default:
	                                    sMarkWhere = "afterEnd";
	                            }
	                            oElement.insertAdjacentHTML(sMarkWhere, sMarkHTML);
	                        } else {
	                            var sClassName = oElement.className;
	                            if (sClassName != "required") {
	                                oElement.setAttribute("nonreqClass", oElement.className);
	                                oElement.className = "required";
	                            } else {
	                                //oElement.className = _validation.setDefault(oElement.getAttribute("nonreqClass"), oElement.className);
	                                oElement.className = _validation.setDefault(funcs.getAttr(oElement, "nonreqClass"), oElement.className);
	                                oElement.removeAttribute("nonreqClass");
	                            }
	                        }
	                    }
	                }
	            }
	            //var sValidateWhen = oForm.getAttribute("validate");
	            sValidateWhen = funcs.getAttr(oForm, "validate");
	            if (sValidateWhen != null) {
	                //
	                // Capture and replace onreset and onsubmit event handlers
	                //
	                oForm.fSubmit = oForm.onsubmit;
	                oForm.fReset = oForm.onreset;
	                // Create new event handlers
	                oForm.onsubmit = function () {

	                    var i, oElement, iElements = this.elements.length;
	                    // Restore all elements to original style
	                    for (i = 0; i < iElements; i++) {
	                        if (this.elements[i].restore)
	                            this.elements[i].restore();
	                    }
	                    // Validate individual elements
	                    for (i = 0; i < iElements; i++) {
	                        oElement = this.elements[i];
	                        // Perform default validation for element
	                        if (oElement.valid) {
	                            if (!oElement.valid()) {
	                                _err.raise();
	                                if (window.event)
	                                    event.returnValue = false;
	                                return;
	                            }
	                        }
	                    }

	                    // Perform original onsubmit event handler
	                    if (this.fSubmit && this.fSubmit() == false) {
	                        event.returnValue = false;
	                        return;
	                    }
	                    // Insert default values just before submit
	                    var vDefault;
	                    for (i = 0; i < iElements; i++) {
	                        oElement = this.elements[i];
	                        //vDefault = oElement.getAttribute("default");
	                        vDefault = funcs.getAttr(oElement, "default");

	                        if (vDefault && !oElement.value)
	                            oElement.value = vDefault;
	                    }
	                }
	                oForm.onreset = function () {
	                    var i, iElements = this.elements.length;
	                    for (i = 0; i < iElements; i++)
	                        this.elements[i].restore();
	                    // Perform original event handler if present
	                    if (this.fReset && this.fReset() == false)
	                        event.returnValue = false;
	                }
	            }
	            oForm.bProcessed = true;
	        }
	        // Create Input methods
	        var j, iElements = oForm.elements.length;
	        for (j = 0; j < iElements; j++) {
	            var oElement = oForm.elements[j];
	            if (!oElement.bProcessed) {
	                // All event handlers are presumed to be strings/functions
	                // at parse-time and assigned only as functions at run-time.
	                // Create custom onvalidate event handlers
	                //var vOnValidate = oElement.getAttribute("onvalidate");
	                var vOnValidate = funcs.getAttr(oElement, "onvalidate");
	                if (vOnValidate) {
	                    if (typeof vOnValidate != "function")
	                        oElement.onvalidate = new Function(vOnValidate);
	                    else
	                        oElement.onvalidate = vOnValidate;
	                }
	                // Create custom handler for onvalidatefocus event
	                //var vOnValidateFocus = oElement.getAttribute("onvalidatefocus");
	                var vOnValidateFocus = funcs.getAttr(oElement, "onvalidatefocus");

	                if (vOnValidateFocus) {
	                    if (typeof vOnValidateFocus != "function")
	                        oElement.onvalidatefocus = new Function(vOnValidateFocus);
	                    else
	                        oElement.onvalidatefocus = vOnValidateFocus;
	                }
	                // Custom onmark event handler
	                //var vOnMark = oElement.getAttribute("onmark");
	                var vOnMark = funcs.getAttr(oElement, "onmark");

	                if (vOnMark) {
	                    if (typeof vOnMark != "function")
	                        oElement.onmark = new Function(vOnMark);
	                    else
	                        oElement.onmark = vOnMark;
	                }
	                // Custom onkeypress filtering for text fields
	                if (oElement.onkeypress)
	                    oElement.fKeypress = oElement.onkeypress;

	                if (window.event) {
	                    oElement.onkeypress = function () {
	                        if (this.fKeypress && this.fKeypress() == false)
	                            event.returnValue = false;
	                        //var sFilter = this.getAttribute("filter");
	                        var sFilter = funcs.getAttr(this, "filter");

	                        if (sFilter) {
	                            var sKey = String.fromCharCode(event.keyCode);
	                            var re = new RegExp(sFilter);
	                            // Do not filter out ENTER!
	                            if (sKey != "\r" && !re.test(sKey))
	                                event.returnValue = false;
	                            event.keyCode = sKey.charCodeAt(0);
	                        }
	                    }
	                } else {
	                    oElement.onkeypress = function (event) {
	                        if (event == null)
	                            event = event || window.event;

	                        //if (this.fKeypress && this.fKeypress(event) == false) {
	                        if (this.fKeypress) {
	                            if (this.fKeypress(event) == false) {
	                                if (event.preventDefault)
	                                    event.preventDefault();
	                                else
	                                    event.returnValue = false;
	                            }
	                        }
	                        var evtwhich;
	                        evtwhich = event.which || event.keyCode;
	                        if (!(evtwhich == 0 || evtwhich == 8 || evtwhich == 9)) {
	                            //var sFilter = this.getAttribute("filter");
	                            var sFilter = funcs.getAttr(this, "filter");

	                            if (sFilter) {
	                                var sKey = String.fromCharCode(evtwhich);
	                                var re = new RegExp(sFilter);
	                                // Do not filter out ENTER!
	                                if (sKey != "\r" && !re.test(sKey)) {
	                                    if (event.preventDefault)
	                                        event.preventDefault();
	                                    else
	                                        event.returnValue = false;
	                                }
	                                if (event.which)
	                                    event.which = sKey.charCodeAt(0);
	                                else
	                                    event.keyCode = sKey.charCodeAt(0);
	                            }
	                        }
	                    }
	                }

	                // Custom onchange validation
	                if (sValidateWhen == "onchange") {
	                    // Capture and replace onchange event handlers
	                    if (oElement.onchange)
	                        oElement.fChange = oElement.onchange;

	                    if (window.event) {
	                        oElement.onchange = function () {
	                            this.restore();
	                            if (!this.valid()) {
	                                _err.raise();
	                                event.returnValue = false;
	                            }
	                            if (this.fChange && this.fChange() == false) {
	                                event.returnValue = false;
	                            }
	                        }
	                    } else {
	                        oElement.onchange = function (event) {
	                            if (event == null)
	                                event = event || window.event;
	                            this.restore();
	                            if (!this.valid()) {
	                                _err.raise();
	                                if (event.preventDefault)
	                                    event.preventDefault();
	                                else
	                                    event.returnValue = false;
	                            }
	                            if (this.fChange && this.fChange(event) == "undefined") {
	                                event.preventDefault();
	                            }
	                        }


	                    }
	                }
	                /***********************************
	                Method:   Input.paint
	                Purpose:  Change style of element
	                Inputs:   none
	                Returns:  undefined
	                ***********************************/
	                oElement.paint = function () {
	                    /*var sColor = _validation.setDefault(
	                    this.getAttribute("invalidColor"),
	                    this.form.getAttribute("invalidColor"));*/
	                    var sColor = _validation.setDefault(
							funcs.getAttr(this, "invalidColor"),
							funcs.getAttr(this.form, "invalidColor"));

	                    if (!sColor) {
	                        // Paint element by changing class
	                        this.setAttribute("oldClass", this.className);
	                        this.className = "invalid";
	                    } else {
	                        // Paint element by changing color directly
	                        this.setAttribute("bg", this.style.backgroundColor);
	                        this.style.backgroundColor = sColor;
	                    }
	                }
	                /********************************************
	                Method:   Input.restore
	                Purpose:  Restore element to original style
	                Inputs:   none
	                Returns:  undefined
	                ********************************************/
	                oElement.restore = function () {
	                    //var sBG = this.getAttribute("bg");
	                    var sBG = funcs.getAttr(this, "bg");

	                    if (sBG != null) {
	                        // Revert to previous background color
	                        this.style.backgroundColor = sBG;
	                        this.removeAttribute("bg");
	                    } else {
	                        //var sOldClass = this.getAttribute("oldClass");
	                        var sOldClass = funcs.getAttr(this, "oldClass");
	                        if (sOldClass != null) {
	                            // Revert to previous class
	                            this.className = sOldClass;
	                            this.removeAttribute("oldClass");
	                        }
	                    }
	                }
	                /**********************************************
	                Method:   Input.valid
	                Purpose:  Validate an element based on the
	                attributes provided in the HTML text
	                Inputs:   none
	                Returns:  boolean
	                **********************************************/
	                oElement.valid = function () {
	                    var sType = this.type;
	                    if (sType == "text" || sType == "textarea" || sType == "file") {
	                        // Trim leading and trailing spaces

	                        //if (this.form.getAttribute("notrim") == null)
	                        if (funcs.getAttr(this.form, "notrim") == null)
	                            this.value = this.value.trim();
	                        // Remove any Server Side Include text
	                        //if (this.form.getAttribute("ssi") == null) {
	                        if (funcs.getAttr(this.form, "ssi") == null) {
	                            while (this.value.search("<!-" + "-#") > -1)
	                                this.value = this.value.replace("<" + "!--#", "<" + "!--");
	                        }
	                    }
	                    // REQUIRED
	                    //if (this.getAttribute("required") != null && !this.value) {
	                    if (funcs.getAttr(this, "required") != null && !this.value) {
	                        _err.add(this, _validation.REQUIRED, null);
	                        return false;
	                    }
	                    // FLOAT
	                    //var sFloatDelimiter = this.getAttribute("float");
	                    var sFloatDelimiter = funcs.getAttr(this, "float");
	                    //var bSigned = this.getAttribute("signed") != null;
	                    var bSigned = funcs.getAttr(this, "signed") != null;
	                    //var sDecimal = this.getAttribute("decimal");
	                    var sDecimal = funcs.getAttr(this, "decimal");
	                    if (sFloatDelimiter != null && this.value) {
	                        var sNumber
	                        sNumber = this.value;
	                        //alert("1")
	                        this.value = FormatNumberClear(sNumber)

	                        // Assign default value to delimiter
	                        sFloatDelimiter = (sFloatDelimiter == ",") ? "," : "\\.";
	                        var re = new RegExp("^(" + ((bSigned) ? "[\\-\\+]?" : "") + "(\\d*" + sFloatDelimiter + "?\\d+)|(\\d+" + sFloatDelimiter + "?\\d*))$");
	                        if (!re.test(this.value)) {
	                            _err.add(this, _validation.FLOAT, null);
	                            return false;
	                        }
	                        sNumber = this.value;
	                        this.value = FormatNumber(sNumber, 'True', sDecimal);
	                    }

	                    // AMOUNT
	                    //var sAmtDelimiter = this.getAttribute("amount");
	                    var sAmtDelimiter = funcs.getAttr(this, "amount");

	                    if (sAmtDelimiter != null && this.value) {
	                        // Assign default value to delimiter

	                        var sNumber
	                        sNumber = this.value;
	                        this.value = FormatNumberClear(sNumber)

	                        sAmtDelimiter = (sAmtDelimiter == ",") ? "," : "\\.";
	                        var re = new RegExp("^" + ((bSigned) ? "[\\-\\+]?" : "") + "\\d+(" + sAmtDelimiter + "\\d{2})?$");
	                        if (!re.test(this.value)) {
	                            _err.add(this, _validation.AMOUNT, null);
	                            return false;
	                        }
	                        sNumber = this.value;
	                        this.value = FormatNumber(sNumber, 'True', 2);
	                    }
	                    // INTEGER	                    
	                    //if (this.getAttribute("integer") != null && this.value) {
	                    if (funcs.getAttr(this, "integer") != null && this.value) {
	                        var re = new RegExp("^" + ((bSigned) ? "[\\-\\+]?" : "") + "\\d+$");
	                        if (!re.test(this.value)) {
	                            _err.add(this, _validation.INTEGER, null);
	                            return false;
	                        }
	                    }
	                    // DATE
	                    //var sFormat = this.getAttribute("date");
	                    var sFormat = funcs.getAttr(this, "date");
	                    if (sFormat != null && this.value) {
	                        // Set default date format
	                        sFormat = _validation.setDefault(sFormat, "DD/MM/YYYY");
	                        if (this.value != "__/__/____") {
	                            if (!_validation.isDate(this, sFormat)) {
	                                _err.add(this, _validation.DATE, sFormat.toUpperCase());
	                                return false;
	                            }
	                        }
	                    }
	                    // DATETIME
	                    //var sFormat = this.getAttribute("datetime");
	                    var sFormat = funcs.getAttr(this, "datetime");
	                    if (sFormat != null && this.value) {
	                        // Set default date format
	                        sFormat = _validation.setDefault(sFormat, "DD/MM/YYYY");
	                        if (!_validation.isDate(this, sFormat)) {
	                            _err.add(this, _validation.DATE, sFormat.toUpperCase());
	                            return false;
	                        }
	                    }
	                    // MASK
	                    //var sMask = this.getAttribute("mask");
	                    var sMask = funcs.getAttr(this, "mask");
	                    if (sMask && this.value) {
	                        var sPattern = sMask.replace(
								/(\$|\^|\*|\(|\)|\+|\.|\?|\\|\{|\}|\||\[|\])/g, "\\$1");
	                        sPattern = sPattern.replace(/9/g, "\\d");
	                        sPattern = sPattern.replace(/x/ig, ".");
	                        sPattern = sPattern.replace(/z/ig, "\\d?");
	                        sPattern = sPattern.replace(/a/ig, "[A-Za-z]");
	                        var re = new RegExp("^" + sPattern + "$");
	                        if (!re.test(this.value)) {
	                            _err.add(this, _validation.MASK, sMask);
	                            return false;
	                        }
	                    }
	                    // REGEXP
	                    //var sRegexp = this.getAttribute("regexp");
	                    var sRegexp = funcs.getAttr(this, "regexp");
	                    if (sRegexp && this.value) {
	                        var re = new RegExp(sRegexp);
	                        if (!re.test(this.value)) {
	                            _err.add(this, _validation.MASK, sRegexp);
	                            return false;
	                        }
	                    }
	                    // AND
	                    //var sAnd = this.getAttribute("and");
	                    var sAnd = funcs.getAttr(this, "and");
	                    if (sAnd && this.value) {
	                        var aAnd = sAnd.split(/,/);
	                        var i, iFields = aAnd.length;
	                        // Require each element in the list if this element is valued
	                        for (i = 0; i < iFields; i++) {
	                            var oNewElement = this.form.elements[aAnd[i]];
	                            if (oNewElement && oNewElement.value.trim() == "") {
	                                _err.add(oNewElement, _validation.REQUIRED, null);
	                                return false;
	                            }
	                        }
	                    }
	                    // OR
	                    //var sOr = this.getAttribute("or");
	                    var sOr = funcs.getAttr(this, "or");
	                    if (sOr && this.value == "") {
	                        var aOr = sOr.split(/,/);
	                        var i, iFields = aOr.length;
	                        var oNewElement, bAccum = false;
	                        for (i = 0; i < iFields; i++) {
	                            oNewElement = this.form.elements[aOr[i]];
	                            if (oNewElement)
	                                bAccum = bAccum || oNewElement.value.trim();
	                        }
	                        if (!bAccum) {
	                            _err.add(this, _validation.REQUIRED, null);
	                            return false;
	                        }
	                    }
	                    // NOSPACE
	                    //if (this.getAttribute("nospace") != null)
	                    if (funcs.getAttr(this, "nospace") != null)
	                        this.value = this.value.replace(/\s/g, "");
	                    // UPPERCASE
	                    //if (this.getAttribute("uppercase") != null)
	                    if (funcs.getAttr(this, "uppercase") != null)
	                        this.value = this.value.toUpperCase();
	                    // LOWERCASE
	                    //if (this.getAttribute("lowercase") != null)
	                    if (funcs.getAttr(this, "lowercase") != null)
	                        this.value = this.value.toLowerCase();
	                    // Perform onvalidate event handler
	                    if (this.onvalidate && this.onvalidate() == false)
	                        return false;

	                    //var slen = this.getAttribute("len");
	                    var slen = funcs.getAttr(this, "len");
	                    if (slen != null && this.value) {
	                        if (slen.length <= 0)
	                            slen = "0"
	                        if (this.value.length < parseFloat(slen)) {
	                            _err.add(this, _validation.LEN, "Input cannot be less then " + slen + " character");
	                            return false;
	                        }


	                    }

	                    return true;
	                }
	                this.bProcessed = true;
	            }
	        }
	    }
	}
}

/*====================================================================
Function: __init
Purpose:  Sets up validation routines and captures event handlers that
exist on the form already for the onsubmit and onreset events.
Creates methods on FORMs and INPUTs.
====================================================================*/

function __init() {
	// Limit use of script to valid environments
	if ("".replace && document.body && document.body.getAttribute) {

		/*********************************************************************
		Method:   String.trim
		Purpose:  Removing leading and trailing spaces
		Inputs:   none
		Returns:  string
		*********************************************************************/
		String.prototype.trim = function () {
			return this.replace(/^\s+/, "").replace(/\s+$/, "");
		}
		/*********************************************************************
		Method:   String.reformat
		Purpose:  Translate the date format into the correct language
		Inputs:   sLang   - language of error message to display
		iType   - type of failed validation
		Returns:  string
		*********************************************************************/
		String.prototype.reformat = function (sLang, iType) {
			var sString = this.valueOf();
			if (iType == _validation.DATE && _validation.messages[sLang]) {
				sString = sString.replace(/DD/, _validation.messages[sLang].DD);
				sString = sString.replace(/MM/, _validation.messages[sLang].MM);
				sString = sString.replace(/YYYY/, _validation.messages[sLang].YYYY);
			}
			return sString;
		}

		// Form setup
		if (document.forms) {
			// Create custom objects
			_validation = new Validation;
			_err = new Err;

			// Process forms and elements
			_validation.setup();

			var i, iForms = document.forms.length;
			for (i = 0; i < iForms; i++) {
				var oForm = document.forms[i];

				//if(oForm.getAttribute("mark")!=null){
				if (funcs.getAttr(oForm, "mark") != null) {
					oForm.markRequired();
				}
			}
		}
	}
}
__init();

function getCurrentDate(field){
	var d, s;
	d = new Date();
	s = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getYear();
	if(field.value==""){
		field.value=s;
	}
	//getCurrentDate()=s;
}

function RoundToNdp(X, N) { var T = Number('1e'+N)
  return Math.round(X*T)/T 
}

function toNumeric(theValue) {
	var ValX = parseFloat(FormatNumberClear(theValue));
	if (isNaN(ValX))
		ValX = 0;
	return (ValX);
}

function FormatNumber(Value, Comma, DecimalPoint) {
	//=====================================================
	if (Comma == null)
		Comma='True'
  var Pos, i, Count3;
  var strValue, strBefore, strAfter, strReturn;
  var blnSign=false;
  var ValueAbsolute;
  //var ValueFix = toNumeric(Value).toFixed(DecimalPoint);
  var ValueFix = Value;
  //strValue = Value.toString();
  strValue = ValueFix.toString();
  if(strValue==""){
	strValue="0"
  }



  if(parseFloat(strValue)<0){
	blnSign=true;
	ValueAbsolute=(-1 * Value);
	strValue=ValueAbsolute.toString();
  }

  Pos = strValue.indexOf('.')
  if (Pos < 0) {
	if (DecimalPoint > 0) {
	  strValue = strValue + '.' + Replicate('0', DecimalPoint);
	}
  } else {
	if (DecimalPoint > 0) {
	  strBefore = strValue.substr(0, Pos);
	  strAfter = strValue.substr(Pos+1) + Replicate('0', DecimalPoint);
	  strValue = strBefore + '.' + Left(strAfter, DecimalPoint);
	}
  }

  
  if (Comma.toString() == 'True') {
	Pos = strValue.indexOf('.');
	if (Pos<0) {Pos = strValue.length};

	Count3 = 0;
	for (j=Pos-1;j>0;j--) {
	  Count3++;
	  if (Count3 >= 3) {
		strBefore = strValue.substr(0, j);
		strAfter = strValue.substr(j);
		strValue = strBefore + "," + strAfter;
		Count3 = 0;
	  }
	}
  }
  

  if(blnSign){
	strValue='-' + strValue;
  }   
  return(strValue);
}

function Replicate(Chr, Count) {
  var i, RetVal;

  RetVal = '';
  for (i=1; i<=Count; i++) {
	RetVal = RetVal + Chr;
  }
  return RetVal;
}


function FormatNumberClear(aNum){
	var vRet=Replace(String(aNum), ",", "");
	return(vRet);
}

function Replace(Source, SearchChar, ReplaceChar) {
//=====================================================
  var i = 0;
  var Start = 0;
  var LenSearch = 1;

  LenSearch = SearchChar.length;      

  do {
	i = Source.indexOf(SearchChar, Start);
	if (i >= 0) {
	  Source = Source.substr(0, i) + ReplaceChar + Source.substr(i + LenSearch);
	}

	Start = i + LenSearch;
  } while (i >= 0);

  return Source;
}

function Left(str, n) {
//=====================================================
  if (n < 0)					//-- Invalid, return blank string
	return '';
  else if (n > String(str).length)		//-- Invalid, return entire string
	return str;
  else return String(str).substring(0, n);	//-- Valid
}

function CompareDate(dtgl1, dtgl2)
{
	
	vtgl1 = dtgl1.substring(6,11) + dtgl1.substring(3,5) + dtgl1.substring(0,2);
	vtgl2 = dtgl2.substring(6,11) + dtgl2.substring(3,5) + dtgl2.substring(0,2);
	if ( (! isNaN(vtgl1) && ! isNaN(vtgl2)))
	{	
		ntgl1 = vtgl1 - 0;
		ntgl2 = vtgl2 - 0;
		if ((ntgl1>ntgl2) && (ntgl1!=0 && ntgl2!=0))
		{
			return false
		} 
		else
		{
			return true
		}
	}
}

function setFocus(ctrl) {
   ctrl.focus();
}

function ConvertToDate(dt){
	var arrDt=dt.split("/");
	if(arrDt.length==3){

	var sYear=arrDt[2];	
	var now = new Date();
	var year = now.getYear();
	var y=year.toString();
	y=y.substring(0,2);


	if (sYear.length<4){
		var nYear=parseFloat(sYear)

		if(nYear>=60){
//			var dtDate=new Date(sYear, parseFloat(arrDt[1]) + 1, arrDt[0]);
			var dtDate=new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0]);
		} else {
			sYear = y + sYear
//			var dtDate=new Date(sYear, parseFloat(arrDt[1]) + 1, arrDt[0])
			var dtDate=new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0])
		}


	} else {
//		var dtDate=new Date(sYear, parseFloat(arrDt[1]) + 1, arrDt[0])
		var dtDate=new Date(sYear, parseFloat(arrDt[1]) - 1, arrDt[0])


	}

	}
	return dtDate;
}

function CekForm(){
	var oForm=document.forms[0];
	var j, iElements=oForm.elements.length;
	for(j=0; j<iElements; j++){
		var oElement=oForm.elements[j];
		if(!oElement.bProcessed) {
			if (oElement.valid()==false) {
				oElement.restore();
				_err.raise();
				if (event!=null){
					event.returnValue=false;
				}
					return false;
					break;
			}
		}
	}
	return true;
}

function scriptDecode(sText) {
	var sCode = new String;
	
	sCode = sText;
	return sCode.replace("##","'");	
}

function scriptEncode(sText) {
	var sCode = new String;
	
	sCode = sText;
	return sCode.replace("'","##");	
}

//no Right Click
//var message="";
//function clickIE() {if (document.all) {(message);return false;}}
//function clickNS(e) {if 
//(document.layers||(document.getElementById&&!document.all)) {
//if (e.which==2||e.which==3) {(message);return false;}}}
//if (document.layers) 
//{document.captureEvents(Event.MOUSEDOWN);document.onmousedown=clickNS;}
//else{document.onmouseup=clickNS;document.oncontextmenu=clickIE;}
//document.oncontextmenu=new Function("return false")




