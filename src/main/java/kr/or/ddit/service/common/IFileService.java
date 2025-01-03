package kr.or.ddit.service.common;

import java.util.List;

import kr.or.ddit.vo.FileVO;

public interface IFileService {
	public List<FileVO> getFileByFileGroupNo(String fileGroupNo);
	public FileVO getFileByFileNo(FileVO fileVO);
	public void increaseDownloadCount(FileVO fileVO);
	// 파일 저장
	public void insertFile(FileVO fileVO);
	// 공지 새 글 등록
	public void insertNoticeFile(FileVO fileVO);
}
