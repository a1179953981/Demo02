package com.gyf.bos.model;

public class Staff {
    private String id;
    private String name;//名字
    private String telephone;//手机
    private String haspda;//是否有台设备 0:无 1：有
    private String deltag = "0";//删除标志 0:正常在职 1：离职
    private String station;//所属单位
    private String standard;//收费标准

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getHaspda() {
        return haspda;
    }

    public void setHaspda(String haspda) {
        this.haspda = haspda;
    }

    public String getDeltag() {
        return deltag;
    }

    public void setDeltag(String deltag) {
        this.deltag = deltag;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard;
    }


    @Override
    public String toString() {
        return "Staff{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", telephone='" + telephone + '\'' +
                ", haspda='" + haspda + '\'' +
                ", deltag='" + deltag + '\'' +
                ", station='" + station + '\'' +
                ", standard='" + standard + '\'' +
                '}';
    }
}
