package com.gyf.bos.web.action;

import com.gyf.bos.model.AdminEntity;
//import com.gyf.bos.model.User;
import com.gyf.bos.service.IUserService;
import com.gyf.bos.web.action.base.BaseAction;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserAction extends BaseAction<AdminEntity> {

    @Autowired
    private IUserService userService;

    public String login(){

        //1.获取参数
        String username = getModel().getAdmin();
        String password = getModel().getPassword();

        //request
        HttpServletRequest request =  ServletActionContext.getRequest();
        String serverCheckCode = (String) request.getSession().getAttribute("key");
        String clientCheckCode = request.getParameter("checkcode");
        if(serverCheckCode.equalsIgnoreCase(clientCheckCode)){//验证码正确
            //2.调用service
            AdminEntity user= userService.login(username,password);
            //3.判断登录状态
            if(user != null){
                //System.out.println("登录成功");
                request.getSession().setAttribute("loginUser",user);
                return "home";//主页面-后台页面
            }else{
                //System.out.println("登录失败，用户名密码不正确");
                addActionError("登录失败，用户名密码不正确");
            }
        }else{
            //System.out.println("验证码不正确");
            addActionError("验证码不正确");
        }
        return "loginfailure";
    }

    @Override
    public String save() {
        return null;
    }

    @Override
    public String update() {
        return null;
    }

    @Override
    public String delete() {
        return null;
    }

    @Override
    public String list() {
        return null;
    }

    public String logout(){
        //把session数据清除
        ServletActionContext.getRequest().getSession().invalidate();

        return "login";
    }

    public String editPassword() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        //1.获取新密码
        String newPwd = getModel().getPassword();

        //2.获取用户id
        AdminEntity loginUser = (AdminEntity) request .getSession().getAttribute("loginUser");
        String userId = loginUser.getAdmin();

        //3.调用service
        userService.modifyPassword(newPwd,userId);

        //4.返回一个数据
        response.setHeader("content-type","text/json;charset=utf-8");
        response.getWriter().print("{\"success\":\"1\"}");

        return NONE;
    }
}
