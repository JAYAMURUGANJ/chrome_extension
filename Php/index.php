<?php
$data_open = [
    "title" => "Hello from PHP! Open",
    "content" => "This data is sent to Flutter.",
    "timestamp" => date("Y-m-d H:i:s"),
    "action" => "open_extension"
];

$data_popup = [
    "title" => "Hello from PHP! Popup",
    "content" => "This data is sent to Flutter.",
    "timestamp" => date("Y-m-d H:i:s"),
    "action" => "popup_extension"
];
?>
<!DOCTYPE html>
<html>
<head>
    <title>PHP to Flutter Extension</title>
</head>
<body>
    <button id="sendButton">Send Data to Open Extension</button>
    <button id="sendPopupButton">Send Data to Popup Extension</button>
    

    <script>
    document.getElementById('sendButton').addEventListener('click', function() {
        const extensionId = "idddgopnaldljlnjpoejfmppfjamefdi";  // <-- Your actual extension ID
        const message = <?php echo json_encode($data_open); ?>;
        
        if (typeof chrome !== 'undefined' && chrome.runtime) {
            chrome.runtime.sendMessage(extensionId, message, function(response) {
                console.log("Response:", response);
            });
        }
    });

    document.getElementById('sendPopupButton').addEventListener('click', function() {
        const extensionId = "idddgopnaldljlnjpoejfmppfjamefdi";  // <-- Your actual extension ID
        const message = <?php echo json_encode($data_popup); ?>;
        
        if (typeof chrome !== 'undefined' && chrome.runtime) {
            chrome.runtime.sendMessage(extensionId, message, function(response) {
                console.log("Response:", response);
            });
        }
    });
    </script>
</body>
</html>
