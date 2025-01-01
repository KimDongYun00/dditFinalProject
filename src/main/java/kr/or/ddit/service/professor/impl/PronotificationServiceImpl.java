package kr.or.ddit.service.professor.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.NotificationMapper;
import kr.or.ddit.service.professor.inter.INotificationService;
import kr.or.ddit.vo.BoardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PronotificationServiceImpl implements INotificationService {

	@Inject
	private NotificationMapper mapper;

//	@Override
//    public List<BoardVO> list() {
//        return mapper.list();
//    }
	//페이지
	@Override
	public List<BoardVO> list(Map<String, Object> map) {
		return mapper.list(map);
	}
	//페이지
	@Override
	public int getBoardCount(Map<String, Object> map) {
		return mapper.getBoardCount(map);
	}

	@Override
	public BoardVO detail(String boNo) {
		return mapper.detail(boNo);
	}

	@Override
	public List<BoardVO> search(String keyword) {
		return mapper.search(keyword);
	}

	@Override
	public void incrementViewCount(String boNo) {
		mapper.incrementViewCount(boNo);
	}
}
