package kr.or.ddit.service.admin.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AdminNotificationMapper;
import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.admin.inter.IAdminNotificationService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FileVO;
@Service
public class AdminINotificationServiceImpl implements IAdminNotificationService {
	
	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private AdminNotificationMapper mapper;
	
	@Inject
	private IFileMapper fileMapper;

	@Override
	public int getBoardCount(Map<String, Object> map) {
		return mapper.getBoardCount(map);
	}

	@Override
	public List<BoardVO> list(Map<String, Object> map) {
		return mapper.list(map);
	}

	@Override
	public void incrementView(String boNo) {
		mapper.incrementView(boNo);
	}

	@Override
	public BoardVO detail(String boNo) {
		return mapper.detail(boNo);
	}

	// 게시글 수정
	@Override
	public void updateBoard(BoardVO board) {
		mapper.updateBoard(board);
		
	}

	@Override
	public void deleteBoard(String boNo) {
		mapper.deleteBoard(boNo);
		
	}
	// 파일 저장
	@Override
    public void saveFile(FileVO fileVO) {
        mapper.saveFile(fileVO);
    }
	
	// 파일업로드
    @Override
    public List<FileVO> getFileList(String fileGroupNo) {
        return mapper.getFileList(fileGroupNo);
    }

    // 새 글 등록 
	@Override
	public void insertBoard(BoardVO board) {
		mapper.insertBoard(board);
		
	}

	@Override
	public String getFileGroupNo() {
		return fileMapper.getFileGroupNo();
	}
	
	

}
