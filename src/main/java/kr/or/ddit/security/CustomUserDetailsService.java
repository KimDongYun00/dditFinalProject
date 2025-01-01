package kr.or.ddit.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.mapper.ILoginMapper;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	@Inject
	private ILoginMapper loginMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UserVO userVO;	// 초기화
		try {
			String auth = loginMapper.selectUserAuth(username);
			userVO =  loginMapper.readByUserId(username, auth);
			log.info("[서연이가 만든 체크포인트]시크리티 인증 시, UserDetailsService 에서 만든 회원정보 확인 : " + userVO);
			return userVO == null ? null : new CustomUser(userVO);
					// 넘겨받은 memberVO가 null이면 null을 return / 그렇지 않으면 CustomUser라는 새로운 객체를 생성
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
