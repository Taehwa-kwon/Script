<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   a {
      display:inline; width:150px; height:30px;
       background-color:lemonchiffon; 
   }
   .txt{width:100%;height:60px; border:1px solid pink; }
</style>
<script src ="https://code.jquery.com/jquery-3.5.0.js"></script>

<script>
	
					/* ('작성자 : 1','11111','btnDiv1','btnCon1') */
	var gUpdate = function(strID,strContent,strDivID,strConID,strIDX){
		var txtID = "txt" + strIDX;
		var strHTML = "<textarea id='"+txtID+"'>"+strContent+"</textarea>";
		$("#" + strID).html(strHTML);
		
		/* var strHTML2 = "<a href=''>확인</a>":
		$("#" + strDivID).html(strHTML2); */
		
		// 1. 수정을 클릭하면 -> 확인 div를 보여주고 
		$("#" + strDivID).hide();
		$("#" + strConID).show();

		// 2. 확인을 클릭하면 -> 
	}
					
		var Go_Update = function(strIDX){
			var txtID = "txt" + strIDX;
			var txtValue=$("#"+txtID).val();
			
			
			//location.href="update.jsp?idx=" + strIDX + "&contents" + txtValue; //이렇게하면 주소창에 값은 넘어가는데 , 만약에 수정해서 content에 엄청많은 내용을 수정하면 주소창에 개난리난다.
			$("#hIdx").val(strIDX);
			$("#hcontents").val(txtValue);
			
			hidForm.submit();
			
			
			
		}

</script>

</head>
		<%
		   //0. Client가 보낸 데이터를 받아야한다
		   String strName       = request.getParameter("name");
		   String strContents    = request.getParameter("contents"); 
		
		   String url    = "jdbc:oracle:thin:@localhost:1521:XE";
		   String user   = "testdb";
		   String pwd    = "1234";
		   
		   Class.forName("oracle.jdbc.driver.OracleDriver");
		   
		   //1. Connection
		   Connection conn = DriverManager.getConnection(url, user, pwd);
		   
		   //2. PreparedStatement
		  
		   /* String strSQL = "SELECT IDX, NAME, CONTENTS, TO_CHAR(REGDATE, 'YYYY-MM-DD HH:MI:SS') AS REGDATE";
		   strSQL += " FROM GUESTS";
		   strSQL += " ORDER BY IDX DESC";
		   PreparedStatement iPsmt = conn.prepareStatement(strSQL);
		
		   iPsmt.executeUpdate();
		   ResultSet iRs = iPsmt.executeQuery(); */
		   
		   
		   String strProc = "CALL PROC_SELECT(?, ?)";
		   CallableStatement cstmt = conn.prepareCall(strProc);
		   cstmt.setString(1, "");
		   cstmt.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR); // 자바쪽에서 받아야한다.
		   
		   cstmt.execute();
		   /* 만약 out변수가 varchar2와 cursor 두개라면,
		   String strName = (String)cstmt.getObject(1);
		   ResultSet rs = (ResultSet)cstmt.getObject(2); cursor라서 rs type으로 받는다
		   */
		   ResultSet iRs = (ResultSet)cstmt.getObject(2);
		   
		%>
<body>
   <table border="0" cellpadding="0" cellspacing="0" width="500px" align="center">
  
      <tr>
         <td width="500px" style="border:1px solid black"align="right" height="30px" colspan="2">
         	<a href="./write.jsp">글쓰기</a>
         </td>
      </tr>
      
		   <%
		      while(iRs.next()){  //쿼리의 결과를 테이블형식으로 만들어 졌다라고 생각.
		   %>
      
      <tr>
         <td width="120px" align="left" height="30px"><%=iRs.getString("name") %></td>
         <td width="380px" align="right" height="30px"><%=iRs.getString("regdate") %></td>
      </tr>
      
     
      <tr>
         <td width="500px" align="left" height="30px" colspan="2">
         	
         	<%
         		String conID = "Writer" + iRs.getString("idx"); //앞에 작성자: 한글x :x 공백x
         	%>
          
            <div id="<%=conID%>">
            <%= iRs.getString("contents") %>  <!--  컨텐츠 내용을 출력  -->
            <br/>
            	작성자:<%=conID%> <!-- 위에 conID를 출력함  -->
            </div>
         </td>
      </tr>
      
      
      <tr>
         <td colspan="2"  width="500px" style="border:1px solid red" align="right" height="30px">
         	<%
         		String strDivID= "btnDiv" + iRs.getString("idx");
         		String strConID= "btnCon" + iRs.getString("idx");
         	%>
         
         	<div id="<%=strDivID%>">
	         	<a href="javascript:gUpdate('<%=conID%>','<%=iRs.getString("contents")%>','<%=strDivID%>','<%=strConID%>','<%=iRs.getString("IDX")%>' )">수정</a>
	         	
	         	<a href="delete.jsp?idx=<%=iRs.getString("IDX")%>">삭제</a>
         	</div>
         	<div id="<%=strConID%>" style="display:none">
				<%-- <a href="./update.jsp?idx=<%=iRs.getString("IDX")%>">확인</a> <!-- //서버로 보냈다가 다시 가져와야함 . 키값을 가져가야하니깐. --> --%>
				<a href="javascript:Go_Update('<%=iRs.getString("IDX")%>')">확인</a>
         	</div>
         </td>
      </tr>
      
      
      <tr>
         <td colspan="2" width="500px" height="1px" style="background-color:black;">사실 필요없네.</td>
      </tr>
		   <%
		      }
		   %>
   </table>
   
   <form name="hidForm" action="./update.jsp" method="post"> <!-- form태그의 역할은 form태그 사이에 있는값들을 submit해서 전달하는 역할 --> 
	   <input type="hidden" id="hIdx" name="hIdx" />
	   <input type="hidden" id="hcontents" name="hcontents"/>
   </form>
   
</body>
</html>









<!--  마지막 프로시저
	 CREATE OR REPLACE PROCEDURE PROC_SELECT
    (
     CONTENTS IN VARCHAR2,
     O_CUR OUT SYS_REFCURSOR
    )
    AS
    
    BEGIN
    
        OPEN O_CUR FOR
        SELECT IDX, NAME, CONTENTS, TO_CHAR(REGDATE,'YYYY-MM-DD HH:MI:SS')AS REGDATE
        FROM GUESTS
        WHERE CONTENTS LIKE '%'|| CONTENTS ||'%'
        ORDER BY IDX DESC
        ;
    END PROC_SELECT;
        
         -->

