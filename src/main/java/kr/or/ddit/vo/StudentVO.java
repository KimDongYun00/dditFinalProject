package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StudentVO {
	private String stuNo;
	private String deptNo;//학과번호
	private int stuYear;
	private String stuName;
	private String comDetGNo;	// 성별
	private String stuRegno;
	private String stuPostcode;
	private String stuAdd1;
	private String stuAdd2;
	private String stuEmail;
	private String stuImg;
	private String stuIp;
	private String enabled;
	private String comDetBNo;	// 은행
	private String stuAccount;	// 계좌
	private String stuDelYn;
	private String stuSdate;
	private String stuEdate;
	private String comDetMNo;	// 학적상태
	private String stuPhone;
	
	private MultipartFile imgFile;
	private DepartmentVO departmentVO;
	
	// 학과 가져오기 귀찮을때
	private String deptName;
	
	//학생(+학과 + 강의) : 과제 = 1 : N
	private List<AssignmentSubmitVO> assignmentSubmitVOList;
	
	// 출석정보
	private AttendanceVO attVO;
	// 페이징처리시 번호
	private int rnum;
}
