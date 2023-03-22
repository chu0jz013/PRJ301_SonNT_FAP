/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Attendance;
import model.Classroom;
import model.Course;
import model.Enrollment;
import model.Group;
import model.Professor;
import model.Semester;
import model.Student;
import model.User;

/**
 *
 * @author willi
 */
public class AttendanceDBContext extends DBContext<Attendance> {

    @Override
    public void insert(Attendance model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Attendance model, int id) {

    }

    @Override
    public void delete(Attendance model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Attendance get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Attendance> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Attendance> getWeeklyTimetable(int user_id, Date start_date, Date end_date) {
        ArrayList<Attendance> atts = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select a.attendance_id, p.professor_code, s.student_code, c.course_code, se.semester_id,\n"
                    + "g.group_id, a.day_of_week, r.room_code, a.[date],  a.start_time, a.end_time, a.slot, a.[status]\n"
                    + "from Attendance a\n"
                    + "join Enrollments e\n"
                    + "on a.enrollment_id = e.enrollment_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Classrooms r\n"
                    + "on r.classroom_id = a.classroom_id\n"
                    + "join Students s\n"
                    + "on s.student_id = e.student_id\n"
                    + "join Professors p\n"
                    + "on p.professor_id = a.professor_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "join Users u\n"
                    + "on s.[user_id] = u.[user_id] or p.[user_id] = u.[user_id]\n"
                    + "where a.[date] >= ? and a.[date] <= ? and u.[user_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setDate(1, start_date);
            stm.setDate(2, end_date);
            stm.setInt(3, user_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                Professor pro = new Professor();
                Student stu = new Student();
                Course c = new Course();
                Classroom r = new Classroom();
                Enrollment en = new Enrollment();
                Group g = new Group();
                Semester se = new Semester();

                // set professor
                pro.setProfessor_code(rs.getString("professor_code"));

                // set student
                stu.setStudent_code(rs.getString("student_code"));

                // set course
                c.setCourse_code(rs.getString("course_code"));

                // set classroom
                r.setRoom_code(rs.getString("room_code"));

                // set semester
                se.setSemester_id(rs.getInt("semester_id"));

                // set group
                g.setCourse(c);
                g.setGroup_id(rs.getInt("group_id"));
                g.setSemester(se);

                // set enrollment
                en.setStudent(stu);
                en.setGroup(g);

                // set attendance
                att.setAttendance_id(rs.getInt("attendance_id"));
                att.setEnrollment(en);
                att.setProfessor(pro);
                att.setDate(rs.getDate("date"));
                att.setStart_time(rs.getTime("start_time"));
                att.setEnd_time(rs.getTime("end_time"));
                att.setClassroom(r);
                att.setStatus(rs.getString("status"));
                att.setSlot(rs.getInt("slot"));
                att.setDay_of_week(rs.getString("day_of_week"));
                atts.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return atts;
    }

    public ArrayList<Attendance> getViewAttendance(int user_id, int group_id) {
        ArrayList<Attendance> atts = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select a.attendance_id, a.[date], a.day_of_week,a.[start_time], a.end_time, a.slot, g.group_id,"
                    + "r.room_code, p.professor_code, g.group_name, c.course_name, c.course_code, a.[status], a.notes\n"
                    + "from Attendance a\n"
                    + "join Enrollments e\n"
                    + "on a.enrollment_id = e.enrollment_id\n"
                    + "join Groups g\n"
                    + "on e.group_id = g.group_id\n"
                    + "join Classrooms r\n"
                    + "on r.classroom_id = a.classroom_id\n"
                    + "join Professors p\n"
                    + "on p.professor_id = a.professor_id\n"
                    + "join Students s\n"
                    + "on s.student_id = e.student_id\n"
                    + "join Courses c \n"
                    + "on c.course_id  = g.course_id\n"
                    + "where s.[user_id] = ? and g.group_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            stm.setInt(2, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                Enrollment en = new Enrollment();
                Group g = new Group();
                Professor pro = new Professor();
                Course c = new Course();
                Classroom r = new Classroom();

                // set course 
                c.setCourse_name(rs.getString("course_name"));
                c.setCourse_code(rs.getString("course_code"));

                // set group
                g.setGroup_name(rs.getString("group_name"));
                g.setGroup_id(rs.getInt("group_id"));
                g.setCourse(c);

                // set enrollment
                en.setGroup(g);

                // set professor
                pro.setProfessor_code(rs.getString("professor_code"));

                // set room
                r.setRoom_code(rs.getString("room_code"));

                //set Attendance
                att.setAttendance_id(rs.getInt("attendance_id"));
                att.setEnrollment(en);
                att.setProfessor(pro);
                att.setDate(rs.getDate("date"));
                att.setStart_time(rs.getTime("start_time"));
                att.setEnd_time(rs.getTime("end_time"));
                att.setClassroom(r);
                att.setStatus(rs.getString("status"));
                att.setSlot(rs.getInt("slot"));
                att.setDay_of_week(rs.getString("day_of_week"));
                att.setNotes(rs.getString("notes"));
                atts.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return atts;
    }

    public ArrayList<Attendance> getProfessorWeeklyTimetable(int user_id, Date start_date, Date end_date) {
        ArrayList<Attendance> atts = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select a.[date], a.start_time, a.end_time, r.room_code, g.group_id, g.group_name,\n"
                    + "a.slot, c.course_code, p.professor_code, a.day_of_week, a.taken_by\n"
                    + "from Attendance a\n"
                    + "join Enrollments e\n"
                    + "on a.enrollment_id = e.enrollment_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Classrooms r\n"
                    + "on r.classroom_id = a.classroom_id\n"
                    + "join Students s\n"
                    + "on s.student_id = e.student_id\n"
                    + "join Professors p\n"
                    + "on p.professor_id = a.professor_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "where a.[date] >= ? and a.[date] <= ? and p.[user_id] = ?\n"
                    + "group by a.[date], a.start_time, a.end_time, r.room_code, a.slot, a.taken_by, "
                    + "c.course_code, p.professor_code, a.day_of_week, g.group_id, group_name;";
            stm = connection.prepareStatement(sql);
            stm.setDate(1, start_date);
            stm.setDate(2, end_date);
            stm.setInt(3, user_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                Professor pro = new Professor();
                Course c = new Course();
                Classroom r = new Classroom();
                Group g = new Group();
                Enrollment en = new Enrollment();

                // set professor
                pro.setProfessor_code(rs.getString("professor_code"));

                // set course
                c.setCourse_code(rs.getString("course_code"));

                // set classroom
                r.setRoom_code(rs.getString("room_code"));

                // set group
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);

                // set enrollment
                en.setGroup(g);

                // set attendance
                att.setProfessor(pro);
                att.setDate(rs.getDate("date"));
                att.setStart_time(rs.getTime("start_time"));
                att.setEnd_time(rs.getTime("end_time"));
                att.setClassroom(r);
                att.setEnrollment(en);
                att.setTaken_by(rs.getString("taken_by"));
                att.setSlot(rs.getInt("slot"));
                att.setDay_of_week(rs.getString("day_of_week"));
                atts.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return atts;
    }

    public ArrayList<Attendance> getGroupAttendance(Date date, int slot, int group_id) {
        ArrayList<Attendance> atts = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select p.professor_id, p.professor_code, a.attendance_id, s.student_id, s.student_imgsrc, s.student_code, s.last_name, s.first_name, \n"
                    + "a.[status], a.notes, a.taken_by, a.slot, g.group_id, e.enrollment_id, c.course_code, r.room_code, g.group_name, se.semester_id, s.user_id\n"
                    + "from Attendance a\n"
                    + "join Enrollments e\n"
                    + "on e.enrollment_id = a.enrollment_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Students s\n"
                    + "on s.student_id = e.student_id\n"
                    + "join Classrooms r\n"
                    + "on r.classroom_id = a.classroom_id\n"
                    + "join Professors p\n"
                    + "on p.professor_id = a.professor_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "where a.[date] = ? and a.slot = ? and g.group_id = ?\n"
                    + "order by s.student_code;";
            stm = connection.prepareStatement(sql);
            stm.setDate(1, date);
            stm.setInt(2, slot);
            stm.setInt(3, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                Course c = new Course();
                Classroom r = new Classroom();
                Group g = new Group();
                Enrollment en = new Enrollment();
                Student st = new Student();
                Professor pro = new Professor();
                User u = new User();
                Semester se = new Semester();

                // set semester 
                se.setSemester_id(rs.getInt("semester_id"));

                //set user
                u.setUser_id(rs.getInt("user_id"));

                // set professor
                pro.setProfessor_id(rs.getInt("professor_id"));
                pro.setProfessor_code(rs.getString("professor_code"));

                //set student
                st.setStudent_id(rs.getInt("student_id"));
                st.setStudent_imgsrc(rs.getString("student_imgsrc"));
                st.setStudent_code(rs.getString("student_code"));
                st.setFirst_name(rs.getString("first_name"));
                st.setLast_name(rs.getString("last_name"));
                st.setUser(u);

                // set course
                c.setCourse_code(rs.getString("course_code"));

                // set classroom
                r.setRoom_code(rs.getString("room_code"));

                // set group
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);
                g.setSemester(se);

                // set enrollment
                en.setEnrollment_id(rs.getInt("enrollment_id"));
                en.setGroup(g);
                en.setStudent(st);

                // set attendance
                att.setAttendance_id(rs.getInt("attendance_id"));
                att.setDate(date);
                att.setClassroom(r);
                att.setEnrollment(en);
                att.setProfessor(pro);
                att.setStatus(rs.getString("status"));
                att.setSlot(rs.getInt("slot"));
                att.setTaken_by(rs.getString("taken_by"));
                att.setNotes(rs.getString("notes"));
                atts.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return atts;
    }

    public ArrayList<Attendance> getFullAttendanceByGroup(int group_id) {
        ArrayList<Attendance> atts = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select *\n"
                    + "from Attendance a\n"
                    + "join Enrollments e\n"
                    + "on e.enrollment_id = a.enrollment_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "join Students s\n"
                    + "on s.student_id = e.student_id\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Classrooms r\n"
                    + "on r.classroom_id = a.classroom_id\n"
                    + "where g.group_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                Course c = new Course();
                Classroom r = new Classroom();
                Group g = new Group();
                Enrollment en = new Enrollment();
                Student st = new Student();
                User u = new User();
                Semester se = new Semester();

                // set semester 
                se.setSemester_id(rs.getInt("semester_id"));

                //set user
                u.setUser_id(rs.getInt("user_id"));

                //set student
                st.setStudent_id(rs.getInt("student_id"));
                st.setStudent_imgsrc(rs.getString("student_imgsrc"));
                st.setStudent_code(rs.getString("student_code"));
                st.setFirst_name(rs.getString("first_name"));
                st.setLast_name(rs.getString("last_name"));
                st.setUser(u);

                // set course
                c.setCourse_code(rs.getString("course_code"));

                // set classroom
                r.setRoom_code(rs.getString("room_code"));

                // set group
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);
                g.setSemester(se);

                // set enrollment
                en.setEnrollment_id(rs.getInt("enrollment_id"));
                en.setTotal_absent_slot(rs.getInt("total_absent_slot"));
                en.setTotal_slot(rs.getInt("total_slot"));
                en.setGroup(g);
                en.setStudent(st);

                // set attendance
                att.setAttendance_id(rs.getInt("attendance_id"));
                att.setDate(rs.getDate("date"));
                att.setClassroom(r);
                att.setEnrollment(en);
                att.setStatus(rs.getString("status"));
                att.setSlot(rs.getInt("slot"));
                att.setTaken_by(rs.getString("taken_by"));
                att.setNotes(rs.getString("notes"));
                atts.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return atts;
    }

    public ArrayList<Date> getGroupAllDate(int group_id) {
        ArrayList<Date> dates = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select a.[date]\n"
                    + "from Attendance a\n"
                    + "join Enrollments e\n"
                    + "on e.enrollment_id = a.enrollment_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "where g.group_id = ?\n"
                    + "group by a.[date]";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("date");
                dates.add(date);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return dates;
    }

    // take attendance
    public void updateAtts(ArrayList<Attendance> atts) {
        ArrayList<PreparedStatement> stms = new ArrayList<>();
        try {
            connection.setAutoCommit(false);

            //PROCESS Attendace records
            for (Attendance att : atts) {
                String sql_attendance = "update Attendance\n"
                        + "set [status] = ?,\n"
                        + "taken_by = (select p.professor_code\n"
                        + "	from Professors p\n"
                        + "	join Attendance a\n"
                        + "	on p.professor_id = a.professor_id\n"
                        + "	where a.attendance_id = ?)\n"
                        + "where attendance_id = ?";
                PreparedStatement stm_att = connection.prepareStatement(sql_attendance);
                stm_att.setString(1, att.getStatus());
                stm_att.setInt(2, att.getAttendance_id());
                stm_att.setInt(3, att.getAttendance_id());
                stm_att.executeUpdate();
                stms.add(stm_att);

                String sql_enrollment = "update Enrollments \n"
                        + "set total_absent_slot = (select COUNT(a.attendance_id) as total_absent\n"
                        + "	from Attendance a\n"
                        + "	join Enrollments e\n"
                        + "	on a.enrollment_id = e.enrollment_id\n"
                        + "	where e.enrollment_id = \n"
                        + "		(select a.enrollment_id\n"
                        + "		from Attendance a\n"
                        + "		where a.attendance_id = ?) \n"
                        + "	and a.[status] = 'absent'\n"
                        + "	group by a.[status])\n"
                        + "where enrollment_id = \n"
                        + "	(select a.enrollment_id\n"
                        + "	from Attendance a\n"
                        + "	where a.attendance_id = ?)";
                PreparedStatement stm_en = connection.prepareStatement(sql_enrollment);
                stm_en.setInt(1, att.getAttendance_id());
                stm_en.setInt(2, att.getAttendance_id());
                stm_en.executeUpdate();
                stms.add(stm_en);

            }

            connection.commit();
        } catch (SQLException ex) {

            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            for (PreparedStatement stm : stms) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

}
