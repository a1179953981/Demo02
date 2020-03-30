package com.gyf.bos.service;

import com.gyf.bos.model.PageBean;
import com.gyf.bos.model.Subarea;
import com.gyf.bos.model.User;
import com.gyf.bos.service.base.IBaseService;

import java.util.List;

public interface ISubareaService extends IBaseService<Subarea>{
    public void pageQuery(PageBean<Subarea> pb);

    public List<Subarea> findAllWithUnbind();
}
