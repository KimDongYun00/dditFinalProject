<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <div id="templateContent">
            <div class="transcript">
                <!-- 템플릿 내용 -->
                <div class="header">
                    <div class="logo">
                        <img alt="uni_icon.png" src="${pageContext.request.contextPath }/resources/img/uni_icon.png" />
                    </div>
                    <h1 id="title">성 적 증 명 서</h1>
                    <div class="timestamp">발급일자 : </div>
                </div>
                <br/>
                <table class="grades">
                    <tr>
                        <td>학과</td>
                        <td></td>
                        <td>학번</td>
                        <td></td>
                        <td>성명</td>
                        <td></td>
                        <td>생년월일</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>입학</td>
                        <td></td>
                        <td>졸업</td>
                        <td></td>
                        <td>졸업증서번호</td>
                        <td></td>
                        <td>학위등록번호</td>
                        <td></td>
                    </tr>
                </table>
                <br/><br/>
                <table class="grades">
                    <thead>
                        <tr>
                            <th width="350px">구분</th>
                            <th width="350px">교과목명</th>
                            <th width="150px">성적</th>
                            <th width="150px">학점</th>
                        </tr>
                    <thead>
                    <tbody>
                        <!-- 학기별 성적 -->
                        <tr>
                            <td colspan="4" align="center">************************************************************</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <br/><br/>
                <table class="grades">
                    <thead>
                        <tr>
                            <th>총신청학점</th>
                            <th>총취득학점</th>
                            <th>총평점</th>
                            <th>백분율</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <div class="footer_context">
                    <p>본 증명서는 대덕대학교에서 공식적으로 발급한 문서입니다.</p>
                </div>
                <br/><br/>
                <div id="footer">
                    <p>성적원부와 상위 없음을 증명합니다.</p>
                    <p class="footer_date"></p>
                    <h1>대 덕 대 학 교 총 장</h1>
                </div>
            </div>
        </div>
    </div>
    <script>
        $("#btn_pdf").on("click", function() {
            html2canvas($('.transcript')[0]).then(function(canvas) {
                var imgData = canvas.toDataURL('image/png');
                var doc = new jsPDF('p', 'mm', 'a4');
                doc.addImage(imgData, 'PNG', 10, 10, 190, 277);
                var pdfData = doc.output('blob');

                var formData = new FormData();
                formData.append("templateName", "성적 증명서");
                formData.append("templateFile", pdfData, "template.pdf");

                $.ajax({
                    url: '/admin/gradeCertification',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        alert('템플릿이 성공적으로 업로드되었습니다.');
                    },
                    error: function(error) {
                        alert('템플릿 업로드 중 오류가 발생했습니다.');
                    }
                });
            });
        });
    </script>
</body>
</html>
