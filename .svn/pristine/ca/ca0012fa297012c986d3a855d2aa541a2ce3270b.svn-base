package kr.or.ddit.service.student.impl;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.IStuScholarshipMapper;
import kr.or.ddit.service.student.inter.IStuScholarshipService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.ScholarshipVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StuScholarshipServiceImpl implements IStuScholarshipService {


	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private IStuScholarshipMapper scholarshipMapper;
	
	@Inject
	private IFileMapper fileMapper;

	
	// 장학 종류 조회
	@Override
	public List<ScholarshipVO> scholarshipList() {
		return scholarshipMapper.scholarshipList();
	}

	// 장학 종류 상세보기
	@Override
	public List<ScholarshipVO> scholarshipDetail(String schNo) {
		return scholarshipMapper.scholarshipDetail(schNo);
	}

	// 선차감 목록 조회
	@Override
	public Collection<ScholarshipVO> preScholarshipList() {
		return scholarshipMapper.preScholarshipList();
	}

	// 후지급 목록 조회
	@Override
	public Collection<ScholarshipVO> postScholarshipList() {
		return scholarshipMapper.postScholarshipList();
	}

	// 내가 수혜받은 장학 내역 조회
	@Override
	public List<ScholarshipVO> myScholarshipList(String stuNo) {
		return scholarshipMapper.myScholarshipList(stuNo);
	}

	// 승인 목록 조회
	@Override
	public List<ScholarshipVO> approvedList(String stuNo) {
		return scholarshipMapper.approvedList(stuNo);
	}

	// 미승인 목록 조회
	@Override
	public List<ScholarshipVO> unApprovedList(String stuNo) {
		return scholarshipMapper.unApprovedList(stuNo);
	}

	// 반려 목록 조회
	@Override
	public List<ScholarshipVO> rejectedList(String stuNo) {
		return scholarshipMapper.rejectedList(stuNo);
	}

	// 장학금 신청
	@Override
	public boolean insertScholarshipRequest(ScholarshipVO scholarshipVO) {
	    int result = scholarshipMapper.insertScholarshipRequest(scholarshipVO);
	    if (result < 0) {
	        return false;
	    } else {
	        List<FileVO> schFileList = scholarshipVO.getSchFileList();
	        try {
	            String fileGroupNo = schFileUpload(schFileList);
	            if (fileGroupNo != null) {
	                scholarshipVO.setFileGroupNo(fileGroupNo);
	                log.info("파일 그룹 번호 설정: " + fileGroupNo); // 디버깅 로그 추가
	                log.info("장학금 수혜 번호: " + scholarshipVO.getSchRecNo()); // 디버깅 로그 추가
	                scholarshipMapper.insertFileGroupNoToScholarship(scholarshipVO);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    return true;
	}

	// 장학금 파일 첨부
	private String schFileUpload(List<FileVO> schFileList) throws Exception {
	    if (schFileList != null && !schFileList.isEmpty()) {
	        String fileGroupNo = fileMapper.getFileGroupNo();
	        log.info("생성된 파일 그룹 번호: " + fileGroupNo); // 디버깅 로그 추가
	        for (int i = 0; i < schFileList.size(); i++) {
	            FileVO fileVO = schFileList.get(i);
	            String saveName = UUID.randomUUID().toString() + "_" + fileVO.getFileName().replaceAll(" ", "_");
	            String savePath = uploadPath + "/scholarship/" + fileGroupNo;
	            File file = new File(savePath);
	            if (!file.exists()) {
	                file.mkdirs();
	            }
	            String saveLocate = savePath + "/" + saveName;
	            fileVO.setFileGroupNo(fileGroupNo);
	            fileVO.setFileNo(i + 1);
	            fileVO.setFileSaveName(saveName);
	            fileVO.setFileSavepath(saveLocate);
	            fileMapper.insertSchFile(fileVO);
	            File saveFile = new File(saveLocate);
	            fileVO.getItem().transferTo(saveFile);
	        }
	        return fileGroupNo;
	    }
	    return null;
	}


    // 장학금 상세보기
    @Override
    public ScholarshipVO myRequestDetail(String schRecNo) {
        return scholarshipMapper.myRequestDetail(schRecNo);
    }

	// 장학금 신청시 장학금번호로 장학금명 끌어오기
	@Override
	public ScholarshipVO getScholarshipByNo(String schNo) {
		return scholarshipMapper.getScholarshipByNo(schNo);
	}

	@Override
	public List<ScholarshipVO> getStuTuitionScholarShipList(String stuNo) {
		return scholarshipMapper.getStuTuitionScholarShipList(stuNo);
	}

	// 장학금 신청 내역 수정
	@Override
	public int scholarshipRequestUpdate(ScholarshipVO scholarshipVO) {
	    int cnt = scholarshipMapper.scholarshipRequestUpdate(scholarshipVO);

	    if (cnt < 0) {
	        return cnt;
	    } else {
	        List<FileVO> schFileList = scholarshipVO.getSchFileList();
	        if (schFileList != null && !schFileList.isEmpty()) {
	            try {
	                if (scholarshipVO.getFileGroupNo() == null) {
	                    // 파일 그룹 번호가 null인 경우 생성
	                    scholarshipVO.setFileGroupNo(fileMapper.getFileGroupNo());
	                }
	                FileVO fileVO = new FileVO();
	                fileVO.setFileGroupNo(scholarshipVO.getFileGroupNo());
	                String savePath = uploadPath + "/scholarship/" + scholarshipVO.getFileGroupNo();
	                File file = new File(savePath);

	                // 디렉토리와 파일 삭제 로직
	                if (file.exists()) {
	                    if (file.isDirectory()) {
	                        File[] files = file.listFiles();
	                        for (File f : files) {
	                            if (f.delete()) {
	                                log.info(f.getName() + " 삭제성공");
	                            } else {
	                                log.info(f.getName() + " 삭제실패");
	                            }
	                        }
	                    }
	                    if (file.delete()) {
	                        log.info("파일삭제 성공");
	                    } else {
	                        log.info("파일삭제 실패");
	                    }
	                } else {
	                    log.info("파일이 존재하지 않습니다.");
	                }

	                // DB에서도 파일 삭제
	                fileMapper.deleteFile(fileVO);

	                // 새 파일 업로드
	                String fileGroupNo = schFileUpload(schFileList);
	                scholarshipVO.setFileGroupNo(fileGroupNo);
	                scholarshipMapper.insertFileGroupNoToScholarship(scholarshipVO);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return cnt;
	}


	// 장학금 신청 내역 삭제
	@Override
	public int scholarshipRequestDelete(String schRecNo) {
		return scholarshipMapper.scholarshipRequestDelete(schRecNo);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
