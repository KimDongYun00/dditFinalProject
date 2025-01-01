package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAdminSubjectMapper;
import kr.or.ddit.service.admin.inter.IAdminSubjectService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.SubjectVO;

@Service
public class AdminSubjectServiceImpl implements IAdminSubjectService {
	
	@Inject
	private IAdminSubjectMapper subMapper;
	
	@Override
	public void insertSubject(SubjectVO subjectVO) {
		subMapper.insertSubject(subjectVO); 
	}

	@Override
	public int selectSubjectCount(PaginationInfoVO<SubjectVO> pagingVO) {
		return subMapper.selectSubjectCount(pagingVO);
	}

	@Override
	public List<SubjectVO> getSubjectList(PaginationInfoVO<SubjectVO> pagingVO) {
		return subMapper.getSubjectList(pagingVO);
	}

	@Override
	public void updateAvailable(SubjectVO subVO) {
		subMapper.updateAvailable(subVO);
	}

	@Override
	public SubjectVO getSubjectBySubNo(String subNo) {
		return subMapper.getSubjectBySubNo(subNo);
	}

	@Override
	public void subjectDelete(String subNo) {
		subMapper.subjectDelete(subNo);
	}

	@Override
	public void subjectUpdate(SubjectVO subjectVO) {
		subMapper.subjectUpdate(subjectVO);
	}

	@Override
	public List<SubjectVO> searchSubject(String subName) {
		return subMapper.searchSubject(subName);
	}
	
}
