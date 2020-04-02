package com.gyf.bos.service;

import com.gyf.bos.model.ComputerHostEntity;
import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Subarea;
import com.gyf.bos.model.User;
import com.gyf.bos.service.base.IBaseService;

import java.util.List;

public interface ISubareaService extends IBaseService<ComputerHostEntity>{
    public void pageQuery(PageBean<ComputerHostEntity> pb);

    public List<ComputerHostEntity> findAllWithUnbind();
}
