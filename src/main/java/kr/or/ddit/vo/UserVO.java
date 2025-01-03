package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private String userNo;
	private String userPw;
	private String comDetUNo;
	private List<UserAuthVO> userAuthList;
	private StudentVO stuVO;
	private ProfessorVO profVO;
	private EmployeeVO empVO;
}
