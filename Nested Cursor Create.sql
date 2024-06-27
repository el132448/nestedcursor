CREATE TABLE departments (
    dept_id INT PRIMARY KEY NOT NULL,
    dept_name VARCHAR(100)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'Finance');

CREATE TABLE employees (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees (emp_id, emp_name, dept_id) VALUES
(1, 'Alice', 1),
(2, 'Bob', 1),
(3, 'Charlie', 2),
(4, 'David', 2);

CREATE TABLE process_results (
    message VARCHAR(200)
);
