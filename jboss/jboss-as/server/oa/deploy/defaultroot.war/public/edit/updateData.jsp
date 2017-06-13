<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang='zh-cn' id = "loginHtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改当前用户姓名和登录人姓名</title>
</head>

<body>
	<div>
		<input type="button" value="修改" onclick="updateData()">
	</div>
</body>
<script>
	function updateData(){
		window.open("/defaultroot/public/edit/updateLoginName.jsp");
	}
</script>
