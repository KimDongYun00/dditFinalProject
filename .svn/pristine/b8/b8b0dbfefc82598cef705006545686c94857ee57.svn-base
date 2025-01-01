package kr.or.ddit.academic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AcademicMapper;
import kr.or.ddit.vo.AcademicCalendarVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.YearSemesterVO;
@Service
public class AcademicServiceImpl implements AcademicService {
	@Inject
	private AcademicMapper mapper;
	
	@Override
	public int acaInsert(AcademicCalendarVO acaVO) {
		
		return mapper.acaInsert(acaVO);
	}

	@Override
	public List<AcademicCalendarVO> acaList() {
		return mapper.acaList();
	}

	@Override
	public AcademicCalendarVO acaRead(String acaNo) {
		
		return mapper.acaRead(acaNo);
	}

	@Override
	public int acaModify(AcademicCalendarVO acaVO) {
		return mapper.acaModify(acaVO);
	}

	@Override
	public int acaDelete(String acaNo) {
		return mapper.acaDelete(acaNo);
	}

	@Override
	public List<YearSemesterVO> getYearSemester(PaginationInfoVO<YearSemesterVO> pagingVO) {
		return mapper.getYearSemester(pagingVO);
	}

	@Override
	public int getYearCount(PaginationInfoVO<YearSemesterVO> pagingVO) {
		return mapper.getYearCount(pagingVO);
	}

	@Override
	public int yearSemesterInsert(YearSemesterVO ysVO) {
		return mapper.yearSemesterInsert(ysVO);
	}

	@Override
	public int yearSemesterUpdate(YearSemesterVO ysVO) {
		return mapper.yearSemesterUpdate(ysVO);
	}

}
