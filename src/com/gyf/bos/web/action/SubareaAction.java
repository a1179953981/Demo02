package com.gyf.bos.web.action;

import com.gyf.bos.model.ComputerHostEntity;
import com.gyf.bos.model.Region;
import com.gyf.bos.model.Subarea;
import com.gyf.bos.model.UserEntity;
import com.gyf.bos.service.IRegionService;
import com.gyf.bos.service.ISubareaService;
import com.gyf.bos.utils.PinYin4jUtils;
import com.gyf.bos.web.action.base.BaseAction;
import org.apache.commons.collections.functors.NonePredicate;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class SubareaAction extends BaseAction<ComputerHostEntity> {

    @Autowired
    private ISubareaService subareaService;

    @Override
    public String save() {
//        ComputerHostEntity c=this.getModel();
//        System.out.println("数据1:" + getModel());
        //调用service
        ComputerHostEntity computerHostEntity =getModel();
        if(computerHostEntity.getUserEntity().getName().equals(""))
        {
            computerHostEntity.setUserEntity(null);
        }
        subareaService.save(computerHostEntity);
        return SUCCESS;
    }

    @Override
    public String update() {
        ComputerHostEntity computerHostEntity =getModel();
        if(computerHostEntity.getUserEntity().getName().equals(""))
        {
            computerHostEntity.setUserEntity(null);
        }
        subareaService.update(computerHostEntity);
        return SUCCESS;
    }

    //   根据id 删除
    private String ids;
    public void setIds(String ids) {
        this.ids = ids;
    }

    @Override
    public String delete() throws IOException {
        System.out.println("ids====================================================="+ids);

        subareaService.delete(ids);

        //响应
        HttpServletResponse response = ServletActionContext.getResponse();
        response.getWriter().write("success");

        return NONE;
    }

    @Override
    public String list() {
        return null;
    }

    public void pageQuery() throws IOException {
        pb.setCurrentPage(page);
        pb.setPageSize(rows);

        //添加查询的条件
        DetachedCriteria dc = pb.getDetachedCriteria();//Subarea
        // addresskey:d
        String no = getModel().getNo();
        if (!StringUtils.isEmpty(no)) {
            dc.add(Restrictions.like("no", "%" + no + "%"));
        }

        UserEntity user = getModel().getUserEntity();
        if (user != null) {
            String name = user.getName();
//            dc.createAlias("user", "r");//创建一个别名

            if (!StringUtils.isEmpty(name)) {
                dc.add(Restrictions.like("userEntity.name", "%" + name + "%"));
            }
        }
        String mac = getModel().getMac();
        if (!StringUtils.isEmpty(mac)) {
            dc.add(Restrictions.like("mac", "%" + mac + "%"));
        }
        String type = getModel().getType();
        if (!StringUtils.isEmpty(type)) {
            dc.add(Restrictions.like("type", "%" + type + "%"));
        }
        String status = getModel().getStatus();
        if (!StringUtils.isEmpty(status)) {
            dc.add(Restrictions.like("status", "%" + status + "%"));
        }


        //2.调用service,参数里传一个PageBean
        subareaService.pageQuery(pb);

        //3.返回json数据
        responseJson(pb, new String[]{"currentPage", "pageSize", "detachedCriteria", "subareas"});
        System.out.println();
//        1.接收参数 page[当前页] rows[每页显示多少条]
//        封装条件
//        pb.setCurrentPage(page);
//        pb.setPageSize(rows);
//
//        //2.调用service,参数里传一个PageBean
//        subareaService.pageQuery(pb);
//
//        //3.返回json数据
//        responseJson(pb,new String[]{"currentPage","pageSize","detachedCriteria"});

    }


    //导出表格【下载一个xls文件】
    public void exportExcel() throws IOException {
//
//        //准备xls文件【输入流】
//        //1.创建wookbook【相当于xls文件】
//        HSSFWorkbook workbook = new HSSFWorkbook();
//
//        //2.创建sheet
//        HSSFSheet sheet = workbook.createSheet("分区数据");
//
//        //3.创建标题行
//        HSSFRow row = sheet.createRow(0);
//        row.createCell(0).setCellValue("分区编码");
//        row.createCell(1).setCellValue("区域编码");
//        row.createCell(2).setCellValue("关键字");
//
//        row.createCell(3).setCellValue("省市区");
//
//        //4.查询数据
//        List<Subarea> subareas = subareaService.findAll();
//        for(Subarea s : subareas){
//            row = sheet.createRow(sheet.getLastRowNum() + 1);
//            row.createCell(0).setCellValue(s.getId());
//            row.createCell(1).setCellValue(s.getRegion().getId());
//            row.createCell(2).setCellValue(s.getAddresskey());
//            row.createCell(3).setCellValue(s.getRegion().getName());
//        }
//
//        //响应【输出流】
//        HttpServletResponse response =  ServletActionContext.getResponse();
//        //设置响应头
//        String fileName = URLEncoder.encode("分区数据.xls","utf-8");
//        response.setHeader("Content-Disposition","attachment;filename=" + fileName);
//
//
//        String contentType = ServletActionContext.getServletContext().getMimeType(fileName);
//        System.out.println(contentType);
//        response.setContentType(contentType);
//        //response.setContentType("application/octet-stream");
//
//        OutputStream os = response.getOutputStream();
//        workbook.write(os);
    }

    public void listJson() throws IOException {
//        //未绑定的分区数据【也就是这个分区没有指向一个员工负责】
//        List<Subarea> list = subareaService.findAllWithUnbind();
//        responseJson(list,new String[]{"decidedzone","region"});
    }
}
