package kr.or.ddit.service.admin.inter;

import java.util.List;

import kr.or.ddit.vo.TuitionVO;

public interface IAdminTuitionService {
	public List<TuitionVO> getTuitionListByDeptNo(String deptNo);
	public void insertTuition(TuitionVO tuitionVO);
	public List<TuitionVO> selectTuiList();
	 // 통계 현황 조회를 위한 증명서 발급 전체 데이터 끌어오기 
	//public List<TuitionVO> tuitionStatistics();
	//미납자 수 count
	public int selectUnpayPeopleCount();
	//납부자 수 count
	public int selectPayPeopleCount();
	// 일시불 납부 수 count
	public int selectFullPayCount();
	// 할부 납부 수 count
	public int selectMonthPayCount();
}
