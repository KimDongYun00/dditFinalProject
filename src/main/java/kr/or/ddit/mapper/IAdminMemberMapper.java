package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;

public interface IAdminMemberMapper {
	public List<ProfessorVO> searchProfessor(String proName);

	public List<CommonVO> commonList(String comNo);

	public StudentVO stuDetail(String stuNo);	
	public int stuUpdate(StudentVO stuVO);
	public int stuInsert(StudentVO stuVO);
	public int stuCount(PaginationInfoVO<StudentVO> pagingVO);
	public List<StudentVO> stuList(PaginationInfoVO<StudentVO> pagingVO);
	public int stuDelete(String stuNo);

	
	
	public int proCount(PaginationInfoVO<ProfessorVO> pagingVO);
	public List<ProfessorVO> proList(PaginationInfoVO<ProfessorVO> pagingVO);
	public ProfessorVO proDetail(String proNo);
	public int proUpdate(ProfessorVO proVO);
	public int proInsert(ProfessorVO proVO);
	public int proIdCheck(String proID);
	public int proDelete(String proNo);
	public void memProAuthInsert(String userNo);
	public int memProInsert(UserVO user);
	


	public int empCount(PaginationInfoVO<EmployeeVO> pagingVO);
	public List<EmployeeVO> empList(PaginationInfoVO<EmployeeVO> pagingVO);
	public EmployeeVO empDetail(String empNo);
	public int empUpdate(EmployeeVO empVO);
	public int empDelete(String empNo);
	public int memEmpInsert(UserVO user);
	public void memEmpAuthInsert(String userNo);
	public int empInsert(EmployeeVO empVO);

	public int memInsert(UserVO user);

	public void memAuthInsert(String userNo);

	




	


	


	
}
