package com.test;

import com.gyf.bos.dao.IUserDao;
import com.gyf.bos.model.AdminEntity;
import com.gyf.bos.model.User;
import com.gyf.bos.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:beans.xml")
public class Demo02 {

    @Autowired
    private IUserService userService;
    //测试Dao
    @Test
    public void test1(){
        //1.创建User
        AdminEntity user = new AdminEntity();
        user.setAdmin("gyf");
        user.setPassword("123");

        //2.保存
        userService.save(user);
    }
}
