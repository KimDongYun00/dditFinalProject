package kr.or.ddit.service.common.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IYearSemesterMapper;
import kr.or.ddit.service.common.IYearSemesterService;
import kr.or.ddit.vo.YearSemesterVO;

@Service
public class YearSemesterServiceImpl implements IYearSemesterService {

	
	@Inject
	private IYearSemesterMapper ysMapper;
	
	@Override
	public YearSemesterVO getYearSemester() {
		System.out.println("ysMapper.getYearSemester()" + ysMapper.getYearSemester());
		return ysMapper.getYearSemester();
	}

	@Override
	public YearSemesterVO getYearSemesterDate() {
		return ysMapper.getYearSemesterDate();
	}

	@Override
	public List<YearSemesterVO> getAllYear() {
		return ysMapper.getAllYear();
	}
	
}

























