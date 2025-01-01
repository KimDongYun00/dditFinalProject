package kr.or.ddit.exam.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IExamMapper;
import kr.or.ddit.vo.ExamQuestionSelectVO;
import kr.or.ddit.vo.ExamQuestionVO;
import kr.or.ddit.vo.ExamSubmitVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class ExamServiceImpl implements IExamService {
	
	@Inject
	private IExamMapper examMapper;
		
	@Override
	public void insertExam(ExamVO examVO) {
		examMapper.insertExam(examVO);
		if(examVO.getExamQueArr() == null) {
			return;
		}
		for(ExamQuestionVO examQueVO : examVO.getExamQueArr()) {
			examQueVO.setExamNo(examVO.getExamNo());
			examMapper.insertExamQue(examQueVO);
			if(examQueVO.getExamQueSelArr() == null) {
				return;
			}
			for(ExamQuestionSelectVO examQueSelVO : examQueVO.getExamQueSelArr()) {
				examQueSelVO.setExamQueNo(examQueVO.getExamQueNo());
				examMapper.insertExamQueSel(examQueSelVO);
			}
		}
	}

	@Override
	public List<ExamVO> getExamListByLecNo(PaginationInfoVO<ExamVO> pagingVO) {
		return examMapper.getExamListByLecNo(pagingVO);
	}

	@Override
	public ExamVO getExamDetail(String examNo) {
		return examMapper.getExamDetail(examNo);
	}

	@Override
	public List<StudentVO> getStudentExamList(String examNo) {
		return examMapper.getStudentExamList(examNo);
	}
	
	@Override
	public List<ExamSubmitVO> getStudentExamSubmitList(String examNo) {
		return examMapper.getStudentExamSubmitList(examNo);
	}

	@Override
	public int deleteExam(String examNo) {
		int result = 0;
		int cnt0 = examMapper.deleteExamSubmit(examNo);
		int cnt1 = examMapper.deleteExamQueSel(examNo);
		int cnt2 = examMapper.deleteExamQue(examNo);
		int cnt3 = examMapper.deleteExam(examNo);
		if(cnt1 > 0 && cnt2 > 0 && cnt3 > 0) result = 1;
		
		return result;
	}

	@Override
	public void updateExam(ExamVO examVO) {
		examMapper.updateExam(examVO);
		if(examVO.getExamQueArr() == null) {
			return;
		}
		examMapper.deleteExamQueSel(examVO.getExamNo());
		examMapper.deleteExamQue(examVO.getExamNo());
		for(ExamQuestionVO examQueVO : examVO.getExamQueArr()) {
			examQueVO.setExamNo(examVO.getExamNo());
			examMapper.insertExamQue(examQueVO);
			if(examQueVO.getExamQueSelArr() == null) {
				return;
			}
			for(ExamQuestionSelectVO examQueSelVO : examQueVO.getExamQueSelArr()) {
				examQueSelVO.setExamQueNo(examQueVO.getExamQueNo());
				examMapper.insertExamQueSel(examQueSelVO);
			}
		}
		
	}

	@Override
	public void submitStudentAnswer(ExamSubmitVO submitVO, String examNo) {
		String[] stuAnsArr = submitVO.getAnswerArr();
		List<ExamQuestionVO> queAnsList = examMapper.getExamQueAnswer(examNo);
		
		for (int i = 0; i < stuAnsArr.length; i++) {
			ExamQuestionVO que = queAnsList.get(i);
			int score = 0;
			if(stuAnsArr[i].equals(que.getExamQueAnswer())) {
				score += que.getExamQueScore();
			}
			submitVO.setExamQueNo(que.getExamQueNo());
			submitVO.setExamSubAnswer(stuAnsArr[i]);
			submitVO.setExamSubScore(score);
			examMapper.submitStudentAnswer(submitVO);
		}
	}

	@Override
	public boolean checkSubmit(ExamSubmitVO submitVO) {
		int cnt = examMapper.checkSubmit(submitVO);
		if(cnt > 0) return true;
		else return false;
	}

	@Override
	public List<ExamSubmitVO> getStuExamSubList(ExamSubmitVO examSubVO) {
		return examMapper.getStuExamSubList(examSubVO);
	}

	
	
}






















