package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StudentVO;

public interface IScoreMapper {
	public List<StudentVO> getCourseStudentList(String lecNo);
	public List<Map<String, Object>> getStudentScoreList(String lecNo);
	public LectureVO getLectureScoreDetail(String lecNo);
	public Integer getMaxExamScore(ExamVO examVO);
	public Integer getMaxAssScore(String lecNo);
	public int checkStuScore(CourseVO couVO);
	public void updateStuScore(CourseVO couVO);
	public void insertStuScore(CourseVO couVO);
	public List<Map<String, String>> getStuScoreList(Map<String, String> map);
}
