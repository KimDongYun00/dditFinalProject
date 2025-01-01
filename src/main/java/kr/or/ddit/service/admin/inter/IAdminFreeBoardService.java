package kr.or.ddit.service.admin.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;

public interface IAdminFreeBoardService {

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
	
	// 신고글 숨기기
	public void hideFreeBoard(String freeNo);


}
