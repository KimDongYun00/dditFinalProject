package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAdminScholarshipMapper;
import kr.or.ddit.service.admin.inter.IAdminScholarshipService;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ScholarshipVO;

@Service
public class AdminScholarshipServiceImpl implements IAdminScholarshipService {

    @Inject
    private IAdminScholarshipMapper scholarshipMapper;

    // 장학 종류 관련------------
    
    // 페이징 처리를 위한 메서드 행 구하기
    @Override
	public int selectScholarshipCount(PaginationInfoVO<ScholarshipVO> pagingVO) {
		return scholarshipMapper.selectScholarshipCount(pagingVO);
	}

    // 페이징 처리 - 장학금 종류 리스트
	@Override
	public List<ScholarshipVO> selectScholarshipList(PaginationInfoVO<ScholarshipVO> pagingVO) {
		return scholarshipMapper.selectScholarshipList(pagingVO);
	}
    
	// 장학 종류 등록
    @Override
    public int scholarshipInsert(ScholarshipVO scholarshipVO) {
        return scholarshipMapper.scholarshipInsert(scholarshipVO);
    }

    // 장학 종류 상세보기
    @Override
    public List<ScholarshipVO> scholarshipDetail(String schNo) {
        return scholarshipMapper.scholarshipDetail(schNo);
    }

    // 장학 종류 수정
    @Override
	public int scholarshipUpdate(ScholarshipVO scholarshipVO) {
		return scholarshipMapper.scholarshipUpdate(scholarshipVO);
	}
	
    // 장학 종류 삭제
    @Override
    public int deleteScholarship(String schNo) {
        return scholarshipMapper.deleteScholarship(schNo);
    }

    //-----------------------------------------------------------------------
    // 장학금 신청 관련
    
    // 페이징 처리를 위한 행 구해오는 메서드
    @Override
	public int selectScholarshipRequestCount(PaginationInfoVO<ScholarshipVO> pagingVO) {
		return scholarshipMapper.selectScholarshipRequestCount(pagingVO);
	}

    // 페이징처리된 장학금 신청 내역 조회
	@Override
	public List<ScholarshipVO> selectScholarshipRequestList(PaginationInfoVO<ScholarshipVO> pagingVO) {
		return scholarshipMapper.selectScholarshipRequestList(pagingVO);
	}
    
	// 전체 학과 목록 가져오기
	@Override
	public List<DepartmentVO> getAllDepartments() {
		return scholarshipMapper.getAllDepartments();
	}
	
	// 전체 신청년도 가져오기
	@Override
	public List<ScholarshipVO> getAllYear() {
		return scholarshipMapper.getAllYear();
	}
	
	// 필터링을 위한 장학금 목록 가져오기
	@Override
	public List<ScholarshipVO> getTypeList() {
		return scholarshipMapper.getTypeList();
	}		
    
	// 장학 신청 내역 세부 조회
    @Override
    public ScholarshipVO getScholarshipRequestDetail(String schRecNo) {
        return scholarshipMapper.getScholarshipRequestDetail(schRecNo);
    }

    @Override
    public List<ScholarshipVO> getUnApproveScholarshipRequestList(String comDetCNo) {
        return scholarshipMapper.getUnApproveScholarshipRequestList(comDetCNo);
    }

    // 개별 승인처리
	@Override
	public boolean scholarshipRequestApprove(String schRecNo) {
		return scholarshipMapper.scholarshipRequestApprove(schRecNo);
	}

	// 반려처리
	@Override
	public boolean scholarshipRequestWait(String schRecNo, String rejContent) {
		return scholarshipMapper.scholarshipRequestWait(schRecNo, rejContent);
	}

	// 미승인건 일괄 승인처리
	@Override
	public void scholarshipRequestAgree(String schRecNo) {
		scholarshipMapper.scholarshipRequestAgree(schRecNo);
		
	}
	
	// 통계 현황 조회를 위한 장학금 신청 전체 데이터 끌어오기 
	@Override
	public List<ScholarshipVO> scholarshipStatistics() {
		return scholarshipMapper.scholarshipStatistics();
	}

	// 필터링을 위한 장학금 목록 가져오기
	@Override
	public List<ScholarshipVO> getScholarshipList() {
		return scholarshipMapper.getScholarshipList();
	}

}
