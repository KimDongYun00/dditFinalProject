package kr.or.ddit.controller.admin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.service.admin.inter.IAdminDepartmentService;
import kr.or.ddit.service.admin.inter.IAdminGraReqService;
import kr.or.ddit.service.admin.inter.IAdminTuitionService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.ColleageVO;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.GraReqVO;
import kr.or.ddit.vo.TuitionVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminDepartmentController {
	
	@Inject
	private IAdminDepartmentService departmentService;
	
	@Inject
	private IAdminTuitionService tuitionService;
	
	@Inject
	private IAdminGraReqService graReqService;
	
	@Inject
	private IAdminFacilityService facilityService;
	
	@Inject
	private IAdminCommonService commonService;
	
	
	@RequestMapping(value = "/departmentList", method = RequestMethod.GET)
	public String departmentList(Model model) {
		log.info("departmentList()...!");
		
		List<ColleageVO> colleageList = departmentService.getColleageList();
		for(ColleageVO vo : colleageList) {
			log.info("###" + vo.toString());
		}
		
		model.addAttribute("colleageList", colleageList);
		
		return "sum/admin/department/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/departmentList.do", method = RequestMethod.POST)
	public ResponseEntity<List<DepartmentVO>> departmentListByColleage(@RequestBody Map<String, String> map, Model model) {
		log.info("departmentListByColleage()...!");
		log.info("colNo >> " + map.get("colNo"));
		
		List<DepartmentVO> departmentList = departmentService.getDepartmentsByColleageNo(map.get("colNo"));
		
		return new ResponseEntity<List<DepartmentVO>>(departmentList, HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "/departmentInsertForm", method = RequestMethod.POST)
	public String departmentInsertForm(String colNo, Model model) {
		log.info("departmentInsertForm()..!");
		log.info("colNo > " + colNo);
		
		ColleageVO colleageVO = departmentService.getColleageByColleageNo(colNo);
		log.info("### colleageVO > " + colleageVO.toString());
		
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getFacilityListByTypeNo("4");
		List<CommonVO> bankList = commonService.getBankList();
		
		model.addAttribute("colleageVO", colleageVO);
		model.addAttribute("builingList", builingList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/department/insertForm";
	}
	
	@RequestMapping(value = "/departmentInsert.do", method = RequestMethod.POST)
	public String departmentInsert(DepartmentVO departmentVO, RedirectAttributes ra) {
		log.info("departmentInsert()...!");
		log.info("insert vo >> " + departmentVO.toString());
		
		departmentService.insertDeaprtment(departmentVO);
		
		return "redirect:/admin/departmentList"; 
	}
	
	@RequestMapping(value = "/departmentDetail", method = RequestMethod.POST)
	public String departmentDetail(String deptNo, String colNo, Model model) {
		log.info("departmentDetail()...!");
		log.info("deptNo > " + deptNo);
		
		DepartmentVO departmentVO = departmentService.getDepartmentByDeptNo(deptNo);
		ColleageVO colleageVO = departmentService.getColleageByColleageNo(colNo);
		List<TuitionVO> tuitionList = tuitionService.getTuitionListByDeptNo(deptNo);
		List<GraReqVO> graReqList = graReqService.getGraReqListByDeptNo(deptNo);
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getFacilityListByTypeNo("4");
		List<CommonVO> bankList = commonService.getBankList();
		
		log.info("departmentVO >> " + departmentVO.toString());
		log.info("colleageVO >> " + colleageVO.toString());
		model.addAttribute("departmentVO", departmentVO);
		model.addAttribute("colleageVO", colleageVO);
		model.addAttribute("tuitionList", tuitionList);
		model.addAttribute("graReqList", graReqList);
		model.addAttribute("builingList", builingList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("bankList", bankList);
		
		return "sum/admin/department/detail";
	}
	
	@RequestMapping(value = "/departmentDetail", method = RequestMethod.GET)
	public String departmentDetailGet() {
		log.info("departmentDetailGet()...!");
		
		return "sum/admin/department/detail";
	}
	
	@RequestMapping(value = "/departmentUpdate.do", method = RequestMethod.POST)
	public String departmentUpdate(DepartmentVO deptVO, RedirectAttributes ra) {
		log.info("departmentUpdate()...!");
		log.info("### vo >> " + deptVO);
		
		departmentService.updateDepartment(deptVO);
		
		String deptNo = deptVO.getDeptNo();
		DepartmentVO departmentVO = departmentService.getDepartmentByDeptNo(deptNo);
		ColleageVO colleageVO = departmentService.getColleageByColleageNo(deptVO.getColNo());
		List<TuitionVO> tuitionList = tuitionService.getTuitionListByDeptNo(deptNo);
		List<GraReqVO> graReqList = graReqService.getGraReqListByDeptNo(deptNo);
		List<BuildingVO> builingList = facilityService.getBuildingList();
		List<BuildingVO> facilityList = facilityService.getFacilityListByTypeNo("4");
		List<CommonVO> bankList = commonService.getBankList();
		
		ra.addFlashAttribute("departmentVO", departmentVO);
		ra.addFlashAttribute("colleageVO", colleageVO);
		ra.addFlashAttribute("tuitionList", tuitionList);
		ra.addFlashAttribute("graReqList", graReqList);
		ra.addFlashAttribute("builingList", builingList);
		ra.addFlashAttribute("facilityList", facilityList);
		ra.addFlashAttribute("bankList", bankList);
		
		return "redirect:/admin/departmentDetail";
	}
	
	
	
	
	
	
	
	
	
}





















