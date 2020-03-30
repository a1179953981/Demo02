package com.gyf.bos.dao;

import com.gyf.bos.dao.base.IBaseDao;
import com.gyf.bos.model.AdminEntity;
//import com.gyf.bos.model.User;

public interface IUserDao extends IBaseDao<AdminEntity> {

    public AdminEntity findByEmail(String email);

    public AdminEntity find(String username, String password);
}
