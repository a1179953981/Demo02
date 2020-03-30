package com.gyf.bos.model;

import java.util.HashSet;
import java.util.Set;

public class Region {
    private String id;
    private String province;
    private String city;
    private String district;
    private String postcode;
    private String shortcode;
    private String citycode;

    //一个区域对应多个分区
    private Set<Subarea> subareas = new HashSet<Subarea>();

    public Set<Subarea> getSubareas() {
        return subareas;
    }

    public void setSubareas(Set<Subarea> subareas) {
        this.subareas = subareas;
    }

    public String getName(){
        return province + city + district;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getShortcode() {
        return shortcode;
    }

    public void setShortcode(String shortcode) {
        this.shortcode = shortcode;
    }

    public String getCitycode() {
        return citycode;
    }

    public void setCitycode(String citycode) {
        this.citycode = citycode;
    }

    @Override
    public String toString() {
        return "Region{" +
                "id='" + id + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", district='" + district + '\'' +
                ", postcode='" + postcode + '\'' +
                ", shortcode='" + shortcode + '\'' +
                ", citycode='" + citycode + '\'' +
                '}';
    }

    public Region() {
    }

    public Region(String id, String province, String city, String district, String postcode) {
        this.id = id;
        this.province = province;
        this.city = city;
        this.district = district;
        this.postcode = postcode;
    }
}
