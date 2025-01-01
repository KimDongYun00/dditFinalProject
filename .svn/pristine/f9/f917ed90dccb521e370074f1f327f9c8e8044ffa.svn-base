package kr.or.ddit.controller.common;

import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.common.IUserLoginService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common")
public class CommonLoginController {

    @Inject
    private IUserLoginService iUserLoginService;

    @Inject
    private PasswordEncoder passwordEncoder;
    
    @Inject
    private JavaMailSender mailSender;
    
    @PostConstruct
    public void init() {
        log.info("###### Initialized with Password Encoder");
    }

    // 로그인폼 띄워주는 페이지
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(Model model) {
    	
    	List<BoardVO> boardList = iUserLoginService.selectNotice();
    	model.addAttribute("boardList", boardList);
    	
        return "common/login";
    }

    // 이름 꺼내오는 기능
    @RequestMapping("/main")
    public String mypage(HttpSession session, Model model, String userId) {
        userId = (String) session.getAttribute("userId");
        if (userId != null) {
            ProfessorVO professor = iUserLoginService.professorInfo(userId);
            model.addAttribute("username", professor.getProNo());
            log.info("#################데이터 테스트##############");
            log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            log.info("로그인 한 아이디 = " + userId);
            log.info("정보1 : " + professor.getProEmail());
            log.info("정보2 : " + professor.getDeptNo());
            log.info("정보3 : " + professor.getComDetGNo());
            log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        }
        return "mypage";
    }

