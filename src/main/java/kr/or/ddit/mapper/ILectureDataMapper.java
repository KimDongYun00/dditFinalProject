package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ILectureDataMapper {

	public List<LectureDataVO> selectLectureDataList(PaginationInfoVO<LectureDataVO> pagingVO);

	public int selectLectureDataCount(PaginationInfoVO<LectureDataVO> pagingVO);

	public int insertLectureData(LectureDataVO lectureDataVO);

	public LectureDataVO selectLectureDataDetail(String lecDataNo);

	public int deleteLectureData(String lecDataNo);

	// 번호 가져오기
	public String getLecDataNo();
	
	public List<FileVO> selectFileList(String fileGroupNo);

	public void deleteFile(String delNoticeNo);

	public int updateLectureData(LectureDataVO lectureDataVO);

	public String selectFileGroupNo(String lecDataNo);

}
