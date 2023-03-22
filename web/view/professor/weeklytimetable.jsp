<%-- 
    Document   : weeklytimetable
    Created on : Mar 5, 2023, 3:16:31 AM
    Author     : willi
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Weekly Timetable</title>
        <script>
            function submitForm() {
                document.getElementsByTagName('form')[0].submit();
            }
        </script>
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
                background-color: #dce1dc;
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
        <h1 style="text-align: center;">WEEKLY TIMETABLE</h1>
        <table border = "1px">
            <tr>
                <td>
                    <form action="WeeklyTimetable" method="get">
                        Date
                        <input type="date" id="date" name="date" value="${requestScope.date}" onchange="submitForm()"><br/>
                    </form>
                </td>
                <c:forEach items="${requestScope.week_date}" var="d">
                    <td> 
                        <fmt:formatDate value="${d}" pattern="EEEE"/> <br> 
                        <fmt:formatDate value="${d}" pattern="dd-MM"/>
                    </td>
                </c:forEach>
            </tr>
            <c:forEach items="${requestScope.slot_index}" var="slot_index"> 
                <tr>
                    <td>Slot ${slot_index}</td>
                    <c:forEach items="${requestScope.week_date}" var="d">
                        <td>
                            <c:forEach items="${requestScope.weeklyTimetable}" var="w">
                                <c:if test="${slot_index eq w.slot and w.date eq d}"> 
                                    <span style="color: #124DA3">${w.enrollment.group.course.course_code}</span> at ${w.classroom.room_code} - <span style="color: chocolate">${w.enrollment.group.group_name}</span>
                                    <span style="${w.status eq 'present' ? 'color: green;' : 'color: red;'}">
                                        ${w.status} 
                                    </span>
                                    </br>
                                    (<fmt:formatDate value="${w.start_time}" pattern="HH:mm"/> - <fmt:formatDate value="${w.end_time}" pattern="HH:mm"/>) 
                                    <c:if test="${w.taken_by ne null}">
                                        <a style="font-size : small; color: green" href="TakeAttendance?date=${w.date}&slot=${w.slot}&group_id=${w.enrollment.group.group_id}">edit attendance</a>
                                    </c:if>
                                    <c:if test="${w.taken_by eq null}">
                                        <a style="font-size : small; color: red" href="TakeAttendance?date=${w.date}&slot=${w.slot}&group_id=${w.enrollment.group.group_id}">take attendance</a>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>