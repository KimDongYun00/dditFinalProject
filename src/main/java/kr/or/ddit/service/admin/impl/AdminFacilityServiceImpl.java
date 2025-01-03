package kr.or.ddit.service.admin.impl;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.IAdminFacMapper;
import kr.or.ddit.mapper.IFacilityMapper;
import kr.or.ddit.service.admin.inter.IAdminFacilityService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class AdminFacilityServiceImpl implements IAdminFacilityService {

	@Inject
	private IAdminFacMapper facMapper;
	
	@Inject	
	private IFacilityMapper mapper;
	
	@Override
	public List<BuildingVO> getBuildingList() {
		return facMapper.getBuildingList();
	}

	@Override
	public List<BuildingVO> getLecRoomFacilityList() {
		return facMapper.getLecRoomFacilityList();
	}
	@Override
	public List<FacilityVO> selectFacility() {
		
		return mapper.selectFacility();
	}

	@Override 
	public List<FacilityVO> selectFacilityType(String facTypeNo) {
		
		return mapper.selectFacilityType(facTypeNo);
	}

	@Override
	public List<BuildingVO> selectBuildingList() {
		
		return mapper.selectBuildingList();
	}

	@Override
	public FacilityVO facDetail(String facNo) {
		
		return mapper.facDetail(facNo);
	}



	@Override
	public List<FacilityVO> getLecRoomFacilityListByBuiNo(String buiNo) {
		return facMapper.getLecRoomFacilityListByBuiNo(buiNo);
	}


	@Override
	public int insertFacility(FacilityVO facilityVO, HttpServletRequest req) {
		String uploadPath = "";
		uploadPath = req.getServletContext().getRealPath("/resources/facilityImg");
		
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String facilityImg = ""; // 시설이미지 경로
		
		try {
			MultipartFile facilityImgFile = facilityVO.getImgFile();
			
			if(facilityImgFile.getOriginalFilename() != null && !facilityImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 만들기
				fileName += "_" + facilityImgFile.getOriginalFilename();
				
				uploadPath += "/" + fileName;
				
				facilityImgFile.transferTo(new File(uploadPath));
				
				facilityImg = "/resources/facilityImg/" + fileName;
			}
			
			facilityVO.setFacImg(facilityImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return mapper.facInsert(facilityVO);
	}

	@Override
	public int updateFacility(FacilityVO facilityVO, HttpServletRequest req) {
		String uploadPath = "";
		uploadPath = req.getServletContext().getRealPath("/resources/facilityImg");
		
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String facilityImg = ""; // 시설이미지 경로
		
		try {
			MultipartFile facilityImgFile = facilityVO.getImgFile();
			
			if(facilityImgFile.getOriginalFilename() != null && !facilityImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 만들기
				fileName += "_" + facilityImgFile.getOriginalFilename();
				
				uploadPath += "/" + fileName;
				
				facilityImgFile.transferTo(new File(uploadPath));
				
				facilityImg = "/resources/facilityImg/" + fileName;
			}
			
			facilityVO.setFacImg(facilityImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return mapper.facUpdate(facilityVO);
	}

	
	@Override
	public int deleteFacility(String facNo) {
		
		return mapper.facDelete(facNo);
	}

	@Override
	public int selectFacilityCount(PaginationInfoVO<FacilityVO> pagingVO) {
		
		return mapper.selectFacilityCount(pagingVO);
	}

	@Override
	public List<FacilityVO> selectFacilityList(PaginationInfoVO<FacilityVO> pagingVO) {
		
		return mapper.selectFacilityList(pagingVO);
	}

	@Override
	public List<FacilityVO> getFacilityListByMap(Map<String, String> map) {
		return facMapper.getFacilityListByMap(map);
	}

	@Override
	public List<BuildingVO> getFacilityListByTypeNo(String typeNo) {
		return facMapper.getFacilityListByTypeNo(typeNo);
	}

	@Override
	public List<FacilityReserveVO> selectFacResList(PaginationInfoVO<FacilityReserveVO> pagingVO) {
		
		return mapper.selectFacResList(pagingVO);
	}

	@Override
	public int selectFacResCount(PaginationInfoVO<FacilityReserveVO> pagingVO) {
		return mapper.selectFacResCount(pagingVO);
	}

	@Override
	public FacilityReserveVO facResRead(String facResNo) {
		
		return mapper.facResRead(facResNo);
	}

	@Override
	public int facResApprove(String facResNo) {
		return mapper.facResApprove(facResNo);
	}

	@Override
	public int facResReject(FacilityReserveVO facVO) {
		return mapper.facResReject(facVO);
	}

	@Override
	public void facResAllAgree(String facResNo) {
		mapper.facResAllAgree(facResNo);
		
	}


}

















