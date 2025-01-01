package kr.or.ddit.lecList.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;

public interface ILectureListService {

	public List<CourseVO> selectLectureList(String userNo);

	public LectureVO selectLecture(String lecNo);

	public List<LectureNoticeVO> selectLectureNotice(String lecNo);

	public List<AssignmentVO> selectAssignment(String lecNo);

	public List<ExamVO> selectExam(String lecNo);

	public List<Map<String, String>> selectLecData(String lecNo);

}
