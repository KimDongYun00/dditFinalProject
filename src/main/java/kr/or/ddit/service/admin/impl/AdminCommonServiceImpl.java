package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ICommonMapper;
import kr.or.ddit.service.admin.inter.IAdminCommonService;
import kr.or.ddit.vo.CommonVO;

@Service
public class AdminCommonServiceImpl implements IAdminCommonService {

	@Inject
	private ICommonMapper mapper;
	
	@Override
	public List<CommonVO> getBankList() {
		return mapper.getBankList();
	}

	@Override
	public List<CommonVO> getComDetailList(String comNo) {
		return mapper.getComDetailList(comNo);
	}

}
