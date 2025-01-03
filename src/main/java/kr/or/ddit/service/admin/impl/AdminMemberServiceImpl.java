package kr.or.ddit.service.admin.impl;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.IAdminMemberMapper;
import kr.or.ddit.mapper.ICommonMapper;
import kr.or.ddit.mapper.IDepartmentMapper;
import kr.or.ddit.service.admin.inter.IAdminMemberService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Service
public class AdminMemberServiceImpl implements IAdminMemberService {
	
	@Resource(name="uploadFolder")
	private String uploadPath;
	
	// 패스워드 인코더
	@Inject
	private PasswordEncoder pw;
	
	@Inject
	private IAdminMemberMapper memMapper;
	
	@Inject
	private ICommonMapper comMapper;
	
	@Inject
	private IDepartmentMapper deptMapper;
	
	@Override
	public List<ProfessorVO> searchProfessor(String proName) {
		return memMapper.searchProfessor(proName);
	}



	@Override
	public StudentVO stuDetail(String stuNo) {
		
		return memMapper.stuDetail(stuNo);
	}

	@Override
	public List<CommonVO> commonList(String comNo) {
		
		return memMapper.commonList(comNo);
	}

	@Override
	public int stuUpdate(StudentVO stuVO, HttpServletRequest req) {
		String uploadPath = "";
		uploadPath = req.getServletContext().getRealPath("/resources/stuImg");
		
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String stuImg = ""; // 시설이미지 경로
		
		try {
			MultipartFile stuImgFile = stuVO.getImgFile();
			
			if(stuImgFile.getOriginalFilename() != null && !stuImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 만들기
				fileName += "_" + stuImgFile.getOriginalFilename();
				
				uploadPath += "/" + fileName;
				
				stuImgFile.transferTo(new File(uploadPath));
				
				stuImg = "/resources/stuImg/" + fileName;
			}
			
			stuVO.setStuImg(stuImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return memMapper.stuUpdate(stuVO);
	}

	
	// 학생 페이징처리 위한 카운터
	@Override
	public int stuCount(PaginationInfoVO<StudentVO> pagingVO) {
		
		return memMapper.stuCount(pagingVO);
	}

	// 학생 페이징 처리를 위한 리스트
	@Override
	public List<StudentVO> stuList(PaginationInfoVO<StudentVO> pagingVO) {
		
		return memMapper.stuList(pagingVO);
	}


	// 교수 페이징 처리를 위한 카운터
	@Override
	public int proCount(PaginationInfoVO<ProfessorVO> pagingVO) {
		return memMapper.proCount(pagingVO);
	}


	// 교수 페이징 처리를 위한 리스트
	@Override
	public List<ProfessorVO> proList(PaginationInfoVO<ProfessorVO> pagingVO) {
		return memMapper.proList(pagingVO);
	}


	// 교수 상세보기 데이터
	@Override
	public ProfessorVO proDetail(String proNo) {
		return memMapper.proDetail(proNo);
	}



	@Override
	public int proUpdate(ProfessorVO proVO, HttpServletRequest req) {
		String uploadPath = "";
		uploadPath = req.getServletContext().getRealPath("/resources/proImg");
		
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String proImg = ""; // 시설이미지 경로
		
		try {
			MultipartFile proImgFile = proVO.getProFile();
			
			if(proImgFile.getOriginalFilename() != null && !proImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 만들기
				fileName += "_" + proImgFile.getOriginalFilename();
				
				uploadPath += "/" + fileName;
				
				proImgFile.transferTo(new File(uploadPath));
				
				proImg = "/resources/proImg/" + fileName;
			}
			
			proVO.setProImg(proImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return memMapper.proUpdate(proVO);
	}



	@Override
	public int proIdCheck(String proID) {
		return memMapper.proIdCheck(proID);
	}



	@Override
	public int proDelete(String proNo) {
		return memMapper.proDelete(proNo);
	}



	@Override
	public int stuDelete(String stuNo) {
		return memMapper.stuDelete(stuNo);
	}


	@Override
	public int empCount(PaginationInfoVO<EmployeeVO> pagingVO) {
		return memMapper.empCount(pagingVO);
	}


	@Override
	public List<EmployeeVO> empList(PaginationInfoVO<EmployeeVO> pagingVO) {
		return memMapper.empList(pagingVO);
	}


	@Override
	public EmployeeVO empDetail(String empNo) {
		return memMapper.empDetail(empNo);
	}


	@Override
	public int empUpdate(EmployeeVO empVO, HttpServletRequest req) {
		String uploadPath = "";
		uploadPath = req.getServletContext().getRealPath("/resources/empImg");
		
		File file = new File(uploadPath);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String empImg = ""; // 시설이미지 경로
		
		try {
			MultipartFile empImgFile = empVO.getEmpFile();
			
			if(empImgFile.getOriginalFilename() != null && !empImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 만들기
				fileName += "_" + empImgFile.getOriginalFilename();
				
				uploadPath += "/" + fileName;
				
				empImgFile.transferTo(new File(uploadPath));
				
				empImg = "/resources/empImg/" + fileName;
			}
			
			empVO.setEmpImg(empImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return memMapper.empUpdate(empVO);
	}


	@Override
	public int empDelete(String empNo) {
		return memMapper.empDelete(empNo);
	}


	@Override
	public int stuInsert(StudentVO stuVO) {
		stuVO.setEnabled("1");			// enabled? 
		stuVO.setStuDelYn("N");			// 삭제여부
		stuVO.setComDetMNo("M0101");	// 재적상태
		stuVO.setStuYear(1);			// 학년 입학해서 1학년		
		
		// selectKey를 이용해 학번을 받아와서 리턴한다.
		return memMapper.stuInsert(stuVO);
	}


	// 학생 회원가입 전에 유저를 먼저 가입해야함
	@Override
	public String memInsert(StudentVO stuVO) {
	    UserVO user = new UserVO();
	    String stuReg = stuVO.getStuRegno();

	    if (stuReg != null && stuReg.length() >= 6) {
	        String pass = stuReg.substring(0, 6);
	        user.setUserPw(pw.encode(pass));
	    } else {
	        // 만약 주민등록번호가 유효하지 않다면 기본 비밀번호를 설정하거나 예외를 발생시키는 로직을 추가
	        user.setUserPw(pw.encode("defaultPassword"));
	        // 또는
	        // throw new IllegalArgumentException("Invalid resident registration number: " + stuReg);
	    }

	    user.setComDetUNo("U0101");
	    
	    int cnt = memMapper.memInsert(user);
	    
	    if (cnt > 0) {
	        memMapper.memAuthInsert(user.getUserNo());
	    }
	    
	    return user.getUserNo();
	}


	// 교수 정보를 유저로 저장
	@Override
	public int memProInsert(ProfessorVO proVO) {
		
		// 교수 아이디
		String proNo = proVO.getProNo();
		// 교수 비밀번호가 될 주민번호
		String proReg = proVO.getProRegno();		
		// 교수 주민번호 앞자리 6자리가 비밀번호가 된다.
		String pass = proReg.substring(0, 6);
		
		// user 객체에 위 데이터를 넣어준다.
		UserVO user = new UserVO();
		user.setUserNo(proNo);
		// 비밀번호 암호화해서 넘기기
		user.setUserPw(pw.encode(pass));
		// 권한설정 U0101학생		U0102교수		U0103교직원
		user.setComDetUNo("U0102");
		
		int cnt = memMapper.memProInsert(user);
		
		if(cnt > 0 ) {
			memMapper.memProAuthInsert(user.getUserNo());
		}
		
		return cnt;
	}


	@Override
	public int proInsert(ProfessorVO proVO) {
		
		
		proVO.setEnabled("1");			// enabled? 
		proVO.setProDelYn("N");			// 삭제여부
		proVO.setComDetMNo("M0201");	// 재적상태 M0201 재직 M0202 휴가 M0203 퇴사
		proVO.setComDetPNo("P0203");	// 새로 들어온 교수는 단과대장부터 시작
		
		
		// selectKey를 이용해 학번을 받아와서 리턴한다.
		return memMapper.proInsert(proVO);
	}


	@Override
	public int memEmpInsert(EmployeeVO empVO) {
		// 교수 아이디
		String empNo = empVO.getEmpNo();
		// 교수 비밀번호가 될 주민번호
		String empReg = empVO.getEmpRegno();		
		// 교수 주민번호 앞자리 6자리가 비밀번호가 된다.
		String pass = empReg.substring(0, 6);
		
		// user 객체에 위 데이터를 넣어준다.
		UserVO user = new UserVO();
		user.setUserNo(empNo);
		// 비밀번호 암호화해서 넘기기
		user.setUserPw(pw.encode(pass));
		// 권한설정 U0101학생		U0102교수		U0103교직원
		user.setComDetUNo("U0103");
		
		// 교수랑 같은 기능이라 이거 써도 된다.
		int cnt = memMapper.memProInsert(user);
		
		if(cnt > 0 ) {
			memMapper.memEmpAuthInsert(user.getUserNo());
		}
		
		return cnt;
	}

	@Override
	public int empInsert(EmployeeVO empVO) {
		empVO.setEnabled("1");			// enabled? 
		empVO.setEmpDelYn("N");			// 삭제여부
		empVO.setComDetMNo("M0201");	// 재적상태 M0201 재직 M0202 휴가 M0203 퇴사
		empVO.setComDetPNo("P0102");	// P0101 과장, P0102직원
		
		
		// selectKey를 이용해 학번을 받아와서 리턴한다.
		return memMapper.empInsert(empVO);
	}

// ----------------------------------------------------일괄 등록 테스트중

	// 엑셀 데이터 파싱
	@Override
	public List<StudentVO> parseExcelFile(MultipartFile file) throws IOException {
		/*
		 * Map<String, String> genderMap = getGenderCodeMap(); Map<String, String>
		 * bankMap = getBankCodeMap(); Map<String, String> deptMap = getDeptCodeMap();
		 */
	    List<CommonVO> genderList = comMapper.getComDetailList("G01");
	    List<CommonVO> bankList = comMapper.getComDetailList("B01");
	    List<DepartmentVO> deptList = deptMapper.getDeptNameList();

	    List<StudentVO> students = new ArrayList<>();
	    Workbook workbook = WorkbookFactory.create(file.getInputStream());

	    Sheet sheet = workbook.getSheetAt(0);
	    for (Row row : sheet) {
	        if (row.getRowNum() == 0) continue; // 가장 위에 부분은 skip
	        StudentVO student = new StudentVO();
	        student.setStuName(getCellValue(row.getCell(0)));       // 이름
	        student.setStuRegno(getCellValue(row.getCell(1)));      // 주민등록번호
	        

	        // 성별에 따른 성별 코드 설정
	        for(int i=0; i<genderList.size(); i++) {
	        	if(genderList.get(i).getComDetName().replaceAll(" ","").equals(getCellValue(row.getCell(2)))) {
	        		String gender = genderList.get(i).getComDetNo();
	        		student.setComDetGNo(gender);  
	        	}
	        }
	        
	        // 학과명에 따른 학과번호 세팅
	        for(int i=0; i<deptList.size(); i++) {
	        	if(deptList.get(i).getDeptName().replaceAll(" ","").equals(getCellValue(row.getCell(3)))) {
	        		String dept = deptList.get(i).getDeptNo();
	        		student.setDeptNo(dept);  // 학과번호
	        	}
	        }
	        
	        
	        // 은행명에 따른 은행번호 설정
	        for(int i=0; i<bankList.size(); i++) {
	        	if(bankList.get(i).getComDetName().replaceAll(" ","").equals(getCellValue(row.getCell(4)))) {
	        		String bankNo = bankList.get(i).getComDetNo();
	        		student.setComDetBNo(bankNo);  // 은행번호
	        	}
	        }

	      
	        
	        student.setStuAccount(getCellValue(row.getCell(5)));    // 계좌번호
	        student.setStuAdd1(getCellValue(row.getCell(6)));       // 기본주소
	        student.setStuAdd2(getCellValue(row.getCell(7)));       // 상세주소
	        student.setStuPostcode(getCellValue(row.getCell(8)));   // 우편번호
	        student.setStuPhone(getCellValue(row.getCell(9)));      // 연락처
	        student.setStuEmail(getCellValue(row.getCell(10)));     // 이메일
	        
	        String dateStr = getCellValue(row.getCell(11));         // 입학일
	        System.out.println("Excel에서 가져온 날짜 문자열: " + dateStr); // 가져온 날짜 문자열 출력
	        student.setStuSdate(parseKoreanDate(dateStr)); // 입학일
	        
	        // 입학일, 상세주소 등 추가 필드 필요 시 추가

	        student.setEnabled("1");                                // 기본값 설정
	        student.setStuDelYn("N");                               // 기본값 설정
	        student.setComDetMNo("M0101");                          // 기본값 설정
	        student.setStuYear(1);                                  // 기본값 설정
	        
	        students.add(student);
	    }

	    workbook.close();
	    return students;
	}

	// 셀 값을 문자열로 가져오는 유틸리티 메서드
	private String getCellValue(Cell cell) {
	    if (cell == null) {
	        return "";
	    }

	    switch (cell.getCellType()) {
	        case STRING:
	            return cell.getStringCellValue();
	        case NUMERIC:
	            if (DateUtil.isCellDateFormatted(cell)) {
	                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	                return dateFormat.format(cell.getDateCellValue());
	            } else {
	                return String.valueOf((int) cell.getNumericCellValue());
	            }
	        case BOOLEAN:
	            return String.valueOf(cell.getBooleanCellValue());
	        case FORMULA:
	            return cell.getCellFormula();
	        case BLANK:
	            return "";
	        default:
	            return "";
	    }
	}

	// 한국어 날짜 형식을 파싱하는 메서드
	private String parseKoreanDate(String dateStr) {
	    if (dateStr == null || dateStr.isEmpty()) {
	        return "";
	    }

	    System.out.println("#########################################################");
	    System.out.println("파싱된 날짜는 ==============>" + dateStr); // 입력된 날짜 문자열 출력
	    System.out.println("#########################################################");

	    try {
	        SimpleDateFormat koreanDateFormat = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
	        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Date date = koreanDateFormat.parse(dateStr);
	        String formattedDate = targetFormat.format(date);
	        System.out.println("☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆");
	        System.out.println("반환된 날짜는  ==============> " + formattedDate); // 변환된 날짜 출력
	        System.out.println("☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆");
	        return formattedDate;
	    } catch (ParseException e) {
	        try {
	            SimpleDateFormat altKoreanDateFormat = new SimpleDateFormat("yyyy/M/d", Locale.KOREAN);
	            SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	            Date date = altKoreanDateFormat.parse(dateStr);
	            String formattedDate = targetFormat.format(date);
	            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	            System.out.println("Formatted date (alternative format): " + formattedDate); // 변환된 날짜 출력
	            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	            return formattedDate;
	        } catch (ParseException ex) {
	            ex.printStackTrace();
	            return "";
	        }
	    }
	}


	// 일괄 등록
	@Override
	public void insertAllStudents(List<StudentVO> students) {
		int cnt = 0;
		
	    for (StudentVO student : students) {
	    	
	    	cnt++;
	    	
	    	String stuNo = memInsert(student);
	        student.setStuNo(stuNo);
	        memMapper.stuInsert(student);
	    }
	}

	// 엑셀 데이터랑 파싱하기 위해 문자열을 코드값으로 매핑하기 위한 용도
	@Override
	public Map<String, String> getGenderCodeMap() {
	    List<CommonVO> genderList = comMapper.getComDetailList("G01");
	    return genderList.stream().collect(Collectors.toMap(CommonVO::getComDetName, CommonVO::getComDetNo));
	}

	@Override
	public Map<String, String> getBankCodeMap() {
	    List<CommonVO> bankList = comMapper.getComDetailList("B01");
	    return bankList.stream().collect(Collectors.toMap(CommonVO::getComDetName, CommonVO::getComDetNo));
	}

	@Override
	public Map<String, String> getDeptCodeMap() {
	    List<DepartmentVO> deptList = deptMapper.getDeptNameList();
	    return deptList.stream().collect(Collectors.toMap(DepartmentVO::getDeptName, DepartmentVO::getDeptNo));
	}

}







