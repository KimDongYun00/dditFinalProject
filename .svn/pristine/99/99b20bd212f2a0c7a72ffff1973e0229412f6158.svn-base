package kr.or.ddit.evaluate.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IEvaluateMapper;
import kr.or.ddit.vo.LectureEvaluateQuestionVO;
import kr.or.ddit.vo.LectureEvaluateVO;

@Service
public class EvaluateServiceImpl implements IEvaluateService {
	
	@Inject
	private IEvaluateMapper evaMapper;
	
	@Override
	public List<LectureEvaluateQuestionVO> getEvaQueList() {
		return evaMapper.getEvaQueList();
	}

	@Override
	public int insertLecEva(LectureEvaluateVO lecEvaVO) {
		String[] lecEvaContentArr = lecEvaVO.getLecEvaContentArr();
		int cnt = 0;
		for(int i=0;i<lecEvaContentArr.length;i++) {
			String str = lecEvaContentArr[i];
			String lecEvaQueNo = str.substring(0, 13);
			long lecEvaScore = Long.parseLong(str.split("_")[4]);
			LectureEvaluateVO tempLecEvaVO = new LectureEvaluateVO();
			tempLecEvaVO.setStuNo(lecEvaVO.getStuNo());
			tempLecEvaVO.setLecNo(lecEvaVO.getLecNo());
			tempLecEvaVO.setLecEvaQueNo(lecEvaQueNo);
			tempLecEvaVO.setLecEvaScore(lecEvaScore);
			cnt += evaMapper.insertLecEvaScore(tempLecEvaVO);
		}
		cnt += evaMapper.insertLecEvaContent(lecEvaVO);
		if(cnt == lecEvaContentArr.length + 1) {
			return cnt;
		} else {
			return 0;
		}
	}

	@Override
	public int checkEvaluate(LectureEvaluateVO lecEvaVO) {
		return evaMapper.checkEvaluate(lecEvaVO);
	}

}























