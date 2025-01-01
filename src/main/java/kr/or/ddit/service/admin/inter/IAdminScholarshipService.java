package kr.or.ddit.service.admin.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ScholarshipVO;

public interface IAdminScholarshipService {

	// -------장학 관련------
	
    // 페이징 처리를 위한 메서드
    public int selectScholarshipCount(PaginationInfoVO<ScholarshipVO> pagingVO); 
    
    // 페이징 처리 // 장학 종류 조회
    public List<ScholarshipVO> selectScholarshipList(PaginationInfoVO<ScholarshipVO> pagingVO);

    // 장학 종류 세부 조회
    public List<ScholarshipVO> scholarshipDetail(String schNo); 
    
    // 장학 종류 등록
    public int scholarshipInsert(ScholarshipVO scholarshipVO);	

    // 장학 종류 수정
    public int scholarshipUpdate(ScholarshipVO scholarshipVO);
   
    // 장학 종류 삭제
    public int deleteScholarship(String schNo); 
    
    //--------------------------------------------------------------------------
    
    // -----장학 신청 관련-----
    
    // 페이징을 위한 행 조회해오기
    public int selectScholarshipRequestCount(PaginationInfoVO<ScholarshipVO> pagingVO);
    
    // 페이징 처리한 장학 신청 내역 조회
    public List<ScholarshipVO> selectScholarshipRequestList(PaginationInfoVO<ScholarshipVO> pagingVO);
    
    // 전체 학과 목록 가져오기
 	public List<DepartmentVO> getAllDepartments();
 	
 	// 필터링을 위한 장학금 목록 가져오기
 	public List<ScholarshipVO> getScholarshipList();

 	// 필터링을 위한 지급 종류 가져오기 
 	public List<ScholarshipVO> getTypeList();

 	// 전체 신청년도 가져오기
 	public List<ScholarshipVO> getAllYear();

    // 장학 신청 내역 세부 조회
    public ScholarshipVO getScholarshipRequestDetail(String schRecNo); 

    // 미승인건 개별 승인 처리
    public boolean scholarshipRequestApprove(String schRecNo); 
    
    public List<ScholarshipVO> getUnApproveScholarshipRequestList(String comDetCNo);
    
    // 미승인건 개별 반려 처리
    public boolean scholarshipRequestWait(String schRecNo, String rejContent);

    // 미승인건 일괄 처리
	public void scholarshipRequestAgree(String schRecNo);

	
	// -------------------------통계
	// 통계 현황 조회를 위한 장학금 신청 전체 데이터 끌어오기 
	public List<ScholarshipVO> scholarshipStatistics();




	

    
	

	

	


	

	

}
