<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>졸업 증명서</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .preview-container {
            text-align: center;
            padding-right: 20px;
        }
        .preview {
            border: 1px solid #ddd;
            padding: 10px;
            background-color: white;
            transform: scale(1.0);
            transform-origin: top left;
            margin-bottom: 20px;
        }
        .actions-container {
            text-align: center;
            width: 100%;
        }
        .certificate-container {
            width: 210mm;
            height: 297mm;
            background-color: white;
            position: relative;
            border: 3px solid #193C77;
            padding: 20px;
            box-sizing: border-box;
        }
        .certificate {
            width: 100%;
            height: 100%;
            padding: 20px;
            background-color: white;
            font-family: 'Times New Roman', serif;
            line-height: 1.6;
            position: relative;
            box-sizing: border-box;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 3em;
            margin: 0;
            font-weight: bold;
        }
        .body {
            margin-top: 20px;
        }
        .field {
            margin-bottom: 20px;
        }
        .field-label {
            display: inline-block;
            width: 150px;
            font-weight: bold;
            font-size: 1.2em;
        }
        .field-value {
            display: inline-block;
            width: calc(100% - 160px);
            font-size: 1.2em;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2em;
        }
        .timestamp {
            font-size: 1.2em;
            color: #888;
            text-align: right;
            margin-top: 20px;
        }
        .seal-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }
        .seal {
            margin-left: 20px;
        }
        .seal img {
            width: 100px;
            height: 100px;
        }
        .logo-container {
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .logo-container img {
            width: 400px;
            height: 400px;
        }
        button {
            padding: 10px 20px;
            font-size: 1.2em;
            cursor: pointer;
            background-color: #193C77;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
<h1>미리보기</h1>
    <div class="preview-container">
        <div class="preview">
            <div class="certificate-container" id="previewContainer">
                <div class="certificate">
                    <div class="logo-container">
                        <img src="${pageContext.request.contextPath}/resources/images/대덕대학교_증명서용로고.png" alt="대덕대학교 로고" 
                        style="width:300px; height:300px;">
                    </div>
                    <p style="text-align: left;">발급 번호 : 제 <span id="certificateNumber"></span> 호</p> <br><br><br>

                    <div class="header">
                        <h1>졸   업   증   명   서</h1>
                    </div>
                    <br>
                    <div class="body">
                        <div class="field">
                            <span class="field-label">성명</span>
                            <span class="field-value">${student.stuName}</span>
                        </div>
                        <div class="field">
                            <span class="field-label">생년월일</span>
                            <span class="field-value">${student.stuRegno}</span>
                        </div>
                        <div class="field">
                            <span class="field-label">학번</span>
                            <span class="field-value">${student.stuNo}</span>
                        </div>
                        <div class="field">
                            <span class="field-label">전공</span>
                            <span class="field-value">${student.deptName}</span>
                        </div>
                        <div class="field">
                            <span class="field-label">졸업일</span>
                            <span class="field-value">2025년 2월 3일</span>
                        </div>
                         <div class="timestamp"><br><br><br><br>
                            발급일자: <span id="currentDate"></span>
                        </div>
                    </div>
                    <br><br><br>
                    <div class="footer">
                        <h5>대덕대학교 총장 송중호</h5>
                        <div class="seal-container">
                            <div class="seal">
                                <img src="${pageContext.request.contextPath}/resources/images/대덕대학교직인.png" alt="학교 직인">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-container">
            <button id="generatePdf">결제하기</button>
            <button id="listBtn">목록으로 돌아가기</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
    	
    	// 목록으로 돌아가기
    	$("#listBtn").on("click", function(){
			location.href="/student/certificationList";    		
    	});
    	
    	
        // 오늘 날짜를 '년 월 일' 형식으로 반환하는 함수
        function getToday() {
            var date = new Date();
            return date.getFullYear() + "년 " + (date.getMonth() + 1) + "월 " + date.getDate() + "일";
        }

        // 랜덤 발급 번호를 생성하는 함수
        function getRandomCertificateNumber() {
            const parts = [];
            for (let i = 0; i < 3; i++) {
                // 0부터 999999 사이의 랜덤 숫자를 생성하고, 4자리로 맞춤
                parts.push(Math.floor(Math.random() * 1000000).toString().padStart(4, '0'));
            }
            // 각 부분을 '-'로 연결하여 반환
            return parts.join('-');
        }

        // HTML 요소에 오늘 날짜와 랜덤 발급 번호 설정
        $('#currentDate').text(getToday());
        $('#certificateNumber').text(getRandomCertificateNumber());

        // PDF 생성 버튼 클릭 이벤트 핸들러
        $('#generatePdf').on('click', function() {
            // 결제 로직 추가
            IMP.init("imp50368470");

            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: "merchant_" + new Date().getTime(),
                name: "${param.cerName}",
                amount: "100", // 원래는 ${param.cerCharge}가 들어와야하지만 테스트를 위해 100원으로 설정
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
                            html2canvas(document.querySelector('#previewContainer'), {
                                scale: 2 // 해상도를 2배로 설정
                            }).then(function(canvas) {
                                var imgData = canvas.toDataURL('image/png');
                                var imgWidth = 210; // A4 width in mm
                                var pageHeight = 297; // A4 height in mm
                                var imgHeight = canvas.height * imgWidth / canvas.width; // 이미지의 높이를 비율에 맞게 계산
                                var { jsPDF } = window.jspdf; // jsPDF를 jspdf 객체에서 가져옴
                                var doc = new jsPDF('p', 'mm', 'a4'); // 새로운 jsPDF 문서 생성

                                // PDF에 이미지 추가
                                doc.addImage(imgData, 'PNG', 0, 0, imgWidth, imgHeight);
                                
                                // PDF를 Blob 형식으로 출력
                                var pdfBlob = doc.output('blob');

                                // Blob URL 생성
                                var pdfUrl = URL.createObjectURL(pdfBlob);

                                // 새 창에서 PDF 보기
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
</body>
</html>
