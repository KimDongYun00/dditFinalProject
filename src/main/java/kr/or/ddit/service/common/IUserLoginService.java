package kr.or.ddit.service.common;

import java.util.List;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;

public interface IUserLoginService {

	public UserVO loginCheck(UserVO userVO); // 로그인 처리

	public ProfessorVO professorInfo(String userId); // 로그인한 학번/사번으로 이름 개인정보 다 꺼내오는 용도

	// 학생 - 아이디 찾기
	public String findIdByStudentDetails(String userName, String userBirth, String userEmail);

	// 교수 - 아이디 찾기
	public String findIdByProfessorDetails(String userName, String userBirth, String userEmail);

	// 관리자 - 아이디 찾기
	public String findIdByAdminDetails(String userName, String userBirth, String userEmail);

	//-------------비밀번호 초기화---------------------------

	// 학생 - 데이터 일치 여부 확인
	public boolean checkStudentDetails(String userId, String userBirth, String userEmail);

	// 교수 - 데이터 일치 여부 확인
	public boolean checkProfessorDetails(String userId, String userBirth, String userEmail);

	// 관리자 - 데이터 일치 여부 확인
	public boolean checkAdminDetails(String userId, String userBirth, String userEmail);

	// 비밀번호 재설정
	public int resetPw(String userId, String encodedPassword);

	public List<BoardVO> selectNotice();

	
	public int tempPwUpdate(UserVO userVO);

	public UserVO tempPwSel(String userId);
	
	
}
