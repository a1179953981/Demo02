package com.gyf.bos.dao.impl;

import com.gyf.bos.dao.IRegionDao;
import com.gyf.bos.dao.IStaffDao;
import com.gyf.bos.dao.base.BaseDaoImpl;
import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Region;
import com.gyf.bos.model.Staff;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RegionDaoImpl extends BaseDaoImpl<Region> implements IRegionDao {


}
