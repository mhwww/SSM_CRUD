<%--
  Created by IntelliJ IDEA.
  User: MHW
  Date: 2019/8/17
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工信息</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 修改选项模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">eamil</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@xut.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_Update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_Update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所在部门</label>
                        <div class="col-sm-4">
                            <%--保存部门id即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 新增选项模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">eamil</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@xut.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所在部门</label>
                        <div class="col-sm-4">
                            <%--保存部门id即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<%--搭建显示页面--%>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12"><h1>SSM-CRUD</h1></div>
    </div>
    <%--按钮行--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--信息展示行,里面存放的是一个表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <td>
                            <input type="checkbox" id="check_all"/>
                        </td>
                        <td>#</td>
                        <td>姓名</td>
                        <td>性别</td>
                        <td>Email</td>
                        <td>所在部门</td>
                        <td>操作</td>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息栏--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script>

    var totalRecord,currentPage;
    //1.页面加载完成后,直接发送一个ajax请求,要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });
    function to_page(pagenumber) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pagenumber="+pagenumber,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工信息
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析分页数据
                build_page_nav(result);
            }

        });
    }
    //建立信息显示表格
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd =  $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义属性，来表示员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody")
        });
    }
    //解析分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前为"+result.extend.pageInfo.pageNum+"页,总共"
            + result.extend.pageInfo.pages+"页,总共"
            + result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析分页显示栏
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断是否前一页和首页可点击
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        //判断是否下一页和末页可点击
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
               to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        //添加首页和前一页标签
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {//该function中传参数时，第二个参数则是遍历对象
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            //添加连续页码显示标签
            ul.append(numLi);
        });
        //添加下一页和末页显示标签
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav中
        var navEle = $("<nav></nav>").append(ul);
        //把nav放在分页栏显示区域
        navEle.appendTo("#page_nav_area");
    }
    function reset_form(ele){
        //清空数据
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //绑定新增按钮的点击事件
    $("#emp_add_modal_btn").click(function(){
        //清除表单数据和样式
        reset_form("#empAddModal form");
        //弹出模态框之前，要查询部门信息
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            //点击背景不关闭模态框
            backdrop:"static"
        });
    });
    function getDepts(ele) {
        //清除样式和数据
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //遍历查出来的每一个部门
                $.each(result.extend.depts,function(){//该function中不传参数时，可以用this取到当前遍历的对象；
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }
    function validate_add_form(){
        //1.拿到要校验的数据，使用正则表达式进行校验

        //校验姓名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("姓名可以为2-5位的中文，或者3-16位的英文");
            show_validata_msg("#empName_add_input","error","姓名可以为2-5位的中文，或者3-16位的英文");
            return false;
        }else{
            show_validata_msg("#empName_add_input","success","姓名可用");
        };

        //校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式错误！");
            show_validata_msg("#email_add_input","error","邮箱格式错误！");
            return false;
        }else{
            show_validata_msg("#email_add_input","success","邮箱可用");
        };
        return true;
    }

    //优化校验信息
    function show_validata_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //检查用户名是否可用
    $("#empName_add_input").change(function(){
        //发送ajax请求，检查用户名是否可用
        var empName = $("#empName_add_input").val();
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 100){
                    show_validata_msg("#empName_add_input","success","姓名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else if(result.code == 200){
                    show_validata_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    $("#emp_save_btn").click(function () {
        //1.模态框的中数据提交给服务器进行保存。
        //1.提交数据之前需要进行校验
        if(!validate_add_form()){
            return false;
        };
        //1.校验用户名是否可用
        if($(this).attr("ajax-va") == "error"){
            return false;
        }
        //2.发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //员工保存成功后
                if(result.code == 100){
                    //1.先关闭模态框
                    $("#empAddModal").modal("hide");
                    //2.跳转的最后一页
                    to_page(totalRecord);//此处使用这里的技巧时，在页数数据大于真实数据时，显示最后一页；记录数必然大于总页数
                }else{
                    //显示失败信息
                    //哪个字段错误显示哪个错误信息
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validata_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示姓名错误信息
                        show_validata_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        });
    });

    //绑定编辑按钮事件
    //因为绑定发生在创建之前，所以直接绑定是失败的，因此有两种解决办法：
    //1、创建时即绑定，过于复杂。2、绑定点击
    $(document).on("click",".edit_btn",function () {
        //alert("edit");


        //1、查询部门信息并显示
        getDepts("#empUpdateModal select");
        //2、查询员工信息并显示
        getEmp($(this).attr("edit-id"));
        //3、把员工的id传递过去
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            //点击背景不关闭模态框
            backdrop:"static"
        });
    });
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    $("#emp_update_btn").click(function(){
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式错误！");
            show_validata_msg("#email_update_input","error","邮箱格式错误！");
            return false;
        }else{
            show_validata_msg("#email_update_input","success","邮箱可用");
        };
        //2、发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"POST",
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            success:function(result){
                //alert(result.msg);
                //1、关闭对话框
                $("#empUpdateModal").modal("hide");
                //2、回到本页面
                to_page(currentPage);
            }
        });
    });
    $(document).on("click",".delete_btn",function () {
        //alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if(confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    //alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
    //完成全选/全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined;
        //attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否全选
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var delete_ids = "";
        $.each($(".check_item:checked"),function () {
           empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
           delete_ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的逗号
        empNames = empNames.substring(0,empNames.length-1);
        //去除多余的-号
        delete_ids = delete_ids.substring(0,delete_ids.length-1);
        if(confirm("确认删除【"+empNames+"】吗？"));{
            $.ajax({
                url:"${APP_PATH}/emp/"+delete_ids,
                type:"DELETE",
                success:function (result) {
                    //alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
