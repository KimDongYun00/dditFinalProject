<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>처리 현황 통계</title>
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
                    <h5 class="card-header" style="text-align: left;">통계관리 > 장학금 신청 현황</h5>
                </div>
            </div>
        <div class="row">
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">
                    <h5 class="card-header">처리 현황 통계</h5>
                      <hr class="my-0">
                    <div class="card-body">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-xl-6">
                <div class="card mb-4 bg-white chartCard">     
                    <h5 class="card-header">신청 장학금 비율 통계</h5>
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
        $(document).ready(function() {
            // 처리 현황 통계 데이터
            var approvedCount = ${approvedCount};        // 승인
            var unApprovedCount = ${unApprovedCount};    // 미승인
            var rejectedCount = ${rejectedCount};        // 반려

            // 처리 현황 도넛 차트 생성
            var ctx1 = $('#statusChart');
            var statusChart = new Chart(ctx1, {
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
                            var elementIndex = elements[0].index;
                            var label = this.data.labels[elementIndex];
                            var urls = {
                                '미승인': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=99&searchDept=99&searchStatus=2&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '반려': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=99&searchDept=99&searchStatus=3&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '승인완료': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=99&searchDept=99&searchStatus=1&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47'
                            };
                            var url = urls[label];
                            if (url) {
                                window.location.href = url;
                            }
                        }
                    }
                }
            });

            // 장학금 신청 종류 통계 데이터
            var gradeCount = ${gradeCount};             // 성적 장학금
            var workCount = ${workCount};               // 근로 장학금
            var volunteerCount = ${volunteerCount};     // 봉사 장학금
            var achievementCount = ${achievementCount}; // 성취 장학금
            var topCount = ${topCount};                 // 수석 장학금
            var welfareCount = ${welfareCount};         // 복지 장학금

            // 장학금 신청 종류 도넛 차트 생성
            var ctx2 = $('#typeChart');
            var typeChart = new Chart(ctx2, {
                type: 'doughnut',
                data: {
                    labels: ['성적 장학금', '수석 장학금', '봉사 장학금', '근로 장학금', '성취 장학금', '복지 장학금'],
                    datasets: [{
                        label: '신청 건수',
                        data: [gradeCount, topCount, volunteerCount, workCount, achievementCount, welfareCount],
                        backgroundColor: ['#084d78', '#85bcde', '#b5db69', '#fbfc8d', '#ed9c2b', '#cc4910']
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
                            var elementIndex = elements[0].index;
                            var label = this.data.labels[elementIndex];
                            var urls = {
                                '성적 장학금': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=%EC%84%B1%EC%A0%81+%EC%9E%A5%ED%95%99%EA%B8%88&searchDept=99&searchStatus=99&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '수석 장학금': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=수석+장학금&searchDept=99&searchStatus=99&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '봉사 장학금': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=봉사+장학금&searchDept=99&searchStatus=99&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '근로 장학금': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=근로+장학금&searchDept=99&searchStatus=99&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '성취 장학금': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=성취+장학금&searchDept=99&searchStatus=99&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47',
                                '복지 장학금': '/admin/scholarshipRequestList?page=1&searchType=99&searchName=복지+장학금&searchDept=99&searchStatus=99&searchStuId=&searchStuName=&_csrf=0cb928e5-9460-462c-ad2e-364873d57e47'
                            };
                            var url = urls[label];
                            if (url) {
                                window.location.href = url;
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
