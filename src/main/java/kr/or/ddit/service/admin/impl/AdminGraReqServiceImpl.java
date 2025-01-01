package kr.or.ddit.service.admin.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IGraReqMapper;
import kr.or.ddit.service.admin.inter.IAdminGraReqService;
import kr.or.ddit.vo.GraReqVO;

@Service
public class AdminGraReqServiceImpl implements IAdminGraReqService {
	
	@Inject
	private IGraReqMapper graReqMapper;
	
	@Override
	public List<GraReqVO> getGraReqListByDeptNo(String deptNo) {
		return graReqMapper.getGraReqListByDeptNo(deptNo);
	}

	@Override
	public void insertGraReq(GraReqVO graReqVO) {
		graReqMapper.insertGraReq(graReqVO);
	}

	@Override
	public GraReqVO getStuGraReq(String stuNo) {
		return graReqMapper.getStuGraReq(stuNo);
	}

	@Override
	public Map<String, String> getStuGraReqScore(String stuNo) {
		return graReqMapper.getStuGraReqScore(stuNo);
	}
	
}
