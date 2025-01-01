package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ILicenseMapper {

	// 학생 - 자격증 신청 
	public int insertLicense(LicenseVO licenseVO);

	// 학생 - 본인이 신청한 자격증 내역 조회
	public List<LicenseVO> myLicenseList(String stuNo);

	// 자격증 부분에 대한 파일그룹번호 생성
	public void insertFileGroupNoToLicense(LicenseVO licenseVO);

	// 자격증 상세보기 - 학생
	public LicenseVO licenseDetail(String licNo);
	
	
	//----------------------------------관리자
	
	// 페이징 처리를 위한 자격증 신청 내역 카운트
	public int selectLicenseRequestCount(PaginationInfoVO<LicenseVO> pagingVO);

	// 페이징 처리 된 자격증 신청 내역 조회
	public List<LicenseVO> selectLicenseRequestList(PaginationInfoVO<LicenseVO> pagingVO);

	// 자격증 종류 가져오기(필터링을 위한 용도)
	public List<LicenseVO> getAllLicenseTypes();

	//자격증 신청 상세조회
	public LicenseVO getLicenseRequestDetail(String licNo);
	
	// 자격증 신청 개별 승인 처리
	public int licenseRequestApprove(String licNo);

	// 자격증 신청 개별 반려 처리
	public int licenseRequestWait(LicenseVO licenseVO);

	// 자격증 신청 일괄 승인 처리
	public int licenseRequestAllApprove(String licNo);

	// 파일 그룹번호로 파일 가져오기
	public List<FileVO> getFileByFileGroupNo(String fileNo);

	// 자격증 신청 통계 현황을 위한 데이터 조회
	public List<LicenseVO> licenseStatistics();

	// 내가 신청한 자격증 삭제
	public int licenseDelete(String licNo);

	// 내가 신청한 자격증 내역 수정
	public int licenseUpdate(LicenseVO licenseVO);

	


}
