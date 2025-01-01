package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ExamQuestionSelectVO;
import kr.or.ddit.vo.ExamQuestionVO;
import kr.or.ddit.vo.ExamSubmitVO;
import kr.or.ddit.vo.ExamVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.StudentVO;

@Mapper
public interface IExamMapper {
	public void insertExam(ExamVO examVO);
	public void insertExamQue(ExamQuestionVO examQueVO);
	public void insertExamQueSel(ExamQuestionSelectVO examQueSelVO);
	public List<ExamVO> getExamListByLecNo(PaginationInfoVO<ExamVO> pagingVO);
	public ExamVO getExamDetail(String examNo);
	public List<StudentVO> getStudentExamList(String examNo);
	public List<ExamSubmitVO> getStudentExamSubmitList(String examNo);
	public int deleteExamSubmit(String examNo);
	public int deleteExamQueSel(String examNo);
	public int deleteExamQue(String examNo);
	public int deleteExam(String examNo);
	public void updateExam(ExamVO examVO);
	public List<ExamQuestionVO> getExamQueAnswer(String examNo);
	public void submitStudentAnswer(ExamSubmitVO submitVO);
	public int checkSubmit(ExamSubmitVO submitVO);
	public List<ExamSubmitVO> getStuExamSubList(ExamSubmitVO examSubVO);
}
