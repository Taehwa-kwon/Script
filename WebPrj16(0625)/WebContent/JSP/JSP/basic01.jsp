<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 컴파일은 컴퓨터가 이해할 수 있는 언어 (cpu에 연산을 시키는 것) 로 바꿔주는것(즉 어셈블리언어로 바꿔주는 것),  자바와 c#의 컴파일은 사실상 다르다.-->
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<select id="bYear">
		<%
			String strHTML ="";
			for(int i=1901; i<=2020; i++){
				strHTML += "<option value='"+ i +"'> "+ i +" </option>";
			
			}
			
			out.println(strHTML);//얘네들만 밖으로 떨어져 나옴
			
			
		%>
		
	</select>




<%-- 	
	<%
		int a =7;
		int b =8;
		int c= a+b;
		
		out.println("<font color='red'>"+c+"</font>");  /* /% %/  이 태그안에 있는것은 클라이언트에 보내지지 않는다. 태그 바깥에 있는 내용이 브라우저에 전달되고 브라우저는 이 내용들을 해석한다. */ 
	%>
 --%>
</body>
</html>