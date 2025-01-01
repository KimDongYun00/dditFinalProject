package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationVO;

public interface VacationMapper {

	public List<VacationVO> selProVacationList(String username);

	public int proVacationInsert(VacationVO vacationVO);

	public VacationVO proVacationDetail(String vacNo);

	public int proVacationUpdate(VacationVO vacationVO);

	public int proVacationDelete(String vacNo);

	public List<VacationVO> selEmpVacationList(PaginationInfoVO<VacationVO> pagingVO);

	public int selEmpVacationCount(PaginationInfoVO<VacationVO> pagingVO);

	public int rejectVacation(VacationVO vac);

	public int approveVacation(String vacNo);

}
