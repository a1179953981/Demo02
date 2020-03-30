package com.gyf.bos.dao;

import com.gyf.bos.dao.base.IBaseDao;
import com.gyf.bos.model.User;

public interface IUserDao extends IBaseDao<User> {

    public User findByEmail(String email);

    public User find(String username,String password);
}
