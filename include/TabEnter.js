
//var doclen=document.all.length;
var c = document.getElementsByTagName("body")[0].getElementsByTagName("*");
//var doclen=document.getElementsByTagName("body")[0].getElementsByTagName("*");
var doclen = c.length;
var iObj=0
var arrObj=new Array();

function TabToEnter() {
	for(var i=0;i<=doclen + 1;i++){
		//var elm=document.all[i];
		var elm = c[i];
        
       
		if (elm){
		    var elmTagName = elm.tagName.toUpperCase();
		    if (elmTagName == "INPUT" || elmTagName == "TEXTAREA") {
			    var elmType=elm.type.toUpperCase();
			    if (!(elmType == "BUTTON" || elmType == "SUBMIT")) {
			        elm.onfocus = function () {
			            this.select();
			        }
			    } else if (elmType == "BUTTON" || elmType == "SUBMIT" ) {
			        elm.setAttribute("noenter", "");
			        
			    }
			}

			/*if (elmTagName=="INPUT" && elm.name=="txtSearch"){
				elm.onkeypress=function(){
					if(event.keyCode==13){
						document.forms[0].action=document.forms[0].action + '?Action=Search'
					}
				}
			}*/

			if ((elm.readOnly || elm.disabled)) {

			    if (elmTagName == "INPUT" && elm.type.toUpperCase() == "TEXT"){
			        elm.onkeydown = function (event) {
			            if (event == null)
			                event = event || window.event;
			            var KeyCode = event.keyCode || event.which;
			            if (KeyCode == 13) {
			                return (false);
			            }
			        }
                }

			}


			if ((elmTagName=="INPUT" && elm.name!="txtSearch" && elm.className.toUpperCase()!="DISABLED"
						&& elm.type.toUpperCase() != "HIDDEN" && elm.type.toUpperCase() != "CHECKBOX"  
                        && elm.type.toUpperCase()!="IMAGE"
                        && elm.type.toUpperCase() != "IMG"
						&& (!elm.readOnly && !elm.disabled))
					|| (elmTagName=="SELECT" || elmTagName=="TEXTAREA"))
			{
				if (elm.getAttribute("noenter")==null){
				    iObj = iObj + 1;
					arrObj[iObj]=elm;
					arrObj[iObj].setAttribute("elmIdx", iObj);
					arrObj[iObj].onkeydown = function (event) {
					    if (event == null)
					        event = event || window.event;
					    var KeyCode = event.keyCode || event.which;
					    if (KeyCode == 13) {
					        var elmIdx = toNumeric(this.getAttribute("elmIdx"));
					        if (elmIdx + 1 > arrObj.length)
					            elmIdx = 1;
					        else
					            elmIdx = elmIdx + 1

					        var elmMove = arrObj[elmIdx];
					        if (elmMove) {
					            while (elmMove.readOnly || elmMove.disabled) {
					                elmIdx = elmIdx + 1;
					                if (elmIdx >= arrObj.length)
					                    elmIdx = 1;
					                elmMove = arrObj[elmIdx];
					            }
					            elmMove.focus();
					            if (elmMove.tagName.toUpperCase() != "SELECT")
					                elmMove.select()
					        }
					        return (false);
					    }

					}
				}
			}

		}
    }
}

function toNumeric(theValue) {
    var ValX = parseFloat(FormatNumberClear(theValue));
    if (isNaN(ValX))
        ValX = 0;
    return (ValX);
}


