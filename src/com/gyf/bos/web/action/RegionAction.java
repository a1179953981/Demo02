package com.gyf.bos.web.action;

import com.gyf.bos.model.*;
import com.gyf.bos.service.IRegionService;
import com.gyf.bos.service.IStaffService;
import com.gyf.bos.utils.PinYin4jUtils;
import com.gyf.bos.web.action.base.BaseAction;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.apache.commons.lang3.StringUtils;
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
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class RegionAction extends BaseAction<MonitorEntity>{


    @Autowired
    private IRegionService regionService;
   private File excelFile;

    public void setExcelFile(File excelFile) {
        this.excelFile = excelFile;
    }

//    public String importExcel() throws Exception {
//        System.out.println(excelFile.getAbsolutePath());
//        //1.解析excel文件中数据
//        //1.1创建Workbook
//        HSSFWorkbook  workbook = new HSSFWorkbook(new FileInputStream(excelFile));
//
//        //1.2 获取sheet
//        Sheet sheet = workbook.getSheetAt(0);
//
//        //1.3遍历里面数据
//        List<MonitorEntity> regions = new ArrayList<MonitorEntity>();
//        for(Row row : sheet){
//            String id = row.getCell(0).getStringCellValue();
//            String province = row.getCell(1).getStringCellValue();
//            String city=  row.getCell(2).getStringCellValue();
//            String district = row.getCell(3).getStringCellValue();
//            String postcode = row.getCell(4).getStringCellValue();
//
//            //根据中文生成城市编码
//            String citycode = StringUtils.join(PinYin4jUtils.stringToPinyin(city),"");
//
//            //根据中文生成简码
//            String cityTmp = city.substring(0,city.length() - 1);
//            String districtTmp = district.substring(0,district.length() - 1);
//            String[] cityStrs =  PinYin4jUtils.getHeadByString(cityTmp);
//            String[] districtStrs = PinYin4jUtils.getHeadByString(districtTmp);
//            String shortcode = StringUtils.join(cityStrs,"") + StringUtils.join(districtStrs,"");
//
//            //封装成Region模型
//            MonitorEntity region = new MonitorEntity(no,brand,city,district,postcode);
//            region.setCitycode(citycode);
//            region.setShortcode(shortcode);
//            regions.add(region);
//            System.out.println("----------------------------------");
//        }
//
//        regions.remove(0);//移除第一行的标题数据
//
//        //调用service
//       regionService.saveAll(regions);
//
//        //响应
//       responseStr("success");
//
//       return NONE;
//   }

    @Override
    public String save() {
        regionService.save(getModel());
        return SUCCESS;
    }

    @Override
    public String update() {

        System.out.println("表单提交:" + getModel());
        regionService.update(getModel());

        return SUCCESS;
    }
    private String ids;

    public void setIds(String ids) {
        this.ids = ids;
    }

    @Override
    public String delete() throws IOException {
        regionService.delete(ids);

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
//1.接收参数 page[当前页] rows[每页显示多少条]
        //封装条件
        pb.setCurrentPage(page);
        pb.setPageSize(rows);
        DetachedCriteria dc = pb.getDetachedCriteria();
        String no=getModel().getNo();
        if(!StringUtils.isEmpty(no)){
            dc.add(Restrictions.like("no","%"+no+"%"));
        }
        String brand=getModel().getBrand();
        if(!StringUtils.isEmpty(brand)){
            dc.add(Restrictions.like("brand","%"+brand+"%"));
        }
        String size=getModel().getSize();
        if(!StringUtils.isEmpty(size)){
            dc.add(Restrictions.like("size","%"+size+"%"));
        }
        UserEntity user = getModel().getUserEntity();
        if (user != null) {
            String name = user.getName();
//            dc.createAlias("user", "r");//创建一个别名

            if (!StringUtils.isEmpty(name)) {
                dc.add(Restrictions.like("userEntity.name", "%" + name + "%"));
            }
        }
        String starus=getModel().getStarus();
        if (!StringUtils.isEmpty(starus)){
            dc.add(Restrictions.like("starus","%"+starus+"%"));
        }

        //2.调用service,参数里传一个PageBean
        regionService.pageQuery(pb);

        //3.返回json数据
        responseJson(pb,new String[]{"currentPage","pageSize","detachedCriteria","region"});

    }

    public void listJson() throws IOException {
//        // 查询所有区域
//        List<MonitorEntity> regions = regionService.findAllWithNoDelete();
//
//        //返回json数据
//        /**
//         *转json不要转subareas字段，否则会出现死循环
//         */
//        responseJson(regions,new String[]{"no","brand","size","note","starus"});
    }
}
