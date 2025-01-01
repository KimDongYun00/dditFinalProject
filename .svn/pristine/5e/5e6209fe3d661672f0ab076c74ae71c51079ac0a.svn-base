package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;

public interface AdminFreeBoardMapper {

	public int getFreeBoardCount(Map<String, Object> map);

	public List<FreeBoardVO> freeList(Map<String, Object> map);

	public void incrementViewCount(String freeNo);

	public FreeBoardVO detail(String freeNo);

	public void freeboardInsert(FreeBoardVO freeboardVO);

	public void freeboardUpdate(FreeBoardVO freeboardVO);

	public void freeboardDelete(String freeNo);

	public void freeboardDeleteMultiple(List<String> freeNoList);
	
	public List<FreeCommentVO> getCommentsByFreeNo(String freeNo);

	public void freecommentInsert(FreeCommentVO freeCommentVO);

	public void freeCommentUpdate(FreeCommentVO freeCommentVO);

	public void freeCommentDelete(FreeCommentVO freeCommentVO);
	
	public void deleteCommentsByFreeNo(String freeNo);
	
	public void deleteCommentsByFreeNoList(List<String> freeNoList);
	
	// 신고 글 숨기기
	public void hideFreeBoard(String freeNo);

}
