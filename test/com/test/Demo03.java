package com.test;

import com.gyf.bos.model.User;
import com.gyf.bos.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:beans.xml")
public class Demo03 {

    @Autowired
    private IUserService userService;
    //测试Dao
    @Test
    public void test1(){
        //在dao中抽取一个公共的执行hql的方法
        /**
         * 1.public void executeUpdate(String hql, Object... objs)
         * 2.public void executeUpdateByQueryName(String queryName, Object... objs)
         *   step01: queryName是在映射文件中配置一个查询hql语句
         *   step02:
         */
        userService.modifyPassword("123","1");
    }
}
