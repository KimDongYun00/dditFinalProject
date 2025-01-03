package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public interface IConsultingMapper {

	public List<ConsultingVO> selectConsultingList(PaginationInfoVO<ConsultingVO> pagingVO);
	public int selectConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO);
	public ConsultingVO selectConsultingDetail(String conNo);
	public int updateConsulting(ConsultingVO consultingVO);	
	public int deleteConsulting(String conNo);

	
	public List<ConsultingVO> proConsultingList(PaginationInfoVO<ConsultingVO> pagingVO);
	public int proConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO);
	public ConsultingVO proConsultingDetail(String conNo);
	public int proConsultingUpdate(ConsultingVO con);
	public List<StudentVO> proSearchStu(String stuName);
	public int consultingInsert(ConsultingVO con);
	public int consultingDelete(String conNo);

	
	public List<ConsultingVO> stuConsultingList(PaginationInfoVO<ConsultingVO> pagingVO);
	public int stuConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO);
	public ConsultingVO stuconsultingDetail(String conNo);
	public List<ProfessorVO> stuSearchPro(String stuName);
	public int stuConsultingInsert(ConsultingVO con);
	public int stuConsultingUpdate(ConsultingVO con);

	
}
