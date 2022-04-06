<%@Language="VBScript" CODEPAGE="65001" %>

<% Option Explicit %>
<!--#include file="config.asp"-->
<%
  Dim Gotopage
  GoTopage= request("GotoPage")

  Dim adoDb, SQL, Rs
  Set adoDb = Server.CreateObject("ADODB.Connection")
  adoDb.Open strConnect

  SQL = "Update MyBoard set b_readnum=b_readnum+1 where board_idx=" & request("board_idx")
  adoDb.execute SQL

  SQL = "SELECT board_idx,b_name,b_title,b_date,b_email,b_ipaddr,b_readnum,b_pwd, "
  SQL = SQL & " b_content from MyBoard "
  SQL = SQL & " where board_idx=" & request.Querystring("board_idx")

  Set Rs = adoDb.execute(SQL)

  Dim board_idx, name, title, mail, writeday
  Dim ipaddr, readnum, pwd, content

  if Rs.BOF or Rs.EOF then
    Response.Write "<Script>"
    Response.Write " alert('현재 글은 존재하지 않습니다.');"
    Response.Write " location.href='list.asp';"
    Response.Write "</Script>"
    Response.End
  else
    board_idx = Rs("board_idx")
    name = Rs("b_name")
    title = Rs("b_title")
    writeday = Rs("b_date")
    mail = Rs("b_email")
    ipaddr = Rs("b_ipaddr")
    readnum = Rs("b_readnum")
    content = Rs("b_content")
    content = replace(content,vblf,"<br>")
  end if

  adoDb.close
  Set Rs = Nothing
  Set adoDb = nothing
%>

<%
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ks_c_5601-1987">
        <style type="text/css">
         A{text-decoration: none; color:navy }
         A:hover{text-decoration: none; color:orange}
         td{padding:7; font-family:돋움; font-size:12 }
         input{border: 1 solid silver; font-family:dotum; font-size:9pt;}
        </style>
        <script language="javascript">
        <!--
        function Del()
        {var pwd = document.myform.pwd.value;
        if (CheckStr(pwd, " ", "")==0){alert("비밀번호를 입력해 주세요");return;}
        document.myform.action = "del_ok.asp";
        document.myform.submit();}

        function Edit()
        {var pwd = document.myform.pwd.value;if (CheckStr(pwd, " ", "")==0){alert("비밀번호를 입력해 주세요");return;}
        document.myform.action = "Edit.asp";
        document.myform.submit();}

        function addComment()
        {document.myform.action = "Comment.asp";
        document.myform.submit();}

        function CheckStr(strOriginal, strFind, strChange){
        var position, strOri_Length;
        position = strOriginal.indexOf(strFind);

        while (position != -1){
        strOriginal = strOriginal.replace(strFind, strChange);
        position = strOriginal.indexOf(strFind);}

        strOri_Length = strOriginal.length;
        return strOri_Length;} //-->
        </script>
    </head> 
    <body>
        <form method= "POST" action="Write.asp" name= "myform">
        <input type="hidden" name= "board_idx"value="<%=board_idx%>">
        <table cellpadding="0" cellspacing= "0"border="0"width="540">
        <tr>
            <td bgcolor="white"valign="top"style="padding:2px;"width="400">
            <a href="list.asp?gotopage=<%=gotopage%>">[ 리스트로 ]</a></td>
            <td bgcolor="white" valign="top" align="right" width="140">조회수 : <%=readnum%></td>
        </tr>
    
        <tr>
            <td bgcolor="#aaaaaa" style="padding:2px;" colspan="2">
            <table cellpadding="0" cellspacing="1" border="0" width="540">
          
        <tr>
            <td width="100" bgcolor="#EFEFEF" align="center" height="20">게시자</td>
            <td width="44" bgcolor="white">
              <%if mail<>""then%>
                <a href="mailto:<%=mail%>"><%=name%></a>
              <%else%>
                <%=name%>
              <% end if%>
            </td>
        </tr>
        
        <tr>
            <td BGCOLOR="#EFEFEF" align="center" valign="middle" height="25">날짜</td>
            <td bgcolor="white"><%=writeday%></td>
         </tr>
         
         <tr>
            <td BGCOLOR="#EFEFEF" align="center" valign="middle" height="25">제목</td>
            <td bgcolor="white"><%=title%></td>
        </tr>
        
        <tr VALIGN="top">
            <td BGCOLOR="#EFEFEF" align="center" valign="middle">내용</td>
            <td bgcolor= "white"class="content"><%=content%></td>
        </tr>
        </table>
            </td>
        </tr>
    
        <tr>
            <td style="padding-top:3px;" align="right" colspan="2">
            <table cellpadding="0" cellspacing="0" border="0" width="340">
          
        <tr>
            <td align="right" width= "200"style="padding=0">
              비밀번호 <input type="password" name="pwd" size="10" class="pwd"></td>
            <td align="right" width= "70"style="padding=0">
              <a href="javascript:Edit();">[수정하기]</a></td>
            <td align="right" width= "70"style="padding=0">
              <a href="javascript:Del();">[삭제하기]</a></td>
        </tr>
        </table>
            </td>
        </tr>
        </table>
        </form>
    </body>
</html>