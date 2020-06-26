<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*" %>

<%
//jsp page이다

	String strSid = request.getParameter("sid");
	String strSName= request.getParameter("sName");
	String strAge= request.getParameter("sage");
	String strGender = request.getParameter("gender");
	
	/* String strHobby = request.getParameter("hobby"); 			
	out.println(strHobby); */
	
	//데이터베이스 students테이블에 데이터(row)를 추가해보자 
	//데이터베이스를 연동하려면 사용하는 java package 는  java.sql이다.
	
	//0.오라클을 연결하려면 오라클 연결정보 
	String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
	String useID = "testdb";
	String usePWD = "1234";
	//1.DB연결을 위한 Class
	Connection conn = DriverManager.getConnection(strURL,useID,usePWD);
	
	//2. preparedStatement class
	String strSql = "insert into students2 (sid,sname,did,sage,sgen) values(?,?,?,?,?)";
	
	PreparedStatement psmt = conn.prepareStatement(strSql);
	psmt.setString(1,strSid);
	psmt.setString(2,strSName);
	psmt.setString(3,"D004");
	psmt.setString(4,strAge);
	psmt.setString(5,strGender);
	
	psmt.executeUpdate();
	
	response.sendRedirect("./list.jsp?sname=");





%>



