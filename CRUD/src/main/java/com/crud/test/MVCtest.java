package com.crud.test;


import com.crud.domain.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MVCtest {

    //传入springmvc的ioc
    @Autowired
    private WebApplicationContext webApplicationContext;
    //虚拟mvc请求，获取请求的结果
    private MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        this.mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testPage() throws Exception {
        //1、perform 模拟发送请求
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pagenumber","5"))
                .andReturn();
        //2、请求成功后，请求域中有PageInfo对象，我们可以取出来进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码为：" + pi.getPageNum());
        System.out.println("总页码为：" + pi.getPages());
        System.out.println("总记录数：" + pi.getTotal());
        System.out.println("在页面需要连续显示的页码：");
        int[] nums = pi.getNavigatepageNums();
        for(int i:nums){
            System.out.println(i);
        }
        //获取包装进去的员工数据
        List<Employee> list = pi.getList();
        for (Employee emp:list) {
            System.out.println("ID:" + emp.getEmpId()+"==>Name:" + emp.getEmpName());
        }

    }

}
