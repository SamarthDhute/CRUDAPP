# 🎓 CRUDAPP — Student Management System

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![JSP](https://img.shields.io/badge/JSP%20%26%20Servlets-007396?style=for-the-badge&logo=java)

**CRUDAPP** is a Student Management System built using **Java, JSP, Servlets, and JDBC**. This project demonstrates full CRUD (Create, Read, Update, Delete) operations with **Authentication**, **Pagination**, and follows the **DAO design pattern** with an MVC-style architecture.

---

## 📌 Features

* 🔐 User Registration & Login (Authentication)
* 🔒 Route protection using Servlet Filter
* ➕ Add new students
* 📋 View paginated student list
* ✏️ Update student details
* 🗑️ Delete student records
* ⚠️ Centralized exception handling
* 📦 DAO pattern for database operations

---

## 🛠️ Technologies Used

* Java (JDK 8+)
* JSP & Servlets
* JDBC
* Apache Tomcat (9/10)
* PostgreSQL
* HTML & JSP

---

## 📂 Project Structure

```
CRUDAPP
│
├── src/main/java
│   └── com.samarth.CRUDAPP
│       ├── Auth
│       │   ├── User.java                 ← User model for authentication
│       │   ├── UserDao.java              ← Interface for user DB operations
│       │   ├── UserDaoImpl.java          ← Implementation of UserDao
│       │   └── UserServlet.java          ← Handles login/register requests
│       │
│       ├── DAO
│       │   ├── StudentDAO.java           ← Interface for student DB operations
│       │   └── StudentDAOImpl.java       ← Implementation of StudentDAO
│       │
│       ├── Exception
│       │   └── DAOException.java         ← Custom exception handling
│       │
│       ├── Filter
│       │   └── AuthFilter.java           ← Protects routes from unauthenticated access
│       │
│       ├── Model
│       │   ├── Pagination.java           ← Pagination logic & metadata
│       │   └── Student.java              ← Student entity model
│       │
│       └── util
│           └── JDBCUtils.java            ← DB connection utility
│
├── src/main/webapp
│   └── studentservlet.java               ← Main student controller servlet
│
└── webapp
    ├── WEB-INF
    │   └── web.xml                       ← Servlet & filter mappings
    ├── errorPage.jsp                     ← Global error page
    ├── header.jsp                        ← Common header (included in pages)
    ├── LoginPage.jsp                     ← User login form
    ├── RegisterPage.jsp                  ← New user registration form
    ├── student-Form.jsp                  ← Add / Edit student form
    └── student-List.jsp                  ← Paginated student list view
```

---

## ⚙️ Database Configuration

Create the database and tables:

```sql
-- Create database
CREATE DATABASE studentdb;

-- Connect to the database
\c studentdb;

-- Students table
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    course VARCHAR(50)
);

-- Users table for authentication
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
```

Update database credentials in `JDBCUtils.java`:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/studentdb";
private static final String USERNAME = "postgres";
private static final String PASSWORD = "your_password";
```

> ⚠️ **Note:** Never push real credentials to GitHub. Consider using environment variables or a `.env` file.

---

## ▶️ How to Run the Project

### ✅ Prerequisites
- JDK 8 or higher
- Apache Tomcat 9/10
- PostgreSQL Server
- Eclipse / IntelliJ IDEA
- PostgreSQL JDBC Driver (`postgresql-xx.jar`)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/SamarthDhute/CRUDAPP.git
   ```

2. Open in **Eclipse / IntelliJ IDEA**

3. Configure **Apache Tomcat Server**

4. Add `postgresql-xx.jar` to project build path

5. Create the database and tables (see above)

6. Start the server and navigate to:
   ```
   http://localhost:8080/CRUDAPP/login
   ```

---

## 🔐 Authentication Flow

1. User visits any protected page → **AuthFilter** intercepts the request
2. If not logged in → redirected to **LoginPage.jsp**
3. User can **Register** a new account via **RegisterPage.jsp**
4. On successful login → session is created and user is redirected to the student list
5. On logout → session is invalidated and user is redirected to login

---

## 📄 Pagination

- Student records are fetched in pages (e.g., 5 records per page)
- The `Pagination.java` model holds metadata: current page, total pages, records per page
- `StudentDAOImpl` uses PostgreSQL's `LIMIT` and `OFFSET` in SQL queries to fetch the correct page
- Navigation controls are rendered in `student-List.jsp`

---

## 🧠 Design Patterns Used

* **DAO (Data Access Object)** – separates persistence logic from business logic
* **MVC Architecture** – Servlet (Controller), JSP (View), Model (Student, User, Pagination)
* **Filter Pattern** – `AuthFilter` intercepts requests for authentication checks

---

## 🚀 Future Enhancements

* Add client-side & server-side input validation
* Hash passwords using BCrypt
* Use Hibernate / JPA instead of raw JDBC
* Improve UI with Bootstrap
* Add role-based access control (Admin / Student)
* REST API support

---

## 🖼️ Screenshots

### 🔐 Login Page


### 📝 Register Page
![Register Page](https://github.com/SamarthDhute/CRUDAPP/assets/register-page-screenshot)

### 📋 Student List Page (with Pagination)
![Student List with Pagination](https://github.com/SamarthDhute/CRUDAPP/assets/student-list-pagination-screenshot)

### ➕ Add Student Page
<img width="1594" height="726" alt="Add Student" src="https://github.com/user-attachments/assets/eeabcabf-3d91-472b-b764-0da5801a7bfe" />

### ✏️ Edit Page
<img width="1597" height="727" alt="Edit Student" src="https://github.com/user-attachments/assets/3b13fed1-a3b3-44bd-89b9-ea7ade3ea32a" />

---

## 👨‍💻 Author

**Samarth Dhute**
Java Full Stack Developer

---

## 📜 License

This project is open-source and free to use for learning purposes.
