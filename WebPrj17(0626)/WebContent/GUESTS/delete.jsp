<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*" %>

<%

	String strIDX = request.getParameter("idx");




	//1.DB정보 입력
	String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
	String useID = "testdb";
	String usePWD = "1234";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//2.Connection
	Connection con = DriverManager.getConnection(strURL,useID,usePWD);
	
	String strSql = "DELETE FROM GUESTS WHERE IDX=?"; //?
	PreparedStatement psmt = con.prepareStatement(strSql);
	
	psmt.setString(1,strIDX);
	
	psmt.executeUpdate();
	
	String strUpdate = "update guests set idx = idx -1 where idx > ?";
	PreparedStatement psmt2 = con.prepareStatement(strUpdate);
	
	psmt2.setString(1,strIDX);
	
	psmt2.executeUpdate();
	
	con.close();
	
	//렌더링을 해서 돌려준다.
	response.sendRedirect("./list.jsp");
	
	
%>
    
    
    