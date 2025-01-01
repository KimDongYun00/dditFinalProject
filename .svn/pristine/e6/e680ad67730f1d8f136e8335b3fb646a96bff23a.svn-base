<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>증명서 발급 현황</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        #statusChart, #deptChart {
            width: 400px;
            height: 600px;
            margin: 0 auto;
        }
        .chartCard {
            height: 600px;
        }
    </style>
</head>
<body>
    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="col-xl-12">
            <div class="card mb-4 bg-white">
                <h5 class="card-header" style="text-align: left;">통계관리 > 증명서 발급 현황</h5>
            </div>
        </div>
        <div class="row">
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">발급 현황 통계</h5>
                    <hr class="my-0">
                    <div class="card-body">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">학과별 발급 현황 통계</h5>
                    <hr class="my-0">
                    <div class="card-body">
                        <canvas id="deptChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 처리 현황 통계 데이터
            var enrollmentCount = ${enrollmentCount};        
            var gradeCount = ${gradeCount};    
            var graduationCount = ${graduationCount};      

            var ad = ${ad};      
            var ee = ${ee};      
            var phil = ${phil};      
            var it = ${it};      
            var chem = ${chem};      
            var cs = ${cs};      
            var kor = ${kor};      
            var astro = ${astro};      
            var design = ${design};      

            // 처리 현황 도넛 차트 생성
            var ctx1 = document.getElementById('statusChart').getContext('2d');
            var statusChart = new Chart(ctx1, {
                type: 'doughnut',
                data: {
                    labels: ['재학증명서', '성적증명서', '졸업증명서'],
                    datasets: [{
                        label: '처리 현황 건수',
                        data: [enrollmentCount, gradeCount, graduationCount],
                        backgroundColor: ['#b5db69', '#85bcde', '#084d78']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                font: {
                                    size: 16
                                }
                            }
                        }
                    }
                }
            });

            // 학과별 발급 현황 도넛 차트 생성
            var ctx2 = document.getElementById('deptChart').getContext('2d');
            var deptChart = new Chart(ctx2, {
                type: 'doughnut',
                data: {
                    labels: ['광고홍보학과', '전자공학과', '철학과', '정보통신학과', '화학과', '컴퓨터공학과', '국어국문학과', '천문학과', '시각디자인학과'],
                    datasets: [{
                        label: '처리 현황 건수',
                        data: [ad, ee, phil, it, chem, cs, kor, astro, design],
                        backgroundColor: ['#d9402b', '#f5a34c', '#fae996', '#c4f58c', '#3d823d', '#9fe7fc', '#388cd1', '#383b8a', '#864e9c']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                font: {
                                    size: 16
                                }
                            }
                        }
                    }
                }
            });

            // 차트 클릭 이벤트
            function handleChartClick() {
               location.href = '/admin/certificationList'; 
            }

            ctx1.canvas.onclick = handleChartClick;
            ctx2.canvas.onclick = handleChartClick;
        });
    </script>
</body>
</html>
