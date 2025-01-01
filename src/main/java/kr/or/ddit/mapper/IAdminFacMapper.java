package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminFacMapper {
	List<BuildingVO> getBuildingList();
	List<BuildingVO> getLecRoomFacilityList();
	List<FacilityVO> getLecRoomFacilityListByBuiNo(String buiNo);
	List<FacilityVO> getFacilityListByMap(Map<String, String> map);
	List<BuildingVO> getFacilityListByTypeNo(String typeNo);

	
}
