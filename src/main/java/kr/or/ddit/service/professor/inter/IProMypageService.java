package kr.or.ddit.service.professor.inter;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.ProfessorVO;

public interface IProMypageService {

	public ProfessorVO selectProfessor(String userNo);

	public DepartmentVO selectProfessorDep(String userNo);

	public ServiceResult profileUpdate(HttpServletRequest req, ProfessorVO professorVO);

	public DepartmentVO departmentInfo(String deptNo);

}
