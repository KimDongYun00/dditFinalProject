package kr.or.ddit.service.student.inter;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.StudentVO;

public interface IStuMypageService {


	public StudentVO selectStudent(String userNo);

	public ServiceResult profileUpdate(HttpServletRequest req, StudentVO stuVO);

	public String getPass(String stuNo);

}
