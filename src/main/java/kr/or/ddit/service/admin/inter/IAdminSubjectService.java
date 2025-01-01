package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.SubjectVO;

public interface IAdminSubjectService {
	public void insertSubject(SubjectVO subjectVO);
	public int selectSubjectCount(PaginationInfoVO<SubjectVO> pagingVO);
	public List<SubjectVO> getSubjectList(PaginationInfoVO<SubjectVO> pagingVO);
	public void updateAvailable(SubjectVO subVO);
	public SubjectVO getSubjectBySubNo(String subNo);
	public void subjectDelete(String subNo);
	public void subjectUpdate(SubjectVO subjectVO);
	public List<SubjectVO> searchSubject(String subName);
}

