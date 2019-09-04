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
    $description = $_POST['subject'];
    $sota = $_POST['sota'];
    $hidden = $_POST['hiddenValue'];

    if($hidden == 'update'){
        $sql = "UPDATE topic set name = '$description', sota = '$sota' where id = '$id'";
    }else{
        $sql = "Insert into topic (name, sota) values ('$description', '$sota')";
    }

    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    header("location:topic.php");

    
?>