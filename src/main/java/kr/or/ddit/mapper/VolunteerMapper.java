package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VolunteerVO;

public interface VolunteerMapper {

	public List<VolunteerVO> selectVolunteer(String stuNo);

	public int insertVolunteer(VolunteerVO volunteerVO);

	public List<VolunteerVO> selectList(PaginationInfoVO<VolunteerVO> pagingVO);

	public int selectCount(PaginationInfoVO<VolunteerVO> pagingVO);

	public void volunteerAgree(String volNo);

	public List<DepartmentVO> selectDept();

	public VolunteerVO volunteerDetail(String volNo);

	public int volunteerApprove(String volNo);

	public int volunteerReject(VolunteerVO volunteerVo);

	public int updateVolunteer(VolunteerVO volunteerVO);

	public int deleteVolunteer(String volNo);

	public VolunteerVO stuDetailVolunteer(String volNo);

	public void insertFileGroupNo(VolunteerVO volunteerVO);


}
