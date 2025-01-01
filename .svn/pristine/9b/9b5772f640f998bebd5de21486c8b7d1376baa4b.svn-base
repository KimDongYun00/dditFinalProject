<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>등록금 통계</title>
    <style>
        #statusChart, #typeChart {
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
                    <h5 class="card-header" style="text-align: left;">통계관리 > 등록금 납부 현황</h5>
                </div>
            </div>
        <div class="row">
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">등록금 납부 / 미납부 현황 통계</h5>
                          <hr class="my-0">
                    <div class="card-body">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">납부 방식 통계</h5>
                          <hr class="my-0">
                    <div class="card-body">
                        <canvas id="typeChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 처리 현황 통계 데이터
            var pay = ${pay};       // 납부
            var unPay = ${unPay};   // 미납부
            var fullPay = ${fullPay}; // 일시불
            var monthPay = ${monthPay}; // 할부

            // 처리 현황 도넛 차트 생성
            var ctx1 = document.getElementById('statusChart').getContext('2d');
            var statusChart = new Chart(ctx1, {
                type: 'doughnut',
                data: {
                    labels: ['납부', '미납부'],
                    datasets: [{
                        label: '신청 건수',
                        data: [pay, unPay],
                        backgroundColor: ['#f2da6f', '#E86F51']
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

            // 납부 방식 도넛 차트 생성
            var ctx2 = document.getElementById('typeChart').getContext('2d');
            var typeChart = new Chart(ctx2, {
                type: 'doughnut',
                data: {
                    labels: ['일시불', '할부'],
                    datasets: [{
                        label: '신청 건수',
                        data: [fullPay, monthPay],
                        backgroundColor: ['#688713', '#c9db86']
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
        });
    </script>
</body>
</html>
