package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.YearSemesterVO;

public interface IYearSemesterMapper {
	public YearSemesterVO getYearSemester();
	public YearSemesterVO getYearSemesterDate();
	public List<YearSemesterVO> getAllYear();
}
