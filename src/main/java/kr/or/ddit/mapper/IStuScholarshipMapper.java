package kr.or.ddit.mapper;

import java.util.Collection;
import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ScholarshipVO;

public interface IStuScholarshipMapper {

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

	// 승인 내역 조회
	public List<ScholarshipVO> approvedList(String stuNo);

	// 미승인 내역 조회
	public List<ScholarshipVO> unApprovedList(String stuNo);

	// 반려 목록 조회
	public List<ScholarshipVO> rejectedList(String stuNo);

	// 장학금 신청
	public int insertScholarshipRequest(ScholarshipVO scholarshipVO);

	// 장학금 신청시 장학금번호로 장학금명 끌어오기
	public ScholarshipVO getScholarshipByNo(String schNo);

	public int selectTotalCount(PaginationInfoVO<ScholarshipVO> pagingVO);	//페이징 처리를 위한 행 수 세오기

	// 내가 신청한 내역 상세보기
	public ScholarshipVO myRequestDetail(String stuNo);

	// 장학금 파일 관련 파일 그룹번호 생성
	public void insertFileGroupNoToScholarship(ScholarshipVO scholarshipVO);
	
	public List<ScholarshipVO> getStuTuitionScholarShipList(String stuNo);

	// 장학금 신청 내역 수정
	public int scholarshipRequestUpdate(ScholarshipVO scholarshipVO);

	// 장학금 신청 내역 삭제
	public int scholarshipRequestDelete(String schRecNo);

}
