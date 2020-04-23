package com.gyf.bos.service.impl;

import com.gyf.bos.dao.IRegionDao;
import com.gyf.bos.dao.ISubareaDao;
import com.gyf.bos.model.*;
import com.gyf.bos.service.IRegionService;
import com.gyf.bos.service.ISubareaService;
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
public class SubareaServiceImpl extends BaseServiceImpl<ComputerHostEntity> implements ISubareaService {


    @Autowired
    private ISubareaDao subareaDao;

    @Override
    public void save(ComputerHostEntity entity) {
        subareaDao.save(entity);
    }

    @Override
    public void delete(String ids) {
        subareaDao.delete(ids);

    }

    @Override
    public void update(ComputerHostEntity entity) {
//        ComputerHostEntity subarea = subareaDao.find(entity.getNo());

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
        subareaDao.update(entity);
    }

    @Override
    public ComputerHostEntity find(Serializable id) {
        return null;
    }

    @Override
    public List<ComputerHostEntity> findAll() {
        return subareaDao.findAll();
    }

    @Override
    public void pageQuery(PageBean<ComputerHostEntity> pb) {
        subareaDao.pageQuery(pb);
    }

    @Override
    public List<ComputerHostEntity> findAllWithUnbind() {
        DetachedCriteria dc = DetachedCriteria.forClass(Subarea.class);
        dc.add(Restrictions.isNull("decidedzone"));
        return subareaDao.findAllByDetachedCriteria(dc);
    }

}
