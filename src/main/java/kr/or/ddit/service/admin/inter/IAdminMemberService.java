package kr.or.ddit.service.admin.inter;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public interface IAdminMemberService {
	public List<ProfessorVO> searchProfessor(String proName);


	public List<CommonVO> commonList(String comNo);

	//학생
	public List<StudentVO> stuList(PaginationInfoVO<StudentVO> pagingVO);
	public StudentVO stuDetail(String stuNo);
	public int stuDelete(String stuNo);
	public int stuUpdate(StudentVO stuVO, HttpServletRequest req);
	public int stuCount(PaginationInfoVO<StudentVO> pagingVO);
	public int stuInsert(StudentVO stuVO);
	public String memInsert(StudentVO stuVO);

	//교수
	public List<ProfessorVO> proList(PaginationInfoVO<ProfessorVO> pagingVO);
	public int proCount(PaginationInfoVO<ProfessorVO> pagingVO);
	public ProfessorVO proDetail(String proNo);
	public int proUpdate(ProfessorVO proVO, HttpServletRequest req);
	public int proIdCheck(String proID);
	public int proDelete(String proNo);
	public int proInsert(ProfessorVO proVO);
	public int memProInsert(ProfessorVO proVO);

	//직원
	public List<EmployeeVO> empList(PaginationInfoVO<EmployeeVO> pagingVO);
	public int empCount(PaginationInfoVO<EmployeeVO> pagingVO);
	public EmployeeVO empDetail(String empNo);
	public int empUpdate(EmployeeVO empVO, HttpServletRequest req);
	public int empDelete(String empNo);
	public int memEmpInsert(EmployeeVO empVO);
	public int empInsert(EmployeeVO empVO);

	
	
	//----------------------test중
	
	//----------- 학생 일괄 등록 관련
	// 엑셀파일 파싱하기
	public List<StudentVO> parseExcelFile(MultipartFile file) throws IOException;
	// 학생 일괄 등록
	public void insertAllStudents(List<StudentVO> students);

	// 성별코드 관련
	public Map<String, String> getGenderCodeMap();
	
	// 은행코드 관련
	public Map<String, String> getBankCodeMap();

	// 학과코드 관련
	public Map<String, String> getDeptCodeMap();

}
