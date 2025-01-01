package kr.or.ddit.service.student.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ICourseMapper;
import kr.or.ddit.service.student.inter.IStuCourseService;
import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class StuCourseServiceImpl implements IStuCourseService {
	
	@Inject
	private ICourseMapper couMapper;

	@Override
	public void insertCourse(CourseVO courseVO) {
		couMapper.insertCourse(courseVO);
	}

	@Override
	public int hasCourseCart(CourseVO courseVO) {
		return couMapper.hasCourseCart(courseVO);
	}

	@Override
	public List<StudentVO> getCourseStudentList(AttendanceVO attVO) {
		return couMapper.getCourseStudentList(attVO);
	}
	
}



















