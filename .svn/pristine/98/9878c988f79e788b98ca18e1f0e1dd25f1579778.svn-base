package kr.or.ddit.service.admin.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AdminFreeBoardMapper;
import kr.or.ddit.service.admin.inter.IAdminFreeBoardService;
import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminFreeboardServiceImpl implements IAdminFreeBoardService {

	@Inject
	private AdminFreeBoardMapper mapper;

	@Override
	public int getFreeBoardCount(Map<String, Object> map) {
		return mapper.getFreeBoardCount(map);
	}

	@Override
	public List<FreeBoardVO> freeList(Map<String, Object> map) {
		return mapper.freeList(map);
	}

	@Override
	public void incrementViewCount(String freeNo) {
		mapper.incrementViewCount(freeNo);
	}

	@Override
	public FreeBoardVO detail(String freeNo) {
		return mapper.detail(freeNo);
	}

	@Override
	public void freeboardInsert(FreeBoardVO freeboardVO) {
		mapper.freeboardInsert(freeboardVO);
	}

	@Override
	public void freeboardUpdate(FreeBoardVO freeboardVO) {
		mapper.freeboardUpdate(freeboardVO);
	}

	@Override
	public void freeboardDelete(String freeNo) {
		mapper.deleteCommentsByFreeNo(freeNo); // 댓글 삭제
		mapper.freeboardDelete(freeNo); // 게시글 삭제
	}

	@Override
	public void freeboardDeleteMultiple(List<String> freeNoList) {
		mapper.deleteCommentsByFreeNoList(freeNoList); // 댓글 삭제
		mapper.freeboardDeleteMultiple(freeNoList); // 게시글 삭제
	}

	@Override
	public List<FreeCommentVO> getCommentsByFreeNo(String freeNo) {
		return mapper.getCommentsByFreeNo(freeNo);
	}

	@Override
	public void freecommentInsert(FreeCommentVO freeCommentVO) {
		mapper.freecommentInsert(freeCommentVO);

	}

	@Override
	public void freeCommentUpdate(FreeCommentVO freeCommentVO) {
		mapper.freeCommentUpdate(freeCommentVO);
	}

	@Override
	public void freeCommentDelete(FreeCommentVO freeCommentVO) {
		mapper.freeCommentDelete(freeCommentVO);
	}
	
	//신고글 숨기기
	@Override
	public void hideFreeBoard(String freeNo) {
	    mapper.hideFreeBoard(freeNo);
	}


}
