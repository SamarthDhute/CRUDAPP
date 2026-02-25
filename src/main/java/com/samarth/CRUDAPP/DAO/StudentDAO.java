package com.samarth.CRUDAPP.DAO;

import com.samarth.CRUDAPP.Model.Student;
import com.samarth.CRUDAPP.Model.Pagination;

import java.util.List;

public interface StudentDAO {
    void insert(Student student);
    void update(Student student);
    void delete(int id);
    Student getStudentByID(int id);
    List<Student> getSelectedStudent(Pagination pagination);
    int getToatalRecords();
}
