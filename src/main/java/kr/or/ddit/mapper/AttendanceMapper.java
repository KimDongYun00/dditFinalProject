package kr.or.ddit.mapper;

import kr.or.ddit.vo.AttendanceVO;

public interface AttendanceMapper {
	public int checkAttData(AttendanceVO attendanceVO);
	public void updateAttendance(AttendanceVO tempAtt);
	public void insertAttendance(AttendanceVO tempAtt);
}
