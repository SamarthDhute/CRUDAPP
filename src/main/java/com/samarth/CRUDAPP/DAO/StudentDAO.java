package com.samarth.CRUDAPP.DAO;

import com.samarth.CRUDAPP.Model.Student;

import java.util.List;

public interface StudentDAO {
    void insert(Student student);
    void update(Student student);
    void delete(int id);
    Student getStudentByID(int id);
    List<Student> getAllStudent();
}
