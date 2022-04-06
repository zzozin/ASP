<%@Language="VBScript" CODEPAGE="65001" %>

<% Option Explicit %>
<!--#include file="config.asp"-->

<%
    Dim Gotopage, board_idx, pwd
    GoTopage= request("GotoPage")
    board_idx = request("board_idx")
    pwd = request("pwd")

    Dim adoDb, SQL, Rs
    Set adoDb = Server.CreateObject("ADODB.Connection")
    adoDb.Open strConnect

    SQL = "SELECT b_name,b_title,b_email,b_url,b_content from MyBoard "
    SQL = SQL & " where board_idx=" & board_idx & " and b_pwd='" & pwd & "'"

    Set Rs = adoDb.execute(SQL)

    Dim name, title, mail, url, content

    if Rs.BOF and Rs.EOF then '비밀번호가 틀리면
        Response.Write "<script language=javascript>"
        Response.Write " alert('비밀번호가 일치하지 않습니다');"
        Response.Write " history.back();"
        Response.Write "</script>"
        Response.End
    else '비밀번호가 맞다면
        name = Rs("b_name")
        title = Rs("b_title")
        mail = Rs("b_email")
        url = Rs("b_url")
        content = Rs("b_content")
    end if

    Rs.Close
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
        <title></title>
        <style type="text/css">
            A{text-decoration: none; color:navy }
            A:hover{text-decoration: underline; color:orange}
            td { font-family:돋움; font-size:12 }
            input,Textarea {font-family:돋움;border: 1 solid white;border-bottom: 1 solid silver}
        </style>
    </head>
    <script language="javascript">
     function sendit(){
    //제목
    if (document.myform.title.value == "") {
        alert("제목.");
        return;}
    //이름
    if (document.myform.name.value == "") {
        alert("이름.");
        return;}
    //글 내용
    if (document.myform.memo.value == "" ) {
        alert("내용");
        return;}
    document.myform.submit();}

    function focus_it(){
    document.all.title.focus();}
    </script>

    <body bgcolor="#ffffff" onload="javascript:focus_it();">
        <form method="POST" action="Edit_result.asp" name="myform">
        <input type="hidden" name= "board_idx"value="<%=board_idx%>">
        <input type="hidden" name= "Gotopage"value="<%=Gotopage%>">

        <table border="0" cellspacing="0" width="520" cellpadding="0">
            <tr height="50">
                <td align="right" width="170" >
                <input type="button" value="수정완료" name="edit" OnClick="sendit()"
                style="background-color:khaki"></td>
                <td width="350" align="left" style="padding-left:70">
                <font color="blue">글을 수정합니다</font>
                </td>
            </tr>
    
            <tr height="30" >
                <td width="170" align="right" >제목</td>
                <td width="350" align="left" style="padding-left: 20; padding-right: 30">
                <input type="text" name="title" size= "50"value="<%=title%>"></td>
            </tr>
            <tr>
                <td align="right" >이름</td>
                <td align="left" style="padding-left: 20; padding-right: 30">
                <input type="text" name="name" size= "50"value="<%=name%>"></td>
            </tr>
    
            <tr>
                <td align="right" >메일</td>
                <td align="left" style="padding-left: 20; padding-right: 30">
                <input type="text" name="mail" size= "50"value="<%=mail%>"></td>
            </tr>
    
            <tr>
                <td align="right" >사이트</td>
               <td align="left" style="padding-left: 20; padding-right: 30">
            <input type="text" name="url" size= "50"value="<%=url%>"></td>
            </tr>
    
            <tr>
                <td align="right" >글</td>
                <td align="left" style="padding-left: 20; padding-top: 5; padding-bottom: 5">
                <textarea wrap="hard" rows="10" name= "memo"cols="50"><%=content%></textarea></td>
            </tr>
    
            <tr height="25">
                <td align="right" colspan="2" style="padding-right:25">
                <input type="button" value="수정완료" name="edit" OnClick="sendit()"
                style="background-color:khaki">
            </td>
        </tr>
        </table>
        </form>
    </body>
</html>