package com.test;

import com.gyf.bos.dao.IUserDao;
import com.gyf.bos.model.AdminEntity;
import com.gyf.bos.model.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:beans.xml")
public class Demo01 {

    @Autowired
    private IUserDao userDao;
    //测试Dao
    @Test
    public void test1(){
        //spring配置要做好
        /**
         * 1.spring的单元测试加载spring配置文件
         * 2.配置一个UserDaoImpl的bean【注解@Repository】
         * 3.配置hibernateTemplate的bean
         * 4.事务?
         */

        //1.创建User
        User user = new User();
        user.setUsername("abc");
        user.setPassword("123");

        //2.调用dao【保存用户】
        //userDao.save(user);

        //获取用户
        /*User user1 = userDao.find("4028b881632f1d9d01632f1da0210000");
        System.out.println(user1);*/

        //获取所有用户
        List<AdminEntity> users = userDao.findAll();
        System.out.println(users);
    }
}
