package kr.or.ddit.service.admin.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FileVO;

public interface IAdminNotificationService {

	public int getBoardCount(Map<String, Object> map);

	public List<BoardVO> list(Map<String, Object> map);

	public void incrementView(String boNo);

	public BoardVO detail(String boNo);
	
	// 게시글 수정
	public void updateBoard(BoardVO board);
	
	// 게시글 삭제
	public void deleteBoard(String boNo);
	
	// 파일 저장
	public void saveFile(FileVO fileVO);

	public List<FileVO> getFileList(String fileGroupNo);
	
	// 새 글 등록
	public void insertBoard(BoardVO board);

	public String getFileGroupNo();
	

}
