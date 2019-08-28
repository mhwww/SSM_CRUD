package com.crud.service;

import com.crud.dao.EmployeeMapper;
import com.crud.domain.Employee;
import com.crud.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    //查询员工所有信息
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
    //新增员工
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
    //检查用户名是否可用
    public boolean checkuser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }
    //查询一个员工信息
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    //修改一个员工的信息
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    //删除单个员工
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }
}
