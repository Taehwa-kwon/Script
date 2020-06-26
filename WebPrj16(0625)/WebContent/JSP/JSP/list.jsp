<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.cls0{ width:50px; height:30px; border:1px solid green; text-align:center; font-size:20px; float:left;}
	.cls1{ width:100px; height:30px; border:1px solid green; text-align:center; font-size:20px; float:left;}
	.cls2{ width:150px; height:30px; border:1px solid green; text-align:center; font-size:20px; float:left;}
	.cls3{ width:100px; height:30px; border:1px solid green; text-align:center; font-size:20px; float:left;}
	.cls4{ width:100px; height:30px; border:1px solid green; text-align:center; font-size:20px; float:left;}
	
	.row{clear:both;}
</style>

<script type="text/javascript">
	function Go_Del(){
		var checkedSids =[];
		var num =0;
		
		/* 1.체크된 아이의 value값을 뽑는다. */
		var objCHKs = document.getElementsByName("chk"); //앞에 체크박스를 전체에 추가되었으니깐 
		
		for(var i=0; i<objCHKs.length; i++){ //
			if(objCHKs[i].checked){ //여기서 value의 값을 찾아서 서버로 넘겨준다. 
				//일단 value의 개수를 담아놓을 공간을 먼저 만든다. 즉 배열 checkedSids를 만듬
				checkedSids[num]= objCHKs[i].value; //체크된 value의 값을 배열에 넣는다. checkedSids[0] = 체크된 value  || 그 다음 ->  checkedSids[0] = 체크된 value  // 즉 checkbox의 value를 가져온다.
				num += 1;//내생각에는 num을 i로 바꾸면 괜찮을것이라고 생각했는데 보니깐  체크된 objCHKs[i]가 5번째면 checkedSide도 5번쨰가 되니깐 안맞은거지.
			}
		}
			
			var serverParams = "(";
			for (var i = 0; i < checkedSids.length; i++) { //체크된 것들을 담아둔 곳 checkedSids 
				
				if(i == (checkedSids.length - 1))
				serverParams += "'"+checkedSids[i] +"'"
				//serverParams += "'"+checkedSids[i] +"'," 이 상태로 두면 맨 마지막에 ,가 유지되잖아 그걸 해결해야하니깐. 바로위에 if문을 추가시켜주고 콤마를 뺼 수 있다. 
			
			else {
				serverParams += "'"+checkedSids[i]+"',"
				}
			}
			serverParams += ")";
			//serverParams = "('S005','S008','S010','S012')"만약에 얘네들을 선택하면 
		
			//서버로 보낸다 (delete.jsp)
			location.href= "./delete.jsp?delsid="+serverParams; //get방식으로 넘겨준다.  ? 뒤에 있는것을 delete.jsp에서  String delsid = request.getParameter("delsid"); 이렇게 받아준다.
		
	}//Go_del()
	
	function Go_Write(){
		location.href = "basic02.jsp"; //이 버튼을 누르면 basic02로 넘겨보낼려고 
		
		
	}
	
</script>


</head>
<%
		String strSName = request.getParameter("sname");//아래 이름검색의 name과 맞춰준다.
		out.println(strSName);
		/* 1.DB연결하즈아아ㅏ아 */
		
			//0.오라클을 연결하려면 오라클 연결정보 
		String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
		String useID = "testdb";
		String usePWD = "1234";
		
		//1.DB연결을 위한 Class
		Connection conn = DriverManager.getConnection(strURL,useID,usePWD);
		
		String strSql = "SELECT sid,sname,sage,decode(sgen,'M','남자','F','여자')as sgen FROM STUDENTS2 "; 
			  strSql += " where sname like '%" +strSName+ "%'"; //where앞에는 띄어쓰기 주의 
		PreparedStatement psmt = conn.prepareStatement(strSql);
		
		ResultSet rs = psmt.executeQuery();
		
		
		%>

<body>
	<div id="wrap">
		<div>
			<form action="list.jsp" method="post">
		   이름 검색 : <input type="text" name="sname" size="10"/> <!-- //서버로 가서 찾아야하니깐  submit으로 바꿔주고 form태그 추가하고 action을 추가한다.--> 
		   		  <input type ="submit" value="검색"/>
		   		  
		   		  <input type ="button" value="삭제" onclick="Go_Del()"/> <!-- on_click이라는 스크립트 방식을 추가해서 자기자신을 호출한다. -->
		   		    <input type ="button" value="등록" onclick="Go_Write()"/>
		   	</form>	   
		</div>
		
		<div id="" class="row">
			
			<!-- 앞에 체크박스 추가하기  -->
			<div class="cls0"></div> 
			<!-- 앞에 체크박스 추가하기  -->
		
			<div class="cls1">학생아이디</div>
			<div class="cls2">학생이름</div>
			<div class="cls3">학생나이</div>
			<div class="cls4">학생성별</div>
			<div class="cls4"></div>
		</div>
		
		<%
			while(rs.next()){
		%>
	
		<div id="" class="row">
		
		<!-- 앞에 체크박스 추가하기  -->
		<div class="cls0"><input type="checkbox" name="chk" value="<%=rs.getString("sid")%>"></div> <!-- 앞에 체크박스 추가하기  <input type="checkbox" name="chk" value=""> 체크박스 만들기 -->
		<!-- 앞에 체크박스 추가하기  -->
					
			<div class="cls1"><%=rs.getString("sid")%></div>
			<%-- <div class="cls2"><%=rs.getString("sname")%></div> --%>
			<div class="cls2"><input type="text" size="10" value= '<%=rs.getString("sname")%>'/></div>
			<div class="cls3"><%=rs.getString("sage")%></div>
			<div class="cls4"><%=rs.getString("sgen")%></div>
			<div class="cls4"><a href="./update.jsp?sid=<%=rs.getString("sid")%>">수정</a></div> <%-- get방식으로 cls0 의 값을 가져간다.<%=rs.getString("sid")%> --%>
		</div>
	
		<%
			}
		%>
		
	
	</div>
	
	
	

</body>
</html>