package kr.or.ddit.service.admin.inter;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminFacilityService {
	public List<BuildingVO> getBuildingList();
	public List<BuildingVO> getLecRoomFacilityList();
	public List<FacilityVO> selectFacility();
	public List<FacilityVO> selectFacilityType(String facTypeNo);
	public List<BuildingVO> selectBuildingList();
	public FacilityVO facDetail(String facNo);
	public List<FacilityVO> getLecRoomFacilityListByBuiNo(String string);

	public int insertFacility(FacilityVO facilityVO, HttpServletRequest req);
	
	public int updateFacility(FacilityVO facilityVO, HttpServletRequest req);
	public int deleteFacility(String facNo);
	public int selectFacilityCount(PaginationInfoVO<FacilityVO> pagingVO);
	public List<FacilityVO> selectFacilityList(PaginationInfoVO<FacilityVO> pagingVO);
	public List<FacilityVO> getFacilityListByMap(Map<String, String> map);
	public List<BuildingVO> getFacilityListByTypeNo(String typeNo);
	public List<FacilityReserveVO> selectFacResList(PaginationInfoVO<FacilityReserveVO> pagingVO);
	public int selectFacResCount(PaginationInfoVO<FacilityReserveVO> pagingVO);
	public FacilityReserveVO facResRead(String facResNo);
	public int facResApprove(String facResNo);
	public int facResReject(FacilityReserveVO facVO);
	public void facResAllAgree(String facResNo);
}
