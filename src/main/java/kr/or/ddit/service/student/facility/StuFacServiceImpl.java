package kr.or.ddit.service.student.facility;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFacilityMapper;
import kr.or.ddit.vo.FacilityReserveVO;
import kr.or.ddit.vo.FacilityVO;

@Service
public class StuFacServiceImpl implements IStuFacService {

	@Inject
	private IFacilityMapper mapper;
	
	@Override
	public List<FacilityVO> selectList(String facTypeNo) {
		return mapper.selectFacList(facTypeNo);		
	}

	@Override
	public FacilityVO selectDetail(String facNo) {
		
		return mapper.selectDetail(facNo);
	}

	@Override
	public int facilityStuReserve(FacilityReserveVO facReserveVO) {
		// TODO Auto-generated method stub
		return mapper.facilityStuReserve(facReserveVO);
	}

	@Override
	public List<FacilityReserveVO> facilityStuReserveList(String facNo) {
		return mapper.facilityStuReserveList(facNo);
	}

	@Override
	public int facStuResDelete(String facResNo) {
		
		return mapper.facStuResDelete(facResNo);
	}

	
	
}
