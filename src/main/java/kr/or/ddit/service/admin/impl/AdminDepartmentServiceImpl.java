package kr.or.ddit.service.admin.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IColleageMapper;
import kr.or.ddit.mapper.IDepartmentMapper;
import kr.or.ddit.service.admin.inter.IAdminDepartmentService;
import kr.or.ddit.vo.ColleageVO;
import kr.or.ddit.vo.DepartmentVO;

@Service
public class AdminDepartmentServiceImpl implements IAdminDepartmentService {
	
	@Inject
	private IColleageMapper ColleageMapper;
	
	@Inject
	private IDepartmentMapper deptMapper;
	
	@Override
	public List<ColleageVO> getColleageList() {
		return ColleageMapper.getColleageList();
	}

	@Override
	public List<DepartmentVO> getDepartmentsByColleageNo(String colNo) {
		return deptMapper.getDepartmentsByColleageNo(colNo);
	}

	@Override
	public ColleageVO getColleageByColleageNo(String colNo) {
		return ColleageMapper.getColleageByColleageNo(colNo);
	}

	@Override
	public DepartmentVO getDepartmentByDeptNo(String deptNo) {
		return deptMapper.getDepartmentByDeptNo(deptNo);
	}

	@Override
	public void updateDepartment(DepartmentVO deptVO) {
		deptMapper.updateDepartment(deptVO);
	}

	@Override
	public void insertDeaprtment(DepartmentVO departmentVO) {
		deptMapper.insertDeaprtment(departmentVO);
	}

	@Override
	public List<DepartmentVO> getDeptNameList() {
		return deptMapper.getDeptNameList();
	}
	
	
}













