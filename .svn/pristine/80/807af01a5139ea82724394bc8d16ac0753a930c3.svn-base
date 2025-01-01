package kr.or.ddit.service.professor.impl;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.IProfessorMapper;
import kr.or.ddit.service.professor.inter.IProMypageService;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.ProfessorVO;

@Service
public class ProMypageServiceImpl implements IProMypageService {
	
	@Inject
	private IProfessorMapper professorMapper;
	
	@Override
	public ProfessorVO selectProfessor(String userNo) {
		return professorMapper.selectProfessor(userNo);
	}

	@Override
	public DepartmentVO selectProfessorDep(String userNo) {
		DepartmentVO departmentVO = professorMapper.selectProfessorDep(userNo);
		return departmentVO;
	}

	@Override
	public ServiceResult profileUpdate(HttpServletRequest req, ProfessorVO professorVO) {
		ServiceResult result = null; 
		// 업데이트시, 프로필 이미지로 파일을 업로드 할 서버경로
		String uploadPath = req.getServletContext().getRealPath("/resources/profile");
		File file = new File(uploadPath);
		//해당 경로에 폴더 구조가 만들어져 있는지 체크 
		if (!file.exists()) {
			file.mkdirs(); // 없을 경우 파일 폴더 생성
		}
		String profileImg = ""; // 사용자 정보에 추가할 프로필 이미지 경로 
		try {
			// 이미 존재 하는 프로필 이미지 파일
			MultipartFile profileImgFile = professorVO.getProFile();
			
			if(profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString();
				// UUID_원본파일명 생성
				fileName += "_"+ profileImgFile.getOriginalFilename();
				uploadPath += "/"+ fileName; // /resources/profile/UUID_원본파일명
				profileImgFile.transferTo(new File(uploadPath)); // 파일복사
				
				// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
				profileImg = "/resources/profile/" + fileName;
			}
			professorVO.setProImg(profileImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		int status = professorMapper.profileUpdate(professorVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else { // 수정 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public DepartmentVO departmentInfo(String deptNo) {
		return professorMapper.departmentInfo(deptNo);
	}

}
