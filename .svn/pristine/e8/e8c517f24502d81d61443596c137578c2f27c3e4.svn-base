package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ITuitionMapper;
import kr.or.ddit.service.admin.inter.IAdminTuitionService;
import kr.or.ddit.vo.TuitionVO;

@Service
public class AdminTuitionServiceImpl implements IAdminTuitionService {
	
	@Inject
	private ITuitionMapper tuitionMapper;
	
	@Override
	public List<TuitionVO> getTuitionListByDeptNo(String deptNo) {
		return tuitionMapper.getTuitionListByDeptNo(deptNo);
	}

	@Override
	public void insertTuition(TuitionVO tuitionVO) {
		tuitionMapper.insertTuition(tuitionVO);
	}

	@Override
	public List<TuitionVO> selectTuiList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 통계 현황 조회를 위한 증명서 발급 전체 데이터 끌어오기 
	/*
	 * @Override public List<TuitionVO> tuitionStatistics() { return
	 * tuitionMapper.tuitionStatistics(); }
	 */
	
	//미납자 수 count
	@Override
	public int selectUnpayPeopleCount() {
		return tuitionMapper.selectUnpayPeopleCount();
	}

	//납부자 수 count
	@Override
	public int selectPayPeopleCount() {
		return tuitionMapper.selectPayPeopleCount();
	}

	// 일시불 납부 수 count
	@Override
	public int selectFullPayCount() {
		return tuitionMapper.selectFullPayCount();
	}

	// 할부 납부 수 count
	@Override
	public int selectMonthPayCount() {
		return tuitionMapper.selectMonthPayCount();
	}

}
