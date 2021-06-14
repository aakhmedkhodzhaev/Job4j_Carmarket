<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 13.06.2021
  Time: 23:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Office</title>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: "Lato", sans-serif;
        }

        .sidenav {
            width: 150px;
            position: fixed;
            z-index: 1;
            top: 60px;
            left: 5px;
            background: #000000;
            overflow-x: hidden;
            padding: 50px 0;
        }

        .sidenav a {
            padding: 6px 8px 6px 16px;
            text-decoration: none;
            font-size: 25px;
            color: #2196F3;
            display: block;
        }

        .sidenav a:hover {
            color: #064579;
        }

        .main {
            margin-left: 140px;
            font-size: 28px;
            padding: 0px 10px;
        }

        @media screen and (max-height: 450px) {
            .sidenav {
                padding-top: 15px;
            }

            .sidenav a {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <a class="navbar-brand" href="#">CarMarket</a>

    <!-- Links -->
    <ul class="navbar-nav">
        <li class="nav-item dropdown" id="menu_personal_area">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                Личный кабинет
            </a>
            <div class="dropdown-menu">
                <a id="menuLogin" class="dropdown-item" href="auth.do">Авторизация</a>
                <a id="menuRegister" class="dropdown-item" href="reg.do">Регистрация</a>
                <a id="menuNotes" hidden="true" class="dropdown-item" onclick="showMyNotes();">Мои объявления</a>
                <a id="menuLogout" hidden="true" class="dropdown-item" onclick="doLogout();">Выход</a>
            </div>
        </li>
        <li hidden class="nav-item">
            <a class="nav-link" href="#">Поиск</a>
        </li>
    </ul>
</nav>
<div class="sidenav">
    <a href="#about">Мои объявления</a>
    <a href="#services">Добавить объявления</a>
    <a href="#clients"></a>
    <a href="#contact">Выход</a>
</div>
</body>
</html>