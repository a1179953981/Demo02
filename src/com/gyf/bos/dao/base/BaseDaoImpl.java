package com.gyf.bos.dao.base;

import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Region;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import sun.reflect.generics.reflectiveObjects.ParameterizedTypeImpl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

public class BaseDaoImpl<T> implements IBaseDao<T>{

    private Class<T> entityClass;
    public BaseDaoImpl(){
        System.out.println("公共Dao实现类的空参构造方法");
        //获取泛型的真实类型
        /**
         * 1.this.getClass().getGenericSuperclass()获取泛型父类
         * 2.ParameterizedType 参数类型
         */
        ParameterizedType pt = (ParameterizedType) this.getClass().getGenericSuperclass();

        //获取泛型真实类型
        Type[] types = pt.getActualTypeArguments();

        //把type类型赋值给Class类型
        entityClass = (Class<T>) types[0];
        //System.out.println(entityClass);
       /* for (Type type : types){
            System.out.println(type);
        }*/
    }
    @Autowired //由spring自动注入
    protected HibernateTemplate hibernateTemplate;

    @Override
    public void save(T entity) {
        this.hibernateTemplate.save(entity);
    }

    @Override
    public void delete(T entity) {
        this.hibernateTemplate.delete(entity);
    }

    @Override
    public void update(T entity) {

        this.hibernateTemplate.update(entity);
    }

    @Override
    public T find(Serializable id) {
        return this.hibernateTemplate.get(entityClass,id);
    }

    @Override
    public List<T> findAll() {
        //entityClass.getSimpleName() 获取类名
        String hql = "from " + entityClass.getSimpleName();
        System.out.println("hql:" + hql);
        return this.hibernateTemplate.find(hql);
    }

    @Override
    public List<T> findAllByDetachedCriteria(DetachedCriteria dc) {
        return this.hibernateTemplate.findByCriteria(dc);
    }

    @Override
    public void executeUpdate(String hql, Object... objs) {
        //获取session
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();

        //获取查询对象
        //update User set password=? where id = ?;
        Query query = session.createQuery(hql);

        //设置参数
        for(int i=0;i<objs.length;i++){
            query.setParameter(i,objs[i]);
        }
        //执行
        query.executeUpdate();

    }

    @Override
    public void executeUpdateByQueryName(String queryName, Object... objs) {
        //获取session
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();

        //从映射文件中查找hql，并返回query对象
        Query query = session.getNamedQuery(queryName);

        //设置参数
        for(int i=0;i<objs.length;i++){
            query.setParameter(i,objs[i]);
        }
        //执行
        query.executeUpdate();
    }

    @Override
    public void saveAll(List<T> list) {
        hibernateTemplate.saveOrUpdateAll(list);
    }

    @Override
    public void pageQuery(PageBean<T> pb) {
        //1.查询总记录数
        //获取离线的查询对象
        DetachedCriteria dc = pb.getDetachedCriteria();

        //select count(*) From Staff;
        //设置查询总记录数条件
        dc.setProjection(Projections.rowCount());

        List<Long> list = hibernateTemplate.findByCriteria(dc);
        Long total = list.get(0);

        pb.setTotal(total.intValue());

        //2.查询分页数据
        dc.setProjection(null);//把之前条件清空
        dc.setResultTransformer(DetachedCriteria.ROOT_ENTITY);//重置hql
        //limit 0,10
        int start = (pb.getCurrentPage() - 1) * pb.getPageSize();
        int length = pb.getPageSize();
        List<T> rows = hibernateTemplate.findByCriteria(dc,start,length);
        pb.setRows(rows);
    }
}
