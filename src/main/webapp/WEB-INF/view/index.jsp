<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
<script src="resources/js/sockjs-0.3.4.js"></script>
<script src="resources/js/stomp.js"></script>
</head>
<body>
<h2>Hi there </h2>
<input id="name">
<button onclick="connect()">Connect</button>
<button onclick="send()">Send</button>
<button onclick="disconnect()">Disconnect</button>
<script type="text/javascript">
function connect() {
	var socket = new SockJS('/users');
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		console.log('Connected: ' + frame);
		stompClient.subscribe('/topic/users', function(response) {
			console.log(response);
			console.log(JSON.parse(response.body));
		});
	});
}

function disconnect() {
	stompClient.disconnect();
	console.log("Disconnected");
}

function send() {	
	console.log("sending");
	var name = document.getElementById("name").value;
	stompClient.send("/app/user/"+name, {}, JSON.stringify({}));
}
</script>
</body>
</html>