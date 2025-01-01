package kr.or.ddit.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

//principal
public class CustomUser extends User {
	//principal.user
	private UserVO user;
	
	// User객체를 만들기 위한 첫 번째 생성자
	public CustomUser(String username, String password, 
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		
	}
	// 커스텀 생성자
	public CustomUser(UserVO user) {
		// Java 스트림을 사용한 경우 (람다표현식)
		// - 자바 버전 8부터 추가된 기능
		// map : 컬렉션(List, Map, Set 등), 배열 등의 설정되어 있는 각 타입의 값들을 하나씩 참조하여
		//		   람다식으로 반복 처리할 수 있게 해준다.
		// collect : Stream()을 돌려 발생되는 데이터를 가공 처리하고 원하는 형태의 자료형으로 변환을 돕는다.	   
		//		   회원정보 안에 들어있는 역할명들을 컬렉션 형태의 스트림으로 만들어서 보내준다.
		super(user.getUserNo(), user.getUserPw(),
				// 반복문에 의해 list안에 들어있는 권한 하나하나가 람다 표현식을 이용한 데이터로 바꿔줌
				user.getUserAuthList().stream().map(
						auth -> new SimpleGrantedAuthority(auth.getUserAuthNo())).collect(Collectors.toList()));	
		this.user = user;	// CustomUser가 생성됨과 동시에 member로 만들어놨던 전역변수의 객체 정보가 setter getter로 존재하게 된다.
	}
	
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}

}
