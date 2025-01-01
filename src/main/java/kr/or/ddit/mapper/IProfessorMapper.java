package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;

public interface IProfessorMapper {

	public ProfessorVO selectProfessor(String userNo);

	public DepartmentVO selectProfessorDep(String userNo);

	public int profileUpdate(ProfessorVO professorVO);

	public List<LectureVO> lectureList(String userNo);

	public List<LectureNoticeVO> selectLectureNotice(String lecNo);

	public List<AssignmentVO> selectAssignment(String lecNo);

	public List<ExamVO> selectExam(String lecNo);

	public LectureVO selectLecture(String lecNo);

	public int selectAssignmentCount(PaginationInfoVO<AssignmentVO> pagingVO);

	public List<AssignmentVO> selectAssignmentList(PaginationInfoVO<AssignmentVO> pagingVO);

	public AssignmentVO selectAssignmentDetail(String assNo);

	public int selectAssignmentSubmitCount(PaginationInfoVO<AssignmentSubmitVO> pagingVO);

	public List<AssignmentSubmitVO> selectAssignmentSubmitList(PaginationInfoVO<AssignmentSubmitVO> pagingVO);

	public int selectStudentCount(PaginationInfoVO<CourseVO> pagingVO);

	public List<CourseVO> selectStudentList(PaginationInfoVO<CourseVO> pagingVO);

	public List<AssignmentSubmitVO> selectASList(String assNo);

	public List<AssignmentSubmitVO> selStuAss(Map<String, String> skMap);

	public int insertAssignment(AssignmentVO assignmentVO);

	public int updateAssignment(AssignmentVO assignmentVO);

	public int deleteAssignment(String assNo);

	public int updateAssignmentScore(AssignmentSubmitVO assignmentSubmitVO);

	public DepartmentVO departmentInfo(String deptNo);




}
