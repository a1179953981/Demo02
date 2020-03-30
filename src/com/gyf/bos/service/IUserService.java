package com.gyf.bos.service;

import com.gyf.bos.model.AdminEntity;
//import com.gyf.bos.model.User;
import com.gyf.bos.service.base.IBaseService;

public interface IUserService extends IBaseService<AdminEntity>{

    //特有的业务方法
    public AdminEntity findByTel(String tel);

    public AdminEntity login(String username, String password);

    public void modifyPassword(String newPwd,String userId);
}
