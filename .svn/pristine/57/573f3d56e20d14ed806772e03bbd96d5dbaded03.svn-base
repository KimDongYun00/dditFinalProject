package kr.or.ddit.service.common.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AdminNotificationMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.common.IFileService;
import kr.or.ddit.vo.FileVO;

@Service
public class FileServiceImpl implements IFileService {

	@Inject
	private IFileMapper mapper;
	
	@Inject
	private AdminNotificationMapper noticeMapper;
	
	
	@Override
	public List<FileVO> getFileByFileGroupNo(String fileGroupNo) {
		return mapper.getFileByFileGroupNo(fileGroupNo);
	}


	@Override
	public FileVO getFileByFileNo(FileVO fileVO) {
		return mapper.getFileByFileNo(fileVO);
	}


	@Override
	public void increaseDownloadCount(FileVO fileVO) {
		mapper.increaseDownloadCount(fileVO);
	}

	// 증명서 관련 파일 저장
	@Override
	public void insertFile(FileVO fileVO) {
		mapper.insertLecFile(fileVO);	// 쿼리문이 동일하길래 임시로 사용
		
	}

	
	// 공지 새 글 등록
	@Override
	public void insertNoticeFile(FileVO fileVO) {
		noticeMapper.insertNoticeFile(fileVO);
	}


}
