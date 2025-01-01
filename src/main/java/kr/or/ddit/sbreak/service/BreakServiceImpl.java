package kr.or.ddit.sbreak.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BreakMapper;
import kr.or.ddit.vo.BreakVO;
import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class BreakServiceImpl implements BreakService {

	@Inject
	private BreakMapper mapper;
	
	@Override
	public List<BreakVO> selectBreakList(String username) {
		
		return mapper.selectBreakList(username);
	}

	@Override
	public int insertBreak(BreakVO breakVO) {
		return mapper.insertBreak(breakVO);
	}

	@Override
	public BreakVO breakDetail(String breNo) {
		return mapper.breakDetail(breNo);
	}

	@Override
	public int deleteBreak(String breNo) {

		return mapper.deleteBreak(breNo);
	}

	@Override
	public int updateBreak(BreakVO breakVO) {
		return mapper.updateBreak(breakVO);
	}

////////////////////////////////////////////////////관리자///////////////////////////////////////	
	@Override
	public int selEmpBreakCount(PaginationInfoVO<BreakVO> pagingVO) {
		 
		return mapper.selEmpBreakCount(pagingVO);
	}

	@Override
	public List<BreakVO> selEmpBreakList(PaginationInfoVO<BreakVO> pagingVO) {
		
		return mapper.selEmpBreakList(pagingVO);
	}

	@Override
	public List<DepartmentVO> selDepartment() {
		
		return mapper.selDepartment();
	}

	@Override
	public int rejectBreak(BreakVO breVO) {
		return mapper.rejectBreak(breVO);
	}

	@Override
	public int approveBreak(BreakVO breakVO) {
		// 학적 변경 신청을 완료할때는 학생 테이블의 학적 상태도 변경을 해줘야 한다.
		// 먼저 승인처리를 해주고 성공을 한다면
		// 학생 정보를 불러와서 학적도 변경해준다. ==> stuNo가 필요하겠네
		int cnt = mapper.approveBreak(breakVO);
		int cnt2 = 0;
		if(cnt > 0) {
			cnt2 = mapper.updateStuBreak(breakVO);
		} 		
		
		return cnt2;
	}

}
