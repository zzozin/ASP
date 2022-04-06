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
        td{ font-family:돋움; font-size:12 }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <Script language="javascript">
          //var searchstring=$("documnet.frmsearch.searchstring") =  var searchstring = $("#searchstring")
          function doSearch()
          {
             //var searchString = document.frmSearch.searchString.value;
             var searchString = $("#searchString").val();
             if (CheckStr(searchString, "금지어", "")==0){
            //if ($("#searchString").val().trim() == ''){
                alert("검색어를 기입해 주세요111");
                $("#searchString").val('');
                $("#searchString").focus();
                return;
             }
             document.frmSearch.submit();
          }
       
          //function CheckStr(strOriginal, strFind, strChange){
              var position, strOri_Length;
              position = strOriginal.indexOf(strFind);
          
              while (position != -1){
                strOriginal = strOriginal.replace(strFind, strChange);
                position = strOriginal.indexOf(strFind);
             }
       
             strOri_Length = strOriginal.length;
             return strOri_Length;
          } //공백을 방지하기위한 function이다.(금지어 설정도 가능하다.)
       </script>
      </head>


<%
  Dim Gotopage
  Dim Dbcon, Rs
  Dim pagecount, recordCount
  Dim SQL

  GotoPage = Request("GotoPage")
  if GotoPage = "" then GotoPage = 1

  Set Dbcon = Server.CreateObject("ADODB.Connection")
  Dbcon.Open strConnect

  SQL = "select count(board_idx) as recCount from MyBoard"
  Set Rs = Dbcon.Execute(SQL)

  recordCount = Rs(0)
  pagecount = int((recordCount-1)/pagesize) +1

  SQL = "SELECT TOP " & pagesize & " * FROM MyBoard "
  SQL = SQL & " WHERE board_idx not in "
  SQL = SQL & "(SELECT TOP " & ((GotoPage - 1) * pagesize) & " board_idx FROM MyBoard"
  SQL = SQL & " ORDER BY board_idx DESC) order by board_idx desc"

  Set Rs = Dbcon.Execute(SQL)
%>


    <body topmargin="5" leftmargin="20"><br>
        <table cellpadding="0" cellspacing="0" border="0" width="600">
  <tr>
    <td bgcolor="white" height="30" width="400" style="padding-top:5px;">
      글의 갯수 : <%=recordCount%> &nbsp;&nbsp;

      [<a href="write.asp">글쓰기</a>] &nbsp;
      <% if int(gotopage) > 1 then %>
        [<a href="list.asp?gotopage=<%=gotopage-1%>">이전</a>]
      <% else %>
        <font color="gray">[이전]</font>
      <% end if %>
      &nbsp;
      <% if int(gotopage) < int(pagecount) then %>
        [<a href="list.asp?gotopage=<%=gotopage+1%>">다음</a>]
      <% else %>
        <font color="gray">[다음]</font>
      <% end if %>
    </td>
    <td width="200" align="right">
      page ( <%=gotopage%> / <%=pagecount%> )
    </td>
  </tr>
        </table>
        <table cellpadding="1" cellspacing="0" width="600" style="border:1px solid #cfcfdf">
        <tr bgcolor="#cfcfdf" height="25">
            <td width="340" align="center">제&nbsp; 목</td>
            <td width="20" align="center">
            <img src="images/clipw.gif" WIDTH="13" HEIGHT="13"></td>
            <td width="60" align="center">글쓴이</td>
            <td width="50" align="center">읽음수</td>
            <td width="130" align="center">날짜</td>
        </tr>


<%  
function replaceTag2Text(str)
  Dim text
    
  text = replace(str, "&", "&amp;")
  text = replace(text, "<", "&lt;")
  text = replace(text, ">", "&gt;")
  ReplaceTag2Text = text
End Function

Dim board_idx, name, mail, title, yymmdd, strNew
Dim yy, mm, dd, h, mi, re_level, readnum

Do until Rs.EOF

  board_idx = rs("board_idx")
  name = rs("b_name")
  mail = rs("b_email")

  If Len(name) > 4 Then name = Mid(name,1,4) & ".."
  if name="" then name="무명"

  name= replaceTag2Text(name)

  title = rs("b_title")
  If Len(title) > 22 Then title = Mid(title,1,23) & "..."
  If Trim(title) = "" then title = "[제목없음]"

  title = replaceTag2Text(title)

  yymmdd = rs("b_date")
  strNew = ""

  if datediff ("n",yymmdd,Now()) > 1440 then 
    strNew = " <img src='images/new.gif' border=0>"
  end if
%>


        <tr bgcolor= "white">
            <td height="20"style="padding-left:10px;">
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
 
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
%>

<form name="frmSearch" Method="post" action="search_Result.asp" onSubmit="return false">
  <table cellpadding="1" cellspacing="0" width="600" style="border:1px solid #cfcfdf">
     <tr bgcolor="#cfcfdf" height="25">
        <td align="right">
           <select name="column" align="absmiddle">
              <option value="b_name">글쓴이</option>
              <option value="b_title" selected>제목</option>
              <option value="b_content">내용</option>
           </select>
           <input type="text" size="20" id="searchString" name="searchString">
           <input type="button" value="검색" onClick="doSearch();" id=button3 name=button3>
        </td>
     </tr>
  </table>
</form>
    </body>
</html>