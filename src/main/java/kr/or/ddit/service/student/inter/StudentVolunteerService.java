package kr.or.ddit.service.student.inter;

import java.util.List;

import kr.or.ddit.vo.FileVO;
import kr.or.ddit.vo.VolunteerVO;

public interface StudentVolunteerService {

	public List<VolunteerVO> selectVolunteer(String stuNo);

	public int insertVolunteeR(VolunteerVO volunteerVO);

	public VolunteerVO detailVolunteer(String volNo);

	public int updateVolunteer(VolunteerVO volunteerVO);

	public int deleteVolunteer(String volNo);

	public List<FileVO> getFileByFileGroupNo(String fileGroupNo);


}
