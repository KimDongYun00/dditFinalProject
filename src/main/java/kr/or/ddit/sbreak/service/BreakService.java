package kr.or.ddit.sbreak.service;

import java.util.List;

import kr.or.ddit.vo.BreakVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface BreakService {

	public List<BreakVO> selectBreakList(String username);
	public int insertBreak(BreakVO breakVO);
	public BreakVO breakDetail(String breNo);
	public int deleteBreak(String breNo);
	public int updateBreak(BreakVO breakVO);

	
	public int selEmpBreakCount(PaginationInfoVO<BreakVO> pagingVO);
	public List<BreakVO> selEmpBreakList(PaginationInfoVO<BreakVO> pagingVO);
	// 학과 정보
	public List<DepartmentVO> selDepartment();
	public int rejectBreak(BreakVO breVO);
	public int approveBreak(BreakVO breakVO);

}
