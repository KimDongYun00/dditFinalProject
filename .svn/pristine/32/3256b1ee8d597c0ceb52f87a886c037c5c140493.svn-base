package kr.or.ddit.tuition.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ITuitionMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TuitionPaymentVO;
import kr.or.ddit.vo.TuitionVO;

@Service
public class TuitionServiceImpl implements ITuitionService {

	@Inject
	private ITuitionMapper tuiMapper;
	
	@Override
	public int selectTuitionCount(PaginationInfoVO<TuitionVO> pagingVO) {
		return tuiMapper.selectTuitionCount(pagingVO);
	}

	@Override
	public List<TuitionVO> getTuitionList(PaginationInfoVO<TuitionVO> pagingVO) {
		return tuiMapper.getTuitionList(pagingVO);
	}

	@Override
	public List<String> getYearList() {
		return tuiMapper.getYearList();
	}

	@Override
	public int insertTuition(TuitionVO tuiVO) {
		return tuiMapper.insertTuition2(tuiVO);
	}

	@Override
	public int updateTuition(TuitionVO tuiVO) {
		return tuiMapper.updateTuition(tuiVO);
	}

	@Override
	public int deleteTuition(TuitionVO tuiVO) {
		return tuiMapper.deleteTuition(tuiVO);
	}

	@Override
	public TuitionVO getTuitionByStuNo(String stuNo) {
		return tuiMapper.getTuitionByStuNo(stuNo);
	}

	@Override
	public List<TuitionVO> getTuiPayListByStuNo(String stuNo) {
		return tuiMapper.getTuiPayListByStuNo(stuNo);
	}
	
	// Y0201 일시불 Y0202 할부
	// Y0101 납부 중 Y0102 납부 완료
	@Override
	public int checkTuitionSubmit(TuitionPaymentVO tuiPayVO, String type) {
		Map<String, String> resultMap = tuiMapper.checkTuitionSubmit(tuiPayVO);
		if(resultMap == null) {
			return 0;
		}
		String submitYn = resultMap.get("COM_DET_Y_NO");
		String submitType = resultMap.get("COM_DET_Y2_NO");
		System.out.println("submitYn>"+submitYn + " submitType>" + submitType);
		if(submitYn.equals("Y0101")) {
			if(type.equals("1")) {
				return 1;
			} else {
				return 0;
			}
		} else {
			if(submitType.equals("Y0201")) {
				return 1;
			} else {
				return 2;
			}
		} 
	}

	@Override
	public int submit1Tuition(TuitionPaymentVO tuiPayVO) {
		int cnt1 = tuiMapper.submit1Tuition(tuiPayVO);
		int cnt2 = tuiMapper.submit1TuitionDetail(tuiPayVO);
		return cnt1 + cnt2 - 1;
	}

	@Override
	public int submit2Tuition(TuitionPaymentVO tuiPayVO) {
		int submitTime = tuiMapper.checkTuitionSubmit2(tuiPayVO);
		tuiPayVO.setTuiPayAmount((tuiPayVO.getTuiPayAmount()-tuiPayVO.getTuiPayDed())/4);
		int cnt = 0;
		if(submitTime == 0) {
			int cnt1 = tuiMapper.submit2TuitionFirst(tuiPayVO);
			int cnt2 = tuiMapper.submit2TuitionDetail(tuiPayVO);
			cnt = cnt1 + cnt2 - 1;
		} else if(submitTime == 3) {
			int cnt1 = tuiMapper.submit2TuitionLast(tuiPayVO);
			int cnt2 = tuiMapper.submit2TuitionDetail(tuiPayVO);
			cnt = cnt1 + cnt2 - 1;
		} else {
			cnt = tuiMapper.submit2TuitionDetail(tuiPayVO);
		}
		tuiMapper.updateSubmit2Tuition(tuiPayVO);
		return cnt;
	}

	@Override
	public TuitionVO getTuitionDetail(TuitionPaymentVO tuiPayVO) {
		return tuiMapper.getTuitionDetail(tuiPayVO);
	}
	
	@Override
	public TuitionVO getTuitionDetail(String tuiPayNo) {
		return tuiMapper.getTuitionDetailByTuiPayNo(tuiPayNo);
	}

	@Override
	public int submitTuitionListCount(PaginationInfoVO<TuitionVO> pagingVO) {
		return tuiMapper.submitTuitionListCount(pagingVO);
	}

	@Override
	public List<TuitionVO> submitTuitionList(PaginationInfoVO<TuitionVO> pagingVO) {
		return tuiMapper.submitTuitionList(pagingVO);
	}

}
























