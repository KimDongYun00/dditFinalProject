package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAdminLecService {

	public int selectLectureCount(PaginationInfoVO<LectureVO> pagingVO);

	public List<LectureVO> selectLectureList(PaginationInfoVO<LectureVO> pagingVO);

	public LectureVO lecDetail(String lecNo);
	

}
