package kr.or.ddit.service.admin.inter;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ReportVO;

public interface IAdminReportBoardService {

	public int getReportCount(Map<String, Object> map);

	public List<ReportVO> list(Map<String, Object> map);

	public ReportVO detail(String repNo);
	
	// 삭제
	//public void deleteReportAndFreeBoard(String repNo);
	
	//신고 글 숨기기
	public void updateReportStatus(String repNo);
	



}
