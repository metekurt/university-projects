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
    $title = $_POST['title'];
    $description = $_POST['description'];
    $result = $_POST['result'];
    $author = $_POST['author'];
    $topic = $_POST['topic'];
    $hidden = $_POST['hiddenValue'];

    if($hidden == 'update'){
        $sql = "UPDATE paper set title = '$title', description = '$description', result = '$result', author_id = '$author', topic = '$topic' where id = '$id'";
    }else{
        $sql = "Insert into paper (author_id, title, description, result, topic) values ('$author', '$title', '$description', '$result', '$topic')";
    }

    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    header("location:admin.php");

    
?>