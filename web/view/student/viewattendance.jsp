<%-- 
    Document   : viewattendance
    Created on : Mar 10, 2023, 1:19:28 AM
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
                <h1 style="text-align: center; margin-right: 0 20px 0 0; margin-left: auto;">FPT University Academic Portal</h1>
                <h3 style="text-align: right; margin-left: auto;">Welcome ${sessionScope.user.username}</h3>  
            </div>
        </header>
        </br> 
        <h1 style="text-align: center;"> VIEW ATTENDANCE GROUP

        </h1>
        <div>
            <h2>SEMESTER:
                <c:forEach var="se" items="${requestScope.semesters}">
                    <a style="font-size: small;" href="ViewAttendance?semester_id=${se.semester_id}&user_id=${sessionScope.user.user_id}"">${se.semester_name}</a>
                </c:forEach>
                <h2>GROUPS:
                    <c:forEach var="g" items="${requestScope.groups}">
                        <a style="font-size: small;" href="ViewAttendance?semester_id=${sessionScope.semester_id}&group_id=${g.group_id}&user_id=${sessionScope.user.user_id}"">${g.course.course_name} - ${g.group_name}</a>
                    </c:forEach>
                </h2>
            </h2>
        </div>
        <h2 style="text-align: center;" > SEMESTER: 
            <c:forEach var="ses" items="${requestScope.semesters}">
                <c:if test="${ses.semester_id == sessionScope.semester_id}">
                    ${ses.semester_name}
                </c:if>
            </c:forEach>
        </h2>
        <h2 style="text-align: center;" > COURSE: 
            <c:forEach var="group" items="${requestScope.groups}">
                <c:if test="${group.group_id == sessionScope.group_id}">
                    ${group.group_name}_${group.course.course_code}_${group.course.course_name}
                </c:if>
            </c:forEach>
        </h2>
        <table>
            <thead>
                <tr>
                    <th>INDEX</th>
                    <th>DATE</th>
                    <th>DAY OF WEEK</th>
                    <th>TIME</th>
                    <th>SLOT</th>
                    <th>ROOM</th>
                    <th>LECTURER</th>
                    <th>GROUP NAME</th>
                    <th>ATTENDANCE STATUS</th>
                    <th>LECTURER'S COMMENT</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.viewAttendance}" var="att" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><fmt:formatDate value="${att.date}" pattern="dd-MM-yyyy"/></td>
                        <td>${att.day_of_week}</td>
                        <td>
                            <fmt:formatDate value="${att.start_time}" pattern="HH:mm"/> - <fmt:formatDate value="${att.end_time}" pattern="HH:mm"/>
                        </td>
                        <td>${att.slot}</td>
                        <td>${att.classroom.room_code}</td>
                        <td>${att.professor.professor_code}</td>
                        <td>${att.enrollment.group.group_name}</td>
                        <td>
                            <div style="${att.status eq 'present' ? 'color: green;' : att.status eq 'absent' ? 'color: red;' : 'color: gray;'}">
                                ${att.status}
                            </div>
                        </td>
                        <td>${att.notes}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <table>
            <tr>
                <th>
                    ABSENT : ${requestScope.absent_percentage}% ABSENT SO FAR (${requestScope.enrollment.total_absent_slot} ABSENT ON ${requestScope.enrollment.total_slot} TOTAL)
                </th>
            </tr>
        </table>
    </body>
</html>
