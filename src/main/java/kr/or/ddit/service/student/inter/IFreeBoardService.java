package kr.or.ddit.service.student.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FoodBoardVO;
import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;
import kr.or.ddit.vo.ReportVO;

public interface IFreeBoardService {

//	public List<FreeBoardVO> freeList();

	// 페이지
	public List<FreeBoardVO> freeList(Map<String, Object> map);
	
	// 페이지
	public int getFreeBoardCount(Map<String, Object> map);

	public void incrementViewCount(String freeNo);

	public FreeBoardVO detail(String freeNo);

	public List<FreeBoardVO> search(String keyword);

	// 새 글 등록
	public void freeboardInsert(FreeBoardVO freeboardVO);

	public void freecommentInsert(FreeCommentVO freeCommentVO);

	public List<FreeCommentVO> getCommentsByFreeNo(String freeNo);
	
	// 댓글 수정
	public void freeCommentUpdate(FreeCommentVO freeCommentVO);

	public void freeCommentDelete(FreeCommentVO freeCommentVO);
	
	// 게시글 수정 
	public void freeboardUpdate(FreeBoardVO freeboardVO);
	
	// 게시글 삭제
	public void freeboardDelete(String freeNo, String userNo);

	// 신고
	public void reportInsert(ReportVO reportVO);
	

}
