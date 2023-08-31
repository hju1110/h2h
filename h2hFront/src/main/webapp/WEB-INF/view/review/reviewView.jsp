<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_inc/inc_head.jsp" %>
<style>
.line {
        text-align: center;
        }
h2 { text-align: center; }
#sform {
          text-align: center;
        }

</style>
<script>
function confirmDelete(rlIdx) {
    if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
        // 확인을 눌렀을 때
        location.href = "reviewdeleteform?rlidx=" + rlIdx;
    }
}
</script>
<div class="container mt-5"align="center" style="padding:100px;">
<h2 text-align:center>후기게시판</h2>
<table class="table table-bordered" width="1000" cellpadding="5" style="text-align:center" >
    <tr>
        <th width="10%">작성자</th><td width="15%">${rl.getRl_writer()}</td>
        <th width="10%">조회수</th><td width="15%">${rl.getRl_read()}</td>
        <th width="10%">작성일</th><td width="15%">${rl.getRl_date()}</td>
    </tr>
    <tr><th>글제목</th><td colspan="5">${rl.getRl_title()}</td></tr>
    <tr><th>글내용</th><td colspan="5">${rl.getRl_content()}</td></tr>
    <tr>
        <td colspan="6" class="center">
            <img src="resources/img/${rl.getRl_name()}" width="300" />
        </td>
    </tr>
    <tr>
       <td colspan="6" class="center">
       </div>
  

           <input type="button" value="글목록" onclick="location.href='reviewList';" />
         <c:if test="${loginInfo.getMi_name() eq rl.getRl_writer()}" >
             <input type="button" value="글삭제" onclick="confirmDelete(${rl.getRl_idx()});" />
             <input type="button" value="글수정" onclick="location.href='reviewFormUp?rl_idx=${rl.getRl_idx()}';" />
         </c:if>         
           <!-- 이미지 다운로드 버튼 -->
           <a href="downloadImage?filename=${rl.getRl_name()}" download>
               <input type="button" value="다운로드" />
           </a>
       </td>
    </tr>
</table>

<c:if test="${empty reviewReply}">
    등록된 댓글이 없습니다.
</c:if>

<hr>
<div id="sform">
<form action="addReviewReply" method="post" class="comment-form">
   <input type="hidden" name="rl_idx" value="${rl.getRl_idx()}" />
   작성자: <input type="text" name="rr_writer" value="<%=loginInfo.getMi_name() %>" readonly /><br>
   <textarea rows="5" cols="40" name="rr_content"></textarea><br>
   <!-- 댓글 작성일은 자동으로 서버에서 처리하므로 input 요소에서는 입력하지 않습니다. -->
   <input type="submit" value="댓글 등록" />
<hr>
<c:if test="${not empty reviewReply}">
    <ul class="comment-list">
        <c:forEach var="reply" items="${reviewReply}">
            <li>
                <span class="writer">작성자: ${reply.rr_writer}</span><br>
                <span class="content">내용: ${reply.rr_content}</span><br>
                <span class="date">작성일: ${reply.rr_date}</span>
            </li>
        </c:forEach>
    </ul>
</c:if>
</div>
</div>
</section>
<%@ include file="../_inc/inc_foot.jsp" %>