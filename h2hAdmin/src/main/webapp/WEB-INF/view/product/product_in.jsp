<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/sidebar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script>
function setDetailImage(event){
	for(var image of event.target.files){
		var reader = new FileReader();
	
		reader.onload = function(event){
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
function setDetailImage1(event){
	for(var image of event.target.files){
		var reader = new FileReader();
	
		reader.onload = function(event){
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
    <style>
        body {
            font-family: Arial, sans-serif;
            
        }

        h2 {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 700px;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        select, input[type="text"], input[type="number"] {
            width: 99%;
            padding: 4px;
        }

        .form-group {
            margin: 10px auto;
        }

        .form-group1 {
            margin: 10px auto;
        }

        .pimg, .pimg1 {
            width: 300px;
            border: 1px solid #ddd;
            height: 300px;
            margin: 10px auto;
        }

        .pimg1 {
            width: 900px;
            height: 600px;
        }

        div.align-center {
            text-align: center;
        }

        input[type="button"], input[type="submit"] {
            width: 150px;
            height: 40px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }
    </style>
<body>
<div class="left">
    <form name="frmPd"  action="productInfo" method="post" enctype="multipart/form-data">
        <h2>상품등록</h2>
        <table>
            <tr>
                <td>상품 ID</td>
                <td><input type="text" name="pi_id" value="" /></td>
            </tr>
            <tr>
                <td>상품 분류</td>
                <td>
                    <select name="pcs_id">
                        <option value="AA01">악세사리</option>
                        <option value="AA02">의류</option>
                        <option value="AA03">잡화</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>상품명</td>
                <td><input type="text" name="pi_name" value="" /></td>
            </tr>
            <tr>
                <td>상품가격</td>
                <td><input type="text" name="pi_price" value="" /></td>
            </tr>
            <tr>
                <td>상품재고</td>
                <td><input type="number" min="1" max="100" name="pi_stock" value="" />최대 100개 까지 가능합니다</td>
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
        <div class="form-group">
            <h2>대표이미지</h2>
            <input class="form-control form-control-user" type="file" multiple="multiple" name="pi_img" id="product_detail_image" onchange="setDetailImage(event);">
        </div>
        <div id="images_container" class="align-center"></div>
        <hr />
        <h2>상품소개</h2>
        <div class="form-group1">
            <input class="form-control form-control-user" type="file" multiple="multiple" name="pi_desc1" id="product_detail_image1" onchange="setDetailImage1(event);">
        </div>
        <div id="images_container1" class="align-center"></div>
        <hr />
        <div class="align-center">
            <input type="button" value="목록" onclick="location.href='productList';" >
        </div>
        <br />
        <div class="align-center">
            <input type="submit" value="상품등록">
        </div>
    </form>
    </div>
</body>
</html>