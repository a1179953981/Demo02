package com.gyf.bos.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "Monitor", schema = "asset", catalog = "")
public class MonitorEntity {

    private String no;

    @Id
    @Column(name = "No")
    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    private String brand;

    @Basic
    @Column(name = "brand")
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    private String size;

    @Basic
    @Column(name = "Size")
    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    private String note;

    @Basic
    @Column(name = "Note")
    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    private UserEntity userEntity;

    @Basic
    @Column(name = "User_Name")
    public UserEntity getUserEntity() {
        return userEntity;
    }

    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }

    private String starus;

    @Basic
    @Column(name = "Starus")
    public String getStarus() {
        return starus;
    }

    public void setStarus(String starus) {
        this.starus = starus;
    }

    @Override
    public String toString() {
        return "MonitorEntity{" +
                "no=" + no +
                ", brand='" + brand + '\'' +
                ", size=" + size +
                ", note='" + note + '\'' +
                ", starus='" + starus + '\'' +
                '}';
    }
}
