package kr.or.ddit.service.student.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.ILicenseMapper;
import kr.or.ddit.service.student.inter.IStuLicenseService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LicenseVO;
import kr.or.ddit.vo.ScholarshipVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StuLicenseServiceImpl implements IStuLicenseService {

	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private ILicenseMapper licenseMapper;

	@Inject
	private IFileMapper fileMapper;

	
	// 자격증 등록
    @Override
    public boolean insertLicense(LicenseVO licenseVO) {
        int result = licenseMapper.insertLicense(licenseVO);
        if (result < 0) {
            return false;
        } else {
            List<FileVO> licFileList = licenseVO.getLicFileList();
            try {
                //String currentDate = new SimpleDateFormat("yyyy/MM/dd").format(new Date());

                String fileGroupNo = licFileUpload(licFileList);
                licenseVO.setFileGroupNo(fileGroupNo);
         
                licenseMapper.insertFileGroupNoToLicense(licenseVO);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    // 자격증 파일 첨부
    private String licFileUpload(List<FileVO> licFileList) throws Exception {
        if (licFileList != null) { // 넘겨받은 파일 데이터가 존재할 때
            String fileGroupNo = fileMapper.getFileGroupNo(); // 파일 그룹번호 시퀀스값 가져오기
            
            if (licFileList.size() > 0) {
                for (int i = 0; i < licFileList.size(); i++) {
                    FileVO fileVO = licFileList.get(i);
                    // 파일명을 설정할 때 원본 파일명은 공백을 '_' 로 변경한다.
                    String saveName = UUID.randomUUID().toString(); // UUID의 랜덤 파일명의 생성
                    saveName = saveName + "_" + fileVO.getFileName().replaceAll(" ", "_");
                    String savePath = uploadPath + "/license/" + fileGroupNo;
                    File file = new File(savePath);
                    if (!file.exists()) {
                        file.mkdirs();
                    }

                    // 파일 복사를 하기 위한 최종 경로
                    String saveLocate = savePath + "/" + saveName;

                    fileVO.setFileGroupNo(fileGroupNo);
                    fileVO.setFileNo(i + 1);
                    fileVO.setFileSaveName(saveName);
                    fileVO.setFileSavepath(saveLocate);
                    fileMapper.insertLicFile(fileVO); // 파일 데이터를 DB에 저장

                    // 파일 복사를 하기 위한 target
                    File saveFile = new File(saveLocate);
                    fileVO.getItem().transferTo(saveFile); // 파일 복사
                }
            }

            return fileGroupNo;
        }

        return null;
    }

    @Override
    public List<LicenseVO> myLicenseList(String stuNo) {
        return licenseMapper.myLicenseList(stuNo);
    }

    // 자격증 상세보기
	@Override
	public LicenseVO licenseDetail(String licNo) {
		return licenseMapper.licenseDetail(licNo);
	}

	// 내가 신청한 자격증 삭제
	@Override
	public int licenseDelete(String licNo) {
		return licenseMapper.licenseDelete(licNo);
	}

	// 내가 신청한 자격증 수정
	@Override
	public int licenseUpdate(LicenseVO licenseVO) {
		int cnt = licenseMapper.licenseUpdate(licenseVO);
		
		if(cnt < 0) {
			return cnt;
		} else {
			List<FileVO> licFileList = licenseVO.getLicFileList();
			if(licFileList != null) {
				try {
					FileVO fileVO = new FileVO();
					fileVO.setFileGroupNo(licenseVO.getFileGroupNo());
					String savePath = uploadPath + "/license/" + licenseVO.getFileGroupNo();
					File file = new File(savePath);
					
					if( file.exists() ){ //파일존재여부확인
			    		
			    		if(file.isDirectory()){ //파일이 디렉토리인지 확인
			    			
			    			File[] files = file.listFiles();
			    			
			    			for( int i=0; i<files.length; i++){
			    				if( files[i].delete() ){
			    					log.info(files[i].getName()+" 삭제성공");
			    				}else{
			    					log.info(files[i].getName()+" 삭제실패");
			    				}
			    			}
			    			
			    		}
			    		if(file.delete()){
			    			log.info("파일삭제 성공");
			    		}else{
			    			log.info("파일삭제 실패");
			    		}
			    		
			    	}else{
			    		log.info("파일이 존재하지 않습니다.");
			    	}			
			
					// 새로 업데이트 할 시에 원래 있던 내 파일 하나가 사라질것이다.
					// DB에도 지워주자
					fileMapper.deleteFile(fileVO);
					
					String fileGroupNo = licFileUpload(licFileList);
					licenseVO.setFileGroupNo(fileGroupNo);
					licenseMapper.insertFileGroupNoToLicense(licenseVO);
				} catch (Exception e) {
					e.printStackTrace();				
				}
			}
		}

	return cnt;

	}

}
