package kr.or.ddit.lecnotice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ILectureNoticeMapper;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class LectureNoticeServiceImpl implements ILectureNoticeService {
	
	@Inject
	private ILectureNoticeMapper lecMapper;
	
	@Override
	public int selectLectureNoticeCount(PaginationInfoVO<LectureNoticeVO> pagingVO) {
		
		return lecMapper.selectLectureNoticeCount(pagingVO);
	}

	@Override
	public List<LectureNoticeVO> selectLectureNoticeList(PaginationInfoVO<LectureNoticeVO> pagingVO) {
		
		return lecMapper.selectLectureNoticeList(pagingVO);
	}

	@Override
	public LectureNoticeVO selectLectureNoticeDetail(String lecNotNo) {
		lecMapper.updateCnt(lecNotNo);
		
		return lecMapper.selectLectureNoticeDetail(lecNotNo);
	}

	//강의공지사항 등록(비동기)
	@Override
	public int insertLectureNotice(LectureNoticeVO lectureNoticeVO) {
		
		return this.lecMapper.insertLectureNotice(lectureNoticeVO);
	}
	//강의공지사항 수정(비동기)
	@Override
	public int updateLectureNotice(LectureNoticeVO lectureNoticeVO) {

		return this.lecMapper.updateLectureNotice(lectureNoticeVO);
	}

	@Override
	public int deleteLectureNotice(String lecNotNo) {
		// TODO Auto-generated method stub
		return lecMapper.deleteLectureNotice(lecNotNo);
	}


}
