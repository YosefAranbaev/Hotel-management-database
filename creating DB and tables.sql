SET SQL_SAFE_UPDATES = 0;  
CREATE DATABASE hotel_reservation;
USE hotel_reservation;

CREATE TABLE room (
room_id 			INT AUTO_INCREMENT,
room_status 		VARCHAR (100) NOT NULL,
room_type   		INT NOT NULL,
amount_of_beds 		INT,
changed_status_time TIMESTAMP,
					PRIMARY KEY (room_id),
					FOREIGN KEY (room_type) 
					REFERENCES room_price (room_type)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE room_price (
room_type   		int auto_increment,
room_name			VARCHAR (100) NOT NULL,
price_per_day 		DOUBLE,
					PRIMARY KEY (room_type)
);


CREATE TABLE building (
building_id 		INT NOT NULL,
room_id 			INT ,
floor_number		INT NOT NULL,
					PRIMARY KEY (room_id),
					FOREIGN KEY (room_id) 
					REFERENCES room (room_id)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE client_ (
client_id 			INT AUTO_INCREMENT,
client_first_name 	VARCHAR (100) NOT NULL,
client_last_name   	VARCHAR (100) NOT NULL,
					PRIMARY KEY (client_id)
);

CREATE TABLE client_phone (
client_id 			INT AUTO_INCREMENT,
phone_home 			VARCHAR (20) NOT NULL,
phone_cellular  	VARCHAR (20) NOT NULL,
					PRIMARY KEY (client_id),
					FOREIGN KEY (client_id) 
					REFERENCES client_ (client_id)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE client_address (
client_id 			INT AUTO_INCREMENT,
client_street 		VARCHAR (100) NOT NULL,
client_city 		VARCHAR (50) NOT NULL,
client_country 		VARCHAR (50) NOT NULL,
					PRIMARY KEY (client_id),
					FOREIGN KEY (client_id) 
					REFERENCES client_ (client_id)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE employees (
employee_id 		INT AUTO_INCREMENT,
employee_type 		VARCHAR (20) NOT NULL,
employee_first_name VARCHAR (50) NOT NULL,
employee_last_name 	VARCHAR (50) NOT NULL,
					PRIMARY KEY (employee_id)
);


CREATE TABLE cleaned_by (
clean_id			INT auto_increment,
room_id 			INT,
employee_id 		INT,
clean_time 			TIMESTAMP,
					PRIMARY KEY (clean_id),
					FOREIGN KEY (employee_id) 
					REFERENCES employees (employee_id),
					FOREIGN KEY (room_id) 
					REFERENCES room (room_id)
);


CREATE TABLE employee_phone (
employee_id 		INT,
emp_home 			VARCHAR (20),
emp_cellular		VARCHAR (20),
					PRIMARY KEY (employee_id),
					FOREIGN KEY (employee_id) 
					REFERENCES employees (employee_id)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE employee_address (
employee_id 		INT,
emp_street 			VARCHAR (100) NOT NULL,
emp_city 			VARCHAR (50) NOT NULL,
emp_country 		VARCHAR (50) NOT NULL,
					PRIMARY KEY (employee_id),
					FOREIGN KEY (employee_id) 
					REFERENCES employees (employee_id)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE reservation (
reservation_id 		INT AUTO_INCREMENT NOT NULL,
room_id 			INT NOT NULL,
employee_id 		INT NOT NULL,
client_id 			INT NOT NULL,
					PRIMARY KEY (reservation_id),
					FOREIGN KEY (room_id) 
					REFERENCES room (room_id)
					ON DELETE CASCADE ON UPDATE CASCADE,
					FOREIGN KEY (employee_id) 
					REFERENCES employees (employee_id)
					ON DELETE CASCADE ON UPDATE CASCADE,
					FOREIGN KEY (client_id) 
					REFERENCES client_ (client_id)
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE reservation_details (
reservation_id 	    INT  NOT NULL ,
check_in 	 		DATE NOT NULL,
check_out    		DATE NOT NULL,
calc_price 			DOUBLE,
					PRIMARY KEY (reservation_id),
					FOREIGN KEY (reservation_id) 
					REFERENCES  reservation (reservation_id)
					ON DELETE CASCADE ON UPDATE CASCADE,
					CHECK (check_out>check_in)
);
