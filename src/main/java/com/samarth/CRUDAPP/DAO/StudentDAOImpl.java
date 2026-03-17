package com.samarth.CRUDAPP.DAO;

import com.samarth.CRUDAPP.Exception.DAOException;
import com.samarth.CRUDAPP.Model.Pagination;
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
    private static final String SELECT_STUDENT = "SELECT id,name, email, mobile FROM student ";
    private static final String PAGINATION_SQL = " LIMIT ? OFFSET ?";
    private static final String COUNT_SQL = "SELECT COUNT(*) FROM student";
    private static final String SEARCH_WITH_NAME ="SELECT * FROM student WHERE LOWER(name) LIKE ? ";
    private static final String SEARCH_WITH_MOBILE ="SELECT * FROM student WHERE mobile LIKE ? ";
    private static final String SEARCH_WITH_EMAIL ="SELECT * FROM student WHERE LOWER(email) LIKE ? ";
    private static final String SEARCH_NAME_COUNT = "SELECT COUNT(*) FROM student WHERE LOWER(name) LIKE ? ";
    private static final String SEARCH_EMAIL_COUNT = "SELECT COUNT(*) FROM student WHERE LOWER(email) LIKE ? ";
    private static final String SEARCH_MOBILE_COUNT = "SELECT COUNT(*) FROM student WHERE mobile LIKE ? ";



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
    public List<Student> getSelectedStudent(Pagination pagination) {
        String sql = SELECT_STUDENT + PAGINATION_SQL;

        List<Student> studentlist = new ArrayList<>();
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(sql)){

            pstmt.setInt(1,pagination.getPagesize());
            pstmt.setInt(2,pagination.getOffest());


            ResultSet resultset = pstmt.executeQuery();
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

    @Override
    public int getToatalRecords(){
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(COUNT_SQL)){

            try (ResultSet resultset = pstmt.executeQuery()) {

                if (resultset.next()) {
                    return resultset.getInt(1);  // Get count directly as int
                }
            }


        }catch(SQLException sqle){
            throw new DAOException("FAILED TO GET TOTAL STUDENT RECORDS",sqle);
        }
        return 0;
    }

    @Override
    public List<Student> searchStudents(String search,String type,Pagination pagination) {
        String sql ;
        switch (type) {
            case "email":
                sql =SEARCH_WITH_EMAIL + PAGINATION_SQL;
                break;
            case "mobile":
                sql =SEARCH_WITH_MOBILE + PAGINATION_SQL;
                break;
            case "name":
                sql = SEARCH_WITH_NAME + PAGINATION_SQL;
                break;

            default:sql = SEARCH_WITH_NAME;
               break;
        }

        List<Student> studentlist = new ArrayList<>();
        try(Connection con = JDBCutils.fetchConnection();
            PreparedStatement pstmt = con.prepareStatement(sql)){

            pstmt.setString(1,"%" + search.toLowerCase() + "%");
            pstmt.setInt(2,pagination.getPagesize());
            pstmt.setInt(3,pagination.getOffest());
            ResultSet resultset = pstmt.executeQuery();

            while(resultset.next()){
                Student student = new Student();
                student.setId(resultset.getInt("id"));
                student.setName(resultset.getString("name"));
                student.setEmail(resultset.getString("email"));
                student.setMobile(resultset.getString("mobile"));

                studentlist.add(student);
            }

        }catch(SQLException sqle){
            throw new DAOException("FAILED TO GET SEARCHED STUDENT RECORDS",sqle);
        }
        return studentlist;
    }

    public int getSearchedTotalRecords(String search,String type){
        String sql;

        switch(type){
            case "email" : sql=SEARCH_EMAIL_COUNT;
            break;
            case "mobile":sql=SEARCH_MOBILE_COUNT;
            break;
            case "name":sql=SEARCH_NAME_COUNT;
            break;
            default: sql=SEARCH_NAME_COUNT;
            break;
        }

        try(Connection connection = JDBCutils.fetchConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1,"%" + search.toLowerCase() + "%");

            try(ResultSet resultSet = pstmt.executeQuery();){

                if(resultSet.next()){
                    return resultSet.getInt(1);
                }
            }

        } catch(SQLException sqle){
            throw new DAOException("FAILED TO GET TOTAL NUMBER SEARCHED RECORDS",sqle);
        }
        return 0;
    }

}
