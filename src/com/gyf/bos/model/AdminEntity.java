package com.gyf.bos.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "admin", schema = "asset", catalog = "")
public class AdminEntity {
    private String id;
    private String admin;
    private String password;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "admin")
    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    @Basic
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AdminEntity that = (AdminEntity) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(admin, that.admin) &&
                Objects.equals(password, that.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, admin, password);
    }
}
