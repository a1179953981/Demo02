package com.gyf.bos.service;

import com.gyf.bos.model.User;
import com.gyf.bos.service.base.IBaseService;

public interface IUserService extends IBaseService<User>{

    //特有的业务方法
    public User findByTel(String tel);

    public User login(String username,String password);

    public void modifyPassword(String newPwd,String userId);
}
