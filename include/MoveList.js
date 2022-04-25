//fungsi untuk move list

function MoveList(cboSource, cboDestination, bSort){
	var idx=0;
	var iLength=cboSource.options.length;
	if (iLength>0){
		var idx=cboSource.selectedIndex;
		while (idx>=0){
			var ColumnValue=cboSource.value;
			var ColumnText=cboSource.options(idx).text;
							
			var oOption = document.createElement("OPTION");
			oOption.text=ColumnText;
			oOption.value=ColumnValue;
			cboDestination.add(oOption);
			cboSource.remove(idx);
			var idx=cboSource.selectedIndex;
			if (bSort)
				sortSelect(cboDestination, true)	
			FindSelected(cboDestination, ColumnValue)
		}
	}
	//sort destination
	/*if (bSort){
		sortSelect(cboDestination, true)	
	}
	FindSelected(cboDestination, ColumnValue)*/
}

function FindSelected(cbo, ColumnValue){
	var iLength=cbo.options.length;
	if (iLength>0){
		for(var i=0;i<iLength;i++){
			if (cbo.options[i].value==ColumnValue){
				cbo.options[i].selected=true;
			}
		}
	}

}

function sortFuncAsc(record1, record2) {
    var value1 = record1.optText.toLowerCase();
    var value2 = record2.optText.toLowerCase();
    if (value1 > value2) return(1);
    if (value1 < value2) return(-1);
    return(0);
}

function sortSelect(selectToSort, ascendingOrder) {
    if (arguments.length == 1) ascendingOrder = true;    // default to ascending sort

    // copy options ke dalam array
    var myOptions = [];
    for (var loop=0; loop<selectToSort.options.length; loop++) {
        myOptions[loop] = { optText:selectToSort.options[loop].text, optValue:selectToSort.options[loop].value };
    }

    // sort array
    myOptions.sort(sortFuncAsc);

    // copy sort array ke option select lagi
    selectToSort.options.length = 0;
    for (var loop=0; loop<myOptions.length; loop++) {
        var optObj = document.createElement('option');
        optObj.text = myOptions[loop].optText;
        optObj.value = myOptions[loop].optValue;
        selectToSort.options.add(optObj);
    }
}
