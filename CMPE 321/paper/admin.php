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

 $where = " where 1=1 ";
 if(isset($_POST['keyword'])){
     $keyword = $_POST['keyword'];
     $where .= " and paper.topic like '%".$_POST['keyword']."%' or paper.description like '%".$_POST['keyword']."%' or paper.title like '%".$_POST['keyword']."%' or author.first_name like '%".$_POST['keyword']."%'";
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
        <li class="active"><a href="admin.php">manage Paper</a></li>
        <li ><a href="author.php">manage Author</a></li>
        <li><a href="topic.php">Manage Topic</a></li>
        <li><a href="rank.php">Show Rank</a></li>
    </ul>
    <button type="button" class="btn btn-primary" style="margin-top:30px;" onclick="javascript:add();">Add paper</button>         
    <input type="text" name="keyword" id="keyword" class="form-control" style="margin-top:20px;" placeholder="Search the Topic or Author" onkeypress="enterpress(event, this.value);">  
    <table class="table" style="margin-top:30px;">
        <thead>
            <tr>
                <!--<th>No</th>-->
                <th>Title</th>
                <th>Abstract</th>
                <th>Result</th>
                <th>Author</th>
                <th>Topic</th>
                <!-- <th>SOTA</th> -->
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php 
                $sql = "SELECT paper.*, author.first_name, topic.name, topic.sota FROM paper left join author on paper.author_id = author.id left join topic on paper.author_id = topic.author_id".$where." order by topic.sota desc ";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                    $i = 0;
                    while($row = $result->fetch_assoc()) {
                        ?>
                            <tr>
                               <!-- <td><?php echo $i + 1;?></td>-->
                                <td><?php echo $row['title'];?></td>
                                <td><?php echo $row['description'];?></td>
                                <td><?php echo $row['result'];?></td>
                                <td><?php echo $row['first_name'];?></td>
                                <td><a href="javascript:showTopic('<?php echo $row['topic'];?>')"><?php echo $row['topic'];?></a></td>
                                <!-- <td><a href="javascript:showTopic('<?php echo $row['author_id'];?>')"><?php echo $row['subject'];?></a></td> -->
                                <!-- <td><?php echo $row['sota'];?></td> -->
                                <td><a href="javascript:update('<?php echo $row['id'];?>', 'paper')">update</a> | <a href="javascript:deleteFunc('<?php echo $row['id'];?>', 'paper')">delete</a></td>
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
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
            <form class="form-horizontal" id="frm" name="frm" action="" method="POST">
                <div class="form-group">
                    <label class="control-label col-sm-2" for="email">Title:</label>
                    <div class="col-sm-10">
                    <input type="text" class="form-control" id="title" name="title">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">Abstract:</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="description" name="description">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">Result:</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="result" name="result">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">Topic:</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="topic" name="topic">
                    </div>
                </div>
                <div class="form-group">
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

  <div class="modal fade" id="topic_modal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Show Topic</h4>
        </div>
        <div class="modal-body">
            <form class="form-horizontal" id="frm" name="frm" action="" method="POST">
                <!-- <div class="form-group">
                    <label class="control-label col-sm-2" for="email">Author:</label>
                    <div class="col-sm-10">
                    <input type="text" class="form-control" id="author1" name="author1">
                    </div>
                </div> -->
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">Topic:</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="name" name="name">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">SOTA:</label>
                    <div class="col-sm-10"> 
                    <input type="text" class="form-control" id="sota" name="sota">
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  <form method="post" id="searchfrm" name="searchfrm">
        <input type="hidden" name="keyword" id="keyword" value="<?php echo $keyword;?>"/>
  </form>
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
                $("#title").val(result[0].title);
                $("#description").val(result[0].description);
                $("#result").val(result[0].result);
                $("#author").val(result[0].author_id);
                $("#topic").val(result[0].topic);
                $("#add").hide();
                $("#update").show();
                $("#id").val(id);
                $("#myModal").modal('show');
            });
        }

        updateData = function(){
            $("#hiddenValue").val("update");
            $("#frm").attr('action', "update_paper.php");
            $("#frm").submit();
        }

        add = function(){
            $("#myModal").modal('show');
            $("#frm").attr('action', "update_paper.php");
            $("#add").show();
            $("#hiddenValue").val("add");
            $("#update").hide();
        }

        addData = function(){
            $("#hiddenValue").val("add");
            $("#frm").attr('action', "update_paper.php");
            $("#frm").submit();
        }

        enterpress = function(event, val){
            if(event.key=='Enter'){
                $("#searchfrm #keyword").val(val);
                $("#searchfrm").submit();
            }
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

        showTopic = function(topic){
            $.post("show_topic.php",
            {
                topic: topic,
            },
            function(data, status){
                var result = JSON.parse(data);
                if(result.length > 0){
                    $("#name").val(topic);
                    $("#sota").val(result[0].result);
                    $("#topic_modal").modal('show');
                }else{

                }
                
            });
        }
    });

    
  </script>
</body>
</html>