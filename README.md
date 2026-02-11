

A simple **Student Management System** built using **Java, JSP, Servlets, and JDBC**. This project demonstrates basic CRUD (Create, Read, Update, Delete) operations using the **DAO design pattern** and follows an MVC-style structure.

---

## 📌 Features

* Add new students
* View student list
* Update student details
* Delete student records
* Centralized exception handling
* Uses DAO pattern for database operations

---

## 🛠️ Technologies Used

* Java (JDK 8+)
* JSP & Servlets
* JDBC
* Apache Tomcat (9/10)
* MySQL (or any JDBC-supported DB)
* HTML & JSP

---

## 📂 Project Structure

```
Student-Management-System
│
├── src/main/java
│   ├── com.samarth.model
│   │   └── Student.java
│   ├── com.samarth.dao
│   │   ├── StudentDAO.java
│   │   └── StudentDAOImpl.java
│   ├── com.samarth.util
│   │   └── JDBCUtils.java
│   ├── com.samarth.exception
│   │   └── DAOException.java
│   └── com.samarth.controller
│       └── StudentServlet.java
│
├── src/main/webapp
│   ├── student-Form.jsp
│   ├── student-List.jsp
│   ├── errorPage.jsp
│   └── WEB-INF
│       └── web.xml
│
└── README.md
```

---

## ⚙️ Database Configuration

Create a database and table:

```sql
CREATE DATABASE studentdb;

USE studentdb;

CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    course VARCHAR(50)
);
```

Update database credentials in `JDBCUtils.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/studentdb";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

---

## ▶️ How to Run the Project

1. Clone the repository

   ```bash
   git clone https://github.com/your-username/student-management-system.git
   ```

2. Open the project in **Eclipse / IntelliJ IDEA**

3. Configure **Apache Tomcat Server**


4. Add MySQL JDBC Driver (`mysql-connector-j.jar`) to project build path

5. Start the server

6. Open browser and navigate to:

   ```
   http://localhost:8080/your-project-name/student
   ```

---

## 🧠 Design Pattern Used

* **DAO (Data Access Object)** – separates persistence logic from business logic
* **MVC Architecture** – Servlet (Controller), JSP (View), Model (Student)

---

## 🚀 Future Enhancements

* Add pagination to student list (server-side or client-side)
* Add validation (client & server side)
* Implement login & authentication
* Use Hibernate/JPA
* Improve UI with CSS/Bootstrap

---

## 🖼️ Screenshots

### Student List Page

<img width="1590" height="717" alt="image" src="https://github.com/user-attachments/assets/5d751df2-b1b2-4643-bcbb-87b31659064b" />


### Add  Student Page

<img width="1594" height="726" alt="Screenshot 2026-02-11 134626" src="https://github.com/user-attachments/assets/eeabcabf-3d91-472b-b764-0da5801a7bfe" />


### Edit Page

<img width="1597" height="727" alt="Screenshot 2026-02-11 134732" src="https://github.com/user-attachments/assets/3b13fed1-a3b3-44bd-89b9-ea7ade3ea32a" />

---

## 👨‍💻 Author

**Samarth Dhute**
Java Full Stack Developer

---

## 📜 License

This project is open-source and free to use for learning purposes.
