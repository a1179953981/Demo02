package com.gyf.bos.service.impl;

import com.gyf.bos.dao.IRegionDao;
import com.gyf.bos.dao.IStaffDao;
import com.gyf.bos.model.*;
import com.gyf.bos.service.IRegionService;
import com.gyf.bos.service.IStaffService;
import com.gyf.bos.service.base.BaseServiceImpl;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Service
@Transactional//事务是由事务管理器来实现
public class RegionServiceImpl extends BaseServiceImpl<MonitorEntity> implements IRegionService {


    @Autowired
    private IRegionDao regionDao;
    @Override
    public void save(MonitorEntity entity) {
        regionDao.save(entity);
    }

    @Override
    public void delete(String ids) {
        regionDao.delete(ids);
    }

    @Override
    public void update(MonitorEntity entity) {
//        MonitorEntity staff = regionDao.find(entity.getNo());
//

//        //2.更新数据库的数据
////        subarea.setTime(entity.getTime());
//        subarea.setNo(entity.getNo());
//        subarea.setBrand(entity.getBrand());
//        subarea.setCpu(entity.getCpu());
//        subarea.setMac(entity.getMac());
//        subarea.setNotes(entity.getNotes());
//        subarea.setProcurementDate(entity.getProcurementDate());
//        subarea.setRam(entity.getRam());
//        subarea.setRom(entity.getRom());
//        subarea.setStatus(entity.getStatus());
//        subarea.setType(entity.getType());
        regionDao.update(entity);
    }

    @Override
    public MonitorEntity find(Serializable id) {
        return null;
    }

    @Override
    public List<MonitorEntity> findAll() {
        return regionDao.findAll();
    }

    @Override
    public void saveAll(List<MonitorEntity> regions) {
        regionDao.saveAll(regions);
    }

    @Override
    public void pageQuery(PageBean<MonitorEntity> pb) {
        regionDao.pageQuery(pb);
    }

    @Override
    public List<MonitorEntity> findAllWithNoDelete() {
        //离线查询对象
        DetachedCriteria dc = DetachedCriteria.forClass(Staff.class);
        dc.add(Restrictions.eq("deltag","0"));
        return regionDao.findAllByDetachedCriteria(dc);
    }
}
