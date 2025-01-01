package kr.or.ddit.lecnotice.service;

import java.util.List;

import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ILectureNoticeService {

	public int selectLectureNoticeCount(PaginationInfoVO<LectureNoticeVO> pagingVO);

	public List<LectureNoticeVO> selectLectureNoticeList(PaginationInfoVO<LectureNoticeVO> pagingVO);

	public LectureNoticeVO selectLectureNoticeDetail(String lecNotNo);

	//강의공지사항 등록(비동기)
	public int insertLectureNotice(LectureNoticeVO lectureNoticeVO);
	//강의공지사항 업데이트(비동기)
	public int updateLectureNotice(LectureNoticeVO lectureNoticeVO);

	public int deleteLectureNotice(String lecNotNo);
	

}
