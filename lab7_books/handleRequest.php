<?php

function handleCall()
{
    $error_message = "";
    if ($_SERVER['REQUEST_METHOD'] == "POST") {
        if (empty($_POST["command"])) {
            $error_message .= "Empty command. ";
            echo $error_message;
            return;
        }
        $command = test_input($_POST["command"]);
        switch ($command){
            case "add":
                handleAdd();
                break;
            case "update":
                handleUpdate();
                break;
            case "delete":
                handleDelete();
                break;
            case "lend":
                handleLend();
                break;
            default:
                echo "Invalid command!";
                break;

        }

    }
}

function handleLend(){
    $error_book_id = "";
    $error_client_id = "";
    $error_date = "";
    $bookID = 0;
    $clientID = 0;
    $returnDate = $_POST["returnDate"];
    $currentDate = new DateTime();

    if (empty($_POST["bookID"])) {
        $error_book_id = "Book ID number is required.";
    } else {
        $bookID = test_input($_POST["bookID"]);
        if (is_numeric($bookID)) {
            $bookID = (int)$bookID;
        } else {
            $error_book_id = "ID number must be an integer.";
        }
    }

    if (empty($_POST["clientID"])) {
        $error_client_id = "Client ID number is required.";
    } else {
        $clientID = test_input($_POST["clientID"]);
        if (is_numeric($clientID)) {
            $clientID = (int)$clientID;
        } else {
            $error_client_id = "ID number must be an integer.";
        }
    }


    if (empty($_POST["returnDate"])) {
        $error_date = "Date is required. Maybe invalid date.";
    } else {
        $returnDate = test_input($returnDate);
        $returnDate = date_create_from_format("Y-m-d",$returnDate);
        if ($returnDate == false) {
            $error_date = "Invalid date.(".$_POST["returnDate"] . ")";
        }
        else if($returnDate < $currentDate){
            $error_date = "Invalid date.(".$_POST["returnDate"] . "). Date must be after today." .  "(".date("Y-m-d").")";
        }
    }

    if (!empty($error_book_id) || !empty($error_client_id) || !empty($error_date)) {
        echo $error_book_id . " " . $error_client_id . " " . $error_date;
        return;
    }

    $servername = "localhost";
    $username = "ubbstudent";
    $password = "forclasspurposes";
    $dbname = "web_lab7_books";

    $connection = new mysqli($servername, $username, $password, $dbname);

    if ($connection->connect_error) {
        echo "Couldn't connect to database.";
        return;
    }

    $sqlGetRentalsForCurrentID = "SELECT * FROM `rentals` WHERE `book_id` = '" . $bookID . "'";

    $result = $connection->query($sqlGetRentalsForCurrentID);
    if ($result && $result->num_rows > 0) {
        $good = true;
        while ($row = $result->fetch_assoc()) {
            $thisRentalDate = date_create_from_format('Y-m-d',$row['rental_date']);
            $thisReturnDate = date_create_from_format('Y-m-d',$row['return_date']);

            if($thisRentalDate < $returnDate && $thisReturnDate > $currentDate){
                $good = false;
                break;
            }

        }
        if($good == false){
            echo "The selected period overlaps with a another period. The books is currently rented by a client.";
            return;
        }
    }


    $sqlInsert = "INSERT INTO `rentals`(`book_id`,`client_id`, `rental_date`, `return_date`) VALUES (?,?,?,?)";
    $stmt = $connection->prepare($sqlInsert);
    $currentDateString = date('Y-m-d');
    $stmt->bind_param("iiss", $bookID,$clientID,$currentDateString,$_POST["returnDate"]);

    if($stmt->execute()){
        echo "Lending added";
    }
    else{
        echo "Failed to add lending, invalid ID for book/client!";
    }

    mysqli_close($connection);

}

function handleDelete()
{
    $error_id = "";
    $id = 0;

    if (empty($_POST["id"])) {
        $error_id = "ID number is required.";
    } else {
        $id = test_input($_POST["id"]);
        if (is_numeric($id)) {
            $id = (int)$id;
        } else {
            $error_id = "ID number must be an integer.";
        }
    }



    if (!empty($error_id)) {
        echo $error_id;
        return;
    }

    $servername = "localhost";
    $username = "ubbstudent";
    $password = "forclasspurposes";
    $dbname = "web_lab7_books";

    $connection = new mysqli($servername, $username, $password, $dbname);

    if ($connection->connect_error) {
        echo "Couldn't connect to database.";
        return;
    }

    $sqlUpdate = "DELETE FROM `books` WHERE `id` = ?";

    $stmt = $connection->prepare($sqlUpdate);

    $stmt->bind_param("i", $id);
    if ($stmt->execute())
        echo "Delete successfully executed";
    else
        echo "Delete failed";

    mysqli_close($connection);

    return;
}

