<%@Language="VBScript" CODEPAGE="65001" %>

<!--METADATA TYPE="typelib" NAME="ADODB Type Library"
  File="C:\Program Files\Common Files\System\ado\msado15.dll" -->
  <% Option Explicit %>

  <% Response.Expires=-1 %>

  <!--#include file="config.asp"-->
  <!--#include file="functions.asp"-->

  <html>
    <head> <title>게시판 리스트</title>
        <style type="text/css">
        A {text-decoration: none; color:navy }
        A:hover {text-decoration: underline; color:#ff4500}
        td { font-family:돋움; font-size:12 }
        </style>
    </head>
  
    <%

    Dim Gotopage, column, searchString
    Dim Dbcon, Rs
    Dim pagecount, recordCount
    Dim SQL
  
    GotoPage = Request("GotoPage")
    if GotoPage = "" then GotoPage =1
  
    column = Request("column")
    searchString = Request("searchString")
  
    Set Dbcon = Server.CreateObject("ADODB.Connection")
    Dbcon.Open strConnect
  
    SQL = " SELECT count(board_idx) from MyBoard "
    SQL = SQL & " Where " & column & " like '%" & searchString & "%'"
  
    Set Rs = Dbcon.Execute(SQL)
  
    recordCount = Rs(0)
    pagecount = int((recordCount-1)/pagesize) +1
  
    SQL = "SELECT TOP " & pagesize & " * FROM MyBoard "
    SQL = SQL & " WHERE " & column & " like '%" & searchString & "%' and board_idx not in "
    SQL = SQL & "(SELECT TOP " & ((GotoPage - 1) * pagesize) & " board_idx FROM MyBoard"
    SQL = SQL & " Where " & column & " like '%" & searchString & "%'"
    SQL = SQL & " ORDER BY board_idx DESC) order by board_idx desc"
  
    Set Rs = Dbcon.Execute(SQL)
  %>

    <body topmargin="5" leftmargin="20">
        <br>
        <table cellpadding="0" cellspacing="0" border="0" width="600">
        <tr bgcolor="slategray">
            <td height="30" width="300"> &nbsp;
            <font size="3" color=white><b>검색 결과 리스트</b></font>
            </td>
            <td width="300" align="right"><font color=white>
            <B><%=recordCount%></b> 개의 검색결과가 있습니다&nbsp;&nbsp;&nbsp;
            page ( <%=gotopage%> / <%=pagecount%> ) </font>&nbsp;
            </td>
    </tr>

    <tr bgcolor="white">
        <td height="20" colspan=2>&nbsp;&nbsp;
        <a href="list.asp">&lt;&lt; 리스트로</a>
        </td>
    </tr>
    </table>
  
    <table cellpadding="3" cellspacing="1" width="600" bgcolor="slategray">
    <tr bgcolor="#eeeeee" height="25">
        <td width="340" align="center">제&nbsp; 목</td>
        <td width="20" align="center"><img src="images/clipw.gif" WIDTH="13" HEIGHT="13"></td>
        <td width="60" align="center">글쓴이</td>
        <td width="50" align="center">읽음수</td>
        <td width="130" align="center">날짜</td>
    </tr>
  
    <%

      Dim board_idx, name, mail, title, yymmdd, strNew
      Dim yy, mm, dd, h, mi, re_level, readnum
  
      Do until Rs.EOF
  
        board_idx = rs("board_idx")
        name = rs("b_name")
        mail = rs("b_email")
  
        If Len(name) > 4 Then name = Mid(name,1,4) & ".."
        if name="" then name="無名"
  
        name = ReplaceTag2Text(name)
  
        title = rs("b_title")
        If Len(title) > 22 Then title = Mid(title,1,23) & "..."
        If Trim(title) = "" then title = "[제목없음]"
  
        title = ReplaceTag2Text(title)
  
        yymmdd = rs("b_date")
        strNew = ""
        if datediff ("n",yymmdd,Now()) < 1440 then
          strNew = " <img src='images/new.gif' border=0>"
        end if
  
        yy= year(yymmdd)
        mm = right("0" & month(yymmdd),2)
        dd = right("0" & day(yymmdd),2)
        h = right("0" & hour(yymmdd),2)
        mi = right("0" & minute(yymmdd),2)
        yymmdd = yy & "/" & mm & "/" & dd & " (" & h & ":" & mi & ")"
  
        readnum = rs("b_readnum")

    %>
    
    <tr bgcolor="white">
        <td height="20" style="padding-left:10px;">
        <a href="content.asp?board_idx=<%=board_idx%>&GotoPage=<%=GotoPage%>">
        <%=title%> <%=strNew%></td>
        <td align="center">&nbsp;</td>
        <td align="center">
        <% if mail <>"" then %>
          <a href="mailto:<%= mail%>"><%=name%></a>
        <%else%>
          <%=name%>
        <%end if%>
        </td>
      <td align="center"><%=readnum%></td>
      <td align="center"><%=yymmdd%></td>
    </tr>
  
    <%
        Rs.Movenext
      Loop
  
      Rs.close
      Dbcon.close
      Set Rs = Nothing
      Set Dbcon = Nothing
    %>
    
    <tr height="30" bgcolor="#eeeeee">
      <td align="center" colspan="5">
        <%call gotoPageOnSearch(GotoPage, Pagecount)%>

  <%
 
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
  
%>

      </td>
    </tr>
  </table>
  </body>
</html>