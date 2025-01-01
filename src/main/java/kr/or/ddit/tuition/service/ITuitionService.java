package kr.or.ddit.tuition.service;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TuitionPaymentVO;
import kr.or.ddit.vo.TuitionVO;

public interface ITuitionService {
	public int selectTuitionCount(PaginationInfoVO<TuitionVO> pagingVO);
	public List<TuitionVO> getTuitionList(PaginationInfoVO<TuitionVO> pagingVO);
	public List<String> getYearList();
	public int insertTuition(TuitionVO tuiVO);
	public int updateTuition(TuitionVO tuiVO);
	public int deleteTuition(TuitionVO tuiVO);
	public TuitionVO getTuitionByStuNo(String stuNo);
	public List<TuitionVO> getTuiPayListByStuNo(String stuNo);
	public int checkTuitionSubmit(TuitionPaymentVO tuiPayVO, String submitType);
	public int submit1Tuition(TuitionPaymentVO tuiPayVO);
	public int submit2Tuition(TuitionPaymentVO tuiPayVO);
	public TuitionVO getTuitionDetail(TuitionPaymentVO tuiPayVO);
	public TuitionVO getTuitionDetail(String tuiPayNo);
	public int submitTuitionListCount(PaginationInfoVO<TuitionVO> pagingVO);
	public List<TuitionVO> submitTuitionList(PaginationInfoVO<TuitionVO> pagingVO);
}
