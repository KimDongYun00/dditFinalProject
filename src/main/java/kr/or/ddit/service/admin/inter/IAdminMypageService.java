package kr.or.ddit.service.admin.inter;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.EmployeeVO;

public interface IAdminMypageService {

	public EmployeeVO selectAdmin(String userNo);

	public ServiceResult profileUpdate(HttpServletRequest req, EmployeeVO empVO);

}
