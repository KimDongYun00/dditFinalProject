package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.ILicenseMapper;
import kr.or.ddit.service.admin.inter.IAdminLicenseService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ScholarshipVO;

@Service
public class AdminLicenseServiceImpl implements IAdminLicenseService {

	@Inject
	private ILicenseMapper licenseMapper;
	
	@Inject
	private IFileMapper fileMapper;
	
	
	// 페이징 처리를 위한 자격증 신청 내역 count
	@Override
	public int selectLicenseRequestCount(PaginationInfoVO<LicenseVO> pagingVO) {
		return licenseMapper.selectLicenseRequestCount(pagingVO);
	}

	// 페이징 처리 된 자격증 신청 내역 조회
	@Override
	public List<LicenseVO> selectLicenseRequestList(PaginationInfoVO<LicenseVO> pagingVO) {
		return licenseMapper.selectLicenseRequestList(pagingVO);
	}

	// 자격증 종류 가져오기
	@Override
	public List<LicenseVO> getAllLicenseTypes() {
		return licenseMapper.getAllLicenseTypes();
	}

	// 자격증 신청 개별 승인 처리
	@Override
	public int licenseRequestApprove(String licNo) {
		return licenseMapper.licenseRequestApprove(licNo);
	}

	// 자격증 신청 개별 반려 처리
	@Override
	public int licenseRequestWait(LicenseVO licenseVO) {
		return licenseMapper.licenseRequestWait(licenseVO);
	}

	// 자격증 신청 일괄 승인 처리
	@Override
	public int licenseRequestAllApprove(String licNo) {
		return licenseMapper.licenseRequestAllApprove(licNo); 
	}

	// 자격증 신청 상세조회
	@Override
	public LicenseVO getLicenseRequestDetail(String licNo) {
		return licenseMapper.getLicenseRequestDetail(licNo);
	}

	// 파일그룹번호로 파일 가져오기
	@Override
	public List<FileVO> getFileByFileGroupNo(String fileNo) {
		return fileMapper.getFileByFileGroupNo(fileNo);
	}

	// 자격증 신청 통계 현황을 위한 데이터 조회
	@Override
	public List<LicenseVO> licenseStatistics() {
		return licenseMapper.licenseStatistics();
	}
	

}
