package com.gyf.bos.model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import java.util.Objects;

@Entity
@javax.persistence.Table(name = "User", schema = "asset", catalog = "")
public class UserEntity {
    private String name;

    @javax.persistence.Id
    @javax.persistence.Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    private String position;
    private String departments;

    @Basic
    @Column(name = "position")
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @Basic
    @Column(name = "departments")
    public String getDepartments() {
        return departments;
    }

    public void setDepartments(String departments) {
        this.departments = departments;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserEntity that = (UserEntity) o;
        return Objects.equals(position, that.position) &&
                Objects.equals(departments, that.departments);
    }

    @Override
    public int hashCode() {
        return Objects.hash(position, departments);
    }
    private String dateOfEntry;

    @Basic
    @javax.persistence.Column(name = "\r\nDate_of_entry")
    public String getDateOfEntry() {
        return dateOfEntry;
    }

    public void setDateOfEntry(String dateOfEntry) {
        this.dateOfEntry = dateOfEntry;
    }
}
