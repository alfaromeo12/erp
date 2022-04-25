function MouseHighLight(tr, ev){
	var trName;
	trName=""
	if (tr.name){
		var trName=tr.name;
		if (trName.length>0)
			var idx=trName.substring(3,trName.length);
	}
	if (tr.className!="HeaderStyle" || tr.className!="FooterStyle"){
		for(var i=0;i<tr.childNodes.length;i++){
			td=tr.childNodes.item(i);
			if (td.tagName=="TD"){
				if (ev=="over"){
					td.className="RowOver";
					
				} else {
					if (tr.name){
						if (Math.ceil(idx/2)==Math.floor(idx/2)){
							td.className="AlternatingRowStyle";
						}
						else
							td.className="RowStyle";
					} else
						td.className="";			
				}
			}
		}
	}
}

function FormatTable(tableID) {
	var table = document.all ? document.all[tableID] : document.getElementById(tableID);
	if(table){
		//assign event dan Format Row
		for(var i=0;i<=table.rows.length - 1;i++){
			if(i>0){ //bukan header table
				var row=table.rows[i];
				if (row.className!="HeaderStyle" || row.className!="RowStyle"){
					row.onmouseover=function() {MouseHighLight(this, "over");};
					row.onmouseout=function() {MouseHighLight(this, "out");};
				}
			}
		}
	}
}
