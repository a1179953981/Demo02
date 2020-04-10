package com.gyf.bos.web.action;

import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Staff;
import com.gyf.bos.model.User;
import com.gyf.bos.model.UserEntity;
import com.gyf.bos.service.IStaffService;
import com.gyf.bos.service.IUserService;
import com.gyf.bos.web.action.base.BaseAction;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class StaffAction extends BaseAction<UserEntity> {

    @Autowired
    private IStaffService staffService;
    @Override
    public String save() {
        System.out.println(getModel());
        staffService.save(getModel());
        return SUCCESS;//回到取派员列表界面
    }

    @Override
    public String update() {

        //getModel() 【游离/脱管状态 session没有缓存，有id】
        System.out.println("表单提交:" + getModel());
        staffService.update(getModel());

        return SUCCESS;
    }

    //=====================删除取派员=============================
    private String ids;
    public void setIds(String ids) {
        this.ids = ids;
    }
    @Override
    public String delete() throws IOException {
        //1.获取删除的id

        //2.调用service
        staffService.delete(ids);

        //3.响应
        HttpServletResponse response = ServletActionContext.getResponse();
        response.getWriter().write("success");

        return NONE;
    }

    @Override
    public String list() {
        return null;
    }

    //===================分页查询返回json数据==========================


    public void pageQuery() throws IOException {
        //1.接收参数 page[当前页] rows[每页显示多少条]
        //封装条件
        pb.setCurrentPage(page);
        pb.setPageSize(rows);
        DetachedCriteria dc = pb.getDetachedCriteria();
        String name=getModel().getName();
        if(!StringUtils.isEmpty(name)){
            dc.add(Restrictions.like("name","%"+name+"%"));
        }
        String position=getModel().getPosition();
        if(!StringUtils.isEmpty(position)){
            dc.add(Restrictions.like("position","%"+position+"%"));
        }
        String departments=getModel().getDepartments();
        if(!StringUtils.isEmpty(departments)){
            dc.add(Restrictions.like("departments","%"+departments+"%"));
        }
        String dateOfEntry=getModel().getDateOfEntry();
        if (!StringUtils.isEmpty(dateOfEntry)){
            dc.add(Restrictions.like("dateOfEntry","%"+dateOfEntry+"%"));
        }

        //2.调用service,参数里传一个PageBean
        staffService.pageQuery(pb);

        //3.返回json数据
        responseJson(pb,new String[]{"currentPage","pageSize","detachedCriteria","staff"});

    }

    public void listJson() throws IOException {
        //在职员工
        List<UserEntity> list = staffService.findAllWithNoDelete();


       responseJson(list,new String[]{"name","position","departments","dateOfEntry"});
    }
}
