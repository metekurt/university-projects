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

 $topic = $_POST['topic'];

 $sql = "select max(result) as result from paper where topic = '$topic'";
 
 $result = $conn->query($sql);
 $arr = array();
 $returnValue;
 if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        array_push($arr, array("result"=>$row['result']));

        $sql_r = "select * from topic where name = '$topic'";
        $result1 = $conn->query($sql_r);
        if ($result1->num_rows > 0) {
            $insert_sql = "UPDATE topic set name = '$topic', sota = ".intVal($row['result'])." where name = '$topic'";
        }else{
            $insert_sql = "Insert into topic (name, sota) values ('$topic', ".$row['result'].")";
        }
        $conn->query($insert_sql);
    }
 }


 echo json_encode($arr);

?>