package kr.or.ddit.service.common.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ILoginMapper;
import kr.or.ddit.service.common.IUserLoginService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;

@Service
public class UserLoginServiceImpl implements IUserLoginService {

	@Inject
	private ILoginMapper loginMapper;

	// 로그인 체크 관련
	@Override
	public UserVO loginCheck(UserVO userVO) {
		return loginMapper.loginCheck(userVO);
	}

	// 교수 데이터 뿌리기 test용
	@Override
	public ProfessorVO professorInfo(String userId) {
		return loginMapper.professorInfo(userId);
	}

	// 학생 - 아이디 찾기
	@Override
	public String findIdByStudentDetails(String userName, String userBirth, String userEmail) {
		return loginMapper.findIdByStudentDetails(userName, userBirth, userEmail);
	}

	// 교수 - 아이디 찾기
	@Override
	public String findIdByProfessorDetails(String userName, String userBirth, String userEmail) {
		return loginMapper.findIdByProfessorDetails(userName, userBirth, userEmail);
	}

	// 관리자 - 아이디 찾기
	@Override
	public String findIdByAdminDetails(String userName, String userBirth, String userEmail) {
		return loginMapper.findIdByAdminDetails(userName, userBirth, userEmail);
	}

	// ----------------------------------------------------------------------------------------

	// 학생 - 데이터 일치 여부 확인
	@Override
	public boolean checkStudentDetails(String userId, String userBirth, String userEmail) {
		 String foundUserId = loginMapper.checkStudentDetails(userId, userBirth, userEmail);
	     return foundUserId != null;
	}

	// 교수 - 데이터 일치 여부 확인
	@Override
	public boolean checkProfessorDetails(String userId, String userBirth, String userEmail) {
		 String foundUserId = loginMapper.checkProfessorDetails(userId, userBirth, userEmail);
	     return foundUserId != null;
	}

	// 관리자 - 데이터 일치 여부 확인
	@Override
	public boolean checkAdminDetails(String userId, String userBirth, String userEmail) {
		 String foundUserId = loginMapper.checkAdminDetails(userId, userBirth, userEmail);
	     return foundUserId != null;
	}

	// 비밀번호 재설정(공통)
	@Override
	public int resetPw(String userId, String encodedPassword) {
		return loginMapper.resetPw(userId, encodedPassword);
	}

	@Override
	public List<BoardVO> selectNotice() {

		return loginMapper.selectNotice();
	}


	// 임시비밀번호 저장
	@Override
	public int tempPwUpdate(UserVO userVO) {

		return loginMapper.tempPwUpdate(userVO);
	}

	@Override
	public UserVO tempPwSel(String userId) {
		return loginMapper.tempPwSel(userId);
	}

}
