package kr.or.ddit.service.student.inter;

import java.util.List;

import kr.or.ddit.vo.LicenseVO;

public interface IStuLicenseService {

	// 자격증 등록
	public boolean insertLicense(LicenseVO licenseVO);

	// 내가 등록한 자격증 목록 조회
	public List<LicenseVO> myLicenseList(String stuNo);

	// 자격증 상세 보기
	public LicenseVO licenseDetail(String licNo);

	// 내가 신청한 자격증 삭제
	public int licenseDelete(String licNo);

	// 내가 신청한 자격증 내역 수정
	public int licenseUpdate(LicenseVO licenseVO);


}
