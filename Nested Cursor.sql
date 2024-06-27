CREATE OR REPLACE PROCEDURE DB2ADMIN.process_departments_and_employees()
BEGIN
    -- Declare variables to hold data from the cursors
    DECLARE v_dept_id INT;
    DECLARE v_dept_name VARCHAR(100);
    DECLARE v_emp_id INT;
    DECLARE v_emp_name VARCHAR(100);
    DECLARE done INT DEFAULT 0;

    -- Declare the outer cursor for departments
    DECLARE dept_cursor CURSOR FOR
    SELECT dept_id, dept_name
    FROM departments;

    -- Declare the inner cursor for employees
    DECLARE emp_cursor CURSOR FOR
    SELECT emp_id, emp_name
    FROM employees
    WHERE dept_id = v_dept_id;

    -- Handler for NOT FOUND condition
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the outer cursor
    OPEN dept_cursor;

    -- Outer loop label
    outer_loop: LOOP
        -- Fetch each department
        FETCH dept_cursor INTO v_dept_id, v_dept_name;

        IF done = 1 THEN
            LEAVE outer_loop;
        END IF;

        -- Insert department info into the results table
		INSERT INTO process_results (message) VALUES ('Department: ' || v_dept_name);

        -- Reset done for the inner cursor
        SET done = 0;

        -- Open the inner cursor
        OPEN emp_cursor;

        -- Inner loop label
        inner_loop: LOOP
            -- Fetch each employee in the current department
            FETCH emp_cursor INTO v_emp_id, v_emp_name;

            IF done = 1 THEN
                SET done = 0;
                LEAVE inner_loop;
            END IF;

            -- Insert employee info into the results table
			INSERT INTO process_results (message) VALUES ('  Employee: ' || v_emp_name);
           
        END LOOP inner_loop;

        -- Close the inner cursor
        CLOSE emp_cursor;
    END LOOP outer_loop;

    -- Close the outer cursor
    CLOSE dept_cursor;
END;
