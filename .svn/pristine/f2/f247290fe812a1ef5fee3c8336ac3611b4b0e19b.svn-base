package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminCertificationService {
	
	// 증명서 관리---------------------------------------------------------
	
	// 페이징 처리를 위한 행 구하기
	public int selectCertificationCount(PaginationInfoVO<CertificationVO> pagingVO);

	// 증명서 종류 리스트
	public List<CertificationVO> selectCertificationList(PaginationInfoVO<CertificationVO> pagingVO);

	// 증명서 종류 등록
	public boolean insertCertification(CertificationVO certificationVO);

	// 증명서 발급 현황을 위한 데이터 조회
	public List<CertificationVO> certificationStatistics();

	// 증명서 종류 상세보기
	public CertificationVO certificationDetail(String cerNo);

	// 증명서 종류 수정
	public int certificationUpdate(CertificationVO certificationVO);

	// 증명서 발급 현황 학과별로
	public List<CertificationPrintVO> selectByDepartment();

	// 증명서 비활성화 처리
	//public boolean updateCertificationStatus(String cerNo, boolean status);

}
