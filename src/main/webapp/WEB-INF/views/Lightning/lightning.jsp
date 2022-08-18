<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <title>JMT 번개모임 리스트 페이지 </title>
		<link rel="shortcut icon" type="image/x-icon" href="../resources/mainResource/assets/img/pizza-slice.png">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
		 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
		<!-- 페이징 -->
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	
		<!--   Core JS Files   -->
    	<script src="../resources/etcResource/assets/js/jquery.3.2.1.min.js" type="text/javascript"></script>
		<script src="../resources/etcResource/assets/js/bootstrap.min.js" type="text/javascript"></script>

		<!--  Charts Plugin -->
		<script src="../resources/etcResource/assets/js/chartist.min.js"></script>

    	<!--  Notifications Plugin  : 없어도 되네  
    	<script src="../resources/etcResource/assets/js/bootstrap-notify.js"></script>
  -		-->
  
    	<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
		<script src="../resources/etcResource/assets/js/light-bootstrap-dashboard.js?v=1.4.0"></script>
	

			<!-- CSS here 이게 없으면 알림 이모티콘이 안 보임 -->
            <link rel="stylesheet" href="../resources/mainResource/assets/css/bootstrap.min.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/owl.carousel.min.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/slicknav.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/flaticon.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/price_rangs.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/animate.min.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/magnific-popup.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/fontawesome-all.min.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/themify-icons.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/slick.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/nice-select.css">
            <link rel="stylesheet" href="../resources/mainResource/assets/css/style.css">

      
            <!--알림 css-->
            <link href="../resources/etcResource/assets/css/bootstrap.min.css" rel="stylesheet" />
   </head>
   <!-- 
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>

<link rel="stylesheet" href="resources/css/common.css" type="text/css">

	<jsp:include page="../commons/header.jsp"/>
    -->


<style>
	#lightningList {
		border : 1px solid black;
		border-collapse : collapse;
		width : 600px;
	}

	#lightningList > th,td { 
		border : 1px solid black;
		border-collapse : collapse;
		width : 600px;
		padding : 5px 10px;
	}
	

	#searchBar{
		float : left;
		height : 200px;
	}
	
	.dropdown-menu{
		overflow : auto;
	}
	
	.notiDelBtn:hover{
		cursor : pointer;
		color : red;
	}
	
</style>
</head>
<body>
	<jsp:include page="../commons/header.jsp"/>

	<div id="searchBar">
		<button onclick="lightCreateChk()">번개 생성하기</button>
		<br/>
		<input type="text" id="lightning_title" placeholder="모임 이름을 입력해주세요"
		 onKeypress="javascript:if(event.keyCode==13) {enterkey()}"/>
		<button id="search">검색</button><br/>
		
		<select id="food_no">
			<option value="">음식카테고리</option>
				<c:forEach items="${foodList}" var="foodList">
					<option value="${foodList.food_no}">${foodList.food_name}</option>
				</c:forEach>
		</select>
		<br/>
		<select id="eat_speed">
			<option value="">식사속도</option>
			<option value="느림">느림</option>
			<option value="보통">보통</option>
			<option value="빠름">빠름</option>
			<option value="상관없음">상관없음</option>
		</select>
		<br/>
		<select id="job">
			<option value="">직업</option>
			<option value="직장인">직장인</option>
			<option value="취준생">취준생</option>
			<option value="학생">학생</option>
			<option value="상관없음">상관없음</option>
		</select>
		<br/>
		<input type="radio" name ="gender" id="gender" value="남자"/>남자
		<input type="radio" name ="gender" id="gender" value="여자"/>여자
		<input type="radio" name ="gender" id="gender" value="상관없음"/>상관없음
	</div>
	
	<table>
		<thead id="lightningList">
			<tr>
				<th>맛집 이름</th>
				<th>음식 카테고리</th>
				<th>방장 ID</th>
				<th>모임 이름</th>
				<th>모임 날짜</th>
				<th>인원</th>
				<th>상태</th>
				<th>참여여부</th>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
			<tr>
				<td colspan="8" id="paging">
					<!-- plugin 사용법  -->
					<div class="container">
						<nav arial-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination"></ul>
						</nav>
					</div>
				</td>
			</tr>
	</table>

