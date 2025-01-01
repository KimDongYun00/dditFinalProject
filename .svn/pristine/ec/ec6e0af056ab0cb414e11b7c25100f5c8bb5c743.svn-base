package kr.or.ddit.score.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IScoreMapper;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class ScoreServiceImpl implements IScoreService {

	@Inject
	private IScoreMapper scoMapper;
	
	@Override
	public List<Map<String, Object>> getStudentScoreList(String lecNo) {
		return scoMapper.getStudentScoreList(lecNo);
	}

	@Override
	public LectureVO getLectureScoreDetail(String lecNo) {
		return scoMapper.getLectureScoreDetail(lecNo);
	}

	@Override
	public Integer getMaxExamScore(ExamVO examVO) {
		return scoMapper.getMaxExamScore(examVO);
	}

	@Override
	public Integer getMaxAssScore(String lecNo) {
		return scoMapper.getMaxAssScore(lecNo);
	}

	@Override
	public void saveScore(CourseVO courseVO) {
		String[] stuScoreArr = courseVO.getStuScoreArr();
		String lecNo = courseVO.getLecNo();
		for(String stuScore : stuScoreArr) {
			CourseVO couVO = new CourseVO();
			couVO.setLecNo(lecNo);
			couVO.setStuNo(stuScore.split("_")[0]);
			couVO.setCouAttitude(Integer.parseInt(stuScore.split("_")[1]));
			couVO.setCouScore(Double.parseDouble(stuScore.split("_")[2]));
			scoMapper.updateStuScore(couVO);
		}
	}

	@Override
	public List<Map<String, String>> getStuScoreList(Map<String, String> map) {
		return scoMapper.getStuScoreList(map);
	}

}























