package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardVO;

public interface NotificationMapper {
	
	public List<BoardVO> list(Map<String, Object> map);

	// 페이지
	public int getBoardCount(Map<String, Object> map);

	public BoardVO detail(String boNo);

	public List<BoardVO> search(String keyword);

	public void incrementViewCount(String boNo);

	// 홈에 공지사항 띄우기
	public List<BoardVO> selectNotice();

}
