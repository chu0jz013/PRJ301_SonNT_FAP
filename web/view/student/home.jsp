<%-- 
    Document   : home
    Created on : Mar 4, 2023, 5:09:04 PM
    Author     : willi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FPT University Academic Portal</title>
    </head>
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
            margin-left: 20px;
            margin: 0.5rem 0;
        }

        nav a {
            color: #2c3e50;
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
        
        a {
            display: inline-block;
            margin-right: 20px;
            margin-bottom: 20px;
            padding: 10px 20px;
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
    <main>
        <nav>
            <ul>
                <li><a href="WeeklyTimetable">Weekly Timetable</a></li>
                <li><a href="ViewAttendance?user_id=${sessionScope.user.user_id}">View attendance</a></li>
                <li><a href="../Groups">View groups</a></li>
                <li><a href="info?user_id=${sessionScope.user.user_id}">Student information</a></li>
            </ul>
        </nav>
    </main>
</body>
</html>



