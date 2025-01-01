package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminLicenseService {

	// 페이징 처리를 위한 자격증 신청 내역 카운트
	public int selectLicenseRequestCount(PaginationInfoVO<LicenseVO> pagingVO);

	// 페이징 처리된 자격증 신청 내역 조회
	public List<LicenseVO> selectLicenseRequestList(PaginationInfoVO<LicenseVO> pagingVO);

	// 자격증 종류 가져오기
	public List<LicenseVO> getAllLicenseTypes();

	// 자격증 신청 상세조회
	public LicenseVO getLicenseRequestDetail(String licNo);
	
	// 자격증 신청 개별 승인 처리
	public int licenseRequestApprove(String licNo);

	// 자격증 신청 개별 반려 처리
	public int licenseRequestWait(LicenseVO licenseVO);

	// 자격증 신청 일괄 승인 처리
	public int licenseRequestAllApprove(String licNo);

	// 파일 그룹번호로 파일 가져오기
	public List<FileVO> getFileByFileGroupNo(String fileNo);

	
	// -------------------------통계
	// 자격증 신청 통계 현황을 위한 데이터 조회
	public List<LicenseVO> licenseStatistics();



	
}
