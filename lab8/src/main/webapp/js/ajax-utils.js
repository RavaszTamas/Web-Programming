function getProfiles(callbackFunction) {
    // let imageName = document.getElementById("image-search").value;
    let imageName = "";
    let nameToSearch = document.getElementById("name-search").value.trim();
    let email = document.getElementById("email-search").value.trim();
    let age = document.getElementById("age-search").value.trim();
    let homeTown = document.getElementById("home-town-search").value.trim();
    console.log(imageName,nameToSearch,email,age,homeTown);
    console.log(typeof imageName, typeof nameToSearch, typeof email,typeof age,typeof homeTown);
    $.getJSON(
        "/ProfileController",
        {action: 'getAll', imageName: imageName, nameToSearch: nameToSearch, email: email,age:age,homeTown:homeTown},
        callbackFunction
    )
        .fail( function(d, textStatus, error) {
            console.error("getJSON failed, status: " + textStatus + ", error: "+error)
        })        .always(function() { /*alert("complete");*/ });

}

function getUserProfile(userID) {
    console.log("userid",userID)
    $.getJSON(
        "/ProfileController",
        {action: 'getProfile',userID:userID},
        populateUpdateHelper
    );

}

function populateUpdateHelper(profile) {
    console.log("helpet populates the table");
    console.log(profile)
    let picture = profile.picture;
    let name = profile.name;
    let emailAddress = profile.emailAddress;
    let age = profile.age;
    let homeTown = profile.homeTown;
    console.log(picture,name,emailAddress,age,homeTown);
    if(picture != null)
        document.getElementById("image-of-user").src=picture;
    if(name != null)
        document.getElementById("currentName").innerHTML=name;
    if(emailAddress != null)
        document.getElementById("currentEmail").innerHTML=emailAddress;
    if(age != null)
        document.getElementById("currentAge").innerHTML=age;
    if(homeTown != null)
        document.getElementById("currentHomeTown").innerHTML=homeTown;

}

function populateProfilesTable(profiles) {
    console.log(profiles,"profilesloaded");
    console.log(profiles.length);
    $("#profile-table").html("");
    $("#profile-table").append(
        "<tr><th>Image</th><th>Name</th><th>Email</th><th>Age</th><th>Home town</th></tr>"
    );
    let rowString;
    for (var row in profiles) {

        console.log(row);
        if(profiles[row].picture == null)
            rowString = "<tr><td>" + " " + "</td>";
        else
            rowString = "<tr><td><img src="+profiles[row].picture+"></td>"
        if (profiles[row].name == null)
            rowString += "<td> </td>";
        else
            rowString += "<td>" + profiles[row].name + "</td>";
        if (profiles[row].emailAddress == null)
            rowString += "<td> </td>";
        else
            rowString += "<td>" + profiles[row].emailAddress + "</td>";
        if (profiles[row].age == null)
            rowString += "<td> </td>";
        else
            rowString += "<td>" + profiles[row].age + "</td>";
        if (profiles[row].homeTown == null)
            rowString += "<td> </td>";
        else
            rowString += "<td>" + profiles[row].homeTown + "</td>";

        $("#profile-table").append(
            rowString);
    }

}