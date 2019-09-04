<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "paper";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $id = $_POST['id'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $hidden = $_POST['hiddenValue'];

    if($hidden == 'update'){
        $sql = "UPDATE author set first_name = '$first_name', last_name = '$last_name' where id = '$id'";
    }else{
        $sql = "Insert into author (first_name, last_name) values ('$first_name', '$last_name')";
    }

    if ($conn->query($sql) === TRUE) {
        header("location:author.php");
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    

    
?>