package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.AssignmentSubmitVO;
import kr.or.ddit.vo.AssignmentVO;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IAssignmentMapper {

	public int selectAssignmentCount(PaginationInfoVO<AssignmentVO> pagingVO);

	public List<AssignmentVO> selectAssignmentList(PaginationInfoVO<AssignmentVO> pagingVO);

	public AssignmentVO selectAssignmentDetail(String assNo);

	public String getAssSubNo();

	public int insertAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO);

	public AssignmentSubmitVO selectAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO);

	public List<FileVO> selectDelFileList(@Param("fileGroupNo")String fileGroupNo, @Param("fileNo")String delFileNo);

	public int deleteFile(String delNoticeNo);

	public int updateAssignmentSubmit(AssignmentSubmitVO assignmentSubmitVO);

	public List<FileVO> selectFileList(String fileGroupNo);

	public void deleteFile(@Param("fileGroupNo")String fileGroupNo, @Param("fileNo") String delFileNo);

	public int countSubmit(Map<String, String> subMap);

}
