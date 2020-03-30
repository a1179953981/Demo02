package com.gyf.bos.dao.base;

import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Region;
import org.hibernate.criterion.DetachedCriteria;

import java.io.Serializable;
import java.util.List;

/**
 * 公共接口
 */
public interface IBaseDao<T> {

    //增
    public void save(T entity);

    //删
    public void delete(T entity);

    //改
    public void update(T entity);

    // 通过ID来查
    public T find(Serializable id);

    //查询表的所有数据
    public List<T> findAll();

    //查询表的所有数据
    public List<T> findAllByDetachedCriteria(DetachedCriteria dc);

    /**
     * 公共的更新方法
     * @param hql
     * @param objs
     */
    public void executeUpdate(String hql,Object... objs);

    /**
     * 公共的更新方法
     * @param queryName 在映射文件中配置的query名字
     * @param objs
     */
    public void executeUpdateByQueryName(String queryName, Object... objs);

    public void saveAll(List<T> list);

    /**
     * 公共的分页
     * @param pb
     */
    public void pageQuery(PageBean<T> pb);
}
