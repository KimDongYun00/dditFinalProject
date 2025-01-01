package kr.or.ddit.academic.service;

import java.util.List;

import kr.or.ddit.vo.AcademicCalendarVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.YearSemesterVO;

public interface AcademicService {

	public int acaInsert(AcademicCalendarVO acaVO);

	public List<AcademicCalendarVO> acaList();

	public AcademicCalendarVO acaRead(String acaNo);

	public int acaModify(AcademicCalendarVO acaVO);

	public int acaDelete(String acaNo);

	public List<YearSemesterVO> getYearSemester(PaginationInfoVO<YearSemesterVO> pagingVO);

	public int getYearCount(PaginationInfoVO<YearSemesterVO> pagingVO);

	public int yearSemesterInsert(YearSemesterVO ysVO);

	public int yearSemesterUpdate(YearSemesterVO ysVO);

}
