package kr.or.ddit.service.professor.inter;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IProLectureService {

	public List<LectureVO> lectureList(String userNo);

	public List<AssignmentVO> selectAssignment(String lecNo);

	public List<LectureNoticeVO> selectLectureNotice(String lecNo);

	public List<ExamVO> selectExam(String lecNo);

	public LectureVO selectLecture(String lecNo);

	public int selectAssignmentCount(PaginationInfoVO<AssignmentVO> pagingVO);

	public List<AssignmentVO> selectAssignmentList(PaginationInfoVO<AssignmentVO> pagingVO);

	public AssignmentVO selectAssignmentDetail(String assNo);

	public int selectAssignmentSubmitCount(PaginationInfoVO<AssignmentSubmitVO> pagingVO);
	
	// 과제리스트
	public List<AssignmentSubmitVO> selectASList(String assNo);

	public List<AssignmentSubmitVO> selectAssignmentSubmitList(PaginationInfoVO<AssignmentSubmitVO> pagingVO);

	public int selectStudentCount(PaginationInfoVO<CourseVO> pagingVO);

	public List<CourseVO> selectStudentList(PaginationInfoVO<CourseVO> pagingVO);

	public List<AssignmentSubmitVO> selStuAss(Map<String, String> skMap);

	public ServiceResult insertAssignment(HttpServletRequest req, AssignmentVO assignmentVO);

	public ServiceResult updateAssignment(HttpServletRequest req, AssignmentVO assignmentVO);

	public ServiceResult deleteAssignment(HttpServletRequest req, String assNo);

	public List<LectureDataVO> selectLectureDataList(PaginationInfoVO<LectureDataVO> pagingVO);

	public int selectLectureDataCount(PaginationInfoVO<LectureDataVO> pagingVO);

	public ServiceResult insertLectureData(HttpServletRequest req, LectureDataVO lectureDataVO);

	public LectureDataVO selectLectureDataDetail(String lecDataNo);

	public ServiceResult deleteLectureData(HttpServletRequest req, String lecDataNo);

	public List<FileVO> selectFileList(String fileGroupNo);

	public ServiceResult updateLectureData(HttpServletRequest req, LectureDataVO lectureDataVO);

	public int updateAssignmentScore(AssignmentSubmitVO assignmentSubmitVO);

}
