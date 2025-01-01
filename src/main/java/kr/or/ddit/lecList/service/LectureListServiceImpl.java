package kr.or.ddit.lecList.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.ILectureListMapper;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;

@Transactional 
@Service
public class LectureListServiceImpl implements ILectureListService {

	@Inject
	private ILectureListMapper mapper;
	
	@Override
	public List<CourseVO> selectLectureList(String userNo) {
		// TODO Auto-generated method stub
		return mapper.selectLectureList(userNo);
	}

	@Override
	public LectureVO selectLecture(String lecNo) {
		// TODO Auto-generated method stub
		return mapper.selectLecture(lecNo);
	}

	@Override
	public List<LectureNoticeVO> selectLectureNotice(String lecNo) {
		// TODO Auto-generated method stub
		return mapper.selectLectureNotice(lecNo);
	}

	@Override
	public List<AssignmentVO> selectAssignment(String lecNo) {
		// TODO Auto-generated method stub
		return mapper.selectAssignment(lecNo);
	}

	@Override
	public List<ExamVO> selectExam(String lecNo) {
		// TODO Auto-generated method stub
		return mapper.selectExam(lecNo);
	}

	@Override
	public List<Map<String, String>> selectLecData(String lecNo) {
		// TODO Auto-generated method stub
		return mapper.selectLecData(lecNo);
	}

}
