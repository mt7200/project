package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request;

public class PatientUpdateRequest {
    private String name;
    private String gender;
    private Integer age;
    private String phone;
    private String address;
    private String allergyInfo;
    private String status;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getAllergyInfo() { return allergyInfo; }
    public void setAllergyInfo(String allergyInfo) { this.allergyInfo = allergyInfo; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
