package com.gyf.bos.service;

import com.gyf.bos.model.*;
import com.gyf.bos.service.base.IBaseService;
import com.sun.org.apache.regexp.internal.RE;

import java.util.List;

public interface IRegionService extends IBaseService<MonitorEntity>{


    public void saveAll(List<MonitorEntity> regions);

    /**
     * 分页查询
     * @param pb
     */
    public void pageQuery(PageBean<MonitorEntity> pb);
    public List<MonitorEntity> findAllWithNoDelete();
    public void delete(String ids);

}
