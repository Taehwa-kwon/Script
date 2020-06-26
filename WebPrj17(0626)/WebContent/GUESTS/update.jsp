<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*" %>

<%
	String strIDX=request.getParameter("hIdx"); 
	String strContents=request.getParameter("hcontents");
	
	out.println(strIDX + " - "+strContents);

	//1.DB정보 입력
	String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
	String useID = "testdb";
	String usePWD = "1234";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//2.Connection
	Connection con = DriverManager.getConnection(strURL,useID,usePWD);
	
	String strSql = "update guests set contents=? where idx=?";
	PreparedStatement psmt = con.prepareStatement(strSql);
	
	psmt.setString(1, strContents);
	psmt.setString(2, strIDX);
    
	psmt.executeQuery();
	
	response.sendRedirect("./list.jsp");
    
    
    
    %>