<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>상품수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }

        table {
            border-collapse: collapse;
            margin: 0 auto;
        }

        th, td {
            padding: 10px;
        }

        th {
            background-color: #efefef;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .form-group1 {
            margin-bottom: 20px;
        }

        .pimg, .pimg1 {
            width: 300px;
            height: 300px;
            border: 1px solid #c1c1c1;
            margin-bottom: 10px;
        }

        .pimg1 {
            width: 900px;
            height: 600px;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            height: 30px;
        }

        input[type="submit"], input[type="button"] {
            cursor: pointer;
            width: 100px;
            height: 30px;
            background-color: #efefef;
            border: 1px solid #c1c1c1;
        }

        .center {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="left">
    <form name="frmPd" action="productInfoUp" method="post" enctype="multipart/form-data">
        <h2 class="center">상품수정</h2>
        <table border="1">
            <tr>
                <td>상품 ID</td>
                <td><input type="text" name="pi_id" value="<%=pi.getPi_id() %>" readonly="readonly" /></td>
            </tr>
            <tr>
                <td>상품 분류</td>
                <td>
                    <select name="pcs_id" value="<%=pi.getPcs_id() %>">
                        <option value="AA01">악세사리</option>
                        <option value="AA02">의류</option>
                        <option value="AA03">잡화</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>상품명</td>
                <td><input type="text" name="pi_name" value="<%=pi.getPi_name() %>" /></td>
            </tr>
            <tr>
                <td>상품가격</td>
                <td><input type="text" name="pi_price" value="<%=pi.getPi_price() %>" /></td>
            </tr>
            <tr>
                <td>상품재고</td>
                <td><input type="number" min="0" max="100" name="pi_stock" value="<%=pi.getPi_stock() %>" />최대 100개 까지 가능합니다</td>
            </tr>
            <tr>
                <td>사이즈</td>
                <td>
                    <select>
                        <option value="f">f</option>
                    </select>
                </td>
            </tr>
        </table>

        <hr />

        <h2 class="center">대표이미지</h2>
        <p>업로드된 파일 : <%=pi.getPi_img1() %>, <%=pi.getPi_img2() %>, <%=pi.getPi_img3() %></p>
        <hr />
        <div class="form-group">
            <input class="form-control form-control-user" type="file" multiple="multiple" name="pi_img" id="product_detail_image" onchange="setDetailImage(event);">
        </div>
        <div id="images_container"></div>

        <hr />

        <h2 class="center">상품소개</h2>
        <p>업로드된 파일 : <%=pi.getPi_desc() %></p>
        <hr />
        <div class="form-group1">
            <input class="form-control form-control-user" type="file" multiple="multiple" name="pi_desc1" id="product_detail_image1" onchange="setDetailImage1(event);">
        </div>
        <div id="images_container1"></div>

        <hr />

        <div class="center">
            <input type="button" value="목록" onclick="history.back();">
            <input type="submit" value="상품수정">
        </div>
    </form>
</div>
    <script>
        function setDetailImage(event) {
            for (var image of event.target.files) {
                var reader = new FileReader();

                reader.onload = function (event) {
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("class", "pimg");
                    document.querySelector("div#images_container").appendChild(img);
                };

                console.log(image);
                reader.readAsDataURL(image);
                //reader.readAsDataURL(event.target.files[0]);

            }
        }

        function setDetailImage1(event) {
            for (var image of event.target.files) {
                var reader = new FileReader();

                reader.onload = function (event) {
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("class", "pimg1");
                    document.querySelector("div#images_container1").appendChild(img);
                };

                console.log(image);
                reader.readAsDataURL(image);
                //reader.readAsDataURL(event.target.files[0]);

            }
        }
    </script>
</body>
</html>