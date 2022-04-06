<%@Language="VBScript" CODEPAGE="65001" %>

<!--METADATA TYPE= "typelib" NAME= "ADODB Type Library"
    FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->


<% Option Explicit %>

<!--#include file="config.asp"-->

<%
    Dim Gotopage, board_idx, pwd
    Gotopage = Request.Form("Gotopage")
    board_idx = Request.Form("board_idx")
    pwd = Request.Form("pwd")

    Dim adoDb, adoRs, strSQL
    Set adoDb = Server.CreateObject("ADODB.Connection")
    Set adoRs = Server.CreateObject("ADODB.RecordSet")
    
    adoDb.open strconnect

    strSQL = "SELECT board_idx from MyBoard "
    strSQL = strSQL & " where board_idx=" & board_idx & " and b_pwd='" & pwd & "'"

    adoRs.open strSQL, strconnect, adOpenStatic, adLockPessimistic, adCmdText

    if adoRs.BOF and adoRs.EOF then '비밀번호가 틀리면
        Response.Write "<script language=javascript>"
        Response.Write " alert('비밀번호가 일치하지 않습니다');"
        Response.Write " history.back();"
        Response.Write "</script>"
        Response.End
    else '비밀번호가 맞다면
        adoRs.close
        Set adoRs = nothing

    strSQL = "delete from Comment where board_idx=" & board_idx & ";"
    strSQL = strSQL & "delete from MyBoard where board_idx=" & board_idx

    adoDb.Execute strSQL
    adoDb.close
    Set adoDb = nothing
    end if

    Response.redirect "list.asp?Gotopage=" & Gotopage
%>

<%
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
%>