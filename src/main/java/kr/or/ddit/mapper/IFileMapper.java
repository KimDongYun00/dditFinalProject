package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FileVO;

public interface IFileMapper {
	public String getFileGroupNo();
	public void insertLecFile(FileVO fileVO);
	public List<FileVO> getFileByFileGroupNo(String fileGroupNo);
	public FileVO getFileByFileNo(FileVO fileVO);
	public void increaseDownloadCount(FileVO fileVO);
	public int deleteFile(FileVO fileVO);
	public void insertLicFile(FileVO fileVO); // 자격증 파일
	public void insertSchFile(FileVO fileVO); // 등록금 파일
	
}
 