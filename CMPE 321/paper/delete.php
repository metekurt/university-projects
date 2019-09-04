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
 $tbl = $_POST['tbl'];

 $sql = "DELETE from ".$tbl." where id = ".$id;
 
 $result = $conn->query($sql);
 if ($conn->query($sql) === TRUE) {
    echo json_encode(array('success'=>1));
 } else {
    echo json_encode(array('success'=>0));
 }


?>