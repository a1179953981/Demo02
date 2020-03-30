package com.gyf.bos.service;

import com.gyf.bos.model.Decidedzone;
import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Region;
import com.gyf.bos.service.base.IBaseService;

import java.util.List;

public interface IDecidedzoneService extends IBaseService<Decidedzone>{


    /**
     *
     * @param dz 定区数据
     * @param subareaIds 分区的ids
     */
    public void save(Decidedzone dz,String[] subareaIds);

    public void pageQuery(PageBean<Decidedzone> pb);
}
