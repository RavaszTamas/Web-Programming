function populateTable(){

    if(document.getElementById("number-container").value.trimLeft().trimRight() == ""){
        return;
    }
    var arrayOfNumbers = document.getElementById("number-container").value.trimLeft().trimRight().split(" ");
    arrayOfNumbers.sort()
    if(document.contains(document.getElementById("array-table"))){
        document.getElementById("array-table").remove();
    }
    var tableSection = document.getElementById("table-section")
    var tbl = document.createElement('table');
    tbl.id = "array-table"
    tbl.style.width = '100%';
    tbl.style.border = "1px solid black"
    tableSection.appendChild(tbl)
    for(i = 0; i < arrayOfNumbers.length; i = i + 5){
        var row = tbl.insertRow()
        row.style.border = "1px solid black"
        row.style.textAlign = "center"
        for(j = 0; j < 5; j++){
            var newCell = row.insertCell()
            newCell.innerHTML = arrayOfNumbers[i+j]
            newCell.style.width = "20%";
            newCell.style.border = "1px solid black";
            newCell.style.fontSize = "100%";
            if(newCell.innerHTML == "undefined"){
                newCell.innerHTML = ""
            }
        }

    }
}