<html>
    <meta charset="utf-8">
    <head>
        <script type="javascript" src="ttps://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">
        </script>
    </head>
    <body>
        <form name="testForm" id="login">
            <input type="text" id="id"/>
            <input type="text" id="pw"/>
            <input type="submit"/>
        </form>
        <hr/>
        <button id="btn">전송</button>

        <script type="text/javascript">
            $(document).ready(function() {
  $("form").submit(function(event) {
    var id = $('#id').val();
    var pw = $('#pw').val();

    if (id != "" && pw != "") {
      alert("id :: " + id + ", pw :: " + pw);
    }

    if (id == "") {
      alert("id를 입력해주세요.");
      event.preventDefault();
      return;
    }

    if (pw == "") {
      alert("pw를 입력해주세요.");
      event.preventDefault();
      return;
    }
  });

  $('#btn').click(function() {
    $("form").submit();
  });
});

        </script>
    </body>
</html>