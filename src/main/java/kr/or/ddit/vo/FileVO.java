package kr.or.ddit.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileVO {
	private MultipartFile item;
	
	private String fileGroupNo;
	private int fileNo;
	private String fileName;
	private String fileSaveName;
	private long fileSize;
	private String fileFancysize;
	private String fileMime;
	private String fileSavepath;
	private int fileDowncount;
	
	public FileVO() {}
	
	public FileVO(MultipartFile item) {
		this.item = item;
		this.fileName = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMime = item.getContentType();
		// 600KB = 0.6MB		< 처럼 바꿔줌
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
	}
	
	
}
















