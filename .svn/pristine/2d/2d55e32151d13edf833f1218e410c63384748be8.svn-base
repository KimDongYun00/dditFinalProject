package kr.or.ddit.lecData.service;

import java.util.List;

import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ILectureDataService {

	int selectLectureDataCount(PaginationInfoVO<LectureDataVO> pagingVO);

	List<LectureDataVO> selectLectureDataList(PaginationInfoVO<LectureDataVO> pagingVO);

	LectureDataVO selectLectureDataDetail(String lecDataNo);

	List<FileVO> selectFileList(String fileGroupNo);

}
