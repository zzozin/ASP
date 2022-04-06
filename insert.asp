<!--METADATA TYPE="typelib" NAME="ADODB Type Library"
FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->

<%
Option Explicit

Dim name, mail, title, url, memo, pwd

name    = Request.form("name")
mail    = Request.form("mail")
title   = Request.form("title")
url     = Request.form("url")
memo    = Request.form("memo")
pwd     = Request.form("pwd")


Dim strConnect,Gotopage
Request.form ("Gotopage")
strConnect="Provider=SQLOLEDB;Data Source=DESKTOP-5NL4JKP\SQLEXPRESS;Initial Catalog=MyDatabase;"&_
    "user ID=zzo; password=q930704;"


Dim adoRs
Set adoRs = Server.CreateObject("ADODB.RecordSet")
adoRs.Open "myboard", strConnect, adOpenStatic, adLockPessimistic, adCmdTable


with adoRs
  .AddNew
  .Fields("b_name") = name
  .Fields("b_email") = mail
  .Fields("b_title") = title
  .Fields("b_url") = url
  .Fields("b_pwd") = pwd
  .Fields("b_readnum") = 0
  .Fields("b_date") = now()
  .Fields("b_ipaddr") = Request.ServerVariables("REMOTE_ADDR")
  .Fields("b_content") = memo

  .Update
  .Close
end with

Set adoRs = nothing

Response.redirect "list.asp?Gotopage=" & Gotopage
%>

