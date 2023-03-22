/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student.attendace;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.AttendanceDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import model.Attendance;
import model.User;

/**
 *
 * @author willi
 */
public class WeeklyTimetableController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {

        AttendanceDBContext attdb = new AttendanceDBContext();
        // get date choice & default = today
        String raw_date = req.getParameter("date");
        LocalDate date;
        if (raw_date == null) {
            date = LocalDate.now();
        } else {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            date = LocalDate.parse(raw_date, formatter);
        }
        req.setAttribute("date", date);
        //get start_date
        LocalDate monday = date;
        while (monday.getDayOfWeek() != DayOfWeek.MONDAY) {
            monday = monday.minusDays(1);
        }
        Date sqlMon = Date.valueOf(monday); // this is monday - first day of week

        // send arraylist of week
        ArrayList<Date> week_date = new ArrayList<>();
        for (int i = 0; i <= 6; i++) {
            week_date.add(Date.valueOf(monday.plusDays(i)));
        }
        req.setAttribute("week_date", week_date);
        Date sqlSun = week_date.get(6);

        // get time table
        ArrayList<Attendance> weeklyTimetable = attdb.getWeeklyTimetable(user.getUser_id(), sqlMon, sqlSun);

        // send slot num
        int size = 6;
        ArrayList<Integer> slot_index = new ArrayList<>();
        for (int i = 1; i <= size; i++) {
            slot_index.add(i);
        }
        req.setAttribute("slot_index", slot_index);

        // sent slots 
        ArrayList<Integer> slots = new ArrayList<>();
        for (Attendance w : weeklyTimetable) {
            slots.add(w.getSlot());
        }
        req.setAttribute("slots", slots);

        // send weekly time table
        req.setAttribute("weeklyTimetable", weeklyTimetable);
        req.getRequestDispatcher("/view/student/weeklytimetable.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
