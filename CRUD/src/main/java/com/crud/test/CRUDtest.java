package com.crud.test;

import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;
import com.crud.domain.Department;
import com.crud.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作逻辑
 *
 * *推荐使用spring自带的单元测试模块，因为可以为我们自动注入我们需要的组件
 * 1、引入jar包 spring-test
 * 2、@ContextConfiguration 指定配置文件的位置
 * 3、
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CRUDtest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testCRUD(){
        /*//1、创建springIOC容器
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2、获取bean对象
        Department department = applicationContext.getBean(Department.class);*/
        //System.out.println(departmentMapper);

        //插入几个部门
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //插入几个员工
        //employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@xut.com",1));
        //employeeMapper.insertSelective(new Employee(null,"Tom","M","Tom@xut.com",2));

        //批量插入员工
            //1、再applicationContext.xml中配置一个批量执行的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<998;i++){
            String gender = "M";
            int id = 1;
            String uid_name = UUID.randomUUID().toString().substring(0,5);
            if(i/2!=0){
                gender = "F";
                id = 2;
            }
            mapper.insertSelective(new Employee(null,uid_name,gender,uid_name+"@xut.com",id));
        }
    }

}
