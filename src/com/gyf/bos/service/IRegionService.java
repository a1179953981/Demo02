package com.gyf.bos.service;

import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Region;
import com.gyf.bos.model.Staff;
import com.gyf.bos.service.base.IBaseService;
import com.sun.org.apache.regexp.internal.RE;

import java.util.List;

public interface IRegionService extends IBaseService<Region>{


    public void saveAll(List<Region> regions);

    /**
     * 分页查询
     * @param pb
     */
    public void pageQuery(PageBean<Region> pb);

}
