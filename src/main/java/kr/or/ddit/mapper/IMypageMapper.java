package kr.or.ddit.mapper;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.StudentVO;

public interface IMypageMapper {

	public StudentVO selectStudent(String userNo);

	public int profileUpdate(StudentVO stuVO);

	public EmployeeVO selectAdmin(String userNo);

	public int empUpdate(EmployeeVO empVO);

	public String getPass(String stuNo);


}
