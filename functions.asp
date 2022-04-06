<%

function ReplaceTag2Text(str)
   Dim text

   text = replace(str, "&", "&amp;")
   text = replace(text, "<", "&lt;")
   text = replace(text, ">", "&gt;")
   ReplaceTag2Text = text

   End Function

   
   
   Sub gotoPageHTML(page, Pagecount)
   Dim blockpage, i
   blockpage=Int((page-1)/10)*10+1

   '이전 10 개 구문 시작
   if blockPage = 1 Then
      Response.Write "<font color=silver>[이전 10개]</font> ["
   Else
      Response.Write"<a href='list.asp?gotopage=" & blockPage-10 & "'>[이전 10개]</a> ["
   End If
   '이전 10 개 구문 끝

   i=1
   Do Until i > 10 or blockpage > Pagecount
      If blockpage=int(page) Then
         Response.Write " <font size=2 color=gray>" & blockpage & "</font>"
      Else
         Response.Write "<a href='list.asp?gotopage=" & blockpage & "'>" & blockpage & "</a> "
      End If

      blockpage=blockpage+1
      i = i + 1
   Loop

   '다음 10 개 구문 시작
   if blockpage > Pagecount Then
      Response.Write "] <font color=silver>[다음 10개]</font>"
   Else
      Response.write "]<a href='list.asp?gotopage=" & blockpage & "'>[다음 10개]</a>"
   End If
   '다음 10 개 구문 끝
End Sub

'FUNCTION NAME : 검색결과에서 페이지별 바로가기
'FUNCTION CONT. : 검색결과에서 페이지별 바로가기를 생성
'참고사항 : 위의 함수에 각각의 링크에 column, searchString 을 추가

Sub gotoPageOnSearch(page, Pagecount)
   Dim blockpage, i
   blockpage=Int((page-1)/10)*10+1

   '이전 10 개 구문 시작
   if blockPage = 1 Then
       Response.Write "<font color=silver>[이전 10개]</font> ["
   Else
      Response.Write "<a href='searchResult.asp?gotopage=" & blockPage-10 & _
                             "&column=" & column & "&searchString=" & searchString & "'>[이전 10개]</a> ["
   End If
   '이전 10 개 구문 끝

   i=1
   Do Until i > 10 or blockpage > Pagecount
      If blockpage=int(page) Then
         Response.Write " <font size=2 color=gray>" & blockpage & "</font>"
      Else
         Response.Write " <a href='searchResult.asp?gotopage=" & blockpage & _
                                "&column=" & column & "&searchString=" & searchString & "'>" & blockpage & "</a> "
      End If

      blockpage=blockpage+1
      i = i + 1
   Loop

   '다음 10 개 구문 시작
   if blockpage > Pagecount Then
      Response.Write "] <font color=silver>[다음 10개]</font>"
   Else
      Response.write "] <a href='searchResult.asp?gotopage=" & blockpage & _
                             "&column=" & column & "&searchString=" & searchString & "'>[다음 10개]</a>"
   End If
   '다음 10 개 구문 끝
End Sub

%>