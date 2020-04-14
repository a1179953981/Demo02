package com.gyf.bos.model;

import javax.persistence.*;
import java.util.Objects;
//import java.util.Date;

@Entity
@Table(name = "computer_host", schema = "asset", catalog = "")
public class ComputerHostEntity {
    private String no;
    private String brand;
    private String cpu;
    private String rom;
    private String ram;
    private String type;
    private String mac;
    private String status;
    private String procurementDate;
    private String notes;
    private UserEntity userEntity;
    private String time;

    @Basic
    @Column(name = "time")
    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    @Id
    @Column(name = "User_Name")
    public UserEntity getUserEntity() {
        return userEntity;
    }

    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }


    @Id
    @Column(name = "No")
    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    @Basic
    @Column(name = "brand")
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    @Basic
    @Column(name = "cpu")
    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    @Basic
    @Column(name = "Rom")
    public String getRom() {
        return rom;
    }

    public void setRom(String rom) {
        this.rom = rom;
    }

    @Basic
    @Column(name = "Ram")
    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    @Basic
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Basic
    @Column(name = "Mac")
    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }

    @Basic
    @Column(name = "Status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Basic
    @Column(name = "Procurement_date")
    public String getProcurementDate() {
        return procurementDate;
    }

    public void setProcurementDate(String procurementDate) {
        this.procurementDate = procurementDate;
    }

    @Basic
    @Column(name = "Notes")
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ComputerHostEntity that = (ComputerHostEntity) o;
        return no == that.no &&
                status == that.status &&
                Objects.equals(brand, that.brand) &&
                Objects.equals(cpu, that.cpu) &&
                Objects.equals(rom, that.rom) &&
                Objects.equals(ram, that.ram) &&
                Objects.equals(type, that.type) &&
                Objects.equals(mac, that.mac) &&
                Objects.equals(procurementDate, that.procurementDate) &&
                Objects.equals(notes, that.notes);
    }

    @Override
    public int hashCode() {
        return Objects.hash(no, brand, cpu, rom, ram, type, mac, status, procurementDate, notes);
    }
}
