package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.BreakVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface BreakMapper {

	public List<BreakVO> selectBreakList(String username);
	public int insertBreak(BreakVO breakVO);
	public BreakVO breakDetail(String breNo);
	public int deleteBreak(String breNo);
	public int updateBreak(BreakVO breakVO);
	
	

	public List<BreakVO> selEmpBreakList(PaginationInfoVO<BreakVO> pagingVO);
	public int selEmpBreakCount(PaginationInfoVO<BreakVO> pagingVO);
	public List<DepartmentVO> selDepartment();
	public int rejectBreak(BreakVO breVO);
	public int approveBreak(BreakVO breakVO);
	public int updateStuBreak(BreakVO breakVO);
	
}
