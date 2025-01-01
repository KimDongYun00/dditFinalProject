package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.GradeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

public interface IStuCertificationMapper {

	public int selectCertificationCount(PaginationInfoVO<CertificationVO> pagingVO);

	// 증명서 리스트
	public List<CertificationVO> selectCertificationList(PaginationInfoVO<CertificationVO> pagingVO);

	// 내가 발급받은 증명서 내역 조회
	public List<CertificationVO> myCertificationList(String stuNo);

	// 재학 증명서를 위한 재학 정보 조회
	public StudentVO enrollmentInfo(String stuNo);

	// 성적 증명서를 위한 성적 정보 조회
	public List<GradeVO> gradeInfo(String stuNo);

	// 졸업 증명서를 위한 졸업 관련 정보 조회
	public StudentVO graduationInfo(String stuNo);
		
	// 증명서 발급 
	public int insertCertificationPrint(CertificationPrintVO certificationPrint);

	


}

