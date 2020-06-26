<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록</title>
<style>
	.col1{ width:500px; height:30px; text-align:center;  }
	.col2{ width:500px; height:30px; text-align:center;  }
	.col3{ width:500px; height:30px; text-align:center;  }
	.inp{width:400px; font-size:20px; border:1px solid #77777; }
	.txt{width:400px; height:100px;}
	.btn{width:100px; height:25px; background-color:gray; color:#555555; bboard:1px solid #777777}
</style>
<script src = "../js/jquery-3.5.1.min.js"></script>
<!-- <script src ="https://code.jquery.com/jquery-3.5.0.js"></script> -->
<script>
	var checkValue = function(){
		
		var nameVal = $("#name").val();
		var contentsVal = $("#contents").val();
		
		if(nameVal.length<2){
			$("#msg").html("이름을 정확히 써라ㅡㅡ!");
			$("name").focus();
			return;
		}
		if(contentsVal.length<5){
			$("#msg").html("많이좀 써라");
			$("#contents").focus();
			return;
		}
		
		frmWrite.submit();
		
	}

</script>


</head>
<body>

<form name="frmWrite" action="./write_ok.jsp" method="post">
	<table cellpadding="0" cellspacing="0" border="1" width="500" align="center">
		<tr>
			<td colspan="2" class="col1">방명록</td>
		</tr>
		
		
		<tr>
			<td class="col2">작성자</td>
			<td class="col3"><input type="text" name="name" id="name" class="inp"/></td>
		</tr>
		
		<tr>
			<td class="col2"></td>
			<td class="col3">
				<textarea class="txt" id="contents" name="contents"></textarea>
			</td>
		</tr>
		
		<tr>
			<td colspan="2" class="col1"><input type="button" id="btnSubmit" class="btn" value="확인"
			onclick="checkValue()"
			></td>
		</tr>
		
		<tr>
			<td colspan="2" class="col1">
			<span id="msg" style="font-size:20px; color:orange; font-weight:bolor">
			</td>
		</tr>
	</table>
</form>

</body>
</html>