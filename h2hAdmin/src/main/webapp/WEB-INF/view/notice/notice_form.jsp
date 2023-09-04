<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/mainPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">공지사항 작성</h2>
    <form name="frm" action="noticeProcIn" method="post" enctype="multipart/form-data">
        <table class="table table-bordered table-striped">
            <tr>
                <th width="15%">작성자</th>
                <td width="35%"><input type="text" name="nl_writer" class="form-control" value="관리자" readonly="readonly"/></td>
            </tr>
            <tr>
                <th width="15%">글제목</th>
                <td colspan="3"><input type="text" name="nl_title" size="60" class="form-control" /></td>
                <td>
                    <p><input type="file" name="nl_file" multiple="multiple" class="form-control-file" /></p>
                </td>
            </tr>
            <tr>
                <th>글내용</th>
                <td colspan="4"><textarea name="nl_content" rows="10" cols="65" class="form-control"></textarea></td>
            </tr>
            <tr>
                <td colspan="5" align="center">
                    <input type="submit" value="글등록" class="btn btn-primary" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="reset" value="다시 입력" class="btn btn-secondary" />
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
