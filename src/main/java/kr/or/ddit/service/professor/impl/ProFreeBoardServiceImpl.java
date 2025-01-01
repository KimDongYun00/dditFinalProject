package kr.or.ddit.service.professor.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.FreeBoardMapper;
import kr.or.ddit.service.professor.inter.IFreeBoardService;
import kr.or.ddit.vo.FreeBoardVO;
import kr.or.ddit.vo.FreeCommentVO;
import kr.or.ddit.vo.ReportVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProFreeBoardServiceImpl implements IFreeBoardService {

	@Inject
	private FreeBoardMapper mapper;

	// 페이징
	@Override
	public List<FreeBoardVO> freeList(Map<String, Object> map) {
		return mapper.freeList(map);
	}
	
	// 페이징
	@Override
    public int getFreeBoardCount(Map<String, Object> map) {
        return mapper.getFreeBoardCount(map);
    }

	@Override
	public FreeBoardVO detail(String freeNo) {
		return mapper.detail(freeNo);
	}

	@Override
	public void incrementViewCount(String freeNo) {
		mapper.incrementViewCount(freeNo);
	}

	@Override
	public List<FreeBoardVO> search(String keyword) {
		return mapper.search(keyword);
	}

	@Override
	public void freeboardInsert(FreeBoardVO freeboardVO) {
		mapper.freeboardInsert(freeboardVO);

	}

	@Override
	public void freecommentInsert(FreeCommentVO freeCommentVO) {
		mapper.freecommentInsert(freeCommentVO);

	}

	@Override
	public List<FreeCommentVO> getCommentsByFreeNo(String freeNo) {
		return mapper.getCommentsByFreeNo(freeNo);
	}
	
	// 댓글 수정
	@Override
	public void freeCommentUpdate(FreeCommentVO freeCommentVO) {
		mapper.freeCommentUpdate(freeCommentVO);
		
	}

	@Override
	public void freeCommentDelete(FreeCommentVO freeCommentVO) {
		mapper.freeCommentDelete(freeCommentVO);
		
	}
	
	// 게시글 수정
	@Override
	public void freeboardUpdate(FreeBoardVO freeboardVO) {
		mapper.freeboardUpdate(freeboardVO);
		
	}
	// 게시글 삭제(주석처리 해놓음)
	@Override
	public void freeboardDelete(String freeNo, String userNo) {
		mapper.freeboardDelete(freeNo, userNo);
	}

	@Override
	public void reportInsert(ReportVO reportVO) {
		mapper.reportInsert(reportVO);
		
	}


	



}
