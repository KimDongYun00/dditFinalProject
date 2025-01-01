package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;


public interface ILectureNoticeMapper {
	
	public int selectLectureNoticeCount(PaginationInfoVO<LectureNoticeVO> pagingVO);

	public List<LectureNoticeVO> selectLectureNoticeList(PaginationInfoVO<LectureNoticeVO> pagingVO);

	public void updateCnt(String lecNotNo);

	public LectureNoticeVO selectLectureNoticeDetail(String lecNotNo);

	//강의공지사항 등록(비동기)
	public int insertLectureNotice(LectureNoticeVO lectureNoticeVO);

	public int updateLectureNotice(LectureNoticeVO lectureNoticeVO);

	public int deleteLectureNotice(String lecNotNo);

}
 