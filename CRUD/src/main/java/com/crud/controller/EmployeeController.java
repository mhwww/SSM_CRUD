package com.crud.controller;

import com.crud.domain.Employee;
import com.crud.domain.Msg;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 处理员工的CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 查询员工信息（分页查询），返回非json数据
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value="pagenumber",defaultValue = "1")Integer pagenumber, Model model){
        System.out.println("1111111111");
        //1、引入PageHelper分页插件
        //2、查询之前调用
        PageHelper.startPage(pagenumber,5);//从第几页开始查，每页数据量
        //3、startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //4、使用pageInfo进行数据封装,只需要将pageinfo交给页面就可以了，因为它的信息很详细
        PageInfo pageInfo = new PageInfo(emps,5);//连续显示5页
        //5、返回给前端pageinfo
        model.addAttribute(pageInfo);
        return "list";
    }

    /**
     * 查询所有员工信息,返回json数据
     * @param pagenumber
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value="pagenumber",defaultValue = "1")Integer pagenumber){
        //1、引入PageHelper分页插件
        //2、查询之前调用
        PageHelper.startPage(pagenumber,5);//从第几页开始查，每页数据量
        //3、startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //4、使用pageInfo进行数据封装,只需要将pageinfo交给页面就可以了，因为它的信息很详细
        PageInfo pageInfo = new PageInfo(emps,5);//连续显示5页

        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 新增员工
     * 1.支持JSR303数据校验
     * 2.导入Hibernate-Validator
     * @param employee
     * @return
     */
    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            //校验失败，返回失败，在模态框中显示提示信息
            List<FieldError>  errors = result.getFieldErrors();
            for (FieldError fieldError:errors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/checkuser",method = RequestMethod.POST)
    public Msg checkUser(String empName){
        //先判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是3-16位数字、字母、下划线的组合或者2-5个汉字");
        }
        boolean flag = employeeService.checkuser(empName);
        if(flag){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名已存在");
        }
    }

    /**
     * 查询单个员工的信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 员工更新
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println("gengxing");
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            List<Integer> delte_ids = new ArrayList<>();
            String[] id_str = ids.split("-");
            for(String id:id_str){
                delte_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(delte_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }

        return Msg.success();
    }
}
