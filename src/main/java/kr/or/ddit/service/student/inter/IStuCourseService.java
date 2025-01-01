package kr.or.ddit.service.student.inter;

import java.util.List;

import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.StudentVO;

public interface IStuCourseService {
	public void insertCourse(CourseVO courseVO);
	public int hasCourseCart(CourseVO courseVO);
	public List<StudentVO> getCourseStudentList(AttendanceVO attVO);
}
