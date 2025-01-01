package kr.or.ddit.score.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StudentVO;

public interface IScoreService {
	public List<Map<String, Object>> getStudentScoreList(String lecNo);
	public LectureVO getLectureScoreDetail(String lecNo);
	public Integer getMaxExamScore(ExamVO examVO);
	public Integer getMaxAssScore(String lecNo);
	public void saveScore(CourseVO courseVO);
	public List<Map<String, String>> getStuScoreList(Map<String, String> map);
}
