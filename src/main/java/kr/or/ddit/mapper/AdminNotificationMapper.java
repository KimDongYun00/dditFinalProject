package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FileVO;

public interface AdminNotificationMapper {

	public int getBoardCount(Map<String, Object> map);

	// 게시글 목록
	public List<BoardVO> list(Map<String, Object> map);

	// 게시글 조회
	public void incrementView(String boNo);
	
	// 게시글 상세 
	public BoardVO detail(String boNo);
	
	// 게시글 수정
	public void updateBoard(BoardVO board);
	
	// 게시글 삭제
	public void deleteBoard(String boNo);

	// 파일 저장
    public void saveFile(FileVO fileVO);
    
    // 파일 목록
    public List<FileVO> getFileList(String fileGroupNo);
    
    // 새 글 등록
	public void insertBoard(BoardVO board);
	
	// 공지 새 글 등록
	public void insertNoticeFile(FileVO fileVO);

}
