<%@Language="VBScript" CODEPAGE="65001" %>

<% 

  Response.CharSet="utf-8"

  Session.codepage="65001"

  Response.codepage="65001"

  Response.ContentType="text/html;charset=utf-8"

%>

<html>
    <head></head>

    <body>
<%
dim strname, stremail, strphone

strname = request.form ("txtname")
stremail = request.form ("txtemail")
strphone = request.form ("Txtphone")


response.write ("이름은 = " & strname & "<br>")
response.write ("Email은 = " & stremail & "<br>")
response.write ("전화번호는 = " & strphone & "<br>")
%>
</body>
</html>