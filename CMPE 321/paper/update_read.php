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

 $sql = "SELECT * from ".$tbl." where id = ".$id;
 
 $result = $conn->query($sql);
 $arr = array();
 if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        array_push($arr, $row);
    }
 }

 echo json_encode($arr);

?>