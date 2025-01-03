package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.ConsultingVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminConsultingService {


	public List<ConsultingVO> selectConsultingList(PaginationInfoVO<ConsultingVO> pagingVO);

	public int selectConsultingCount(PaginationInfoVO<ConsultingVO> pagingVO);

	public ConsultingVO selectConsultingDetail(String conNo);

	public int updateConsulting(ConsultingVO consultingVO);

	public int deleteConsulting(String conNo);

}
