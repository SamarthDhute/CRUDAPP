package com.samarth.CRUDAPP.DAO;

import com.samarth.CRUDAPP.Exception.DAOException;
import com.samarth.CRUDAPP.Model.Student;
import com.samarth.CRUDAPP.util.JDBCutils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAOImpl implements StudentDAO{
    private static final String INSERT_SQL = "INSERT INTO student(name,email,mobile) VALUES(?,?,?)";
    private static final String UPDATE_SQL = "UPDATE student SET name = ?, email = ? ,mobile = ? WHERE id = ?";
    private static final String DELETE_SQL = "DELETE FROM student WHERE id = ?";
    private static final String SELECT_BY_ID_SQL = "SELECT * FROM student WHERE id = ?";
    private static final String SELECT_ALL_SQL = "SELECT * FROM student ORDER BY id";


    @Override
    public void insert(Student student) {
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(INSERT_SQL)){

            pstmt.setString(1,student.getName());
            pstmt.setString(2,student.getEmail());
            pstmt.setString(3,student.getMobile());

            pstmt.executeUpdate();

        }catch(SQLException sqle){
            throw new DAOException("FAILED TO INSERT RECORD",sqle);
        }
    }

    @Override
    public void update(Student student) {
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(UPDATE_SQL)){

            pstmt.setString(1,student.getName());
            pstmt.setString(2,student.getEmail());
            pstmt.setString(3,student.getMobile());

            pstmt.setInt(4,student.getId());

            pstmt.executeUpdate();

        }catch(SQLException sqle){
            throw new DAOException("FAILED TO UPDATE RECORD",sqle);
        }

    }

    @Override
    public void delete(int id) {
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(DELETE_SQL)){

            pstmt.setInt(1,id);
            pstmt.executeUpdate();

        }catch(SQLException sqle){
            throw new DAOException("FAILED TO DELETE RECORD",sqle);
        }

    }

    @Override
    public Student getStudentByID(int id) {
        Student student;
        try (Connection con = JDBCutils.fetchConnection();
             PreparedStatement pstmt = con.prepareStatement(SELECT_BY_ID_SQL)) {
            student = null;

            pstmt.setInt(1, id);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                if (resultSet.next()) {
                    student = new Student();
                    student.setId(resultSet.getInt("id"));
                    student.setName(resultSet.getString("name"));
                    student.setEmail(resultSet.getString("email"));
                    student.setMobile(resultSet.getString("mobile"));
                }
            }

        } catch (SQLException sqle) {
            throw new DAOException("FAILED TO GET RECORD BY ID", sqle);
        }
        return student;
    }

    @Override
    public List<Student> getAllStudent() {
        List<Student> studentlist = new ArrayList<>();
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(SELECT_ALL_SQL);
            ResultSet resultset = pstmt.executeQuery()){

            while(resultset.next()){
                Student student = new Student();
                student.setId(resultset.getInt("id"));
                student.setName(resultset.getString("name"));
                student.setEmail(resultset.getString("email"));
                student.setMobile(resultset.getString("mobile"));

                studentlist.add(student);
            }

        }catch(SQLException sqle){
            throw new DAOException("FAILED TO GET STUDENT RECORDS",sqle);
        }
        return studentlist;
    }
}
