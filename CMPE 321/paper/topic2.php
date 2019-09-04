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
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>S O T A</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <ul class="nav nav-pills" style="margin-top:30px;">
        <li><a href="user.php">List Papers</a></li>
        <li><a href="author2.php">List Authors</a></li>
        <li class="active"><a href="topic2.php">List Topics</a></li>
        <li><a href="rank2.php">Show Rank</a></li>
    </ul>
    <!--<button type="button" class="btn btn-primary" style="margin-top:30px;" onclick="javascript:add();">Add Topic</button> -->          
    <table class="table" style="margin-top:30px;">
        <thead>
            <tr>
                <!--<th>No</th>-->
                <th>Topic</th>
                <th>SOTA</th>
               
            </tr>
        </thead>
        <tbody>
            <?php 
                $sql = "SELECT topic.* from topic ";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        ?>
                            <tr>
                               
                               <!-- <td><?php echo $row['id'];?></td> -->
                                <td><?php echo $row['name'];?></td>
                                <td><?php echo $row['sota'];?></td>
                                
                            </tr>
                        <?php
                    }
                }
            ?>
        </tbody>
    </table>
</div>


<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Edit</h4>
        </div>
        <div class="modal-body">
            <form class="form-horizontal" id="frm" name="frm" action="" method="POST">
                <!-- <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">Author:</label>
                    <div class="col-sm-10"> 
                        <select name="author" id="author" class="form-control">
                        <?php
                            $sql = "select * from author";
                            $result = $conn->query($sql);
                            if ($result->num_rows > 0) {
                                while($row = $result->fetch_assoc()) {
                                    ?>
                                        <tr>
                                            <option value="<?php echo $row['id'];?>"><?php echo $row['first_name'];?></td>
                                        </tr>
                                    <?php
                                }
                            }
                        ?>
                        </select>
                    </div>
                </div> -->
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">Topic</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="subject" name="subject">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">SOTA</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="sota" name="sota">
                    </div>
                </div>
                
                <input type="hidden" name="hiddenValue" id="hiddenValue"/>
                <input type="hidden" name="id" id="id"/>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="add" onclick="javascript:addData();"> Add</button>
            <button type="button" class="btn btn-success" data-dismiss="modal" id="update" onclick="javascript:updateData();">Update</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

  <script>
    $(document).ready(function(){
        update = function(id, tbl){
            $.post("update_read.php",
            {
                id: id,
                tbl: tbl
            },
            function(data, status){
                var result = JSON.parse(data);
                $("#subject").val(result[0].subject);
                $("#sota").val(result[0].sota);
                $("#add").hide();
                $("#update").show();
                $("#id").val(id);
                $("#myModal").modal('show');
            });
        }

        updateData = function(){
            $("#hiddenValue").val("update");
            $("#frm").attr('action', "update_topic.php");
            $("#frm").submit();
        }

        add = function(){
            $("#myModal").modal('show');
            $("#frm").attr('action', "update_topic.php");
            $("#add").show();
            $("#hiddenValue").val("add");
            $("#update").hide();
        }

        addData = function(){
            $("#hiddenValue").val("add");
            $("#frm").attr('action', "update_topic.php");
            $("#frm").submit();
        }

        deleteFunc = function(id, tbl){
            $.post("delete.php",
            {
                id: id,
                tbl: tbl
            },
            function(data, status){
                var result = JSON.parse(data);
                if(result.success > 0){
                    document.location.reload();
                }
            });
        }
    });

    
  </script>
</body>
</html>