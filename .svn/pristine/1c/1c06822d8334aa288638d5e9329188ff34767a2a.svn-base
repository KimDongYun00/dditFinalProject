package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IFacilityMapper {

	public List<FacilityVO> selectFacList(String facTypeNo);

	public FacilityVO selectDetail(String facNo);



	public List<FacilityVO> selectFacility();

	public List<FacilityVO> selectFacilityType(String facTypeNo);

	public List<BuildingVO> selectBuildingList();

	public FacilityVO facDetail(String facNo);

	public int facInsert(FacilityVO facilityVO);

	public int facUpdate(FacilityVO facilityVO);

	public int facDelete(String facNo);

	public int selectFacilityCount(PaginationInfoVO<FacilityVO> pagingVO);

	public List<FacilityVO> selectFacilityList(PaginationInfoVO<FacilityVO> pagingVO);

	public int facilityStuReserve(FacilityReserveVO facReserveVO);

	public List<FacilityReserveVO> facilityStuReserveList(String facNo);

	public int facStuResDelete(String facResNo);

	public List<FacilityReserveVO> selectFacResList(PaginationInfoVO<FacilityReserveVO> pagingVO);

	public int selectFacResCount(PaginationInfoVO<FacilityReserveVO> pagingVO);

	public FacilityReserveVO facResRead(String facResNo);

	public int facResApprove(String facResNo);

	public int facResReject(FacilityReserveVO facVO);

	public void facResAllAgree(String facResNo);

}
