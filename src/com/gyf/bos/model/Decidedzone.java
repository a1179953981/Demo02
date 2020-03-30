package com.gyf.bos.model;

public class Decidedzone {
    private String id;
    private String name;

    private Staff staff;//员工

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

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

    @Override
    public String toString() {
        return "Decidedzone{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
