package kr.or.ddit.service.student.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IConsultingMapper;
import kr.or.ddit.service.student.inter.IStuConsultingService;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;

@Service
public class StuConsultingServiceImpl implements IStuConsultingService {

	@Inject
	private IConsultingMapper mapper;

	@Override
	public int stuConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO) {
		
		return mapper.stuConsultingCount(pagingVO);
	}

	@Override
	public List<ConsultingVO> stuConsultingList(PaginationInfoVO<ConsultingVO> pagingVO) {
		
		return mapper.stuConsultingList(pagingVO);
	}

	@Override
	public ConsultingVO stuconsultingDetail(String conNo) {
		
		return mapper.stuconsultingDetail(conNo);
	}

	@Override
	public List<ProfessorVO> stuSearchPro(String stuName) {
		
		return mapper.stuSearchPro(stuName);
	}

	@Override
	public int stuConsultingInsert(ConsultingVO con) {
//		title, proNo, stuNo, comdetNNO, content, date, onoff, comdetsno('s0102'), regdate('sysdate'), result = null
		// 부족한 데이터 채워넣기
		con.setComDetSNo("S0102");
		
		return mapper.stuConsultingInsert(con);
	}

	@Override
	public int stuConsultingUpdate(ConsultingVO con) {
		// TODO Auto-generated method stub
		return mapper.stuConsultingUpdate(con);
	}
	


}
