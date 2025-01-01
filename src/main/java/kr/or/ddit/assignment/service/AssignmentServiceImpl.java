package kr.or.ddit.assignment.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAssignmentMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.ILectureDataMapper;
import kr.or.ddit.mapper.IProfessorMapper;
import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AssignmentServiceImpl implements IAssignmentService {

	@Resource(name = "uploadFolder")
	private String uploadPath;

	@Inject
	private IFileMapper fileMapper;

	@Inject
	private IAssignmentMapper mapper;

	@Override
	public int selectAssignmentCount(PaginationInfoVO<AssignmentVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.selectAssignmentCount(pagingVO);
	}

	@Override
	public List<AssignmentVO> selectAssignmentList(PaginationInfoVO<AssignmentVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.selectAssignmentList(pagingVO);
	}

	@Override
	public AssignmentVO selectAssignmentDetail(String assNo) {
		// TODO Auto-generated method stub
		return mapper.selectAssignmentDetail(assNo);
	}

	// 과제 제출 - 파일
	@Override
	public int insertAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO) {
		List<FileVO> fileList = assignmentSubmitVO.getAssFileList();
		String fileGroupNo = "";
		try {
			fileGroupNo = fileUpload(fileList, assignmentSubmitVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		assignmentSubmitVO.setFileGroupNo(fileGroupNo);
		log.info("fileGroupNo :::::" + fileGroupNo);
		return mapper.insertAssignmentSubmit(assignmentSubmitVO);
	}

	// 파일 인서트 매서드
	private String fileUpload(List<FileVO> fileList, AssignmentSubmitVO assignmentSubmitVO) throws Exception {
		String fileGroupNo = "";
		if (fileList != null) {
			// 1. 파일 그룹 번호와 과제 번호 미리 가져와줌
			fileGroupNo = fileMapper.getFileGroupNo();
			String assSubNo = mapper.getAssSubNo();

			// 2. 저장해줌
			assignmentSubmitVO.setAssSubNo(assSubNo);
			assignmentSubmitVO.setFileGroupNo(fileGroupNo);
			// 3. 파일 저장 시작
			String saveLocate = uploadPath + "/assignment/" + assSubNo;
			File file = new File(saveLocate);
			if (!file.exists()) {
				file.mkdirs();
			}
			if (fileList.size() > 0) {
				for (int i = 0; i < fileList.size(); i++) {
					String saveLocate2 = saveLocate;
					FileVO fileVO = fileList.get(i);
					String saveName = UUID.randomUUID().toString(); // UUID 랜덤 파일명 생성
					saveName = saveName + "_" + fileVO.getFileName().replaceAll(" ", "_");

					// 파일 복사 최종경로
					saveLocate2 += "/" + saveName;
					fileVO.setFileGroupNo(fileGroupNo);
					log.info("파일 그룹번호 확인용 {}",fileGroupNo);
					fileVO.setFileNo(i + 1);
					fileVO.setFileSaveName(saveName);
					fileVO.setFileSavepath(saveLocate2);
					// db 저장
					fileMapper.insertLecFile(fileVO);

					// 파일 복사를 하기 위한 target
					File saveFile = new File(saveLocate2);
					fileVO.getItem().transferTo(saveFile);

				}
			}

		}
		return fileGroupNo;
	}

	@Override
	public AssignmentSubmitVO selectAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO) {
		// TODO Auto-generated method stub
		return mapper.selectAssignmentSubmit(assignmentSubmitVO);
	}

	// 과제 수정
	@Override
	public int updateAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO) {
		List<FileVO> fileList = assignmentSubmitVO.getAssFileList();
		// 삭제 로직 변경
//		String delNoticeNo = assignmentSubmitVO.getFileGroupNo();
//		if (delNoticeNo != null) {
//			fileList = mapper.selectFileList(delNoticeNo);
//			log.debug("파일체크2{}", fileList);
//			
//			for (int i = 0; i < fileList.size(); i++) {
//				File file = new File(fileList.get(i).getFileSavepath());
//				file.delete();	// 파일 삭제
//			}
//			
//			mapper.deleteFile(delNoticeNo); // db에서 해당 그룹번호에 해당하는 파일을 삭제
//			assignmentSubmitVO.setFileGroupNo(null);
//		}

		// jsp 에서 넘겨준 삭제할 파일 번호
		String[] delFileNo = assignmentSubmitVO.getDelFileNo();
		log.debug("삭제 파일체크 {}", delFileNo);
		// 수정할 파일의 그룹 번호
		String fileGroupNo = assignmentSubmitVO.getFileGroupNo();
		log.debug("삭제 fileGroupNo : {}", fileGroupNo);

		if (delFileNo.length > 0) {
			for (int i = 0; i < delFileNo.length; i++) {
				fileList = mapper.selectDelFileList(fileGroupNo, delFileNo[i]);
				File file = new File(fileList.get(i).getFileSavepath());
				file.delete(); // 파일 삭제

				// db에 저장된 파일 정보를 삭제 한다.
				mapper.deleteFile(fileGroupNo, delFileNo[i]);
			}
		}

		log.debug("확인 !!! assignmentSubmitVO : {}", assignmentSubmitVO);
		assignmentSubmitVO.setFileGroupNo(fileGroupNo);

		fileList = assignmentSubmitVO.getAssFileList();
		if (fileList != null) {
			try {
				updateFile(fileList, assignmentSubmitVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		log.debug("updateFile 에서 리턴 : {}", fileGroupNo);
		log.debug("update할 assignmentSubmitVO: {}", assignmentSubmitVO);

		return mapper.updateAssignmentSubmit(assignmentSubmitVO);
	}

	// 파일 업데이트
	private String updateFile(List<FileVO> fileList, AssignmentSubmitVO assignmentSubmitVO) throws Exception {
		String fileGroupNo = assignmentSubmitVO.getFileGroupNo();
		String assSubNo = assignmentSubmitVO.getAssSubNo();
		String saveLocate = uploadPath + "/assignment/" + assSubNo;
		File file = new File(saveLocate);
		if (!file.exists()) {
			file.mkdirs();
		}
		if (fileList.size() > 0) {
			for (int i = 0; i < fileList.size(); i++) {
				String saveLocate2 = saveLocate;
				FileVO fileVO = fileList.get(i);
				String saveName = UUID.randomUUID().toString(); // UUID 랜덤 파일명 생성
				saveName = saveName + "_" + fileVO.getFileName().replaceAll(" ", "_");

				// 파일 복사 최종경로
				saveLocate2 += "/" + saveName;
				fileVO.setFileGroupNo(fileGroupNo);
				fileVO.setFileNo(i + 1);
				fileVO.setFileSaveName(saveName);
				fileVO.setFileSavepath(saveLocate2);
				fileMapper.insertLecFile(fileVO);

				// 파일 복사를 하기 위한 target
				File saveFile = new File(saveLocate2);
				fileVO.getItem().transferTo(saveFile);

			}
		}

		return fileGroupNo;

	}

	@Override
	public List<FileVO> selectFileList(String fileGroupNo) {
		// TODO Auto-generated method stub
		return mapper.selectFileList(fileGroupNo);
	}

	@Override
	public int countSubmit(Map<String, String> subMap) {
		// TODO Auto-generated method stub
		return mapper.countSubmit(subMap);
	}

}
