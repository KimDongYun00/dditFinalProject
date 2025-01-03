package kr.or.ddit.controller.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminDepartmentService;
import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.service.admin.inter.IAdminGraReqService;
import kr.or.ddit.service.admin.inter.IAdminTuitionService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.ColleageVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.GraReqVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.TuitionVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminTuitionController {
	
	@Inject
	private IAdminDepartmentService departmentService;
	
	@Inject
	private IAdminTuitionService tuitionService;
	
	@Inject
	private IAdminGraReqService graReqService;
	
	@Inject
	private IAdminFacilityService facilityService;
	
	@RequestMapping(value = "/tuitionInsert.do", method = RequestMethod.POST)
	public String tuitionInsert(TuitionVO tuitionVO, RedirectAttributes ra) {
		log.info("tuitionInsert()...!");
		log.info("tuitionVO >> " + tuitionVO.toString());
		
		tuitionService.insertTuition(tuitionVO);
		
		String deptNo = tuitionVO.getDeptNo();
		DepartmentVO departmentVO = departmentService.getDepartmentByDeptNo(deptNo);
		ColleageVO colleageVO = departmentService.getColleageByColleageNo(departmentVO.getColNo());
		List<TuitionVO> tuitionList = tuitionService.getTuitionListByDeptNo(deptNo);
		List<GraReqVO> graReqList = graReqService.getGraReqListByDeptNo(deptNo);
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getLecRoomFacilityList();
		
		log.info("departmentVO >> " + departmentVO.toString());
		log.info("colleageVO >> " + colleageVO.toString());
		ra.addFlashAttribute("departmentVO", departmentVO);
		ra.addFlashAttribute("colleageVO", colleageVO);
		ra.addFlashAttribute("tuitionList", tuitionList);
		ra.addFlashAttribute("graReqList", graReqList);
		ra.addFlashAttribute("builingList", builingList);
		ra.addFlashAttribute("facilityList", facilityList);
		
		return "redirect:/admin/departmentDetail";
	}
	
	// admin 등록금 리스트
	@RequestMapping(value="/tuiList", method = RequestMethod.GET)
	public String tuiList(Model model) {
		List<TuitionVO> tuiList =  tuitionService.selectTuiList();
		model.addAttribute("tuiList", tuiList);
		return "sum/admin/tuition/tuiList";
	}
	
	 //-------------------------------------------------------------통계 관련
    // charJs를 위한 용도------------------------------------------------------------------------------------------
    // 등록금 납부 현황 통계 페이지
    @RequestMapping(value = "/tuitionStatistics", method = RequestMethod.GET)
    public String tuitionStatistics(Model model) {
        // 통계 현황 조회를 위한 증명서 발급 전체 데이터 끌어오기 
        //List<TuitionVO> tuitionList = tuitionService.tuitionStatistics();
        
        //납부중인 사람들 수 count
        int unPay = tuitionService.selectUnpayPeopleCount();
        
        //미납인 사람들 수 count
        int pay = tuitionService.selectPayPeopleCount();
        
        //일시불인지, 할부인지
        // 일시불
        int fullPay = tuitionService.selectFullPayCount();
        int monthPay = tuitionService.selectMonthPayCount();
        
        log.info("등록금 납부 방식 데이터 : :::::::::::::::::");
        log.info("fullPay : ===>>>>>>>> " + fullPay);
        log.info("monthPay : ===>>>>>>>> " + monthPay);
        
        // 할부
        
        model.addAttribute("pay", pay);	
        model.addAttribute("unPay", unPay);	
        model.addAttribute("fullPay", fullPay);	
        model.addAttribute("monthPay", monthPay);	
        
        return "sum/admin/tuition/tuitionStatistics";
    }
	
	
}




















