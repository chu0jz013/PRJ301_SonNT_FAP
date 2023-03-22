/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author willi
 */
public class Enrollment {

    private int enrollment_id;
    private Student student;
    private Group group;
    private int total_slot;
    private int total_absent_slot;
    private String comments;
    private ArrayList<Attendance> attendances;

    public int getTotal_slot() {
        return total_slot;
    }

    public void setTotal_slot(int total_slot) {
        this.total_slot = total_slot;
    }

    public int getTotal_absent_slot() {
        return total_absent_slot;
    }

    public void setTotal_absent_slot(int total_absent_slot) {
        this.total_absent_slot = total_absent_slot;
    }

    public Enrollment() {
    }

    public ArrayList<Attendance> getAttendances() {
        return attendances;
    }

    public void setAttendances(ArrayList<Attendance> attendances) {
        this.attendances = attendances;
    }

    public int getEnrollment_id() {
        return enrollment_id;
    }

    public void setEnrollment_id(int enrollment_id) {
        this.enrollment_id = enrollment_id;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

}
