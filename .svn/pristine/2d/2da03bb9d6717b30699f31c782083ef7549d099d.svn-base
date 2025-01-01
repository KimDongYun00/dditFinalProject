package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 성적증명서 - 데이터 그룹화를 위한 학기VO
@Data
public class SemesterVO {
	
	private String year;			// 년도
    private String semester;		// 학기
    private List<GradeVO> grades;	// 성적
    private double averageScore;	// 평균학점
	
    public SemesterVO(String year, String semester, List<GradeVO> grades, double averageScore) {
        this.year = year;
        this.semester = semester;
        this.grades = grades;
        this.averageScore = averageScore;
    }
    
    
}
