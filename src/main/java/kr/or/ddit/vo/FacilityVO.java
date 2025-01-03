package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FacilityVO {

	private String facNo;
	private String facTypeNo;
	private String buiNo;
	private String facName;
	private int facMax;
	private String facImg;
	private String facYn;
	
	// MultipartFile Img
	private MultipartFile imgFile;
	
	// 건물명
	private String buiName;
	
	// rnum
	private int rnum;
	
	// 시설이름
	private String facTypeName;
}
