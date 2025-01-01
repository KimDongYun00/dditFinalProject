package kr.or.ddit.service.professor.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardVO;

public interface INotificationService {
	public List<BoardVO> list(Map<String, Object> map);

	public int getBoardCount(Map<String, Object> map);

	public BoardVO detail(String boNo);

	public List<BoardVO> search(String keyword);

	public void incrementViewCount(String boNo);

}
