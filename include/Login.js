<!-- Hide from non-JavaScript browsers

function getXML(URL){
	var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	xmlDoc.async=false;
	xmlDoc.load(URL);
	if (xmlDoc.parseError.errorCode!=0){
		alert("ERROR : " + xmlDoc.parseError.reason);
		alert(xmlDoc.parseError.url);
	}
	root = xmlDoc.documentElement;
	child=root.firstChild;
	return(child)
}

function CheckSession(){
	var UserID=LoginForm.txtLoginName.value;
	var child=getXML("CheckLogSession.aspx?xmlid=CHECKSESSION&UserID=" + UserID);
	if (child!=null){
			var IPAddress=child.selectSingleNode("IPAddress").text;
			var TimeOut=child.selectSingleNode("SessionTimeOut").text + " " + child.selectSingleNode("TimeOut").text;
			if (confirm("User ID : " + UserID + " is Log In from IP Address : " + IPAddress + ", Time Out : " + TimeOut + "\n" + "Do you want to continue...?"))
				return true;
			else
				return false;
	} else{
		var child=getXML("CheckLogSession.aspx?xmlid=CHECKUSERSESSION&UserID=" + UserID);
		if (child!=null){
			var IPAddress=child.selectSingleNode("IPAddress").text;
			var TimeOut=child.selectSingleNode("SessionTimeOut").text + " " + child.selectSingleNode("TimeOut").text;
			if (confirm("User ID : " + UserID + " not logout from IP Address : " + IPAddress + ", Already Time Out : " + TimeOut + "\n" + "Do you want to continue...?"))
				return true;
			else
				return false;
		}
		
	}
		return true;
}

// -- End Hide -->

