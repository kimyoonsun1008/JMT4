<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방장 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	table,th,td {
		border:1px solid black;
		border-collapse:collapse;
	}
	th,td {
		padding:5px 10px;
	}
	/* .groupIndex {
		border: 1px solid pink; padding:10px;
	} */
</style>
</head>
<body>
	<h3>방장 페이지</h3>
		<table style="padding:10px;">
			<caption>모임이름</caption>
			<tr>
				<th>방장</th>
				<td></td>
				<th>모집상태</th>
				<td></td>
			</tr>
			<tr>
				<th>정원</th>
				<td> / </td>
				<th>성별</th>
				<td></td>
			</tr>
			<tr>
				<th>음식 카테고리</th>
				<td></td>
				<th>식사속도</th>
				<td></td>
			</tr>
			<tr>
				<th>개설일</th>
				<td></td>
				<th>직업</th>
				<td></td>
			</tr>
			<tr>
				<th colspan="4">
					<input type="button" value="수정" onclick="leaderGroupEdit()"/>
					<input type="button" value="삭제" onclick=""/>
				</th>
			</tr>
		</table><br/>
	
	<h4><a href="#">나의 모임 관리</a></h4>
	
	<div style="float:left; border: 1px solid pink; magin-right:30px;">
		<h3>최근 게시글</h3>
		<ul>
			<li></li>
		</ul>
	</div>
	
	<div style="float:left; border: 1px solid pink; margin-left:30px;">
		<h3>가입 대기 회원</h3>
		<input type="button" value="회원보기" onclick=""/>
		<ul>
			<li></li>
		</ul>
	</div>
</body>
<script>
</script>
</html>