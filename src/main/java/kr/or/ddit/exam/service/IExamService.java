package kr.or.ddit.exam.service;

import java.util.List;

import kr.or.ddit.vo.ExamSubmitVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

public interface IExamService {
	public void insertExam(ExamVO examVO);
	public List<ExamVO> getExamListByLecNo(PaginationInfoVO<ExamVO> pagingVO);
	public ExamVO getExamDetail(String examNo);
	public List<StudentVO> getStudentExamList(String examNo);
	public List<ExamSubmitVO> getStudentExamSubmitList(String examNo);
	public int deleteExam(String examNo);
	public void updateExam(ExamVO examVO);
	public void submitStudentAnswer(ExamSubmitVO submitVO, String examNo);
	public boolean checkSubmit(ExamSubmitVO submitVO);
	public List<ExamSubmitVO> getStuExamSubList(ExamSubmitVO examSubVO);
}
