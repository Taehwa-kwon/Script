<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*" %>
    

    
    <% 
    	String delsid = request.getParameter("delsid");
    	//out.println(delsid);
    	
    	//1.DB연결 
    	
    	//0.오라클을 연결하려면 오라클 연결정보 
		String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
		String useID = "testdb";
		String usePWD = "1234";
		//1.DB연결을 위한 Class
		Connection conn = DriverManager.getConnection(strURL,useID,usePWD);
    
		
		String strSql = "delete from students2 where sid in " + delsid;
		
		PreparedStatement psmt = conn.prepareStatement(strSql);
    
		psmt.executeUpdate();
		
		response.sendRedirect("./list.jsp?sname="); 
		
		//이걸 치는 이유는 ?sname = 을 안붙이면 list.jsp에서  String strSName = request.getParameter("sname"); 가 sname에 아무값도 없어서 아래의 여기서 못찾아서 계속 null값이 나온다.  
		
		//String strSql = "SELECT sid,sname,sage,decode(sgen,'M','남자','F','여자')as sgen FROM STUDENTS2 "; 
		// strSql += " where sname like '%" +strSName+ "%'"; //where앞에는 띄어쓰기 주의
		
		
		//response.sendRedirect("./list.jsp");

    
    
    
    %>