    // 로그아웃 처리
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/common/home";
    }

    //--------------------------------------아이디, 비밀번호 찾기--------------------------------------
    // 아이디, 비밀번호 찾기 페이지 이동용
    @RequestMapping(value = "/findIdPw", method = RequestMethod.GET)
    public String findIdPw() {
        return "common/findIdPw";
    }

    // 아이디 찾기
    @RequestMapping(value = "/findId", method = RequestMethod.POST)
    public String findId(@RequestParam("userType") String userType,
                         @RequestParam("userName") String userName,
                         @RequestParam("userBirth") String userBirth,
                         @RequestParam("userEmail") String userEmail,
                         Model model) {

   		log.info("userType : " + userType);
    	String userId = "";
    	if ("student".equals(userType)) {
    		userId = iUserLoginService.findIdByStudentDetails(userName, userBirth, userEmail);
    	} else if ("professor".equals(userType)) {
    		userId = iUserLoginService.findIdByProfessorDetails(userName, userBirth, userEmail);
    	} else if ("admin".equals(userType)) {
    		userId = iUserLoginService.findIdByAdminDetails(userName, userBirth, userEmail);
    	}
        
    	if (userId != null) {
    		model.addAttribute("message", "해당 이메일에 아이디가 전송되었습니다.");
    	} else {
    		model.addAttribute("message", "일치하는 정보가 없습니다.");
    	}
       // JavaMail API 
    	try {
    		MimeMessage mail = mailSender.createMimeMessage();
    		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
    		mailHelper.setFrom("ddit12345@naver.com", "대덕인재대학교");	// 보내는 사람 email 안해주면 smtp권한 오류남
    		mailHelper.setTo(userEmail);	// 받는사람 email
    		mailHelper.setSubject(userName +" 회원님이 요청하신 아이디입니다.");	// 제목
    		String text = ""	// 내용
    				 + "<html>"
    				 + "<body>"
    				 + "안녕하세요 대덕대학교 LMS입니다."
    				 + " 회원님께서 요청하신 아이디는<br>"
    				 + userId + " 입니다.<br>"
    				 + "감사합니다.";    		
    		mailHelper.setText(text, true);	// 내용 true해줘야 html형식으로 바뀜
    		mailSender.send(mail);	// mailSender를 통해 메일을 전송함
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "common/findIdResult"; // findIdResult.jsp로 이동	
    }

    // 비밀번호 재설정을 위해 입력 데이터에 일치하는 데이터가 DB에 있는지를 확인
    @RequestMapping(value = "/findPw", method = RequestMethod.POST)
    public String findPw(@RequestParam("userType") String userType,
                         @RequestParam("userId") String userId,
                         @RequestParam("userBirth") String userBirth,
                         @RequestParam("userEmail") String userEmail
//                       , RedirectAttributes ra  
                       , Model model) {
    	String goPage = "";
        log.info("userType : " + userType);

        boolean exists = false;	// 조회한 데이터가 존재하는지 검증
        
        if ("student".equals(userType)) {
            exists = iUserLoginService.checkStudentDetails(userId, userBirth, userEmail);
        } else if ("professor".equals(userType)) {
            exists = iUserLoginService.checkProfessorDetails(userId, userBirth, userEmail);
        } else if ("admin".equals(userType)) {
            exists = iUserLoginService.checkAdminDetails(userId, userBirth, userEmail);
        }
        String tempPw=UUID.randomUUID().toString().replace("-", "");//-를 제거
		tempPw = tempPw.substring(0,10);
		
		
        if (exists) {
        	try {
        		MimeMessage mail = mailSender.createMimeMessage();
        		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
        		mailHelper.setFrom("ddit12345@naver.com", "대덕인재대학교");	// 보내는 사람 email 안해주면 smtp권한 오류남
        		mailHelper.setTo(userEmail);	// 받는사람 email
        		mailHelper.setSubject(userId +" 회원님에게 발급된 임시 비밀번호입니다.");	// 제목
        		String text = ""	// 내용
        				 + "<html>"
        				 + "<body>"
        				 + "안녕하세요 대덕대학교 LMS입니다."
        				 + " 회원님께 발급된 임시비밀번호는<br> "
        				 + tempPw + " 입니다.<br>"
        				 + "감사합니다.";    		
        		mailHelper.setText(text, true);	// 내용 true해줘야 html형식으로 바뀜
        		mailSender.send(mail);	// mailSender를 통해 메일을 전송함
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        	// 메일을 보내고
        	UserVO userVO = new UserVO();
    		userVO.setUserNo(userId);
    		// 암호화
    		tempPw = passwordEncoder.encode(tempPw);    		
    		userVO.setUserPw(tempPw);
        	int cnt = iUserLoginService.tempPwUpdate(userVO);
        	if(cnt > 0) {
        		String msg = "회원님의 이메일로 임시비밀번호가 전송되었습니다.";
        		model.addAttribute("msg", msg);
        		model.addAttribute("userId", userId);
        		
        		goPage = "common/resetPw";       
        			
        	} else {
        		model.addAttribute("message", "다시 시도해 주세요.");
        		goPage = "common/findIdResult";
        	}        	
        } else {
            model.addAttribute("message", "일치하는 정보가 없습니다.");
            goPage = "common/findIdResult";            
        }
        return goPage;
    }

    // 비밀번호 재설정 (공통)
    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public String resetPassword(
    		                    @RequestParam("userId") String userId
                              , @RequestParam("newPassword") String newPassword
                              , String tempPw
                              , Model model) {
    	String goPage ="";
    	UserVO userVO = iUserLoginService.tempPwSel(userId);
    	Boolean tempPwBool = passwordEncoder.matches(tempPw, userVO.getUserPw());
    	
    	if(!tempPwBool) {
    		model.addAttribute("msg1", "임시비밀번호");
    		model.addAttribute("msg2", "발급된 임시비밀번호가 다릅니다. 다시 확인해주세요.");
    		model.addAttribute("msg3", "error");    		
    		model.addAttribute("userId", userId);
    		return "common/resetPw";    		
    	}
    	
        String encodedPassword = passwordEncoder.encode(newPassword);
        int success = iUserLoginService.resetPw(userId, encodedPassword);
        
        if (success > 0) {
            model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        } else {
            model.addAttribute("message", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
        }        
        
        return "common/resetPwResult"; 
    }
}    
