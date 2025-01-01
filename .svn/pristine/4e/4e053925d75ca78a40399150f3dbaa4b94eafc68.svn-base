package kr.or.ddit.service.student.inter;

import java.util.Collection;
import java.util.List;

import kr.or.ddit.vo.ScholarshipVO;

public interface IStuScholarshipService {

	// 장학 종류 조회
	public List<ScholarshipVO> scholarshipList();

	// 장학 종류 상세보기
	public List<ScholarshipVO> scholarshipDetail(String schNo);

	// 선차감 목록 조회
	public Collection<ScholarshipVO> preScholarshipList();
	
	// 후지급 목록 조회
	public Collection<ScholarshipVO> postScholarshipList();

	// 내가 수혜받은 장학 내역 조회
	public List<ScholarshipVO> myScholarshipList(String stuNo);

	// 승인 목록 조회
	public List<ScholarshipVO> approvedList(String stuNo);

	// 미승인 목록 조회
	public List<ScholarshipVO> unApprovedList(String stuNo);

	// 반려 목록 조회
	public List<ScholarshipVO> rejectedList(String stuNo);

	// 장학금 신청
	public boolean insertScholarshipRequest(ScholarshipVO scholarshipVO);

	// 장학금 신청시 장학금번호로 장학금명 끌어오기
	public ScholarshipVO getScholarshipByNo(String schNo);

	// 내가 신청한 내역 상세보기
	public ScholarshipVO myRequestDetail(String schRecNo);
	
	// 장학금 신청 내역 수정
	public int scholarshipRequestUpdate(ScholarshipVO scholarshipVO);

	// 내가 신청한 장학금 신청 내역 삭제
	public int scholarshipRequestDelete(String schRecNo);
	
	public List<ScholarshipVO> getStuTuitionScholarShipList(String stuNo);

	
	

}
