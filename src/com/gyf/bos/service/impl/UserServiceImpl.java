package com.gyf.bos.service.impl;

import com.gyf.bos.dao.IUserDao;
import com.gyf.bos.model.AdminEntity;
import com.gyf.bos.model.User;
import com.gyf.bos.service.IUserService;
import com.gyf.bos.service.base.BaseServiceImpl;
import com.gyf.bos.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Service
@Transactional//事务是由事务管理器来实现
public class UserServiceImpl extends BaseServiceImpl<AdminEntity> implements IUserService {

    @Autowired
    private IUserDao userDao;
    @Override
    public AdminEntity findByTel(String tel) {
        return null;
    }

      @Override
    public AdminEntity login(String username, String password) {
        return userDao.find(username, password);
    }

    @Override
    public void modifyPassword(String newPwd, String userId) {
        /*String hql = "UPDATE User SET password=? WHERE id = ?";
        userDao.executeUpdate(hql,MD5Utils.text2md5(newPwd),userId);*/

        userDao.executeUpdateByQueryName("updatePwd",MD5Utils.text2md5(newPwd),userId);
    }

    @Override
    public void save(AdminEntity entity) {

        userDao.save(entity);
    }

    @Override
    public void delete(AdminEntity entity) {
        userDao.delete(entity);
    }

    @Override
    public void update(AdminEntity entity) {
        userDao.update(entity);
    }

    @Override
    public AdminEntity find(Serializable id) {
        return userDao.find(id);
    }

    @Override
    public List<AdminEntity> findAll() {
        return userDao.findAll();
    }
}
