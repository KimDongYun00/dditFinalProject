package kr.or.ddit.service.admin.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.LectureTimetableVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public interface IAdminLectureService {
	public int selectLectureCount(PaginationInfoVO<LectureVO> pagingVO);
	public List<LectureVO> getLectureList(PaginationInfoVO<LectureVO> pagingVO);
	public boolean insertLecture(LectureVO lectureVO);
	public void insertLectureTime(LectureVO lectureVO);
	public List<LectureTimetableVO> getLectureTimeList(LectureVO lectureVO);
	public List<LectureTimetableVO> getProfessorTimeList(LectureVO lectureVO);
	public LectureVO getLectureByLecNo(String lecNo);
	public List<LectureTimetableVO> getLectureTime(String lecNo);
	public void lectureConfirm(String lecNo);
	public void lectureReject(Map<String, String> reject);
	public void lectureUnConfirm(String lecNo);
	public void updateLecture(LectureVO lectureVO);
	public void updateLectureTime(LectureVO lectureVO);
	public int selectCourseCount(PaginationInfoVO<LectureVO> pagingVO);
	public List<LectureVO> getCourseList(PaginationInfoVO<LectureVO> pagingVO);
	public List<LectureVO> getMyCourseCartList(PaginationInfoVO<LectureVO> pagingVO);
	public void reserveCourseCart(CourseVO courseVO);
	public void cancelCourseCart(CourseVO courseVO);
	public void lectureDelete(String lecNo);
	public List<LectureVO> getMyCourseList(PaginationInfoVO<LectureVO> pagingVO);
	public void cancelCourse(CourseVO courseVO);
	public int selectProLectureCount(PaginationInfoVO<LectureVO> pagingVO);
	public List<LectureVO> getProLectureList(PaginationInfoVO<LectureVO> pagingVO);
	public List<LectureVO> getProLectureListByProVO(ProfessorVO proVO);
	public List<String> getYearList();
	public List<LectureTimetableVO> getMyLecTimeList(StudentVO stuVO);
	public List<LectureTimetableVO> getProLecTimeList(String proNo);
}
