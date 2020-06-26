<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page language="java" import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
 	.title{width:200px; height:40px; font-size:30px; border:1px solid #888888; background-color:#eeeeee; float:left; }
 	.content{width:400px; height:40px; font-size:30px; border:1px solid #888888; background-color:#eeeeee; float:left; }
 	.row{clear:both;}
 </style>
  
<!--   <style>
   
   .title  {width : 200px; height: 40px; font-size: 30px; border: 1px solid #888888; background-color:#eeeeee; float:left;}
   .content{width : 400px; height: 40px; font-size: 30px; border: 1px solid #888888; background-color:#eeeeee; float:left;}
   .row{clear: both;}
</style>  -->
	
<script>
	 function checkValue(){
		 var objSid = document.getElementById("sid");
		//1.학생아이디 유효성 검사 ( 반드시 4자이여야 하고 대문자로 시작해야 한다.)// 중요한것은 학생아아디는 중복되면 안되잖아 DB에 s014까지 만들어져있는데 어떻게 확인하냐면 AJON을 사용해서 검사를 해야하긴 함
		 if(objSid.value.length != 4 || objSid.value.substr(0,1).toUpperCase() !='S'){
			 alert("학생아이디 중복 발생");
			 return false;
		 }
		 
		//2.학생이름 유효성 검사 (2자 이상이면 된다.)
		 var objName = document.getElementById("sName");
		 if(objName.value.length < 2){
			 alert("야이 너무 짧잖아 ㅡㅡ ");
			 return false;
			 
		 }
		 
		  frmStudent.submit(); //얘는 document로 잡지않고 
		 
		 
	 }
</script>
 
</head>

<%
	//list.jsp에서 보낸 sid를 받아야 한다.
	String strSid = request.getParameter("sid");

	/* 1.DB연결하즈아아ㅏ아 */
	
	//0.오라클을 연결하려면 오라클 연결정보 
	String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
	String useID = "testdb";
	String usePWD = "1234";
	
	//1.DB연결을 위한 Class
	Connection conn = DriverManager.getConnection(strURL,useID,usePWD);
	
	String strSql = "SELECT SID, SNAME, SAGE, SGEN FROM STUDENTS2 WHERE SID='"+strSid+"'";
	
	
	PreparedStatement psmt = conn.prepareStatement(strSql);
	
	ResultSet rs = psmt.executeQuery();
	
	rs.next();
%>


<body>

	<form action="./write_ok.jsp" method="post" name="frmStudent" onsubmit="return checkValue()">  <!--  onsubmit="checkValue()"  -->
		<div id="formWrap">
			<div class="row">
				<div class="title">
					학생아이디
				</div>
	
				<div class="content">
					<input type="text" id="sid" name="sid" class="itext" value="<%=rs.getString("sid")%>"/>                <!-- !!!! 여기서 오류가 발생하는데.-->
				</div>
			</div>
			
			<div class="row">
				<div class="title">
					학생이름
				</div>
				<div class="content">
					<input type="text" id="sName" name="sName" class="itext" value="<%=rs.getString("sname")%>"/>
				</div>
			</div>
			
			<div class="row">
				<div class="title">
					학생나이
				</div>
				<div class="content">
					<input type="text" id="sage" name="sage" class="itext" value="<%=rs.getString("sage")%>"/>
				</div>
			</div>
			
			<div class="row">
				<div class="title">
					학생성별
				</div>
				<div class="content">
					<label>
						<input type="radio" id="male" name="gender" value="M"  
						<%
							if(rs.getString("sgen").equals("M")) { 
								out.println("checked");
							}
						%>
						/>남자  <%--  checked="checked"이 문법이 <%%>사이에 들어오는거래   --%>
					</label>
					<label>
						<input type="radio" id="female" name="gender" value="F"
						<%
							if(rs.getString("sgen").equals("F")) { 
								out.println("checked");
							}
						%>
						
						/>여자
					</label>
				</div>
			</div>
			
			<div class="row">
				<div class="title">
					학새취미
				</div>
				<div class="content">
					<label>
						<input type="checkbox" id="hobby1" name="hobby" value="1"/>자기
					</label>
					<label>
						<input type="checkbox" id="hobby2" name="hobby" value="2"/>먹기
					</label>
					<label>
						<input type="checkbox" id="hobby2" name="hobby" value="3"/>놀기
					</label>
				</div>
			</div>
			
			<div class="row">
				<!-- <input type="submit" value="확인"> --> <!-- //이렇게하면 alert이 계속 뜨면서 바로 submit이 실행됌 --> 
				<!-- <input type="button" value="확인" onclick="checkValue()"> -->  <!-- //이렇게 하면 실행은 되지만 서버로 보내지 않는다. --> 
				<input type="button" value="확인" onclick="checkValue()">
				<a href="./list.jsp?sname" >리스트로</a> <!-- <a href="./list.jsp?sname" >리스트로</a> -->
				<!-- <button onclick="checkValue()">확인</button> 왜냐하면 이렇게 함수가 실행되고 return을 만나면 다시 여기로 돌아와서 submit이 그대로 실행된다. 그래서 form태그에 onsubmit="checkValue()" 을 추가한다. -->
				
				<!-- //onsubmit="checkValue()" 이렇게 해도 문제가 생기는게 checkValue()가 실행되고 내려와서 return을 만나면 form태그의 onsubmit으로 돌아오고 submit이 그대로 실행된다. 그래서 checkValue() return에 false를 받고 onsubmit에 return을 추가한다. -->
			</div>
			
		</div>
	</form>

</body>
</html>