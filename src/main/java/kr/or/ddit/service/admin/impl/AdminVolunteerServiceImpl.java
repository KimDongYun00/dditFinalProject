package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.VolunteerMapper;
import kr.or.ddit.service.admin.inter.AdminVolunteerService;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VolunteerVO;

@Service
public class AdminVolunteerServiceImpl implements AdminVolunteerService {

	@Inject
	private VolunteerMapper mapper;

	@Override
	public int selectCount(PaginationInfoVO<VolunteerVO> pagingVO) {
		
		return mapper.selectCount(pagingVO);
	}

	@Override
	public List<VolunteerVO> selectList(PaginationInfoVO<VolunteerVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.selectList(pagingVO);
	}

	@Override
	public void volunteerAgree(String volNo) {
		mapper.volunteerAgree(volNo);
		
	}

	@Override
	public List<DepartmentVO> selectDept() {

		return mapper.selectDept();
	}

	@Override
	public VolunteerVO volunteerDetail(String volNo) {
		
		return mapper.volunteerDetail(volNo);
	}

	@Override
	public int volunteerApprove(String volNo) {
		
		return mapper.volunteerApprove(volNo);
	}

	@Override
	public int volunteerReject(VolunteerVO volunteerVo) {
		
		return mapper.volunteerReject(volunteerVo);
	}
	

}
