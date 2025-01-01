package kr.or.ddit.service.admin.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AdminReportBoardMapper;
import kr.or.ddit.mapper.FreeBoardMapper;
import kr.or.ddit.service.admin.inter.IAdminReportBoardService;
import kr.or.ddit.vo.ReportVO;
import lombok.extern.slf4j.Slf4j;

@Service
public class AdminReportboardServiceImpl implements IAdminReportBoardService {
	@Inject
	private AdminReportBoardMapper mapper;

	@Inject
	private FreeBoardMapper freeboardMapper;
	
	@Override
	public int getReportCount(Map<String, Object> map) {
		return mapper.getReportCount(map);
	}

	@Override
	public List<ReportVO> list(Map<String, Object> map) {
		return mapper.list(map);
	}

	// 상세
	@Override
	public ReportVO detail(String repNo) {
		return mapper.detail(repNo);
	}


	// 삭제
//	@Override
//	public void deleteReportAndFreeBoard(String repNo) {
//		ReportVO report = mapper.detail(repNo);
//		if (report != null) {
//			mapper.deleteReport(repNo);
//			freeboardMapper.deleteFreeBoard(report.getBoardPkNo());
//		}
//	}
	
	// 신고 글 숨기기
	@Override
	public void updateReportStatus(String repNo) {
		mapper.updateReportStatus(repNo);
		
	}
	
	

}
