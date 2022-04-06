<!--METADATA TYPE= "typelib" NAME= "ADODB Type Library"
    FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->

<% Option Explicit %>

<!--#include file="config.asp"-->

<%
    Dim name, mail, title, url, memo, board_idx, Gotopage

    Gotopage = Request.Form("Gotopage")
    board_idx = Request.Form("board_idx")
    name = Request.form("name")
    mail = Request.form("mail")
    title = Request.form("title")
    url = Request.form("url")
    memo = Request.form("memo")

    Response.write "Board_idx : " & board_idx
    'Response.end

    Dim adoRs, strSQL
    Set adoRs = Server.CreateObject("ADODB.RecordSet")

    strSQL = "Select * from MyBoard where board_idx =" & board_idx
    Response.write strSQL
    
    adoRs.Open strSQL, strConnect, adOpenStatic, adLockPessimistic, adCmdText

    with adoRs
        .Fields("b_name") = name
        .Fields("b_email") = mail
        .Fields("b_title") = title
        .Fields("b_url") = url
        .Fields("b_ipaddr") = Request.ServerVariables("REMOTE_ADDR")
        .Fields("b_content") = memo

        .Update
        .Close
    end with

    Set adoRs = nothing

    Response.redirect "list.asp?Gotopage="
%>