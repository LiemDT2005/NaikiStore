/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class Staff {
    
    private String staffID;
    private String staffName;
    private String email;
    private String avatar;
    private Timestamp tokenExpiry;
    private String password;
    private String phone;
    private Gender gender;
    private String address;
    private Role role;
    private Staff supervisor;
    private Status status;
    private String passwordRecoveryToken;
    private Timestamp hireDate;
    private String citizenID;

    public Staff() {
    }
    
    public enum Gender {
        MALE, FEMALE, OTHER
    }

    public enum Role {
        ADMIN, STAFF
    }

    public enum Status {
        ACTIVE, INACTIVE, DELETED
    }

    public Staff(String staffID, String staffName, String email, String avatar, Timestamp tokenExpiry, String password, String phone, Gender gender, String address, Role role, Staff supervisor, Status status, String passwordRecoveryToken, Timestamp hireDate) {
        this.staffID = staffID;
        this.staffName = staffName;
        this.email = email;
        this.avatar = avatar;
        this.tokenExpiry = tokenExpiry;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.role = role;
        this.supervisor = supervisor;
        this.status = status;
        this.passwordRecoveryToken = passwordRecoveryToken;
        this.hireDate = hireDate;
    }

    public Staff(String staffID, String staffName, String email, String avatar, Timestamp tokenExpiry, String password, String phone, Gender gender, String address, Role role, Staff supervisor, Status status, String passwordRecoveryToken, Timestamp hireDate, String citizenID) {
        this.staffID = staffID;
        this.staffName = staffName;
        this.email = email;
        this.avatar = avatar;
        this.tokenExpiry = tokenExpiry;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.role = role;
        this.supervisor = supervisor;
        this.status = status;
        this.passwordRecoveryToken = passwordRecoveryToken;
        this.hireDate = hireDate;
        this.citizenID = citizenID;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Timestamp getTokenExpiry() {
        return tokenExpiry;
    }

    public void setTokenExpiry(Timestamp tokenExpiry) {
        this.tokenExpiry = tokenExpiry;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Staff getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(Staff supervisor) {
        this.supervisor = supervisor;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getPasswordRecoveryToken() {
        return passwordRecoveryToken;
    }

    public void setPasswordRecoveryToken(String passwordRecoveryToken) {
        this.passwordRecoveryToken = passwordRecoveryToken;
    }

    public Timestamp getHireDate() {
        return hireDate;
    }

    public void setHireDate(Timestamp hireDate) {
        this.hireDate = hireDate;
    }

    @Override
    public String toString() {
        return "Staffs{" + "staffID=" + staffID + ", staffName=" + staffName + ", email=" + email + ", avatar=" + avatar + ", tokenExpiry=" + tokenExpiry + ", password=" + password + ", phone=" + phone + ", gender=" + gender + ", address=" + address + ", role=" + role + ", supervisor=" + supervisor + ", status=" + status + ", passwordRecoveryToken=" + passwordRecoveryToken + ", hireDate=" + hireDate + ", citizenID=" + citizenID + '}';
    }

    public String getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(String citizenID) {
        this.citizenID = citizenID;
    }
    
}
