-- USE MASTER DROP DATABASE FPT_University_Management_System

CREATE DATABASE [FPT_University_Management_System]
GO

USE [FPT_University_Management_System]
GO

CREATE TABLE Users (
	[user_id] INT IDENTITY(1,1) PRIMARY KEY,
	[username] VARCHAR(50) UNIQUE NOT NULL,
	[password] VARCHAR(50) NOT NULL
);

CREATE TABLE Roles (
	role_id INT IDENTITY(1,1) PRIMARY KEY,
	role_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Feature(
	feature_id INT IDENTITY(1,1) PRIMARY KEY,
	feature_name VARCHAR(50) NOT NULL,
	[url] VARCHAR(300) NOT NULL
);

CREATE TABLE Role_User (
	role_id INT NOT NULL,
	[user_id] INT NOT NULL,
	PRIMARY KEY (role_id, [user_id]),
	FOREIGN KEY (role_id) REFERENCES Roles(role_id),
	FOREIGN KEY ([user_id]) REFERENCES Users([user_id])
);

CREATE TABLE Role_Feature (
	role_id INT NOT NULL,
	feature_id INT NOT NULL,
	PRIMARY KEY (role_id, feature_id),
	FOREIGN KEY (role_id) REFERENCES Roles(role_id),
	FOREIGN KEY (feature_id) REFERENCES Feature(feature_id)
);


CREATE TABLE Majors (
  major_id INT IDENTITY(1,1) PRIMARY KEY,
  major_name VARCHAR(100) NOT NULL,
  major_code VARCHAR(20) UNIQUE NOT NULL,
  major_description TEXT
);

CREATE TABLE Departments (
	department_id INT IDENTITY(1,1) PRIMARY KEY,
	department_name VARCHAR(100) UNIQUE NOT NULL,
	department_description TEXT
);

CREATE TABLE Courses (
  course_id INT IDENTITY(1,1) PRIMARY KEY,
  course_code VARCHAR(20) UNIQUE NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  department_id INT REFERENCES Departments(department_id),
  credits FLOAT NOT NULL,
  prereq_Course VARCHAR(200),
  description TEXT
);

CREATE TABLE Majors_Courses(
	major_id INT NOT NULL,
	course_id INT NOT NULL,
	PRIMARY KEY (major_id, course_id),
	FOREIGN KEY (course_id) REFERENCES Courses(course_id),
	FOREIGN KEY (major_id) REFERENCES Majors(major_id)
);

CREATE TABLE Professors (
  professor_id INT IDENTITY(1,1) PRIMARY KEY,
  professor_code VARCHAR(10) UNIQUE NOT NULL,
  professor_imgsrc VARCHAR(200),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  [address] VARCHAR(200),
  [user_id] INT REFERENCES [Users]([user_id]) UNIQUE
);

CREATE TABLE Professors_Departments(
	professor_id INT NOT NULL,
	department_id INT NOT NULL,
	PRIMARY KEY (professor_id, department_id),
	FOREIGN KEY (department_id) REFERENCES Departments(department_id),
	FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

CREATE TABLE Semesters (
  semester_id INT IDENTITY(1,1) PRIMARY KEY,
  semester_name VARCHAR(50) NOT NULL,
  [start_date] DATE NOT NULL,
  end_date DATE NOT NULL
);

CREATE TABLE Students (
	student_id INT IDENTITY(1,1) PRIMARY KEY,
	student_code VARCHAR(10) UNIQUE NOT NULL,
	student_imgsrc VARCHAR(200),
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone VARCHAR(20),
	[address] VARCHAR(200),
	major_id INT REFERENCES Majors(major_id),
	[user_id] INT REFERENCES [Users]([user_id]) UNIQUE
);

CREATE TABLE [Groups] (
  group_id INT IDENTITY(1,1) PRIMARY KEY,
  group_name VARCHAR(20),
  course_id INT REFERENCES Courses(course_id),
  days_of_week VARCHAR(20) NOT NULL,
  capacity INT NOT NULL,
  semester_id INT REFERENCES Semesters(semester_id)
);

CREATE TABLE Enrollments (
  enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
  student_id INT REFERENCES Students(student_id),
  group_id INT REFERENCES [groups](group_id),
  total_slot INT ,
  total_absent_slot INT ,
  comments TEXT
);

CREATE TABLE Classrooms (
  classroom_id INT IDENTITY(1,1) PRIMARY KEY,
  building_name VARCHAR(100) NOT NULL,
  room_code VARCHAR(10) UNIQUE NOT NULL,
  capacity INT,
  equipment TEXT
);

CREATE TABLE Attendance (
	attendance_id INT IDENTITY(1,1) PRIMARY KEY,
	enrollment_id INT REFERENCES Enrollments(enrollment_id),
	professor_id INT REFERENCES Professors(professor_id),
	[date] DATE,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	classroom_id INT REFERENCES Classrooms(classroom_id),
	[status] VARCHAR(10), -- persent/absent/not yet
	slot INT,
	taken_by VARCHAR(50),
	day_of_week VARCHAR(10),
	notes TEXT
);

--Roles
INSERT INTO Roles (role_name)
VALUES ('admin'), ('professor'), ('student');

-- Users
INSERT INTO Users (username, [password]) 
VALUES	('admin', '10diemprj301'),
		('sonnt5@fpt.edu.vn', '10diemprj301'), 
		('bantq@fpt.edu.vn', '10diemprj301'),
		('tuanvm2@fpt.edu.vn', '10diemprj301'),
		('haiknhe171578@fpt.edu.vn', '10diemprj301'),
		('loinqhe1705331@fpt.edu.vn', '10diemprj301'),
		('haunthe170842@fpt.edu.vn', '10diemprj301'),
		('huyenntkhe170863@fpt.edu.vn', '10diemprj301'),
		('phuonghmhe171073@fpt.edu.vn', '10diemprj301'),
		('tuntche176697@fpt.edu.vn', '10diemprj301'),
		('AnhNHHE150057@fpt.edu.vn', '10diemprj301'),
		('MinhNDHE151095@fpt.edu.vn', '10diemprj301'),
		('NamQDHE153206@fpt.edu.vn', '10diemprj301'),
		('DuyVDHE160694@fpt.edu.vn', '10diemprj301'),
		('TayNTHE161357@fpt.edu.vn', '10diemprj301'),
		('MinhDTHE161795@fpt.edu.vn', '10diemprj301'),
		('HungBVHE163146@fpt.edu.vn', '10diemprj301'),
		('AnhNTHE164035@fpt.edu.vn', '10diemprj301'),
		('TamVMHE170051@fpt.edu.vn', '10diemprj301'),
		('LongBHHE170245@fpt.edu.vn', '10diemprj301'),
		('PhucVDHE170422@fpt.edu.vn', '10diemprj301'),
		('HuyTQHE170428@fpt.edu.vn', '10diemprj301'),
		('HieuLDHE170444@fpt.edu.vn', '10diemprj301'),
		('GiangPTHE170907@fpt.edu.vn', '10diemprj301'),
		('DucKMHE170996@fpt.edu.vn', '10diemprj301'),
		('NhatVNHE171071@fpt.edu.vn', '10diemprj301');

-- Roles_User
INSERT INTO Role_User (role_id, [user_id])
VALUES	(1,1),
		(2,2),
		(2,3),
		(2,4),
		(3,5),
		(3,6),
		(3,7),
		(3,8),
		(3,9),
		(3,10),
		(3,11),
		(3,12),
		(3,13),
		(3,14),
		(3,15),
		(3,16),
		(3,17),
		(3,18),
		(3,19),
		(3,20),
		(3,21),
		(3,22),
		(3,23),
		(3,24),
		(3,25),
		(3,26);

-- Feature
INSERT INTO Feature(feature_name,  [url])
VALUES	('Student Weekly Timetable','/student/WeeklyTimetable'),
		('View Student Attendance','/student/ViewAttendance'),
		('Student Information','/student/info'),
		('View Group','/Groups'),
		('Student Weekly Timetable','/student/WeeklyTimetable'),
		('Professor Weekly Timetable','/professor/WeeklyTimetable'),
		('Professor Take Attendance','/professor/TakeAttendance'),
		('Professor View Group Attendance','/ViewGroupAttendance'),
		('Professor Information','/professor/info'),
		('Admin Home','/admin/home'),
		('Student Home','/student/home'),
		('Professor Home','/professor/home');

-- Role_Feature
INSERT INTO Role_Feature(role_id, feature_id)
VALUES	(3,1),
		(3,2),
		(3,3),
		(3,4),
		(3,5),
		(2,6),
		(2,7),
		(2,8),
		(2,9),
		(2,2),
		(2,3),
		(2,4),
		(1,10),
		(3,11),
		(2,12);

-- Majors
INSERT INTO Majors
VALUES	('Software Engineering K17B', 'BIT_SE_17B',''),
		('Artificial Intelligence K17A', 'BIT_AI_17A', ''),
		('International Bussines K16C', 'BBA_IB_K16C','');

-- Departments
INSERT INTO Departments (department_name, department_description)
VALUES	('Computing Fundamental', ''),
		('Artificial Intelligence', ''),
		('Mathematics', ''),
		('Business Administration', ''),
		('Information Technology Specialization', '');

-- Courses
INSERT INTO Courses (course_code, course_name, department_id, credits, prereq_Course, [description])
VALUES	('CSI104', 'Introduction to Computer Science', 1, 3.0, NULL, 'This course covers the basics of computer programming and software development.'),
		('DBI202', 'Introduction to Database', 1, 3.0, NULL, 'Basic SQL with MS SQL Server.'),
		('PRJ301', 'Java Web Application', 1, 3.0, 'DBI202', 'Develop Java Web with Servlet and JSP.'),
		('PFP191', 'Python Fundamental', 1, 3.0, NULL, 'Basic Python.'),
		('MAE101', 'Mathematics for Engineering', 3, 3.0, NULL, 'Linear Algebra'),
		('AIL303m', 'Machine Learning', 2, 3.0, NULL, 'Machine Learning'),
		('DPL301m', 'Deep Learing ', 2, 3.0, NULL, 'Deep Learning'),
		('MKT101', 'Marketing Principles', 4, 3.0, NULL, ''),
		('MAS202', 'Applied Statistics for Business', 3, 3.0, NULL, ''),
		('IOT102', 'Internet of Things', 5, 3.0, null, '');

-- Majors_Courses
INSERT INTO Majors_Courses (major_id, course_id)
VALUES	(1,1),
		(1,2),
		(1,3),
		(1,5),
		(1,10),
		(2,2),
		(2,4),
		(2,5),
		(2,6),
		(2,7),
		(3,8),
		(3,9);

--Students
insert into Students(student_code, student_imgsrc, first_name, last_name, email, phone, [address], major_id, [user_id])
values	('HE171578','https://preview.redd.it/exhausted-cat-developer-v0-kaepljx1y93a1.jpg?width=640&crop=smart&auto=webp&s=fcc47d300bbbe914b596f511dfb642a35f09f22f','Hai', 'Kieu Nam', 'haiknhe171578@fpt.edu.vn','0961513848','Ha Noi', 1 ,5),
		('HE170533','https://hips.hearstapps.com/hmg-prod/images/close-up-of-cat-wearing-sunglasses-while-sitting-royalty-free-image-1571755145.jpg?crop=0.675xw:1.00xh;0.147xw,0&resize=1200:*','Loi','Nguyen Quang','loinqhe1705331@fpt.edu.vn','','Thai Binh',1, 6),
		('HE170842','https://www.neweurope.eu/wp-content/uploads/2013/01/cat_videos.jpg','Hau','Nguyen Thanh','haunthe170842@fpt.edu.vn','','Nhat Ban',1, 7),
		('HE170863','https://i.pinimg.com/736x/09/6c/dc/096cdc33e3696ff69bb9891e51e8832e.jpg','Huyen','Nguyen Thi Khanh','huyenntkhe170863@fpt.edu.vn','','Han Quoc',1, 8),
		('HE171073','https://i2-prod.mirror.co.uk/incoming/article25609246.ece/ALTERNATES/s1200b/0_PUSS-IN-BOOTS.jpg','Phuong','Hoang Mai','phuonghmhe171073@fpt.edu.vn','','Trung Quoc',1, 9),
		('HE176697','https://www.rd.com/wp-content/uploads/2019/11/shutterstock_572338033-e1573490008107-scaled.jpg','Tu','Nguyen Thi Cam','tuntche176697@fpt.edu.vn','','Dai Loan', 1, 10),
		('HE150057','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Anh','Nguyen Nhat','AnhNHHE150057@fpt.edu.vn','','Viet Nam', 1, 11),
		('HE151095','https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2013%2F05%2Fb31.jpg&q=60','Minh','Nguyen Duc','MinhNDHE151095@fpt.edu.vn','','Viet Nam', 1, 12),
		('HE153206','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhWSuoV5RUZiv4vizlSTEFOJCuA6Db5nwvtA&usqp=CAU','Nam','Quach Duy','NamQDHE153206@fpt.edu.vn','','Viet Nam', 1, 13),
		('HE160694','https://en.meming.world/images/en/3/3d/Loading_Cat.jpg','Duy','Vu Dinh','DuyVDHE160694@fpt.edu.vn','','Viet Nam', 1, 14),
		('HE161357','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Tay','Nguyen Truong','TayNTHE161357@fpt.edu.vn','','Viet Nam', 1, 15),
		('HE161795','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Minh','Duong Thanh','MinhDTHE161795@fpt.edu.vn','','Viet Nam', 1, 16),
		('HE163146','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Hung','Bui Viet','HungBVHE163146@fpt.edu.vn','','Viet Nam', 1, 17),
		('HE164035','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Anh','Nguyen Tien','AnhNTHE164035@fpt.edu.vn','','Viet Nam', 1, 18),
		('HE170051','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Tam','Vu Minh','TamVMHE170051@fpt.edu.vn','','Viet Nam', 1, 19),
		('HE170245','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Long','Bui Hoang','LongBHHE170245@fpt.edu.vn','','Viet Nam', 1, 20),
		('HE170422','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Phuc','Vu Duy','PhucVDHE170422@fpt.edu.vn','','Viet Nam', 1, 21),
		('HE170428','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Huy','Tran Quang','HuyTQHE170428@fpt.edu.vn','','Viet Nam', 1, 22),
		('HE170444','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Hieu','Le Duc','HieuLDHE170444@fpt.edu.vn','','Viet Nam', 1, 23),
		('HE170907','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Giang','Pham Truong','GiangPTHE170907@fpt.edu.vn','','Viet Nam', 1, 24),
		('HE170996','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Duc','Khieu Minh','DucKMHE170996@fpt.edu.vn','','Viet Nam', 1, 25),
		('HE171071','https://i.pinimg.com/736x/2f/c6/c9/2fc6c990c70249197bcb29d688e1ad80.jpg','Nhat','Vu Ngoc','NhatVNHE171071@fpt.edu.vn','','Viet Nam', 1, 26);

-- Professors
INSERT INTO Professors (professor_code, professor_imgsrc, first_name, last_name, email, phone, [address], [user_id])
VALUES	('SonNT', 'https://i.pinimg.com/736x/5f/24/4b/5f244b5bb0186396adb1fe545f60b0eb.jpg', 'Son', 'Ngo Tung', 'sonnt5@fpt.edu.vn', '1010101010', 'Me Linh xinh dep',2),
		('BanTQ','','Ban', 'Tran Quy', 'bantq@fpt.edu.vn', '1010101011','Thai Binh', 3),
		('TuanVM','https://thumbs.dreamstime.com/b/pet-cat-animal-meme-pet-cat-animal-meme-219285971.jpg','Tuan', 'Vuong Minh', 'tuanvm2@fpt.edu.vn', '1010101011','Vu Tru', 4);

-- Professors_Departments
INSERT INTO Professors_Departments (professor_id, department_id)
VALUES	(1,1),
		(1,2),
		(2,3),
		(3,4);

-- Semesters
INSERT INTO Semesters (semester_name, [start_date], end_date)
VALUES ('Spring 2023', '2023-01-02', '2023-05-04'),
('Summer 2023', '2023-05-05', '2023-09-03');

-- Groups
INSERT INTO [Groups] (group_name, course_id, days_of_week, capacity, semester_id)
VALUES ('ISE_SE1723',3, 'P36', 30, 1),
('SE1701',3 ,'P25', 30, 1),
('SE1723',1,'P52',30,1);


-- Enrollments
INSERT INTO Enrollments (student_id, group_id, total_slot, total_absent_slot, comments)
VALUES	(1, 1, 10, 0, ''),
		(2, 1, 10, 0,''),
		(3, 1, 10, 0,''),
		(4, 1, 10, 0,''),
		(5, 1, 10, 0,''),
		(6, 1, 10, 0,''),
		(7, 1, 10, 0,''),
		(8, 1, 10, 0,''),
		(9, 1, 10, 0,''),
		(10, 1, 10, 0,''),
		-------------
		(11, 2, 10, 0,''),
		(12, 2, 10, 0,''),
		(13, 2, 10, 0,''),
		(14, 2, 10, 0,''),
		(15, 2, 10, 0,''),
		(16, 2, 10, 0,''),
		(17, 2, 10, 0,''),
		(18, 2, 10, 0,''),
		(19, 2, 10, 0,''),
		(20, 2, 10, 0,''),
		-------------
		(1, 3, 10, 0, ''),
		(3, 3, 10, 0,''),
		(5, 3, 10, 0,''),
		(7, 3, 10, 0,''),
		(8, 3, 10, 0,''),
		(9, 3, 10, 0,''),
		(11, 3, 10, 0,''),
		(13, 3, 10, 0,''),
		(15, 3, 10, 0,''),
		(17, 3, 10, 0,'');


-- Classrooms
INSERT INTO Classrooms (building_name, room_code, capacity, equipment)
VALUES	('Delta', 'DE-201', 30, ''),
		('Delta', 'DE-202', 30, ''),
		('Delta', 'DE-203', 30, ''),
		('Delta', 'DE-204', 30, ''),
		('Delta', 'DE-205', 30, ''),
		('Beta', 'BE-201', 30, ''),
		('Beta', 'BE-202', 30, ''),
		('Beta', 'BE-203', 30, ''),
		('Beta', 'BE-204', 30, ''),
		('Beta', 'BE-205', 30, ''),
		('Beta', 'BE-303', 30, '');

-- Attendance
INSERT INTO Attendance (enrollment_id, professor_id, [date], start_time, end_time, classroom_id, [status], slot, taken_by, day_of_week, notes)
VALUES	-- ISE_1723 - PRJ301 - SonNT
		(1, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-07', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-10', '15:20:00', '17:40:00', 11, 'present',4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-14', '12:50:00', '15:10:00', 11, 'present', 3,'SonNT','Tue','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-17', '15:20:00', '17:40:00', 11, 'present', 4,'SonNT','Fri','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-21', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-24', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-28', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-03-31', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-04-04', '12:50:00', '15:10:00', 11, 'not yet', 3, null,'Tue','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(1, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(2, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(3, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(4, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(5, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(6, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(7, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(8, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(9, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),
		(10, 1, '2023-04-07', '15:20:00', '17:40:00', 11, 'not yet ', 4,null ,'Fri','Hai se duoc 10 diem PRJ'),



		--- SE1701-PRJ-SonNT
		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-06', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-09', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-13', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-16', '15:20:00', '17:40:00', 10, 'present', 4,'SonNT','Thu','Hai se duoc 10 diem PRJ'),
		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-20', '12:50:00', '15:10:00', 10, 'present', 3,'SonNT','Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4, null ,'Thu','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4, null,'Thu','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4, null,'Thu','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4, null,'Thu','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-23', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		--------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-27', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-03-30', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		---------------------------------------------------------------------------------------------------------
		(11, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-04-03', '12:50:00', '15:10:00', 10, 'not yet', 3,null,'Mon','Hai se duoc 10 diem PRJ'),
		--------------------------------------------------------------------------------------------------------
		(11, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(12, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(13, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(14, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(15, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(16, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(17, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(18, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(19, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),
		(20, 1, '2023-04-06', '15:20:00', '17:40:00', 10, 'not yet', 4,null,'Thu','Hai se duoc 10 diem PRJ'),





		--- CSI104-TuanVM-SE1723
		(21, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-06', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-09', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present', 4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-13', '15:20:00', '17:40:00', 2, 'present',4,'TuanVM','Mon','Hai se duoc 10 diem PRJ'),



		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-16', '12:50:00', '15:10:00', 2, 'present', 3,'TuanVM','Thu','Hai se duoc 10 diem PRJ'),



		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-20', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-23', '12:50:00', '15:10:00', 2, 'not yet',3, null,'Thu','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-27', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-03-30', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-04-03', '15:20:00', '17:40:00', 2, 'not yet ', 4,null ,'Mon','Hai se duoc 10 diem PRJ'),

		---------------------------------------------------------------------------------------------------------
		(21, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(22, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(23, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(24, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(25, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(26, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(27, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(28, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(29, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ'),
		(30, 3, '2023-04-06', '12:50:00', '15:10:00', 2, 'not yet', 3, null,'Thu','Hai se duoc 10 diem PRJ');