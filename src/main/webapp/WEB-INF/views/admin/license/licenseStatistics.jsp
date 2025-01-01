<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    
    
    <div class="container-xxl flex-grow-1 container-p-y">
        	 <div class="col-xl-12">
                <div class="card mb-4 bg-white">
                    <h5 class="card-header" style="text-align: left;">통계관리 > 자격증 신청 현황</h5>
                </div>
            </div>
        <div class="row">
       		 <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">자격증 신청 처리 현황 통계</h5>
                 <hr class="my-0">
                    <div class="card-body">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">자격증별 신청 현황 통계</h5>
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
        document.addEventListener('DOMContentLoaded', function () {
            var approvedCount = ${approvedCount};        // 승인
            var unApprovedCount = ${unApprovedCount};    // 미승인
            var rejectedCount = ${rejectedCount};        // 반려

            var toeicCount = ${toeicCount};      
            var tofelCount = ${tofelCount};      
            var hskCount = ${hskCount};      
            var jlptCount = ${jlptCount};

            // 신청 자격증 종류 비율 조회 도넛 차트 생성
            var ctx1 = document.getElementById('typeChart').getContext('2d');
            var typeChart = new Chart(ctx1, {
                type: 'doughnut',
                data: {
                    labels: ['TOEIC', 'TOFEL', 'HSK', 'JLPT'],
                    datasets: [{
                        label: '신청 건수',
                        data: [toeicCount, tofelCount, hskCount, jlptCount],
                        backgroundColor: ['#084d78', '#b5db69', '#fbfc8d', '#cc4910']
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
                    },
                    onClick: function(event, elements) {
                        if (elements.length > 0) {
                            var index = elements[0].index;
                            var type = ['TOEIC', 'TOFEL', 'HSK', 'JLPT'][index];
                            var url;
                            
                            switch(type) {
                                case 'TOEIC':
                                    url = '/admin/licenseList?_csrf=a9df6c90-9705-40f4-ad81-f8677ef2c394&page=1&searchType=TOEIC&searchDept=99&searchStatus=99&searchStuId=&searchStuName=';
                                    break;
                                case 'TOFEL':
                                    url = '/admin/licenseList?_csrf=a9df6c90-9705-40f4-ad81-f8677ef2c394&page=1&searchType=TOFEL&searchDept=99&searchStatus=99&searchStuId=&searchStuName=';
                                    break;
                                case 'HSK':
                                    url = '/admin/licenseList?_csrf=a9df6c90-9705-40f4-ad81-f8677ef2c394&page=1&searchType=HSK&searchDept=99&searchStatus=99&searchStuId=&searchStuName=';
                                    break;
                                case 'JLPT':
                                    url = '/admin/licenseList?_csrf=a9df6c90-9705-40f4-ad81-f8677ef2c394&page=1&searchType=JLPT&searchDept=99&searchStatus=99&searchStuId=&searchStuName=';
                                    break;
                            }
                            
                            window.location.href = url;
                        }
                    }
                }
            });

            // 처리 현황 도넛 차트 생성
            var ctx2 = document.getElementById('statusChart').getContext('2d');
            var statusChart = new Chart(ctx2, {
                type: 'doughnut',
                data: {
                    labels: ['승인완료', '반려', '미승인'],
                    datasets: [{
                        label: '처리 현황 건수',
                        data: [approvedCount, rejectedCount, unApprovedCount],
                        backgroundColor: ['#f2da6f', '#fa9748', '#E86F51']
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
                    },
                    onClick: function(event, elements) {
                        if (elements.length > 0) {
                            var index = elements[0].index;
                            var status = ['미승인', '반려', '승인완료'][index];
                            var url;
                            
                            switch(status) {
                                case '미승인':
                                    url = '/admin/licenseList?_csrf=a9df6c90-9705-40f4-ad81-f8677ef2c394&page=1&searchType=99&searchDept=99&searchStatus=2&searchStuId=&searchStuName=';
                                    break;
                                case '반려':
                                    url = '/admin/licenseList?_csrf=a9df6c90-9705-40f4-ad81-f8677ef2c394&page=1&searchType=99&searchDept=99&searchStatus=3&searchStuId=&searchStuName=';
                                    break;
                                case '승인완료':
                                    url = '/admin/licenseList?_csrf=55dfc625-c017-446e-9726-c913bed5c9dd&page=1&searchType=99&searchDept=99&searchStatus=1&searchStuId=&searchStuName=';
                                    break;
                            }
                            
                            window.location.href = url;
                        }
                    }
                }
            });
        });
    </script>
