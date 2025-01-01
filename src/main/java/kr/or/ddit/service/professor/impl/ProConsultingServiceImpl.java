package kr.or.ddit.service.professor.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IConsultingMapper;
import kr.or.ddit.service.professor.inter.ProConsultingService;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class ProConsultingServiceImpl implements ProConsultingService {

	@Inject
	private IConsultingMapper mapper;
	
	@Override
	public int proConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO) {

		return mapper.proConsultingCount(pagingVO);
	}

	@Override
	public List<ConsultingVO> proConsultingList(PaginationInfoVO<ConsultingVO> pagingVO) {
		
		return mapper.proConsultingList(pagingVO);
	}

	@Override
	public ConsultingVO proConsultingDetail(String conNo) {
		
		return mapper.proConsultingDetail(conNo);
	}

	@Override
	public int proConsultingUpdate(ConsultingVO con) {
		// TODO Auto-generated method stub
		return mapper.proConsultingUpdate(con);
	}

	@Override
	public List<StudentVO> proSearchStu(String stuName) {
		 
		return mapper.proSearchStu(stuName);
	}

	@Override
	public int consultingInsert(ConsultingVO con) {

		return mapper.consultingInsert(con);
	}

	@Override
	public int consultingDelete(String conNo) {
		
		return mapper.consultingDelete(conNo);
	}

}
