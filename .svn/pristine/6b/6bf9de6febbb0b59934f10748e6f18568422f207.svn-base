package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VolunteerVO;

public interface AdminVolunteerService {


	public int selectCount(PaginationInfoVO<VolunteerVO> pagingVO);

	public List<VolunteerVO> selectList(PaginationInfoVO<VolunteerVO> pagingVO);

	public void volunteerAgree(String volNo);

	public List<DepartmentVO> selectDept();

	public VolunteerVO volunteerDetail(String volNo);

	public int volunteerApprove(String volNo);

	public int volunteerReject(VolunteerVO volunteerVO);

}
