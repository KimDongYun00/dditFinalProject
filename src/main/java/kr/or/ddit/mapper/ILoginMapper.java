package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;

public interface ILoginMapper {


	public UserVO loginCheck(UserVO userVO);

	// 시큐리티 인증 시, userNo에 해당하는 권한명을 가져오기 위함(공통코드 키)
	public String selectUserAuth(String username);
	// 시큐리티 인증 시, UserDetailsService 객체 정보 안에서 User객체정보 만들때 사용하는 쿼리
	public UserVO readByUserId(@Param("userNo") String username, @Param("auth") String auth);
	
	// 데이터 넘기기 테스트용 교수ver
	public ProfessorVO professorInfo(String userId);


	
	//------------------------------아이디 ,비밀번호 찾기-----------------------------------
	// ------아이디 찾기 -------
	// 학생 아이디 찾기
	public String findIdByStudentDetails(@Param("userName")String userName, @Param("userBirth")String userBirth, @Param("userEmail")String userEmail);

	// 교수 아이디 찾기
	public String findIdByProfessorDetails(@Param("userName")String userName, @Param("userBirth")String userBirth, @Param("userEmail")String userEmail);
	// 관리자 아이디 찾기
	public String findIdByAdminDetails(@Param("userName")String userName, @Param("userBirth")String userBirth, @Param("userEmail")String userEmail);


	// ------비밀번호 찾기 -------

	// 비밀번호 재설정을 위한 회원 존재 여부 검증
	public String checkStudentDetails(@Param("userId")String userId, @Param("userBirth")String userBirth, @Param("userEmail")String userEmail);

	public String checkProfessorDetails(@Param("userId")String userId, @Param("userBirth")String userBirth, @Param("userEmail")String userEmail);

	public String checkAdminDetails(@Param("userId")String userId, @Param("userBirth")String userBirth, @Param("userEmail")String userEmail);
	
	// 비밀번호 재설정(공통)
	public int resetPw(@Param("userId")String userId, @Param("newPassword")String encodedPassword);

	public List<BoardVO> selectNotice();

	public int tempPwUpdate(UserVO userVO);

	public UserVO tempPwSel(String userId);
	
	
}
