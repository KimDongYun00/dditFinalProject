package kr.or.ddit.service.admin.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAdminCertificationMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.admin.inter.IAdminCertificationService;
import kr.or.ddit.vo.CertificationPrintVO;
import kr.or.ddit.vo.CertificationVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class AdminCertificationServiceImpl implements IAdminCertificationService {

	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private IAdminCertificationMapper certificationMapper;
	
	@Inject
	private IFileMapper fileMapper;
	

	// 페이징 처리를 위한 행 구하기
	@Override
	public int selectCertificationCount(PaginationInfoVO<CertificationVO> pagingVO) {
		return certificationMapper.selectCertificationCount(pagingVO);
	}

	// 증명서 종류 리스트
	@Override
	public List<CertificationVO> selectCertificationList(PaginationInfoVO<CertificationVO> pagingVO) {
		return certificationMapper.selectCertificationList(pagingVO);
	}

	// 증명서 pdf 등록
	@Override
	public boolean insertCertification(CertificationVO certificationVO) {
		int result = certificationMapper.insertCertification(certificationVO);
		if(result < 0) {
			return false;
		} else {
			List<FileVO> cerFileList = certificationVO.getCerFileList();
			
			try {
				String fileGroupNo = cerFileUpload(cerFileList);
				certificationVO.setFileGroupNo(fileGroupNo);
				certificationMapper.insertFileGroupNoToCertification(certificationVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	
	
	
	private String cerFileUpload(List<FileVO> cerFileList) throws Exception {
		
		if(cerFileList != null) {	// 넘겨받은 파일 데이터가 존재할 때
			
			String fileGroupNo = fileMapper.getFileGroupNo();	// 파일 그룹번호 시퀀스값 가져오기
			
			if(cerFileList.size() > 0) {
				for(int i=0;i<cerFileList.size();i++) {
					FileVO fileVO = cerFileList.get(i);
					// 파일명을 설정할 때 원본 파일명은 공백을 '_' 로 변경한다.
					String saveName = UUID.randomUUID().toString();	// UUID의 랜덤 파일명의 생성
					saveName = saveName + "_" + fileVO.getFileName().replaceAll(" ", "_");
					String savePath = uploadPath + "/certification/" + fileGroupNo;
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

	// 증명서 발급 현황을 위한 데이터 조회
	@Override
	public List<CertificationVO> certificationStatistics() {
		return certificationMapper.certificationStatistics();
	}

	// 증명서 종류 상세보기
	@Override
	public CertificationVO certificationDetail(String cerNo) {
		return certificationMapper.certificationDetail(cerNo);
	}

	// 증명서 종류 수정
	@Override
	public int certificationUpdate(CertificationVO certificationVO) {
		return certificationMapper.certificationUpdate(certificationVO);
	}

	// 증명서 발급 현황 학과별로
	@Override
	public List<CertificationPrintVO> selectByDepartment() {
		return certificationMapper.selectByDepartment();
	}

	/*
	// 증명서 활성화/비활성화 처리
	@Override
	public boolean updateCertificationStatus(String cerNo, boolean status) {
		return certificationMapper.updateCertificationStatus(cerNo, status) > 0;
	}
	*/
	
}
