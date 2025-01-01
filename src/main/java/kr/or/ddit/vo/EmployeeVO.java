package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmployeeVO {

	private String empNo;
	private String comDetDNo;
	private String comDetPNo;
	private String empName;
	private String comDetGNo;
	private String empRegno;
	private String empPostcode;
	private String empAdd1;
	private String empAdd2;
	private String empEmail;
	private String empImg;
	private String empIp;
	private String enabled;
	private String comDetBNo;
	private String empAccount;
	private String empDelYn;
	private String empSdate;
	private String empEdate;
	private String comDetMNo;
	private String empPhone;
	
	private MultipartFile empFile;
}