function handleUpdate(){
    $error_id = "";
    $error_author = "";
    $error_genre = "";
    $error_title = "";
    $error_pages = "";
    $id=0;
    $author="";
    $genre="";
    $title="";
    $pages=0;

    if (empty($_POST["id"])){
        $error_id = "ID number is required.";
    } else {
        $id = test_input($_POST["id"]);
        if(is_numeric($id)){
            $id = (int)$id;
        }
        else{
            $error_id = "ID number must be an integer.";
        }
    }

    if (empty($_POST["author"])) {
        $error_author = "Author is required.";
    } else {
        $author = test_input($_POST["author"]);
    }

    if (empty($_POST["genre"])) {
        $error_genre = "Genre is required.";
    } else {
        $genre = test_input($_POST["genre"]);
    }

    if (empty($_POST["title"])){
        $error_title = "Title is required.";
    } else {
        $title = test_input($_POST["title"]);
    }


    if (empty($_POST["pages"])){
        $error_pages = "Page number is required.";
    } else {
        $pages = test_input($_POST["pages"]);
        if(is_numeric($pages)){
            $pages = (int)$pages;
            if($pages <= 0 ){
                $error_pages = "Page number must be a positive integer.";
            }
        }
        else{
            $error_pages = "Page number must be a positive integer.";
        }
    }

    if(!empty($error_id) || !empty($error_author) || !empty($error_genre) || !empty($error_title) || !empty($error_pages)){
        echo $error_id . $error_author. " " . $error_genre . " " . $error_title. " " . $error_pages;
        return;
    }

    $servername = "localhost";
    $username = "ubbstudent";
    $password = "forclasspurposes";
    $dbname = "web_lab7_books";

    $connection = new mysqli($servername,$username,$password,$dbname);

    if($connection->connect_error) {
        echo "Couldn't connect to database.";
        return;
    }

    $sqlUpdate = "UPDATE `books` SET `author`= ?, `genre`=?, `title`=?, `pages`=? WHERE `id` = ?";

    $stmt = $connection->prepare($sqlUpdate);

    $stmt->bind_param("sssii",$author,$title,$genre,$pages,$id);
    if($stmt->execute())
        echo "Update successfully executed";
    else
        echo "Update failed";

    mysqli_close($connection);

    return;
}

function handleAdd(){
    $error_author = "";
    $error_genre = "";
    $error_title = "";
    $error_pages = "";
    $author="";
    $genre="";
    $title="";
    $pages=0;
    if (empty($_POST["author"])) {
        $error_author = "Author is required.";
    } else {
        $author = test_input($_POST["author"]);
    }

    if (empty($_POST["genre"])) {
        $error_genre = "Genre is required.";
    } else {
        $genre = test_input($_POST["genre"]);
    }

    if (empty($_POST["title"])){
        $error_title = "Title is required.";
    } else {
        $title = test_input($_POST["title"]);
    }


    if (empty($_POST["pages"])){
        $error_pages = "Page number is required.";
    } else {
        $pages = test_input($_POST["pages"]);
        if(is_numeric($pages)){
            $pages = (int)$pages;
            if($pages <= 0 ){
                $error_pages = "Page number must be a positive integer.";
            }
        }
        else{
            $error_pages = "Page number must be a positive integer.";
        }
    }

    if(!empty($error_author) || !empty($error_genre) || !empty($error_title) || !empty($error_pages)){
        echo $error_author. " " . $error_genre . " " . $error_title. " " . $error_pages;
        return;
    }

    $servername = "localhost";
    $username = "ubbstudent";
    $password = "forclasspurposes";
    $dbname = "web_lab7_books";

    $connection = new mysqli($servername,$username,$password,$dbname);

    if($connection->connect_error) {
        echo "Couldn't connect to database.";
        return;
    }

    $sqlInsert = "INSERT INTO `books` (`author`, `title`, `genre`, `pages`) VALUES (?,?,?,?)";

    $stmt = $connection->prepare($sqlInsert);

    $stmt->bind_param("sssi",$author,$title,$genre,$pages);
    if($stmt->execute())
        echo "Addition successfully executed";
    else
        echo "Addition failed";

    mysqli_close($connection);

    return;
}


function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

handleCall();

?>

