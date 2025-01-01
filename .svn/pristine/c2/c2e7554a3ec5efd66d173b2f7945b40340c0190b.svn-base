package kr.or.ddit.service.common.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ICommonMapper;
import kr.or.ddit.service.common.CommonCodeService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.YearSemesterVO;

@Service
public class CommonCodeServiceImpl implements CommonCodeService {
	
	@Inject
	private ICommonMapper mapper;

	// getComDetailList('C01') 이런식으로 공통코드 정보 가져오기 가능
	@Override
	public List<CommonVO> getComDetailList(String comNo) {
		
		return mapper.getComDetailList(comNo);
	}


	
	
	
}
