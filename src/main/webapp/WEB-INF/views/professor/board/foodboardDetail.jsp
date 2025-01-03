<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3661325bfb14f68f11305c66cfc65e52&libraries=services"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .container-xxl {
            padding: 20px;
        }

        .py-3 {
            padding-top: 1rem;
            padding-bottom: 1rem;
        }

        .mb-4 {
            margin-bottom: 1.5rem;
        }

        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            background-color: #fff;
        }

        .card-header {
            padding: 10px;
            font-weight: bold;
            border-bottom: 1px solid #ddd;
        }

        .card-body {
            padding: 20px;
        }

        .card-footer {
            padding: 10px;
            border-top: 1px solid #ddd;
            text-align: right;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .form-group p {
            margin-bottom: 0.5rem;
        }

        #map {
            width: 100%;
            height: 350px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -10px;
            margin-left: -10px;
        }

        .col-sm-6, .col-sm-10, .col-xl-12 {
            padding-right: 10px;
            padding-left: 10px;
        }

        .col-sm-6 {
            flex: 0 0 50%;
            max-width: 50%;
        }

        .col-sm-10 {
            flex: 0 0 83.333333%;
            max-width: 83.333333%;
        }

        .col-xl-12 {
            flex: 0 0 100%;
            max-width: 100%;
        }

        .text-right {
            text-align: right;
        }

        .float-left {
            float: left;
        }
    </style>
    <script>
        function initMap() {
            var mapX = "${foodboard.foodMapx}";
            var mapY = "${foodboard.foodMapy}";

            var mapContainer = document.getElementById('map'),
                mapOption = {
                    center: new kakao.maps.LatLng(mapY, mapX),
                    level: 3
                };

            var map = new kakao.maps.Map(mapContainer, mapOption);

            var markerPosition = new kakao.maps.LatLng(mapY, mapX);

            var marker = new kakao.maps.Marker({
                position: markerPosition
            });

            marker.setMap(map);

            kakao.maps.event.addListener(marker, 'click', function() {
                var geocoder = new kakao.maps.services.Geocoder();

                geocoder.coord2Address(markerPosition.getLng(), markerPosition.getLat(), function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        var address = result[0].address.address_name;
                        var infowindow = new kakao.maps.InfoWindow({
                            content: '<div style="padding:5px;">' + address + '</div>'
                        });
                        infowindow.open(map, marker);
                    }
                });
            });
        }

        $(document).ready(function() {
            initMap();
        });

        function deleteFoodPost(foodNo) {
            if (confirm('게시글을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/professor/foodBoardDelete/' + foodNo,
                    type: 'POST',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("meta[name='_csrf']").attr("content"));
                    },
                    success: function(response) {
                        if (response.status === "success") {
                            alert(response.message);
                            window.location.href = '${pageContext.request.contextPath}/professor/foodList';
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function(request, status, error) {
                        alert('게시글 삭제에 실패했습니다.');
                    }
                });
            }
        }

        function enableEditMode() {
            $('#foodTitleLabel').hide();
            $('#foodContentLabel').hide();
            $('#foodTitleInput').show();
            $('#foodContentInput').show();
            $('#editButton').hide();
            $('#saveButton').show();
        }

        function updateFoodPost() {
            var foodNo = $('#foodNo').val();
            var foodTitle = $('#foodTitleInput').val();
            var foodContent = $('#foodContentInput').val();
            
            let data = {
                 foodNo: foodNo,
                 foodTitle: foodTitle,
                 foodContent: foodContent
             };

            $.ajax({
                url:'${pageContext.request.contextPath}/professor/foodBoardUpdate',
                contentType:"application/json;charset=utf-8",
                type:'POST',
                data:JSON.stringify(data),
                beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
                success:function(response) {
                    if (response.status === "success") {
                        alert(response.message);
                        window.location.href = '${pageContext.request.contextPath}/professor/foodList';
                    } else {
                        alert(response.message);
                    }
                },
                error: function(request, status, error) {
                    alert('게시글 수정에 실패했습니다.');
                }
            });
        }
    </script>
</head>
<body>
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="py-3 mb-4" style="font-weight:bold;"></h4>
    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header">게시글 상세정보</h5>
                <hr class="my-0">
                <div class="card-body">
                    <input type="hidden" id="foodNo" value="${foodboard.foodNo}">
                    <div class="form-group">
                        <label for="foodTitle">제목</label>
                        <label id="foodTitleLabel">${foodboard.foodTitle}</label>
                        <input type="text" class="form-control" id="foodTitleInput" value="${foodboard.foodTitle}" style="display: none;">
                    </div>
                    <div class="form-group">
                        <label for="foodWriter">작성자</label>
                        <p>${foodboard.foodWriter}</p>
                    </div>
                    <div class="form-group">
                        <label for="foodContent">내용</label>
                        <label id="foodContentLabel">${foodboard.foodContent}</label>
                        <textarea class="form-control" id="foodContentInput" rows="5" style="display: none;">${foodboard.foodContent}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="foodDate">작성일</label>
                        <p>${foodboard.foodDate}</p>
                    </div>
<!--                     <div class="form-group"> -->
<!--                         <label for="foodMapx">X 좌표</label> -->
<%--                         <p>${foodboard.foodMapx}</p> --%>
<!--                     </div> -->
<!--                     <div class="form-group"> -->
<!--                         <label for="foodMapy">Y 좌표</label> -->
<%--                         <p>${foodboard.foodMapy}</p> --%>
<!--                     </div> -->
                    <div id="map"></div>
                </div>
                <div class="card-footer">
                    <a href="${pageContext.request.contextPath}/professor/foodList" class="btn btn-secondary float-left">목록으로</a>
                    <div class="text-right">
                        <button id="editButton" class="btn btn-primary" onclick="enableEditMode()">수정</button>
                        <button id="saveButton" class="btn btn-primary" style="display: none;" onclick="updateFoodPost()">저장</button>
                        <button class="btn btn-primary" onclick="deleteFoodPost('${foodboard.foodNo}')">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
