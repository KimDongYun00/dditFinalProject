package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TuitionPaymentVO;
import kr.or.ddit.vo.TuitionVO;

public interface ITuitionMapper {
	List<TuitionVO> getTuitionListByDeptNo(String deptNo);
	void insertTuition(TuitionVO tuitionVO);
	
	// 통계 현황 조회를 위한 증명서 발급 전체 데이터 끌어오기 
	List<TuitionVO> tuitionStatistics();
	
	
	// 등록금 관리
	public int selectTuitionCount(PaginationInfoVO<TuitionVO> pagingVO);
	public List<TuitionVO> getTuitionList(PaginationInfoVO<TuitionVO> pagingVO);
	List<String> getYearList();
	public int insertTuition2(TuitionVO tuiVO);
	int updateTuition(TuitionVO tuiVO);
	int deleteTuition(TuitionVO tuiVO);
	TuitionVO getTuitionByStuNo(String stuNo);
	List<TuitionVO> getTuiPayListByStuNo(String stuNo);
	Map<String, String> checkTuitionSubmit(TuitionPaymentVO tuiPayVO);
	int submit1Tuition(TuitionPaymentVO tuiPayVO);
	int checkTuitionSubmit2(TuitionPaymentVO tuiPayVO);
	int submit2TuitionFirst(TuitionPaymentVO tuiPayVO);
	int submit2TuitionDetail(TuitionPaymentVO tuiPayVO);
	int submit2TuitionLast(TuitionPaymentVO tuiPayVO);
	void updateSubmit2Tuition(TuitionPaymentVO tuiPayVO);
	int submit1TuitionDetail(TuitionPaymentVO tuiPayVO);
	TuitionVO getTuitionDetail(TuitionPaymentVO tuiPayVO);
	TuitionVO getTuitionDetailByTuiPayNo(String tuiPayNo);
	int submitTuitionListCount(PaginationInfoVO<TuitionVO> pagingVO);
	List<TuitionVO> submitTuitionList(PaginationInfoVO<TuitionVO> pagingVO);
	
	// 미납자 수 count
	public int selectUnpayPeopleCount();
	// 납부자 수 count
	public int selectPayPeopleCount();
	// 일시불 수 count
	public int selectFullPayCount();
	// 할부 수 count
	public int selectMonthPayCount();
}