<%@ include file="../../../resources/inc/footer.jsp" %>		
<script>
	var loginId = "${loginId}";
	var currpage = 1;
	listCall(currpage);

	//검색버튼 클릭시
	$("#search").on("click",function(){
		if($("#lightning_title").val() != ""){ //유효성검사
			// 검색 시 기존 옵션 값 날리기위해
			$("#food_no").val("");
			$("#eat_speed").val("");
			$("#job").val("");
			$("#gender:checked").prop("checked",false);
			
			$("#pagination").twbsPagination('destroy');
			listCall(currpage);
		} else {
		 	alert("검색어를 입력해주세요.");
		}
	});
	
	//검색값 입력 후 enter누를 시 
	function enterkey(){
		if($("#lightning_title").val() != ""){
			// 검색 시 기존 옵션 값 날리기위해
			$("#food_no").val("");
			$("#eat_speed").val("");
			$("#job").val("");
			$("#gender:checked").prop("checked",false);
			
			$("#pagination").twbsPagination('destroy');
			listCall(currpage);
		} else {
		 	alert("검색어를 입력해주세요.");
		}
	}

	//셀렉트박스 값이 변경될 때 
	$("select").on("change", function(){ 
		$("#pagination").twbsPagination('destroy');
		listCall(currpage);
	});

	//radio 값이 변경될 때
	$("input[name='gender']:radio").on("change",function(){
		$("#pagination").twbsPagination('destroy');
		listCall(currpage);
	});


	function listCall(page){
		
		var lightning_title = $("#lightning_title").val();
		var food_no = $("#food_no").val();
		var eat_speed = $("#eat_speed").val();
		var job = $("#job").val();
		var gender = $("#gender:checked").val(); // ->아무것도 체크안됐을때 undefined /다른건 공백
		
		/*
		console.log(food_no);
		console.log(eat_speed);
		console.log(job);
		console.log(gender);
		*/
		
		$.ajax({
			type: 'get',
			url : 'lightList.ajax',
			data : {
				'lightning_title' : lightning_title,
				'food_no' : food_no,
				'eat_speed' : eat_speed,
				'job' : job,
				'gender' : gender,
				'page' : page
			},
			dataType : 'json',
			success : function(data){
				//console.log(data);
				drawList(data.list);
				//console.log(data.pages);
				
				
				currPage = data.currPage;
				//리스트불러오기가 성공되며 플러그인을 이용해 페이징 처리 //{} 옵션 추가
				if(data.list.length>0){
					 $("#pagination").twbsPagination({
						 startPage:1, //시작페이지
						 totalPages : data.pages, //총페이지(전체 게시물 수/한 페이지에 보여줄 게시물 수) 300게시물/10개씩 보여줄거야 - 30 페이지 
						visiblePages : 5, //한번에 보여줄 페이지 수 [1][2][3][4][5]
						 onPageClick:function(e,page){
							 //console.log(e); //클릭한 페이지와 관련된 이벤트 객체
							 //console.log(page); //사용자가 클릭한 페이지 
							 currPage = page;
							 listCall(page);
						 }
					 });
				}else{ //데이터 없을 때 페이징 어떻게 보여질건지 
					$("#pagination").twbsPagination({
						 startPage:1,
						 totalPages : 1, 
						visiblePages : 1
					 });
				}
			},
			error : function(e){
				console.log(e);
			}
			
		});
	}

	
		
	function drawList(list){
		//console.log(list);
		var content ='';
		//데이터가 있는 경우
		if(list.length>0){					
			list.forEach(function(item,idx){
				//console.log(item);
				var date = new Date(item.lightning_date);

				content += '<tr>';
				content += '<td>'+item.restaurant_name+'</td>';
				content += '<td>'+item.food_name+'</td>';
				content += '<td>'+item.leader_id+'</td>';
				content += item.lightning_status == "모집중"? '<td><a href="lightDetail.go?lightning_no='+item.lightning_no+'">'+item.lightning_title+'</a></td>' : '<td>'+item.lightning_title+'</td>';
				content += '<td>'+date.toLocaleDateString("ko-KR")+'</td>';
				content += '<td>'+item.member_count +' / '+ item.member_num+'</td>';
				content += '<td>'+item.lightning_status+'</td>';
				content += item.participate=="승인"? '<td>참여</td>' : item.leader_id == loginId? '<td>참여</td>' :  '<td>미참여</td>'; 
				content += '</tr>';
			});
		//데이터가 없을 경우	
		}else{
			content += '<tr>';
			content += '<td colspan="8" style="text-align: center">찾으시는 데이터가 없습니다.</td>';
			content += '</tr>';
		}
		
		$('#list').empty();
		$('#list').append(content); 
	}
	
	//번개모임 생성시 유효성 체크 
	var profileChk = ${profileChk};
	function lightCreateChk(){
		if(profileChk){
			//console.log(profileChk);
			location.href='/lightCreate.go';
		}else{
			console.log(profileChk);
			alert("프로필 생성 후 이용 가능합니다.");
		}
	}

</script>
 <!--   Core JS Files   -->
    <script src="../resources/etcResource/assets/js/jquery.3.2.1.min.js" type="text/javascript"></script>
	<script src="../resources/etcResource/assets/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Charts Plugin -->
	<script src="../resources/etcResource/assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="../resources/etcResource/assets/js/bootstrap-notify.js"></script>

    <!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<script src="../resources/etcResource/assets/js/light-bootstrap-dashboard.js?v=1.4.0"></script>
	
	<!--  페이징  -->
  	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
	<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>

</html>