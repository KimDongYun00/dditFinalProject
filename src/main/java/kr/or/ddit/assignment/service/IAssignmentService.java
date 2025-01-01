package kr.or.ddit.assignment.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAssignmentService {

	public int selectAssignmentCount(PaginationInfoVO<AssignmentVO> pagingVO);

	public List<AssignmentVO> selectAssignmentList(PaginationInfoVO<AssignmentVO> pagingVO);

	public AssignmentVO selectAssignmentDetail(String assNo);

	public int insertAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO);

	public AssignmentSubmitVO selectAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO);

	public int updateAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO);

	public List<FileVO> selectFileList(String fileGroupNo);

	public int countSubmit(Map<String, String> subMap);

}
