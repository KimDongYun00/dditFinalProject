package kr.or.ddit.service.professor.inter;

import java.util.List;

import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

public interface ProConsultingService {

	public int proConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO);

	public List<ConsultingVO> proConsultingList(PaginationInfoVO<ConsultingVO> pagingVO);

	public ConsultingVO proConsultingDetail(String conNo);

	public int proConsultingUpdate(ConsultingVO con);

	public List<StudentVO> proSearchStu(String stuName);

	public int consultingInsert(ConsultingVO con);

	public int consultingDelete(String conNo);

}
