package kr.or.ddit.lecData.service;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.mapper.ILectureDataMapper;
import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.LectureDataVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class LectureDataServiceImpl implements ILectureDataService {

	@Resource(name="uploadFolder")
	private String uploadPath;
	
	@Inject
	private ILectureDataMapper lectureDataMapper;
	
	@Inject
	private IFileMapper fileMapper;

	@Override
	public int selectLectureDataCount(PaginationInfoVO<LectureDataVO> pagingVO) {
		// TODO Auto-generated method stub
		return lectureDataMapper.selectLectureDataCount(pagingVO);
	}

	@Override
	public List<LectureDataVO> selectLectureDataList(PaginationInfoVO<LectureDataVO> pagingVO) {
		// TODO Auto-generated method stub
		return lectureDataMapper.selectLectureDataList(pagingVO);
	}

	@Override
	public LectureDataVO selectLectureDataDetail(String lecDataNo) {
		// TODO Auto-generated method stub
		return lectureDataMapper.selectLectureDataDetail(lecDataNo);
	}

	@Override
	public List<FileVO> selectFileList(String fileGroupNo) {
		// TODO Auto-generated method stub
		return lectureDataMapper.selectFileList(fileGroupNo);
	}
	
	
}
