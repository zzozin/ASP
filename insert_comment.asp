<!--METADATA TYPE="typelib" NAME="ADODB Type Library"
  FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->

<% Option Explicit %>

<!--#include file="config.asp"-->
<!--#inclue file="functions.asp"-->

<%
  Dim board_idx, GotoPage, name, content
  board_idx = Request.form("board_idx")
  GotoPage = Request.form("GotoPage")
  name = Request.form("name")
  content = Request.form("content")
  
  Dim adoRs
  Set adoRs = Server.CreateObject("ADODB.RecordSet")
  adoRs.Open "Comment", strConnect, adOpenStatic, adLockPessimistic, adCmdTable
  
  with adoRs
    .AddNew
    .Fields("Co_name") = name
    .Fields("board_idx") = board_idx
    .Fields("Co_content") = content
  
    .Update
    .Close
  end with
  
  Set adoRs = nothing
  Response.Redirect "content.asp?GotoPage=" & GotoPage & "&board_idx=" & board_idx
%>