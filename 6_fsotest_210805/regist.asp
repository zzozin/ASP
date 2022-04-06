<html>
    <head> <meta charset="UTF-8">
        <%@language="vbscript" codepage="65001" %>
        <%
         response.charset="UTF-8"
         session.codepage="65001"
         response.codepage="65001"
         response.contenttype="text/html;charset=UTF-8"
         %>
        <title>사용자로부터 정보 얻기</title>
    </head>
    
    <body>
        <form name = frminfo method=post action=regist_ok.asp>
        이름:<input type=text name=txtname size=15><br>
        email:<input type=text name=txtemail size=30><br>
        전화번호 : <input type=text name=txtphone siz=20><br>
        <input type=submit value='전송'>
        </form>

    </body>
</html>