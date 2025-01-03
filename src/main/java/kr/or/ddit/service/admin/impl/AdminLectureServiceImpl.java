package kr.or.ddit.service.admin.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAdminLectureMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.admin.inter.IAdminLectureService;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureTimetableVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.YearSemesterVO;

@Service
public class AdminLectureServiceImpl implements IAdminLectureService {
	
	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private IAdminLectureMapper lecMapper;
	
	@Inject
	private IFileMapper fileMapper;

	@Override
	public int selectLectureCount(PaginationInfoVO<LectureVO> pagingVO) {
		return lecMapper.selectLectureCount(pagingVO);
	}

	@Override
	public List<LectureVO> getLectureList(PaginationInfoVO<LectureVO> pagingVO) {
		return lecMapper.getLectureList(pagingVO);
	}

	@Override
	public boolean insertLecture(LectureVO lectureVO) {
		int result = lecMapper.insertLecture(lectureVO);
		if(result < 0) {
			return false;
		} else {
			List<FileVO> lecFileList = lectureVO.getLecFileList();
			
			try {
				String fileGroupNo = lecFileUpload(lecFileList);
				lectureVO.setFileGroupNo(fileGroupNo);
				lecMapper.insertFileGroupNoToLecture(lectureVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	private String lecFileUpload(List<FileVO> lecFileList) throws Exception {
		
		if(lecFileList != null) {	// 넘겨받은 파일 데이터가 존재할 때
			
			String fileGroupNo = fileMapper.getFileGroupNo();
			
			if(lecFileList.size() > 0) {
				for(int i=0;i<lecFileList.size();i++) {
					FileVO fileVO = lecFileList.get(i);
					// 파일명을 설정할 때 원본 파일명은 공백을 '_' 로 변경한다.
					String saveName = UUID.randomUUID().toString();	// UUID의 랜덤 파일명의 생성
					saveName = saveName + "_" + fileVO.getFileName().replaceAll(" ", "_");
					String savePath = uploadPath + "/lecture/" + fileGroupNo;
					File file = new File(savePath);
					if(!file.exists()) {
						file.mkdirs();
					}
					
					// 파일 복사를 하기 위한 최종 경로
					String saveLocate = savePath + "/" + saveName;
					
					fileVO.setFileGroupNo(fileGroupNo);
					fileVO.setFileNo(i+1);
					fileVO.setFileSaveName(saveName);
					fileVO.setFileSavepath(saveLocate);
					fileMapper.insertLecFile(fileVO);	// 파일 데이터를 DB에 저장
					
					// 파일 복사를 하기 위한 target
					File saveFile = new File(saveLocate);
					fileVO.getItem().transferTo(saveFile); 	// 파일 복사
				}
			}
			
			return fileGroupNo;
		}
		
		return null;
	}

	@Override
	public void insertLectureTime(LectureVO lectureVO) {
		String[] lectureTimes = lectureVO.getLectureTimes();
		if(lectureTimes == null) return;
		Map<String, String> map = new HashMap<String, String>();
		map.put("lecNo", lectureVO.getLecNo());
		for(String s : lectureTimes) {
			String time = s.substring(5).replace("_", ":");
			map.put("day", s.substring(0,5));
			map.put("time", time);
			lecMapper.insertLectureTime(map);
		}
	}

	@Override
	public List<LectureTimetableVO> getLectureTimeList(LectureVO lectureVO) {
		return lecMapper.getLectureTimeList(lectureVO);
	}

	@Override
	public LectureVO getLectureByLecNo(String lecNo) {
		return lecMapper.getLectureByLecNo(lecNo);
	}

	@Override
	public List<LectureTimetableVO> getLectureTime(String lecNo) {
		return lecMapper.getLectureTime(lecNo);
	}

	@Override
	public void lectureConfirm(String lecNo) {
		lecMapper.lectureConfirm(lecNo);
	}

	@Override
	public void lectureReject(Map<String, String> reject) {
		lecMapper.lectureReject(reject);
	}

	@Override
	public void lectureUnConfirm(String lecNo) {
		lecMapper.lectureUnConfirm(lecNo);
	}

	@Override
	public void updateLecture(LectureVO lectureVO) {
		int result = lecMapper.updateLecture(lectureVO);
		if(result < 0) {
			return;
		} else {
			if(lectureVO.getLecFileList().size() == 0) return;
			List<FileVO> lecFileList = lectureVO.getLecFileList();
			
			try {
				String fileGroupNo = lecFileUpload(lecFileList);
				lectureVO.setFileGroupNo(fileGroupNo);
				lecMapper.insertFileGroupNoToLecture(lectureVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return;
	}

	@Override
	public void updateLectureTime(LectureVO lectureVO) {
		lecMapper.deleteLectureTime(lectureVO);
		insertLectureTime(lectureVO);
	}

	@Override
	public int selectCourseCount(PaginationInfoVO<LectureVO> pagingVO) {
		return lecMapper.selectCourseCount(pagingVO);
	}

	@Override
	public List<LectureVO> getCourseList(PaginationInfoVO<LectureVO> pagingVO) {
		List<LectureVO> courseList = lecMapper.getCourseList(pagingVO);
		if(courseList == null) return null;
		for(LectureVO l : courseList) {
			List<LectureTimetableVO> lecTimes = lecMapper.getLectureTime(l.getLecNo());
			String[] strArr = new String[lecTimes.size()];
			for(int i=0;i<strArr.length;i++) {
				strArr[i] = lecTimes.get(i).getComDetWNo() + lecTimes.get(i).getComDetTName();
			}
			l.setLectureTimes(strArr);
		}
		return courseList;
	}

	@Override
	public List<LectureVO> getMyCourseCartList(PaginationInfoVO<LectureVO> pagingVO) {
		List<LectureVO> courseList = lecMapper.getMyCourseCartList(pagingVO);
		if(courseList == null) return null;
		for(LectureVO l : courseList) {
			List<LectureTimetableVO> lecTimes = lecMapper.getLectureTime(l.getLecNo());
			String[] strArr = new String[lecTimes.size()];
			for(int i=0;i<strArr.length;i++) {
				strArr[i] = lecTimes.get(i).getComDetWNo() + lecTimes.get(i).getComDetTName();
			}
			l.setLectureTimes(strArr);
		}
		return courseList;
	}

	@Override
	public void reserveCourseCart(CourseVO courseVO) {
		lecMapper.reserveCourseCart(courseVO);
	}
	
	@Override
	public void cancelCourseCart(CourseVO courseVO) {
		lecMapper.cancelCourseCart(courseVO);
	}

	@Override
	public void lectureDelete(String lecNo) {
		lecMapper.lectureDelete(lecNo);
	}

	@Override
	public List<LectureVO> getMyCourseList(PaginationInfoVO<LectureVO> pagingVO) {
		List<LectureVO> courseList = lecMapper.getMyCourseList(pagingVO);
		if(courseList == null) return null;
		for(LectureVO l : courseList) {
			List<LectureTimetableVO> lecTimes = lecMapper.getLectureTime(l.getLecNo());
			String[] strArr = new String[lecTimes.size()];
			for(int i=0;i<strArr.length;i++) {
				strArr[i] = lecTimes.get(i).getComDetWNo() + lecTimes.get(i).getComDetTName();
			}
			l.setLectureTimes(strArr);
		}
		return courseList;
	}

	@Override
	public void cancelCourse(CourseVO courseVO) {
		lecMapper.cancelCourse(courseVO);
	}

	@Override
	public int selectProLectureCount(PaginationInfoVO<LectureVO> pagingVO) {
		return lecMapper.selectProLectureCount(pagingVO);
	}

	@Override
	public List<LectureVO> getProLectureList(PaginationInfoVO<LectureVO> pagingVO) {
		return lecMapper.getProLectureList(pagingVO);
	}
	
	@Override
	public List<LectureVO> getProLectureListByProVO(ProfessorVO proVO) {
		return lecMapper.getProLectureListByProVO(proVO);
	}

	@Override
	public List<String> getYearList() {
		return lecMapper.getYearList();
	}

	@Override
	public List<LectureTimetableVO> getProfessorTimeList(LectureVO lectureVO) {
		return lecMapper.getProfessorTimeList(lectureVO);
	}

	@Override
	public List<LectureTimetableVO> getMyLecTimeList(StudentVO stuVO) {
		return lecMapper.getMyLecTimeList(stuVO);
	}
	
	@Override
	public List<LectureTimetableVO> getProLecTimeList(String proNo) {
		return lecMapper.getProLecTimeList(proNo);
	}
	

}























