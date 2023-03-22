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
        <h1 style="text-align: center;"> VIEW FULL ATTENDANCE GROUP</h1>
        <div>
            <h2>SEMESTER:
                <c:forEach var="se" items="${requestScope.semesters}">
                    <a style="font-size: small;" href="ViewGroupAttendance?semester_id=${se.semester_id}">${se.semester_name}</a>
                </c:forEach>
            </h2>
            <h2>DEPARTMENT:
                <c:forEach var="d" items="${requestScope.departments}">
                    <a style="font-size: small;" href="ViewGroupAttendance?semester_id=${sessionScope.semester_id}&department_id=${d.department_id}"">${d.department_name}</a>
                </c:forEach>
            </h2>
            <h2>COURSE:
                <c:forEach var="c" items="${requestScope.courses}">
                    <a style="font-size: small;" href="ViewGroupAttendance?semester_id=${sessionScope.semester_id}&department_id=${sessionScope.department_id}&course_id=${c.course_id}"">${c.course_name}</a>
                </c:forEach>
                <h2>GROUP:
                    <c:forEach var="c" items="${requestScope.courses}">
                        <c:forEach var="g" items="${c.groups}">
                            <c:if test="${g.course.course_id eq sessionScope.course_id}">
                                <a style="font-size: small;" href="ViewGroupAttendance?group_id=${g.group_id}"">${g.group_name}</a>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </h2>
            </h2>
        </div>
        <h2 style="text-align: center">${requestScope.group.semester.semester_name} - ${requestScope.group.group_name} - ${requestScope.group.course.course_name} </h2>
        <table>
            <thead>
                <tr>
                    <th>INDEX</th>
                    <th>IMAGE</th>
                    <th>ROLL NUMBER</th>
                    <th>NAME</th>
                    <th>ABSENT PERCENTAGE</th>
                        <c:forEach var="d" items="${requestScope.dates}">
                        <th>
                            <fmt:formatDate value="${d}" pattern="dd-MM"/>
                        </th>
                    </c:forEach>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="en" items="${requestScope.enrollments}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><img width="120px" src="${en.student.student_imgsrc}" alt="Student img"></td>
                        <td>${en.student.student_code}</td>
                        <td>${en.student.last_name} ${en.student.first_name}</td>
                        <c:set var="total_absent_slot" value="${en.total_absent_slot}" />
                        <c:set var="total_slot" value="${en.total_slot}" />
                        <fmt:formatNumber value="${(100 * total_absent_slot / total_slot)}" type="number" maxFractionDigits="0" var="absent_percentage" />
                        <td>${absent_percentage}%</td>
                        <c:forEach var="d" items="${requestScope.dates}">
                            <td>
                                <c:forEach items="${requestScope.groupAttendances}" var="att">
                                    <c:if test="${en.student.student_code eq att.enrollment.student.student_code and att.date eq d}"> 
                                        <div style="${att.status eq 'present' ? 'color: green;' : att.status eq 'absent' ? 'color: red;' : 'color: gray;'}">
                                            ${att.status}
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
