<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.preview-title {
    text-align: center;
    font-size: 24px;
    margin-top: 20px;
    margin-bottom: 20px;
}

.outer-container {
    padding: 3.5mm; /* 패딩 조정 */
    background-color: white; /* 배경 색상: 흰색 */
    margin: 0 auto; /* 자동 여백을 통해 가운데 정렬 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 박스 그림자 설정 */
    box-sizing: border-box; /* 박스 크기 설정 (패딩과 테두리를 포함) */
    position: relative; /* 상대 위치 지정 */
    width: 297mm; /* A4 용지 가로 크기 */
    height: 210mm; /* A4 용지 세로 크기 */
}

.container {
    width: 100%;
    height: 100%;
    padding: 7mm;
    background-color: white;
    box-sizing: border-box;
    position: relative;
    border: 4px solid #193C77;
    font-family: 'Times New Roman', serif;
}

.header, .footer {
    text-align: center;
    margin-bottom: 10px;
}

.header h1 {
    font-size: 20px;
    margin-bottom: 5px;
    font-family: 'Times New Roman', serif;
    line-height: 1.6;
    position: relative;
    box-sizing: border-box; /* 패딩 포함한 크기 조정 */
}

.info, .grades {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 5px;
}

.info th, .info td, .grades th, .grades td {
    border: 1px solid #000;
    padding: 2px;
    font-size: 8px;
    box-sizing: border-box;
}

.grades th {
    text-align: center;
}

.grades td {
    text-align: left;
}

.semester-title {
    font-weight: bold;
    margin-top: 10px;
    font-size: 8px;
    text-align: left;
}

.logo-container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.logo-container img {
    width: 190px;
    height: 190px;
}

.average {
    text-align: right;
    font-size: 8px;
}

.footer {
    text-align: center;
    font-size: 8px;
}

.semester-table {
    width: 33%;
    display: inline-block;
    vertical-align: top;
    margin-right: -4px; /* to remove the extra space between inline-block elements */
}

.seal-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 60px;
}

.seal-container h4 {
    font-size: 2.1rem;
    font-weight: 20%;
}

.seal {
    margin-left: 20px;
}

.seal img {
    width: 100px;
    height: 100px;
}

.actions-container {
    text-align: center;
    width: 100%;
    margin-top: 20px;
}

.actions-container button {
    padding: 10px 20px;
    font-size: 1.2em;
    cursor: pointer;
    background-color: #193C77;
    color: white;
    border: none;
    border-radius: 5px;
}

.header h1 {
    font-size: 3.0rem;
    font-weight: 100px;
}

</style>
<div class="preview-title" style="font-size: 2.5rem;">미리보기</div>
<div class="outer-container">
    <div class="container">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/resources/images/대덕대학교_증명서용로고.png" alt="Daeduck University Logo">
        </div>
          <p style="text-align: left;">발급 번호 : 제 <span id="certificateNumber"></span> 호</p>
        <div class="header">
            <h1>성 적 증 명 서</h1>
            <br>
            <table class="info">
                <tr>
                    <th>학과</th>
                    <td>${student.deptName}</td>
                    <th>학번</th>
                    <td>${student.stuNo}</td>
                    <th>성명</th>
                    <td>${student.stuName}</td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <c:if test="${student.comDetGNo eq 'G0101'}">남성</c:if>
                        <c:if test="${student.comDetGNo eq 'G0102'}">여성</c:if>
                    </td>
                    <th>주민등록번호</th>
                    <td>${student.stuRegno}</td>
                    <th>입학일자</th>
                    <td>${student.stuSdate}</td>
                </tr>
            </table>
        </div>
        <div>
            <c:forEach var="semester" items="${gradeListBySemester}" varStatus="status">
                <div class="semester-table">
                    <div class="semester-title">${semester.year}년도 ${semester.semester}학기</div>
                    <table class="grades">
                        <thead>
                            <tr>
                                <th>과목명</th>
                                <th>강의명</th>
                                <th>교수명</th>
                                <th>학점</th>
                                <th>성적</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="grade" items="${semester.grades}">
                                <tr>
                                    <td>${grade.subName}</td>
                                    <td>${grade.lecName}</td>
                                    <td>${grade.proName}</td>
                                    <td>${grade.lecScore}</td>
                                    <td>${grade.couScore}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5" style="text-align: right;">평균 학점: ${semester.averageScore}</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </c:forEach>
        </div>
          <p style="text-align: right;">발급일자: <span id="currentDate"></span><p>
        <div class="seal-container">
            <h4 style="font-family: 'Times New Roman', serif;">대 덕 대 학 교&nbsp;&nbsp;&nbsp;총 장 &nbsp;&nbsp;&nbsp;송 중 호</h4>
            <div class="seal">
                <img src="${pageContext.request.contextPath}/resources/images/대덕대학교직인.png" alt="학교 직인">
            </div>
        </div>
    </div>
</div>
<div class="actions-container">
    <button id="generatePdf" style="margin-bottom: 30px;" data-html2canvas-ignore="true">결제하기</button>
     <button id="listBtn">목록으로 돌아가기</button>
</div>

<script>
    $(document).ready(function() {
    	// 발급날짜를 위한 함수
        function getToday() {
            var date = new Date();
            return date.getFullYear() + "년 " + (date.getMonth() + 1) + "월 " + date.getDate() + "일";
        }

        // 오늘 날짜와 랜덤 발급 번호 설정
        $('#currentDate').text(getToday());
        $('#currentDateFooter').text(getToday());
        $('#certificateNumber').text(getRandomCertificateNumber());

    	// 목록으로 돌아가기
    	$("#listBtn").on("click", function(){
			location.href="/student/certificationList";    		
    	});
        
    	 // 랜덤 발급 번호 생성 함수
        function getRandomCertificateNumber() {
            const parts = [];
            for (let i = 0; i < 3; i++) {
                parts.push(Math.floor(Math.random() * 1000000).toString().padStart(4, '0'));
            }
            return parts.join('-');
        }
        
        $('#generatePdf').on('click', function() {
            // 결제 로직 추가
            IMP.init("imp50368470");

            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: "merchant_" + new Date().getTime(),
                name: "${param.cerName}",
                amount: "100",
                buyer_name: "${student.stuName}",
                buyer_tel: "010-0000-0000",
                buyer_addr: "구매자 주소",
                buyer_postcode: "우편번호"
            }, function(rsp) {
                if (rsp.success) {
                    Swal.fire({
                        title: '결제 성공',
                        text: '증명서 발급이 완료되었습니다.',
                        icon: 'success',
                        confirmButtonText: '확인'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // 결제가 완료되면 PDF 생성
                            html2canvas(document.querySelector('.container'), {
                                scale: 2
                            }).then(function(canvas) {
                                var imgData = canvas.toDataURL('image/png');
                                var imgWidth = 297;
                                var pageHeight = 210;
                                var imgHeight = canvas.height * imgWidth / canvas.width;
                                var { jsPDF } = window.jspdf;
                                var doc = new jsPDF('landscape', 'mm', 'a4');

                                doc.addImage(imgData, 'PNG', 0, 0, imgWidth, imgHeight);
                                var pdfBlob = doc.output('blob');
                                var pdfUrl = URL.createObjectURL(pdfBlob);
                                window.open(pdfUrl, '_blank');
                            });
                        }
                    });
                } else {
                    Swal.fire({
                        title: '결제 실패',
                        text: rsp.error_msg,
                        icon: 'error',
                        confirmButtonText: '확인'
                    });
                }
            });
        });
    });
</script>
