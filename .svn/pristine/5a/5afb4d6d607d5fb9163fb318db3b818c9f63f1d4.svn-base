package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IConsultingMapper;
import kr.or.ddit.service.admin.inter.IAdminConsultingService;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class AdminConsultingServiceImpl implements IAdminConsultingService {

	@Inject
	private IConsultingMapper mapper;
	
	@Override
	public List<ConsultingVO> selectConsultingList(PaginationInfoVO<ConsultingVO> pagingVO) {
		
		return mapper.selectConsultingList(pagingVO);
	}

	@Override
	public int selectConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO) {
		
		return mapper.selectConsultingCount(pagingVO);
	}

	@Override
	public ConsultingVO selectConsultingDetail(String conNo) {
		
		return mapper.selectConsultingDetail(conNo);
	}

	@Override
	public int updateConsulting(ConsultingVO consultingVO) {

		return mapper.updateConsulting(consultingVO);
	}

	@Override
	public int deleteConsulting(String conNo) {
		
		return mapper.deleteConsulting(conNo);
	}

	

}
