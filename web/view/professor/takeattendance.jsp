<%-- 
    Document   : liststudentbygroup
    Created on : Mar 13, 2023, 3:25:13 AM
    Author     : willi
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Attendance</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f8f8f8;
            }

            /* Header styles */
            header {
                background-color: #F37022;
                color: #fff;
                padding: 1rem;
                /*                display: flex;*/
                /*                justify-content: space-between;*/
                align-items: center;
            }

            /* Main styles */
            main {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                padding: 2rem;
            }

            /* Navigation styles */
            nav {
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 1rem;
                border-radius: 5px;
            }

            nav ul {
                display: flex;
                flex-direction: column;
            }

            nav li {
                margin: 0.5rem 0;
            }

            nav a {
                color: #124DA3;
                font-size: 1.2rem;
                text-decoration: none;
                transition: color 0.3s ease;
                display: block;
            }

            nav a:hover {
                color: #fff;
                background-color: #124DA3;
                padding: 0.5rem;
                border-radius: 5px;
            }
            .no-color-change {
                color: inherit;
                text-decoration: none;
                white-space: nowrap;
            }

            /* Define styles for the table */
            /* Style for table */
            table {
                border-collapse: collapse;
                margin: 20px auto;
                font-size: 18px;
                min-width: 700px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            }

            th, td {
                padding: 15px 20px;
                text-align: center;
                border: 1px solid #ddd;
            }

            thead {
                background-color: #124DA3;
                color: #fff;
            }

            th:first-child {
                border-top-left-radius: 5px;
            }

            th:last-child {
                border-top-right-radius: 5px;
            }

            td:first-child {
                font-weight: bold;
            }

            /* Style for date input */
            input[type="date"] {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 5px;
                padding: 8px;
                font-size: 16px;
                margin: 10px;
            }

            /* Style for submit button */
            input[type="submit"] {
                background-color: #124DA3;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px 15px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #124DA3;
            }

            /* Style for table rows */
            tbody tr:nth-child(odd) {
                background-color: #f2f2f2;
            }

            /* Style for table slots */
            tbody td {
                font-weight: bold;
            }

            /* Style for empty slots */
            tbody td:empty {
                background-color: #fff;
            }
            a {
                display: inline-block;
                margin-right: 20px;
                margin-bottom: 20px;
                padding: 10px 20px;
                background-color: #124DA3;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            a:hover {
                background-color: #555;
            }
            textarea {
                font-family: Arial, sans-serif;
                width: 100%;
                height: 80px;
                padding: 12px 20px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                background-color: #f8f8f8;
                resize: none;
            }
        </style>
    </head>
    <body>
        <header>
            <div style="display: flex; justify-content: center;">
                <a href="/FPT_University_Management_System/${sessionScope.user.roles[0].role_name}/home" style='background-color: #28a745'>
                    <span>Home</span>
                </a>
                <a href="/FPT_University_Management_System/logout" style='background-color: #28a745'>
                    <span>Logout</span>
                </a>
                <a href="/FPT_University_Management_System/professor/WeeklyTimetable" style='background-color: #28a745'>
                    <span>Weekly Timetable</span>
                </a>   
                <h1 style="text-align: center; margin-right: 0 20px 0 0; margin-left: auto;">FPT University Academic Portal</h1>
                <h3 style="text-align: right; margin-left: auto;">Welcome ${sessionScope.user.username}</h3>  
            </div>
        </header>
        </br> 
        <h1 style="text-align: center;">TAKING ATTENDANCE</h1>
        <c:set var="a" value="${sessionScope.attendances[0]}"/>
        <h3 style="text-align: center;">Lecturer: ${a.professor.professor_code}</h3>
        <h3 style="text-align: center;">Group: ${a.enrollment.group.group_name}</h3>
        <h3 style="text-align: center;">Course: ${a.enrollment.group.course.course_code}</h3>
        <h3 style="text-align: center;">
            Date: 
            <fmt:formatDate value="${a.date}" pattern="EEEE"/>
            <fmt:formatDate value="${a.date}" pattern="dd/MM/yyyy" />
        </h3>
        <h3 style="text-align: center;">Slot: ${a.slot}</h3>
        </br>
        <a style="margin-left: 220px; font-size: large;" href="/FPT_University_Management_System/ViewGroupAttendance?group_id=${requestScope.group_id}">View Full Attendances</a>
        <form action="TakeAttendance" method="POST">
            <table>
                <thead>
                    <tr>
                        <th>INDEX</th>
                        <th>IMAGE</th>
                        <th>ROLL NUMBER</th>
                        <th>FULL NAME</th>
                        <th>STATUS</th>
                        <th>NOTES</th>
                        <th>VIEWS</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="att" items="${sessionScope.attendances}" varStatus="loop">
                        <c:set var="s" value="${att.enrollment.student}"/>
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><img width="120px" src="${s.student_imgsrc}" alt="Student img"></td>
                            <td>
                                ${s.student_code}
                                <input type="hidden" name="student_ids" value="${s.student_id}" />
                                <input type="hidden" name="attendance_id${s.student_id}" value="${att.attendance_id}" />
                            </td>
                            <td>${s.last_name} ${s.first_name}</td>
                            <td>
                                <c:set var="isPresent" value="${att.status eq 'present' ? 'checked' : ''}"/>
                                <c:set var="isNotPresent" value="${att.status ne 'present' ? 'checked' : ''}"/>
                                <input type="radio" id="present" name="status${s.student_id}" value="present" ${isPresent}>
                                <label style="color:green;" for="present">Present</label>
                                <input type="radio" id="absent" name="status${s.student_id}" value="absent" ${isNotPresent}>
                                <label style="color:red;"for="absent">Absent</label><br>
                            </td>
                            <td>
                                <textarea name="notes${s.student_id}" rows="3" cols="20">${att.notes}</textarea>
                            </td>
                            <td>
                                <a style="font-size: small;" href="/FPT_University_Management_System/student/info?user_id=${s.user.user_id}">view profile</a>
                                <a style="font-size: small;" href="/FPT_University_Management_System/student/ViewAttendance?group_id=${att.enrollment.group.group_id}&user_id=${s.user.user_id}">view attendance</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <h2 style="text-align: center;">
                <input type="hidden" name="group_id" value="${param.group_id}"/>
                <input type="hidden" name="slot" value="${param.slot}"/>
                <input type="hidden" name="date" value="${param.date}"/>
                <input style="font-size:large; "type="submit" value="Save"/>
                </br>
                </br> 
            </h2>
        </form>
    </body>
</html>
