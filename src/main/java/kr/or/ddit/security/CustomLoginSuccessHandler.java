 package kr.or.ddit.security;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import kr.or.ddit.service.professor.inter.IProMypageService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

//인증(로그인) 전에 접근을 시도한 URL로 리다이렉트하는 기능을 가지고 있음
//스프링 시큐리티에서 기본적으로 사용되는 구현 클래스임
@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Inject
//	private IProMypageService service;
	
	private RequestCache requestCache = new HttpSessionRequestCache();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request
			, HttpServletResponse response,
			Authentication auth) throws ServletException, IOException {
		//******
		User customUser = (User)auth.getPrincipal();
		
		log.info("username : " + customUser.getUsername());//admin
		
		//admin 아이디가 갖고 있는 권한(role) 목록
		List<String> roleNames = new ArrayList<String>();
		auth.getAuthorities().forEach(authority->{
			roleNames.add(authority.getAuthority());
		});
		
		log.info("roleNames : " + roleNames);
		
		clearAuthenticationAttribute(request);

		// 요청이 가지고 있는 request 내 타겟 정보
		// 타겟정보가 존재한다면 타겟으로 이동시켜준다.
		SavedRequest savedRequest = requestCache.getRequest(request, response); // 내가 요청한 타겟정보 : request안에 들어있음
		String targetUrl = "";
		
		CustomUser user = 
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVO userVO = user.getUser();
		String goPage = "/";
		if(savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl(); // 우리가 가고자 하는 target정보가 들어있음
		} else {
			if(roleNames.contains("ROLE_ADMIN")) {
				goPage = "/admin/mypage.do";
			}
			
			if(roleNames.contains("ROLE_STUDENT")) {
				goPage = "/student/mypage.do";
			}

			if(roleNames.contains("ROLE_PROFESSOR")) {
				goPage = "/professor/mypage.do";
			}
			response.sendRedirect(goPage);
			return;
		}
		
		log.info("Login Success targetUrl : " + targetUrl);
		response.sendRedirect(targetUrl);
	}
	
	private void clearAuthenticationAttribute(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session == null) {
			return;
		}

		// SPRING_SECURITY_LAST_EXCEPTION 값에 해당하는 KEY
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
}
