package kr.or.ddit.attendance.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AttendanceMapper;
import kr.or.ddit.vo.AttendanceVO;

@Service
public class AttendanceServiceImpl implements IAttendanceService {

	@Inject
	private AttendanceMapper attMapper;
	
	@Override
	public void saveAttendance(AttendanceVO attendanceVO) {
		String[] attArr = attendanceVO.getAttArr();
		String attDate = attendanceVO.getAttDate();
		String lecNo = attendanceVO.getLecNo();
		for(String att : attArr) {
			String comDetANo = att.split("_")[0];
			String stuNo = att.split("_")[1];
			String attEtc = "";
			if(att.length() != 11) attEtc = att.split("_")[2];
			AttendanceVO tempAtt = new AttendanceVO();
			tempAtt.setStuNo(stuNo);
			tempAtt.setAttDate(attDate);
			tempAtt.setAttEtc(attEtc);
			if(comDetANo.equals("1")) tempAtt.setComDetANo("A0101");
			else if(comDetANo.equals("2")) tempAtt.setComDetANo("A0103");
			else if(comDetANo.equals("3")) tempAtt.setComDetANo("A0102");
			tempAtt.setLecNo(lecNo);
			int cnt = attMapper.checkAttData(tempAtt);
			if(cnt != 0) {
				attMapper.updateAttendance(tempAtt);
			} else {
				attMapper.insertAttendance(tempAtt);
			}
		}
	}

}























