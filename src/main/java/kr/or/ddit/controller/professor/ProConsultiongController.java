package kr.or.ddit.controller.professor;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.impl.AdminMemberServiceImpl;
import kr.or.ddit.service.professor.inter.ProConsultingService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/professor")
public class ProConsultiongController {
	
	@Inject
	private ProConsultingService service;
	
	@Inject
	private AdminMemberServiceImpl commonService;
	
	// 상담 리스트
	@RequestMapping(value="/consultingList", method = RequestMethod.GET)
	public String consultingList(Model model, HttpSession session,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = true, defaultValue = "2") String searchType,
			@RequestParam(required = true, defaultValue = "1") String searchLecType,
			@RequestParam(required = false, defaultValue = "") String searchWord) {
		
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		

		PaginationInfoVO<ConsultingVO> pagingVO = new PaginationInfoVO<ConsultingVO>();

		// 총 4가지의 필드 설정하기 위해서
		// 현제 페이지를 전달 후, start/endRow, start/endPage 설정		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchLecType(searchLecType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setLecNo(user.getUsername());
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = service.proConsultingCount(pagingVO);
		
		// 총 게시글 수 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		List<ConsultingVO> dataList =  service.proConsultingList(pagingVO);
		log.info("pagingVO searchType >> " + pagingVO.getSearchType());
		for(ConsultingVO d: dataList)  log.info("dataList >> " + d.toString());
		pagingVO.setDataList(dataList);
		// 총 게시글 수가 포함된 PaginationInfoVO 객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의
		// 게시글을 얻어온다. (dataList)
		
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchLecType", searchLecType);
		model.addAttribute("pagingVO", pagingVO);
		
		
		return "sum/professor/consulting/consultingList";
	}
	
	@RequestMapping(value="/consultingDetail", method = RequestMethod.GET)
	public String consultingDeatil(String conNo, Model model) {
		
		
		ConsultingVO consultingVO =  service.proConsultingDetail(conNo);
		
		model.addAttribute("consultingVO", consultingVO);
		
		return "sum/professor/consulting/consultingDetail";
	}
	
	@RequestMapping(value="/consultingUpdate", method= RequestMethod.POST)
	public String consultingUpdate(ConsultingVO con, RedirectAttributes ra) {
		String goPage="";
		// con에는 conNo와 conResult가 들어가있다.
		// 상담결과를 제출하면 상담 상태는 완료로 바뀐다.
		// 따라서 여기에 완료도 넣어줘야한다?
		con.setComDetSNo("S0101");
		
		int cnt = service.proConsultingUpdate(con);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "상담이 완료되었습니다.");
			goPage = "redirect:/professor/consultingDetail?conNo="+con.getConNo();
		} else {
			ra.addFlashAttribute("msg", "알 수 없는 오류로 작성에 실패 했습니다. 다시 시도해주세요.");
			goPage = "redirect:/professor/consultingDetail?conNo="+con.getConNo();
		}
		return goPage;
	}
	
	@RequestMapping(value="/consultingForm", method = RequestMethod.GET)
	public String consultingForm(Model model) {
		
		// 진로 상태 동적 셀렉트바
		List<CommonVO> common =  commonService.commonList("N01");
		
		model.addAttribute("common", common);
		
		
		return "sum/professor/consulting/consultingForm";
	}
	
	@ResponseBody	
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public ResponseEntity<List<StudentVO>> search(@RequestBody Map<String, String> map){
			log.info("stuName =======================> " + map.get("stuName"));
		List<StudentVO> stuList =  service.proSearchStu(map.get("stuName"));
		
		
		return new ResponseEntity<List<StudentVO>>(stuList, HttpStatus.OK);
	}
	
	@RequestMapping(value="/consultingInsert", method = RequestMethod.POST)
	public String consultingInsert(ConsultingVO con, RedirectAttributes ra, Model model) {
		String goPage = "";
		
		
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();		
		con.setProNo(userVO.getUserNo());
		
		int cnt = service.consultingInsert(con);
		
		if(cnt > 0) {
			ra.addFlashAttribute("msg", "상담 신청이 완료되었습니다.");
			goPage= "redirect:/professor/consultingDetail?conNo="+con.getConNo()+"&flag='M'";
		} else {
			ra.addFlashAttribute("msg", "알수 없는 이유로 신청을 완료하지 못했습니다.");
			model.addAttribute("con", con);
			goPage = "sum/professor/consulting/consultingForm";
		}
		
		return goPage;
	}
	
	@RequestMapping(value="/deleteConsulting", method = RequestMethod.POST)
	public String consultingDelete(String conNo, RedirectAttributes ra) {
		String goPage = "";
		
		int cnt = service.consultingDelete(conNo);
		
		if(cnt > 0 ) {
			ra.addFlashAttribute("msg", "정상적으로 삭제처리가 완료되었습니다.");
			goPage = "redirect:/professor/consultingList";
		} else {
			ra.addFlashAttribute("msg", "알 수 없는 오류로 삭제처리가 취소되었습니다.");
			goPage = "redirect:/professor/consultingDetail?conNo="+conNo;
		}
		return goPage;
	}
}
