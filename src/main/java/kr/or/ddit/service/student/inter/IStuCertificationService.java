package kr.or.ddit.service.student.inter;

import java.util.List;

import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.GradeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

public interface IStuCertificationService {

	// 페이징 처리를 위한 증명서 수 count
	public int selectCertificationCount(PaginationInfoVO<CertificationVO> pagingVO);

	// 증명서 종류 조회
	public List<CertificationVO> selectCertificationList(PaginationInfoVO<CertificationVO> pagingVO);

	// 본인이 발급받은 증명서 내역 조회
	public List<CertificationVO> myCertificationList(String stuNo);

	// 재학 정보 조회
	public StudentVO enrollmentInfo(String stuNo);

	// 성적 정보 조회
	public List<GradeVO> gradeInfo(String stuNo);
	
	// 졸업 관련 정보 조회
	public StudentVO graduationInfo(String stuNo);

	// 증명서 발급 
	public int insertCertificationPrint(CertificationPrintVO certificationPrint);

	


}
