<?php
$db = mysqli_connect('localhost', 'root', '', 'userdata', 3307);

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE username = '".$username."'";
$result = mysqli_query($db, $sql);
$count = mysqli_num_rows($result);

if ($count == 0) {
    echo json_encode("Username does not exist");
} else {
    $sql = "SELECT * FROM users WHERE username = '".$username."' AND password = '".$password."'";
    $result = mysqli_query($db, $sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
        echo json_encode("Success");
    } else {
        
        echo json_encode("Incorrect ");
    }
}
?>
