package kr.or.ddit.attendance.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.service.IAttendanceService;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.service.common.IYearSemesterService;
import kr.or.ddit.service.student.inter.IStuCourseService;
import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.LectureTimetableVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.YearSemesterVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/attendance")
public class AttendanceController {

	
	@Inject
	private IStuCourseService couService;
	
	@Inject
	private IAdminLectureService lecService;
	
	@Inject
	private IYearSemesterService ysService;
	
	@Inject
	private IAttendanceService attService;
	
	
	@RequestMapping(value = "/attendanceList",method = RequestMethod.GET)
	public String attendanceList(
			@RequestParam(name="date", required = false, defaultValue = "") String date,
			String lecNo, Model model) throws Exception {
		
		List<String> attendanceDayList = getAttendanceDayList(lecNo, lecService, ysService);
		if(attendanceDayList == null) {
			return "redirect:/";
		}
		model.addAttribute("lecNo", lecNo);
		model.addAttribute("date", date);
		
		AttendanceVO attVo = new AttendanceVO();
		attVo.setAttDate(date);
		if(date.equals("")) {
			attVo.setAttDate(attendanceDayList.get(0));
		}
		attVo.setLecNo(lecNo);
		
		// 해당 강의 수강하는 학생 명단
		List<StudentVO> stuAttList = couService.getCourseStudentList(attVo);
		int chul = 0;
		int zi = 0; 
		int gyel  = 0;
		for(StudentVO stu : stuAttList) {
			if(stu.getAttVO() != null) {
				if(stu.getAttVO().getComDetANo().equals("A0101")) chul++;
				if(stu.getAttVO().getComDetANo().equals("A0103")) zi++;
				if(stu.getAttVO().getComDetANo().equals("A0102")) gyel++;
			}
		}
		model.addAttribute("stuAttList", stuAttList);
		model.addAttribute("chul", chul);
		model.addAttribute("zi", zi);
		model.addAttribute("gyel", gyel);
		model.addAttribute("attendanceDayList", attendanceDayList);
		
		return "sum/attendance/attList";
	}
	
	@RequestMapping(value = "/saveAttendance", method = RequestMethod.POST)
	public String saveAttendance(AttendanceVO attendanceVO) {
		log.info("attendanceVO >> {}", attendanceVO);
		
		attService.saveAttendance(attendanceVO);
		
		return "redirect:/attendance/attendanceList?lecNo="+attendanceVO.getLecNo()+"&date="+attendanceVO.getAttDate();
	}
	
	public List<String> getAttendanceDayList(String lecNo, IAdminLectureService lecService, IYearSemesterService ysService ) throws Exception{
		// 해당 강의 요일 List
		log.info("LEC_NO >> {}", lecNo);
		List<LectureTimetableVO> lecDayList = lecService.getLectureTime(lecNo);
		if(lecDayList == null || lecDayList.size() == 0) {
			return null;
		}
		// 현재 년도/학기에 해당하는 개강일 종강일 가져오기
		YearSemesterVO ysVO = ysService.getYearSemesterDate();
		List<String> list = new ArrayList<String>();
		
		Set<Integer> daySet = new HashSet<Integer>();
		for(LectureTimetableVO tt : lecDayList) {
			if(tt.getComDetWNo().equals("W0101")) daySet.add(2);
			else if(tt.getComDetWNo().equals("W0102")) daySet.add(3);
			else if(tt.getComDetWNo().equals("W0103")) daySet.add(4);
			else if(tt.getComDetWNo().equals("W0104")) daySet.add(5);
			else if(tt.getComDetWNo().equals("W0105")) daySet.add(6);
			else if(tt.getComDetWNo().equals("W0106")) daySet.add(7);
			else if(tt.getComDetWNo().equals("W0107")) daySet.add(1);
		}
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String sstr = ysVO.getYsSdate();
		String estr = ysVO.getYsEdate();
		
		Date sdate = df.parse(sstr);
		Date edate = df.parse(estr);
		
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		cal1.setTime(sdate);
		cal2.setTime(edate);
		
		while(cal1.compareTo(cal2) != 1) {
			int day = cal1.get(Calendar.DAY_OF_WEEK);
			Iterator<Integer> it = daySet.iterator();
			while (it.hasNext()) {
				if(day == it.next()) {
					String yearStr = "" + cal1.get(Calendar.YEAR);
					String monthStr = cal1.get(Calendar.MONTH) + 1 < 10 ? "0" + (cal1.get(Calendar.MONTH) + 1) : "" + (cal1.get(Calendar.MONTH) + 1);
					String dayStr = cal1.get(Calendar.DAY_OF_MONTH) < 10 ? "0" + cal1.get(Calendar.DAY_OF_MONTH) : "" + cal1.get(Calendar.DAY_OF_MONTH);
					list.add(yearStr + "-" + monthStr + "-" + dayStr);
				}
			}
			cal1.add(Calendar.DATE, 1);
		}
		
		return list;
	}
	
	
	
}





























