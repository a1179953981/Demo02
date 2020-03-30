package com.gyf.bos.dao.impl;

import com.gyf.bos.dao.IStaffDao;
import com.gyf.bos.dao.IUserDao;
import com.gyf.bos.dao.base.BaseDaoImpl;
import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Staff;
import com.gyf.bos.model.User;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class StaffDaoImpl extends BaseDaoImpl<Staff> implements IStaffDao{


}
