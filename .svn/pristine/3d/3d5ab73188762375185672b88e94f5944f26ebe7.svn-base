package kr.or.ddit.service.professor.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.ILectureDataMapper;
import kr.or.ddit.mapper.IProfessorMapper;
import kr.or.ddit.service.professor.inter.IProLectureService;
import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.CourseVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.LectureNoticeVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProLectureServiceImpl implements IProLectureService {
	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private IProfessorMapper professorMapper;

	@Inject
	private ILectureDataMapper lectureDataMapper;
	
	@Inject
	private IFileMapper fileMapper;

	@Override
	public List<LectureVO> lectureList(String userNo) {

		return professorMapper.lectureList(userNo);
	}

	@Override
	public List<LectureNoticeVO> selectLectureNotice(String lecNo) {
		// TODO Auto-generated method stub
		return professorMapper.selectLectureNotice(lecNo);
	}

	@Override
	public List<AssignmentVO> selectAssignment(String lecNo) {
		// TODO Auto-generated method stub
		return professorMapper.selectAssignment(lecNo);
	}

	@Override
	public List<ExamVO> selectExam(String lecNo) {
		// TODO Auto-generated method stub
		return professorMapper.selectExam(lecNo);
	}

	@Override
	public LectureVO selectLecture(String lecNo) {
		// TODO Auto-generated method stub
		return professorMapper.selectLecture(lecNo);
	}

	@Override
	public int selectAssignmentCount(PaginationInfoVO<AssignmentVO> pagingVO) {
		// TODO Auto-generated method stub
		return professorMapper.selectAssignmentCount(pagingVO);
	}

	@Override
	public List<AssignmentVO> selectAssignmentList(PaginationInfoVO<AssignmentVO> pagingVO) {
		// TODO Auto-generated method stub
		return professorMapper.selectAssignmentList(pagingVO);
	}

	@Override
	public AssignmentVO selectAssignmentDetail(String assNo) {
		// TODO Auto-generated method stub
		return professorMapper.selectAssignmentDetail(assNo);
	}

	@Override
	public int selectAssignmentSubmitCount(PaginationInfoVO<AssignmentSubmitVO> pagingVO) {
		// TODO Auto-generated method stub
		return professorMapper.selectAssignmentSubmitCount(pagingVO);
	}

	@Override
	public List<AssignmentSubmitVO> selectAssignmentSubmitList(PaginationInfoVO<AssignmentSubmitVO> pagingVO) {
		// TODO Auto-generated method stub
		return professorMapper.selectAssignmentSubmitList(pagingVO);
	}

	@Override
	public int selectStudentCount(PaginationInfoVO<CourseVO> pagingVO) {
		// TODO Auto-generated method stub
		return professorMapper.selectStudentCount(pagingVO);
	}

	@Override
	public List<CourseVO> selectStudentList(PaginationInfoVO<CourseVO> pagingVO) {
		// TODO Auto-generated method stub
		return professorMapper.selectStudentList(pagingVO);
	}

	@Override
	public List<AssignmentSubmitVO> selectASList(String assNo) {
		// TODO Auto-generated method stub
		return professorMapper.selectASList(assNo);
	}

	@Override
	public List<AssignmentSubmitVO> selStuAss(Map<String, String> skMap) {
		
		return professorMapper.selStuAss(skMap);
	}

	@Override
	public ServiceResult insertAssignment(HttpServletRequest req, AssignmentVO assignmentVO) {
		ServiceResult result = null;

		int status = professorMapper.insertAssignment(assignmentVO);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult updateAssignment(HttpServletRequest req, AssignmentVO assignmentVO) {
		ServiceResult result = null;
		int status = professorMapper.updateAssignment(assignmentVO);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public ServiceResult deleteAssignment(HttpServletRequest req, String assNo) {
		ServiceResult result = null;
		int status = professorMapper.deleteAssignment(assNo);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 강의 자료실
	@Override
	public List<LectureDataVO> selectLectureDataList(PaginationInfoVO<LectureDataVO> pagingVO) {
		// TODO Auto-generated method stub
		return lectureDataMapper.selectLectureDataList(pagingVO);
	}

	@Override
	public int selectLectureDataCount(PaginationInfoVO<LectureDataVO> pagingVO) {
		// TODO Auto-generated method stub
		return lectureDataMapper.selectLectureDataCount(pagingVO);
	}

	@Override
	public ServiceResult insertLectureData(HttpServletRequest req, LectureDataVO lectureDataVO) {
		ServiceResult result = null;

		List<FileVO> fileList = lectureDataVO.getLecFileList();
		try {
			lectureDataFileUpload(fileList, lectureDataVO, req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int status = lectureDataMapper.insertLectureData(lectureDataVO);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}
	
	private void lectureDataFileUpload(List<FileVO> fileList,LectureDataVO lectureDataVO, HttpServletRequest req) throws Exception {
		 //String savePath = "/resources/lectureData/";
		
		
		if (fileList != null) { // 파일데이터 존재할때
			String fileGroupNo = fileMapper.getFileGroupNo();
			String lecDataNo = "";
			if(lectureDataVO.getLecDataNo() != null) { // update 할때  번호가 바뀌는 문제가 있음.
				lecDataNo = lectureDataVO.getLecDataNo();
			}else {
				lecDataNo = lectureDataMapper.getLecDataNo();
			}
			lectureDataVO.setLecDataNo(lecDataNo);
			lectureDataVO.setFileGroupNo(fileGroupNo);
			

			String saveLocate = uploadPath + "/lectureData/" +  lecDataNo;
			File file = new File(saveLocate);
			if (!file.exists()) {
				file.mkdirs();
			}
			
			if (fileList.size() >0) {
				for (int i = 0 ; i<fileList.size(); i++) {
					String saveLocate2 = saveLocate;
					FileVO fileVO = fileList.get(i);
					String saveName = UUID.randomUUID().toString(); // UUID 랜덤 파일명 생성
					saveName = saveName+"_"+fileVO.getFileName().replaceAll(" ", "_");
					
					// 파일 복사 최종경로 
					saveLocate2 += "/"+ saveName;
					fileVO.setFileGroupNo(fileGroupNo);
					fileVO.setFileNo(i+1);
					fileVO.setFileSaveName(saveName);
					fileVO.setFileSavepath(saveLocate2);
					fileMapper.insertLecFile(fileVO);
					
					// 파일 복사를 하기 위한 target
					File saveFile = new File(saveLocate2);
					fileVO.getItem().transferTo(saveFile);
					
				}
			}
		}
		
	}

	@Override
	public LectureDataVO selectLectureDataDetail(String lecDataNo) {
		
		return lectureDataMapper.selectLectureDataDetail(lecDataNo);
	}

	@Override
	public ServiceResult deleteLectureData(HttpServletRequest req, String lecDataNo) {
		ServiceResult result = null;
		// 1.삭제할 파일의 그룹번호를 얻어온다
		String fileGroupNo = lectureDataMapper.selectFileGroupNo(lecDataNo);
		// 2.파일 그룹번호를 이용해 fileList 를 얻어온다.
		List<FileVO> fileList = selectFileList(fileGroupNo);
		// 3.파일 리스트 사이즈 만큼  저장경로에 저장된 실제 파일을 삭제한다. 
		for (int i = 0; i < fileList.size(); i++) {
			File file = new File(fileList.get(i).getFileSavepath());
			file.delete();	// 파일 삭제
		}
		// 4.해당 파일들이 저장된 폴더를 삭제한다.
		File delFolder = new File(uploadPath + "/lectureData/" + lecDataNo);
		delFolder.delete();
		// 5. db에 저장된 파일 정보를 삭제 한다.
		lectureDataMapper.deleteFile(fileGroupNo); // 파일 삭제
		// 6. 강의 자료실 테이블에 있는 정보를 삭제한다. 
		int status = lectureDataMapper.deleteLectureData(lecDataNo);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<FileVO> selectFileList(String fileGroupNo) {
		
		return lectureDataMapper.selectFileList(fileGroupNo);
	}

	@Override
	public ServiceResult updateLectureData(HttpServletRequest req, LectureDataVO lectureDataVO) {
		
		//String skLecDataNo =lectureDataVO.getLecDataNo();   // 임시로 가지고 있음; if문 쓰기 싫어성
		
		ServiceResult result = null;
	
		//log.debug("체킁 뽀인또 2 {}",lectureDataVO.getLecDataNo());
		
		
//		List<FileVO> fileList = lectureDataVO.getLecFileList();
		List<FileVO> fileList = null;
		
		log.debug("파일체크 {}", fileList);
		String delNoticeNo = lectureDataVO.getFileGroupNo();
		
		if(delNoticeNo != null) {
			fileList = lectureDataMapper.selectFileList(delNoticeNo);
			log.debug("파일체크2{}", fileList);
			
			for (int i = 0; i < fileList.size(); i++) {
				File file = new File(fileList.get(i).getFileSavepath());
				file.delete();	// 파일 삭제
			}
			
			// 폴더 삭제 해주는 로직
//			File delFolder = new File("C:/SVN/documents/file" + "/" + lectureDataVO.getLecDataNo());
//			delFolder.delete();
			
			lectureDataMapper.deleteFile(delNoticeNo); // db에서 해당 그룹번호에 해당하는 파일을 삭제
			lectureDataVO.setFileGroupNo(null);
		}
		
		try {
			fileList = lectureDataVO.getLecFileList();
			lectureDataFileUpload(fileList, lectureDataVO, req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//lectureDataVO.setLecDataNo(skLecDataNo);  // 쪼메 치사한 방법!
		log.debug("체킁 뽀인또 3 {}",lectureDataVO);		
		int status = lectureDataMapper.updateLectureData(lectureDataVO);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int updateAssignmentScore(AssignmentSubmitVO assignmentSubmitVO) {
		// TODO Auto-generated method stub
		return professorMapper.updateAssignmentScore(assignmentSubmitVO);
	}

}
