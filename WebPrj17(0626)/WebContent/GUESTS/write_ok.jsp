<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	write.jsp의 내용을 웹서버(개발자 측에서) 받아서 다시
	
	<%@ page language="java" import="java.sql.*" %>
	<%
	
	//0.클라이언트가 준 데이터를 받아야 한다.
	String strName = request.getParameter("name");
	String strContents = request.getParameter("contents"); //name의 정보를 작성
	
	//1.DB정보 입력
	String strURL = "jdbc:oracle:thin:@localhost:1521:XE";
	String useID = "testdb";
	String usePWD = "1234";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//2.Connection
	Connection con = DriverManager.getConnection(strURL,useID,usePWD);
	
	//3.PreparedStatement  // 요청할 SQL문을 전송하고 실행하는 클래스 
		//3.1프로시저 생성하고
	String iSql = "SELECT nvl(max(idx),0)+1 AS NEWIDX FROM GUESTS";  //?
	PreparedStatement iPsmt = con.prepareStatement(iSql); //Connection의 인터페이스 사용
	
	ResultSet iRs = iPsmt.executeQuery();   //ResultSet 객체 : DB의 자료를 자바로 표현하는 클래스    전송한 후 DB에서 SQL문이 실행되고 결과를 담아 줄 것을 작성
	iRs.next(); //레코드 선택
	
	String strIdx = iRs.getString("NEWIDX");
	out.println(strIdx); //? 
			
	
	String strSql = "INSERT INTO GUESTS(IDX,NAME,CONTENTS,REGDATE) VALUES(?,?,?,sysdate)"; //?
	PreparedStatement psmt = con.prepareStatement(strSql); 
	
	
	
	psmt.setString(1,strIdx);
	psmt.setString(2,strName);
	psmt.setString(3,strContents);
	
	psmt.executeUpdate();
	
	response.sendRedirect("./list.jsp");
	
	
	
	%>
	
	CREATE TABLE GUESTS (
      IDX      NUMBER(6)      PRIMARY KEY
    , NAME     VARCHAR2(20)   NOT NULL
    , CONTENTS VARCHAR2(4000) NOT NULL
    , REGDATE  DATE           NOT NULL
);

	
	SET SERVEROUTPUT ON;
	DECLARE
	
		NEW_IDX NUMBER(6);
	
	BEGIN
		
		SELECT NVL(MAX(IDX),0)+1 
		INTO NEW_IDX
		FROM GUESTS
		;
		DBMS_OUTPUT.PUT_LINE(NEW_IDX);
		
	END;
	
	
	SELECT nvl(max(idx),0)+1 AS NEWIDX FROM GUESTS;
	
	
	