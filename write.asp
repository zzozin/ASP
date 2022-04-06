<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>
    
    <style type="text/css">
      A {text-decoration: none; color:navy }
      A:hover {text-decoration: underline; color:orange}
      td {font-family:돋움;font-size:12 }
      input,Textarea {
      font-family:돋움;
      border: 1 solid white;
      border-bottom: 1 solid silver}
    </style>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">
  
    </script>
  </head>

  <body bgcolor="#ffffff" onload="javascript:document.all.title.focus();">
    
    <form method="POST" action="insert.asp" name="myform">
    
      <table border="0" cellspacing="0" width="520" cellpadding="0">
    
      <tr height="50">
        <td align="right" width="170" >
        <input type="button" value="글 저장" name="write" OnClick="sendit()"
          style="background-color:khaki"></td>
        <td width="350" align="left" style="padding-left:70">
          <font color="blue">글을 남겨주세요...</font></td>
    </tr>
    
    <tr height="30" >
      <td width="170" align="right" >제목</td>
      <td width="350" align="left" style="padding-left: 20; padding-right: 30">
        <input type="text" name="title" size="50"></td>
    </tr>
    
    <tr>
      <td align="right" >이름</td>
      <td align="left" style="padding-left: 20; padding-right: 30">
        <input type="text" name="name" id ="name"  size="50"></td>
    </tr>
    
    <tr>
      <td align="right" >메일</td>
      <td align="left" style="padding-left: 20; padding-right: 30">
        <input type="text" name="mail" size="50"></td>
    </tr>
    
    <tr>
      <td align="right" >사이트</td>
      <td align="left" style="padding-left: 20; padding-right: 30">
        <input type="text" name="url" size="50"></td>
    </tr>
    
    <tr>
      <td align="right" >글</td>
      <td align="left" style="padding-left: 20; padding-top: 5; padding-bottom: 5">
        <textarea wrap="hard" rows="10" name="memo" cols="50"></textarea></td>
    </tr>
    
    <tr height="25">
      <td align="right" colspan="2" style="padding-right:25">비밀번호
        <input type="password" name="pwd" size="7">
        <input type="button" value="글 저장" name="write" OnClick="sendit()"  style="background-color:khaki">
      </td>
    </tr>
  </table>
  </form>
  <script>
    $(document).ready(function() {
      $("input[name=write]").click(function(){
           if($("input[name=title]").val()==''){ alert("제목"); $("input[name=title]").focus(); return; }
           if($("input[name=name]").val()==''){ alert("이름"); $("input[name=name]").focus(); return; }
           if($("textarea").val()==''){ alert("내용"); $("textarea").focus(); return; }
           if($("input[name=pwd]").val()==''){ alert("비밀번호"); $("input[name=pwd]").focus(); return; }
          $("form").submit();
          });		
     });
  </script>
  </body>
</html>