package kr.or.ddit.service.student.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.IStuCertificationMapper;
import kr.or.ddit.service.student.inter.IStuCertificationService;
import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.GradeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class StuCertificationServiceImpl implements IStuCertificationService {

	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private IStuCertificationMapper mapper;
	
	@Inject
	private IFileMapper fileMapper;

	// 페이징 처리를 위한 증명서 count 
	@Override
	public int selectCertificationCount(PaginationInfoVO<CertificationVO> pagingVO) {
		return mapper.selectCertificationCount(pagingVO);
	}

	// 증명서 종류 조회
	@Override
	public List<CertificationVO> selectCertificationList(PaginationInfoVO<CertificationVO> pagingVO) {
		return mapper.selectCertificationList(pagingVO);
	}

	// 본인이 발급받은 증명서 내역 조회
	@Override
	public List<CertificationVO> myCertificationList(String stuNo) {
		return mapper.myCertificationList(stuNo);
	}

	// 재학 증명서를 위한 재학 정보 조회
	@Override
	public StudentVO enrollmentInfo(String stuNo) {
		return mapper.enrollmentInfo(stuNo);
	}

	// 성적 증명서를 위한 성적 정보 조회
	@Override
	public List<GradeVO> gradeInfo(String stuNo) {
		return mapper.gradeInfo(stuNo);
	}
	
	// 졸업 증명서를 위한 졸업 관련 정보 조회
	@Override
	public StudentVO graduationInfo(String stuNo) {
		return mapper.graduationInfo(stuNo);
	}
	
	// 증명서 발급
	@Override
	public int insertCertificationPrint(CertificationPrintVO certificationPrint) {
		return mapper.insertCertificationPrint(certificationPrint);
	}

	

}
