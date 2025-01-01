package kr.or.ddit.service.admin.impl;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.IMypageMapper;
import kr.or.ddit.service.admin.inter.IAdminMypageService;
import kr.or.ddit.vo.EmployeeVO;

@Service
public class AdminMypageServiceImpl implements IAdminMypageService {

	@Inject	
	private IMypageMapper mapper;
	
	@Override
	public EmployeeVO selectAdmin(String userNo) {
		
		
		return mapper.selectAdmin(userNo);
	}

	@Override
	public ServiceResult profileUpdate(HttpServletRequest req, EmployeeVO empVO) {
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
			MultipartFile profileImgFile = empVO.getEmpFile();
			
			if(profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString();
				// UUID_원본파일명 생성
				fileName += "_"+ profileImgFile.getOriginalFilename();
				uploadPath += "/"+ fileName; // /resources/profile/UUID_원본파일명
				profileImgFile.transferTo(new File(uploadPath)); // 파일복사
				
				// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
				profileImg = "/resources/profile/" + fileName;
			}
			empVO.setEmpImg(profileImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		int status = mapper.empUpdate(empVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else { // 수정 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}
