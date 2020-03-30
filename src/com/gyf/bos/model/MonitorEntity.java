package com.gyf.bos.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "Monitor", schema = "asset", catalog = "")
public class MonitorEntity {
    private int no;

    @Id
    @Column(name = "No")
    public int getNo() {
        return no;
    }

    public void setNo(int no) {
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

    private Integer size;

    @Basic
    @Column(name = "Size")
    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
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
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MonitorEntity that = (MonitorEntity) o;
        return no == that.no &&
                Objects.equals(brand, that.brand) &&
                Objects.equals(size, that.size) &&
                Objects.equals(note, that.note) &&
                Objects.equals(starus, that.starus);
    }

    @Override
    public int hashCode() {
        return Objects.hash(no, brand, size, note, starus);
    }
}
