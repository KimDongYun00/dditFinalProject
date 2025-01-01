package kr.or.ddit.vacation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.VacationMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationVO;

@Service
public class VacationServiceImpl implements VacationService {

	@Inject
	private VacationMapper mapper;
	
	@Override
	public List<VacationVO> selProVacationList(String username) {

		return mapper.selProVacationList(username);
	}

	@Override
	public int proVacationInsert(VacationVO vacationVO) {
		return mapper.proVacationInsert(vacationVO);
	}

	@Override
	public VacationVO proVacationDetail(String vacNo) {
		return mapper.proVacationDetail(vacNo);
	}

	@Override
	public int proVacationUpdate(VacationVO vacationVO) {
		return mapper.proVacationUpdate(vacationVO);
	}

	@Override
	public int proVacationDelete(String vacNo) {
		return mapper.proVacationDelete(vacNo);
	}

	@Override
	public int selEmpVacationCount(PaginationInfoVO<VacationVO> pagingVO) {
		return mapper.selEmpVacationCount(pagingVO);
	}

	@Override
	public List<VacationVO> selEmpVacationList(PaginationInfoVO<VacationVO> pagingVO) {
		return mapper.selEmpVacationList(pagingVO);
	}

	@Override
	public int rejectVacation(VacationVO vac) {
		return mapper.rejectVacation(vac);
	}

	@Override
	public int approveVacation(String vacNo) {

		return mapper.approveVacation(vacNo);
	}

}
