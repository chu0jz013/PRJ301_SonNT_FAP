<%-- 
    Document   : add
    Created on : Mar 5, 2023, 11:31:34 PM
    Author     : willi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

            /* Define styles for the input button */
            input[type="button"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            /* Define styles for the input button on hover */
            input[type="button"]:hover {
                background-color: #3e8e41;
            }

            .form-container {
                max-width: 500px;
                margin: auto;
                background-color: #f2f2f2;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: 500;
                margin-bottom: 5px;
            }

            input[type="text"], textarea {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 25px;
                box-sizing: border-box;
                font-size: 16px;
                font-weight: 300;
                color: #333;
                background-color: #f5f5f5;
                transition: background-color 0.3s ease;
            }

            input[type="text"]:focus, textarea:focus {
                outline: none;
                background-color: #e6e6e6;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: #fff;
                padding: 12px 24px;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #3e8e41;
            }

        </style>
        <title>Create Major</title>
    </head>
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
    <body>
        </br>
        <a href="../MajorManagement">Back to edit Majors</a>
        <div>
            <h2 style="text-align: center;">UPDATE MAJOR</h2>
            </br>
            <form action="../MajorManagement/add" method="POST" class="form-container"> 
                <c:set var="m" value="${requestScope.major}"/>
                <div class="form-group">
                    <label for="major_code">Code:</label>
                    <input type="text" name="major_code" id="major_code" value="${m.major_code}" required/>
                </div>
                <div class="form-group">
                    <label for="major_name">Name:</label>
                    <input type="text" name="major_name" id="major_name" value="${m.major_name}"  required/>
                </div>
                <div class="form-group">
                    <label for="major_description">Description:</label>
                    <textarea name="major_description" value="${m.major_description}" id="major_description" rows="5" cols="40"></textarea>
                </div>
                <div class="form-group">
                    <input type="submit" value="Save"/>
                </div>
            </form>

        </div>
    </body>
</html>

