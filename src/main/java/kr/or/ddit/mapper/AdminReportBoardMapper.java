package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ReportVO;

public interface AdminReportBoardMapper {

	public int getReportCount(Map<String, Object> map);

	public List<ReportVO> list(Map<String, Object> map);

	// 상세
	public ReportVO detail(String repNo);
	
	// 삭제
//	public void deleteReport(String repNo);

	// 신고 글 숨기기
	public void updateReportStatus(String repNo);
	

}
