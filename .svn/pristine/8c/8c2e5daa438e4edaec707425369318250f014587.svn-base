package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;
import kr.or.ddit.vo.ReportVO;

public interface FreeBoardMapper {

	
	// 페이지
	public List<FreeBoardVO> freeList(Map<String, Object> map);
	
	// 페이지
	public int getFreeBoardCount(Map<String, Object> map);

	public FreeBoardVO detail(String freeNo);

	public void incrementViewCount(String freeNo);

	public List<FreeBoardVO> search(String keyword);

	// 새 게시글 등록
	public void freeboardInsert(FreeBoardVO freeboardVO);

	public void freecommentInsert(FreeCommentVO freeCommentVO);

	public List<FreeCommentVO> getCommentsByFreeNo(String freeNo);

	public void freecommentUpdate(FreeCommentVO freeCommentVO);
	
	// 댓글 수정
	public void freeCommentUpdate(FreeCommentVO freeCommentVO);
	
	public void freeCommentDelete(FreeCommentVO freeCommentVO);
	
	// 게시글 수정
	public void freeboardUpdate(FreeBoardVO freeboardVO);
	
	// 게시글 삭제(주석)
	public void freeboardDelete(String freeNo, String userNo);

	// 신고
	public void reportInsert(ReportVO reportVO);
	
	// 신고 삭제
	public void deleteFreeBoard(String boardPkNo);
	

	


}
