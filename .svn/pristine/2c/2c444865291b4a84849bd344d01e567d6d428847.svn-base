package kr.or.ddit.controller.student;

import java.security.Principal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.service.student.inter.IStuCertificationService;
import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.GradeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.SemesterVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/student")
public class StuCertificationController {

	@Inject
	private IStuCertificationService service;

	@Inject
	private IFileService fileService;

	// 증명서 종류 출력
	@RequestMapping(value = "/certificationList", method = RequestMethod.GET)
	public String certificationList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "99") String searchType, Model model) {
		log.info("증명서 종류 리스트 출력 메서드 ");

		PaginationInfoVO<CertificationVO> pagingVO = new PaginationInfoVO<CertificationVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		// pagingVO.setSearchWord("test"); // 검색 기능 추가시 바뀌어야할 부분

		// 총 게시글 수를 얻어온다.
		int totalRecord = service.selectCertificationCount(pagingVO);

		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<CertificationVO> dataList = service.selectCertificationList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for (CertificationVO d : dataList)
			log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)

		model.addAttribute("searchType", searchType);
		model.addAttribute("pagingVO", pagingVO);
		return "sum/student/certification/certificationList";
	}

	// 재학 증명서 미리보기
	@RequestMapping(value = "/enrollmentCertification", method = RequestMethod.GET)
	public String enrollmentCertification(Model model, Principal principal, @RequestParam("cerNo") String cerNo,
			@RequestParam("cerName") String cerName, @RequestParam("cerCharge") String cerCharge) {
		String stuNo = principal.getName(); // 로그인한 사용자 학번
		StudentVO student = service.enrollmentInfo(stuNo);
		CertificationPrintVO certificationPrint = new CertificationPrintVO();
		certificationPrint.setCerNo(cerNo);
		certificationPrint.setStuNo(stuNo);

		service.insertCertificationPrint(certificationPrint);
		
		model.addAttribute("student", student);
		model.addAttribute("cerNo", cerNo);
		model.addAttribute("cerName", cerName);
		model.addAttribute("cerCharge", cerCharge);

		return "sum/student/certification/enrollmentCertification";
	}

	// 성적 증명서 미리보기
	@RequestMapping(value = "/gradeCertification", method = RequestMethod.GET)
	public String gradeCertification(Model model, Principal principal, @RequestParam("cerNo") String cerNo, @RequestParam("cerName") String cerName, @RequestParam("cerCharge") String cerCharge) {
	    String stuNo = principal.getName(); // 로그인한 사용자 학번
	    List<GradeVO> gradeList = service.gradeInfo(stuNo);
	    StudentVO student = service.enrollmentInfo(stuNo);

	    // 학기별로 데이터를 그룹화
	    Map<String, List<GradeVO>> semesterMap = new LinkedHashMap<>();
	    for (GradeVO grade : gradeList) {
	        String semesterKey = grade.getYear() + "년도 " + grade.getSemester() + "학기";
	        if (!semesterMap.containsKey(semesterKey)) {
	            semesterMap.put(semesterKey, new ArrayList<>());
	        }
	        semesterMap.get(semesterKey).add(grade);
	    }

	    // 학기별 평균 학점 계산 및 SemesterVO 리스트 생성
	    List<SemesterVO> gradeListBySemester = new ArrayList<>();
	    for (Map.Entry<String, List<GradeVO>> entry : semesterMap.entrySet()) {
	        List<GradeVO> semesterGrades = entry.getValue();
	        double totalScore = 0;
	        int validScoresCount = 0;
	        for (GradeVO grade : semesterGrades) {
	            if (grade.getCouScore() != null && !grade.getCouScore().isEmpty()) {
	                totalScore += Double.parseDouble(grade.getCouScore());
	                validScoresCount++;
	            }
	        }
	        double averageScore = validScoresCount > 0 ? totalScore / validScoresCount : 0.0;
	        String[] keyParts = entry.getKey().split("년도 |학기");
	        SemesterVO semester = new SemesterVO(keyParts[0], keyParts[1], semesterGrades, averageScore);
	        gradeListBySemester.add(semester);
	    }

	    CertificationPrintVO certificationPrint = new CertificationPrintVO();
		certificationPrint.setCerNo(cerNo);
		certificationPrint.setStuNo(stuNo);

		service.insertCertificationPrint(certificationPrint);
		
	    
	    model.addAttribute("student", student);
	    model.addAttribute("gradeListBySemester", gradeListBySemester);
	    model.addAttribute("cerNo", cerNo);
	    model.addAttribute("cerName", cerName);
	    model.addAttribute("cerCharge", cerCharge);

	    return "sum/student/certification/gradeCertification";
	}

	// 졸업 증명서 미리보기
	@RequestMapping(value = "/graduationCertification", method = RequestMethod.GET)
	public String graduationCertification(Model model, Principal principal, @RequestParam("cerNo") String cerNo,
			@RequestParam("cerName") String cerName, @RequestParam("cerCharge") String cerCharge) {
		String stuNo = principal.getName(); // 로그인한 사용자 학번
		StudentVO student = service.graduationInfo(stuNo);
		
		CertificationPrintVO certificationPrint = new CertificationPrintVO();
		certificationPrint.setCerNo(cerNo);
		certificationPrint.setStuNo(stuNo);

		service.insertCertificationPrint(certificationPrint);
		
		model.addAttribute("student", student);
		model.addAttribute("cerNo", cerNo);
		model.addAttribute("cerName", cerName);
		model.addAttribute("cerCharge", cerCharge);

		return "sum/student/certification/graduationCertification";
	}

	// 증명서 발급 관련 => 증명서 종류에 상관없이 공통
	@RequestMapping(value = "/printCertification", method = RequestMethod.POST)
	@ResponseBody
	public String printCertification(@RequestParam String cerNo, Principal principal) {

		String stuNo = principal.getName(); // 로그인한 학번

		// 발급 정보 저장
		CertificationPrintVO certificationPrint = new CertificationPrintVO();
		certificationPrint.setCerNo(cerNo);
		certificationPrint.setStuNo(stuNo);

		int result = service.insertCertificationPrint(certificationPrint);
		 log.info("CertificationPrintVO: " + certificationPrint);
		 log.info("result : " + result);

		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 본인이 발급받은 증명서 내역 조회
	@RequestMapping(value = "/myCertificationList", method = RequestMethod.GET)
	public String myCertificationList(Model model, @RequestParam(required = false) String searchName,
			Principal principal) {
		log.info("본인이 발급받은 증명서 내역 조회...!");

		String stuNo = principal.getName();
		log.info("로그인한 userId : " + stuNo);

		List<CertificationVO> certificationList = service.myCertificationList(stuNo); // 내가 발급받은 증명서들

		// 검색 기능 추가
		if (searchName != null && !searchName.isEmpty()) {
			certificationList = certificationList.stream()
					.filter(c -> c.getCerName().toLowerCase().contains(searchName.toLowerCase()))
					.collect(Collectors.toList());
		}

		model.addAttribute("certificationList", certificationList);
		model.addAttribute("searchName", searchName);

		return "sum/student/certification/myCertificationList";
	}

}
