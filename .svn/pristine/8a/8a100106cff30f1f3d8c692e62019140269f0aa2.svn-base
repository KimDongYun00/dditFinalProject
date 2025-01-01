package kr.or.ddit.controller.student;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.impl.AdminMemberServiceImpl;
import kr.or.ddit.service.student.inter.IStuConsultingService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/student")
public class StuConsultionController {

	@Inject
	private IStuConsultingService consultingService; 
	
	// 공통코드 리스트 보기 위한 서비스
	@Inject
	private AdminMemberServiceImpl commonService;
	
	// 내 상담내역 띄우기
	@RequestMapping(value="/consultingList", method = RequestMethod.GET)
	public String consultingMine(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,			
			 Model model, HttpSession session) {
		
		PaginationInfoVO<ConsultingVO> pagingVO = new PaginationInfoVO<ConsultingVO>();
		StudentVO studentVO = (StudentVO) session.getAttribute("stuVO");
		
		pagingVO.setLecNo(studentVO.getStuNo());
		// 상담 내역 조회 쿼리 필요		
	
		
		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		// 총 게시글 수를 얻어온다.
		int totalRecord = consultingService.stuConsultingCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<ConsultingVO> dataList =  consultingService.stuConsultingList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "sum/student/consulting/mine";		
	}
	
	@RequestMapping(value="/consultingDetail", method = RequestMethod.GET)
	public String consultingDetail(String conNo, Model model, String flag) {
		
		ConsultingVO consultingVO =  consultingService.stuconsultingDetail(conNo);
		// 진로 상태 동적 셀렉트바
		List<CommonVO> common =  commonService.commonList("N01");
		
		model.addAttribute("consultingVO", consultingVO);
		model.addAttribute("flag", flag);
		model.addAttribute("common", common);
		
		return "sum/student/consulting/consultingForm";
	}
	
	@RequestMapping(value="/consultingForm", method = RequestMethod.GET)	
	public String consultingForm(Model model) {
		// 진로 상태 동적 셀렉트바
		List<CommonVO> common =  commonService.commonList("N01");
		
		model.addAttribute("common", common);
		return "sum/student/consulting/consultingForm";
	}
	
	@ResponseBody	
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public ResponseEntity<List<ProfessorVO>> proSearch(@RequestBody Map<String, String> map){
			log.info("stuName =======================> " + map.get("stuName"));
		List<ProfessorVO> proList =  consultingService.stuSearchPro(map.get("stuName"));
		
		
		return new ResponseEntity<List<ProfessorVO>>(proList, HttpStatus.OK);
	}
	
	@RequestMapping(value="/consultingInsert", method = RequestMethod.POST)
	public String consultingInsert(ConsultingVO con, RedirectAttributes ra, Model model) {
//		title, proNo, stuNo, comdetNNO, content, date, onoff, comdetsno('s0101'), regdate('sysdate'), result = null
		String goPage = "";
		
		// selectKey 를 불러올 것이다. 바로 상세보기로 갈 수 있게 따라서 Id값이 리턴될듯
		int cnt = consultingService.stuConsultingInsert(con);
		
		// selectKey가 존재한다면 성공했다는 뜻
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "상담 신청을 완료했습니다.");
			goPage = "redirect:/student/consultingDetail?conNo=" + con.getConNo()+"&flag=Y";
		} else {
			model.addAttribute("msg", "알 수 없는 이유로 실패했습니다. 잠시후 다시 시도해주세요.");
			model.addAttribute("consultingVO", con);
			goPage = "sum/student/consulting/consultingForm";
		}
		
		return goPage;
	}
	
	@RequestMapping(value="/consultingUpdate", method = RequestMethod.POST)
	public String consultingUpdate(ConsultingVO con, RedirectAttributes ra, Model model) {
		String goPage= "";
		
		int cnt = consultingService.stuConsultingUpdate(con);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "상담 신청 내역이 수정되었습니다.");
			goPage = "redirect:/student/consultingDetail?conNo="+con.getConNo()+"&flag=Y";
		} else {
			model.addAttribute("msg", "알 수 없는 이유로 실패했습니다. 잠시 후 다시 시도해 주세요");
			model.addAttribute("consultingVO", con);
			model.addAttribute("flag", "Y");
			goPage = "sum/student/consulting/consultingForm";
		}
		
		return goPage;
	}
}
