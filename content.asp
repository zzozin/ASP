<%@Language="VBScript" CODEPAGE="65001" %>

<% Option Explicit %>

<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->

<%
  Dim Gotopage
  GoTopage= request("GotoPage")

  Dim adoDb, SQL, Rs
  Set adoDb = Server.CreateObject("ADODB.Connection")
  adoDb.Open strConnect

  SQL = "SELECT board_idx,b_name,b_title,b_date,b_email,b_ipaddr,b_readnum,b_pwd,b_content from MyBoard "
  SQL = SQL & " where board_idx=" & request.Querystring("board_idx")

  Set Rs = adoDb.execute(SQL)

  Dim board_idx, name, title, mail, writeday
  Dim ipaddr, readnum, pwd, content
  Dim prev_idx, next_idx

  board_idx = Rs("board_idx")
  name = Rs("b_name")
  name = ReplaceTag2Text(name)
  title = Rs("b_title")
  title = ReplaceTag2Text(title)
  writeday = Rs("b_date")
  mail = Rs("b_email")
  mail = ReplaceTag2Text(mail)
  ipaddr = Rs("b_ipaddr")
  readnum = Rs("b_readnum")
  pwd = rs("b_pwd")
  content = Rs("b_content")
  content = ReplaceTag2Text(content)
  content = replace(content,vblf,"<br>")

  Rs.close

  '이전글
  SQL = "Select Min(board_idx) from MyBoard where board_idx > " & board_idx
  Set Rs = adoDb.Execute(SQL)
  if Not Rs.EOF then
    prev_idx = Rs(0)
  end if
  Rs.close


  '현재글
  SQL = "Select co_name, co_date, co_content from comment " & _
      " where board_idx=" & board_idx
      Set Rs = adoDb.Execute(SQL)
  Dim arrComment
  if Not Rs.EOF then
    arrComment = Rs.GetString()
  End if
  Rs.close

  '다음글
  SQL = "Select Max(board_idx) from MyBoard where board_idx < " & board_idx
  Set Rs = adoDb.Execute(SQL)
  if Not Rs.EOF then
    next_idx = Rs(0)
  end if
  Rs.close

  
  

  adoDb.close
  Set Rs = Nothing
  Set adoDb = nothing
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <style type="text/css">
      A {text-decoration: none; color:navy }
      A:hover {text-decoration: none; color:orange}
      td {padding:7; font-family:돋움; font-size:12 }
      input {border: 1 solid silver; font-family:dotum; font-size:9pt;}
  </style>
  <script language="javascript">
  function Del()
  {
    var pwd = document.myform.pwd.value;
    if (CheckStr(pwd, " ", "")==0) {
      alert("비밀번호를 입력해 주세요");
      return;
    }
    document.myform.action = "del_ok.asp";
    document.myform.submit();
  }

  function Edit()
  {
    var pwd = document.myform.pwd.value;
    if (CheckStr(pwd, " ", "")==0) {
      alert("비밀번호를 입력해 주세요");
      return;
    }
    document.myform.action = "Edit.asp";
    document.myform.submit();
  }

  function addComment()
  {
    var name = document.frmMent.name.value;
    if (CheckStr(name, " ", "")==0) {
      alert("이름을 입력해 주세요");
      document.frmMent.name.focus();
      return;
    }
    var content = document.frmMent.content.value;
    if (CheckStr(content, " ", "")==0) {
      alert("코멘트 내용을 입력해 주세요");
      document.frmMent.content.focus();
      return;
    }
    document.frmMent.submit();
  }

  function CheckStr(strOriginal, strFind, strChange){
    var position, strOri_Length;
    position = strOriginal.indexOf(strFind);

    while (position != -1){
      strOriginal = strOriginal.replace(strFind, strChange);
      position = strOriginal.indexOf(strFind);
    }

    strOri_Length = strOriginal.length;
    return strOri_Length;
  }
  </script>
  </head>
  <body>
    <form method="POST" action="Write.asp" name="myform">
    <input type= "hidden" name= "board_idx"value="<%=board_idx%>">
    <table cellpadding="0" cellspacing="0" border="0" width= "540">
    <tr>
      <td bgcolor="white"valign="top"style="padding:2px;"width="400"><br>        
        <a href="list.asp?gotopage=<%=gotopage%>">[ 리스트로 ]</a>
      </td>
      <td bgcolor="white" valign="top" align="right" width="140">
        조회수 : <%=readnum%>
      </td>
    </tr>
    <tr>
      <td bgcolor="#aaaaaa" style="padding:2px;" colspan="2">
        <table cellpadding="0" cellspacing="1" border="0" width="540">
    <tr>
        <td width="100" bgcolor="#EFEFEF" align="center" height="20">게시자</td>
        <td width= "44"bgcolor = "white">
              <%if mail <> "" then%>
                <a href="mailto:<%=mail%>"><%=name%></a>
              <% else %>
                <%=name%>
              <% end if%>
          </td>
      </tr>
      
      <tr>
          <td BGCOLOR="#EFEFEF" align="center" valign="middle" height="25">날짜</td>
          <td bgcolor="white"><%=writeday%></td>
      </tr>
          
      <tr>
        <td BGCOLOR= "#EFEFEF" align="center" valign= "middle"height="25">제목</td>
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
  <table width="540">
    <tr>
      <td>
        <% if prev_idx <> ""then%>
          <a href="content.asp?board_idx=<%=prev_idx%>&Gotopage=<%=Gotopage%>">
          &lt; &lt; 이전 글 보기
          </a>
        <% end if%>
        |
        <% if next_idx <> ""then%>
          <a href="content.asp?board_idx=<%=next_idx%>&Gotopage=<%=Gotopage%>">
          다음 글 보기 &gt; &gt;
          </a>
        <% end if%>
      </td>
    </tr>
  </table>
</form>

<form name="frmMent" action="Insert_Comment.asp" Method="post">
  <table width="540" bgcolor="slategray" cellspacing="1">
    <tr bgcolor="#eeeeee">
      <td colspan=2>여러분의 커멘트를 남겨주세요</td>
    </tr>
    <Tr bgcolor="white">
      <INPUT class= "inputa" type="hidden" name= "GoTopage"value="<%=GoTopage%>">
      <INPUT class= "inputa" type="hidden" name= "board_idx"value="<%=board_idx%>">
      <td>이름 : <INPUT class="inputa" name="name" size="7"></td>
      <td align="center">멘트 :
        <INPUT class="inputa" name="content" size="50" maxlength="200">
        <Input class="buttona" type="button" onClick="addComment();" value="저장">
      </td>
    </tr>
  </table>
</form>

<%
  if arrComment <> "" then
    Dim arrRecord, arrColumn, inum
    arrRecord = Split(arrComment,chr(13))
%>
  <br><font size=2><b>Comment</b></font>
  <table width="540" bgcolor="slategray" cellspacing="1">
<%
  for inum=0 to Ubound(arrRecord)-1
    arrColumn = Split(arrRecord(inum), Chr(9))
%>
    <tr bgcolor="white">
      <td><p><%= arrColumn(0)%>(<%=arrColumn(1)%>)</p><%=arrColumn(2)%>
      </td>
    </tr>
  <%next %>
  </table>
<%
end if%>
</body>
</html>

<%
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
%>