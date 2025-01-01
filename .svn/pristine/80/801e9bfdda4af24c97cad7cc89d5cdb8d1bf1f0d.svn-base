package kr.or.ddit.service.student.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.VolunteerMapper;
import kr.or.ddit.service.student.inter.StudentVolunteerService;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentVolunteerServiceImpl implements StudentVolunteerService {

	@Inject	
	private VolunteerMapper mapper;
	
	// 학생이 파일을 등록하기 위한 업로드 패스 우리는 svn에 documnet안에 공유한다.
	@Resource(name="uploadFolder")
	private String uploadPath;
	
	// file처리를 위한 mapper
	@Inject
	private IFileMapper fileMapper;
	
	@Override
	public List<VolunteerVO> selectVolunteer(String stuNo) {
		
		return mapper.selectVolunteer(stuNo);
	}

	// 파일처리
	@Override
	public int insertVolunteeR(VolunteerVO volunteerVO) {
		int cnt = mapper.insertVolunteer(volunteerVO);
				
		if(cnt < 0) {
			return cnt;
		} else {
			List<FileVO> lecFileList = volunteerVO.getLecFileList();			
			// 만약 파일을 등록하지 않았더라도 등록처리를 완료하기 위해
			if(lecFileList != null) {
				
				try {				
					String fileGroupNo = lecFileUpload(lecFileList);
					volunteerVO.setFileGroupNo(fileGroupNo);
					mapper.insertFileGroupNo(volunteerVO);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			
		}
		
		return cnt;
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
					String savePath = uploadPath + "/volunteer/" + fileGroupNo;
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
	public int updateVolunteer(VolunteerVO volunteerVO) {
		int cnt = mapper.updateVolunteer(volunteerVO);
		
		if(cnt < 0) {
			return cnt;
		} else {
			List<FileVO> lecFileList = volunteerVO.getLecFileList();
			if(lecFileList != null) {
				try {
					FileVO fileVO = new FileVO();
					fileVO.setFileGroupNo(volunteerVO.getFileGroupNo());
					String savePath = uploadPath + "/volunteer/" + volunteerVO.getFileGroupNo();
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
					
					String fileGroupNo = lecFileUpload(lecFileList);
					volunteerVO.setFileGroupNo(fileGroupNo);
					mapper.insertFileGroupNo(volunteerVO);
				} catch (Exception e) {
					e.printStackTrace();				
				}
			}
		}

	return cnt;

	}

	@Override
	public int deleteVolunteer(String volNo) {
		
		return mapper.deleteVolunteer(volNo);
	}

	@Override
	public VolunteerVO detailVolunteer(String volNo) {
		return mapper.stuDetailVolunteer(volNo);
	}

	@Override
	public List<FileVO> getFileByFileGroupNo(String fileGroupNo) {
		
		return fileMapper.getFileByFileGroupNo(fileGroupNo);
	}

}
