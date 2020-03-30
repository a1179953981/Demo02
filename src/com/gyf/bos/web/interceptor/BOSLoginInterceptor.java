package com.gyf.bos.web.interceptor;

import com.gyf.bos.model.User;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import org.apache.struts2.ServletActionContext;

public class BOSLoginInterceptor extends MethodFilterInterceptor {

    /**
     * string返回的是action的方法返回值
     */
    @Override
    protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
        //是否登录
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("loginUser");

        System.out.println("拦截了.." + ServletActionContext.getRequest().getRequestURL());
        if (user != null){
            return actionInvocation.invoke();
        }
        return "login";//回到登录页面,配置一个全局的result
    }

    /*
    * 1.写个登录拦截器
    * 2.在struts.xml配置一个登录拦截器
    * 3.配置一个拦截器分组，把登录拦截器和struts默认拦截器添加进组
    * 4.修改struts默认拦截器
    * 5.在登录拦截器排除一些不需要拦截的方法excludeMethods
    * */
}
