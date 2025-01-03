package kr.or.ddit.controller.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
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
import kr.or.ddit.vo.TuitionVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminGraReqController {
	
	@Inject
	private IAdminDepartmentService departmentService;
	
	@Inject
	private IAdminTuitionService tuitionService;
	
	@Inject
	private IAdminGraReqService graReqService;
	
	@Inject
	private IAdminFacilityService facilityService;
	
	@RequestMapping(value = "/graReqInsert.do", method = RequestMethod.POST)
	public String graReqInsert(RedirectAttributes ra, GraReqVO graReqVO) {
		log.info("graReqInsert()...!");
		log.info("graReqVO >> " + graReqVO.toString());
		
		graReqService.insertGraReq(graReqVO);
		
		String deptNo = graReqVO.getDeptNo();
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
	
	
	
	
}

























