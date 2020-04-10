package com.gyf.bos.service.impl;

import com.gyf.bos.dao.IStaffDao;
import com.gyf.bos.dao.IUserDao;
import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Staff;
import com.gyf.bos.model.User;
import com.gyf.bos.model.UserEntity;
import com.gyf.bos.service.IStaffService;
import com.gyf.bos.service.IUserService;
import com.gyf.bos.service.base.BaseServiceImpl;
import com.gyf.bos.utils.MD5Utils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Service
@Transactional//事务是由事务管理器来实现
public class StaffServiceImpl extends BaseServiceImpl<UserEntity> implements IStaffService {


    @Autowired
    private IStaffDao staffDao;
    private String ids;

    public void setIds(String ids) {
        this.ids = ids;
    }

    @Override
    public void save(UserEntity entity) {
        staffDao.save(entity);
    }

    @Override
    public void delete(String ids) {
        staffDao.delete(ids);
    }

    @Override
    public void update(UserEntity entity) {
        //实际可以不写，写也没有关系
        //staffDao.update(entity);

       //1.根据id从数据库获取数据【持久状态-session有缓存，有id】
        UserEntity staff = staffDao.find(entity.getName());

        //2.更新数据库的数据
        staff.setName(entity.getName());
        staff.setPosition(entity.getPosition());
        staff.setDepartments(entity.getDepartments());
        staff.setDateOfEntry(entity.getDateOfEntry());
        System.out.println("数据库：" + staff);
    }

    @Override
    public UserEntity find(Serializable id) {
        return   staffDao.find(id);
    }

    @Override
    public List<UserEntity> findAll() {
        return staffDao.findAll();
    }

    @Override
    public void pageQuery(PageBean<UserEntity> pb) {
        staffDao.pageQuery(pb);
    }

//    @Override
//    public void delete(String ids) {
////        String hql = "UPDATE Staff SET deltag = ? WHERE id = ?";
////
////        //拆分id
////        String[] idsArr = ids.split(",");
////        for (String id : idsArr){
////            staffDao.executeUpdate(hql,"1",id);
////            //staffDao.executeUpdateByQueryName("staff.delete","1",id);
////        }
//
//    }

    @Override
    public List<UserEntity> findAllWithNoDelete() {
        //离线查询对象
        DetachedCriteria dc = DetachedCriteria.forClass(Staff.class);
        dc.add(Restrictions.eq("deltag","0"));
        return staffDao.findAllByDetachedCriteria(dc);
    }
}
